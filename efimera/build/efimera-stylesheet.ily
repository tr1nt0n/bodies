\version "2.20.0"
\language english
#(set-default-paper-size "11x17landscape")
#(set-global-staff-size 12)
#(ly:set-option 'relative-includes #t)

\include "../library.ily"
\include "/Users/trintonprater/evans/lilypond/evans-markups.ily"
\include "/Users/trintonprater/abjad-ext-microtones/abjadext/microtones/lilypond/ekmelos-ji-accidental-markups.ily"

\header {
    dedication = \markup \override #'(font-name . "Bodoni72 Book Italic") \fontsize #3 \center-column {". . . donde quiera que podrían estar ellos siempre recuerdan que el pasado era una mentira, que la memoria no tiene retorno, que cada primavera pasada nunca se pudo recuperar, y que el amor más salvaje y más tenaz era una . . ." \fontsize #0.25 \with-color #white "."}
    title = \markup \override #'(font-name . "Bodoni72 Book Italic") \fontsize #12 \center-column {"verdad efímera en el final" \fontsize #0.01 \with-color #white "."}
    subtitle = \markup \override #'(font-name . "Bodoni72") \fontsize #3 \center-column {"or, \"Lugarhou\"" \fontsize #0.01 \with-color #white "."}
    composer = \markup \override #'(font-name . "Bodoni72") \fontsize #3 {"Trinton (*2000)"}
}

\layout {
    \accidentalStyle neo-modern
    ragged-bottom = ##t
    ragged-last = ##t
    ragged-right = ##t
    \context {
        \name TimeSignatureContext
        \numericTimeSignature
        \type Engraver_group
        \consists Axis_group_engraver
        \consists Time_signature_engraver
		\consists Mark_engraver
		\consists Metronome_mark_engraver
		\consists Text_engraver
		\consists Text_spanner_engraver
        \override MetronomeMark.stencil = ##f
		\override TimeSignature.X-extent = #'(0 . -25)
        \override TimeSignature.Y-extent = #'(25 . 0)
        \override VerticalAxisGroup.staff-staff-spacing = #'((basic-distance . 0) (minimum-distance . 7) (padding . 2) (stretchability . 0))
        \override TimeSignature.break-visibility = #end-of-line-invisible
        \override TimeSignature.font-size = 7
		\override TimeSignature.font-name = "Bodoni72"
        \override TimeSignature.X-offset = -1.5
        \override TimeSignature.Y-offset = 3
        \override TimeSignature.whiteout-style = #'outline
        \override TimeSignature.whiteout = 1
        \override TimeSignature.layer = 5
    }

    \context {
        \Score
        \numericTimeSignature
        \accepts TimeSignatureContext
        proportionalNotationDuration = #(ly:make-moment 1 20)
        \override StaffGrouper.staff-staff-spacing = #'((basic-distance . 0) (minimum distance . 7) (padding . 7) (stretchability . 28))
        \override StaffGrouper.staffgroup-staff-spacing = #'((basic-distance . 0) (minimum distance . 7) (padding . 7) (stretchability . 28))

        \override AccidentalSuggestion.avoid-slur = #'ignore

        \override BarLine.bar-extent = #'(-2 . 2)
        \override BarLine.X-extent = #'(0 . 0)
        \override BarLine.hair-thickness = 0.5
        \override BarLine.transparent = ##t
        \override BarLine.thick-thickness = #8

        \override BarNumber.stencil = #(make-stencil-circler 0.1 0.75 ly:text-interface::print)
        \override BarNumber.Y-extent = ##f
		\override BarNumber.Y-offset = 0
		\override BarNumber.extra-offset = #'(-2 . 4)
        \override BarNumber.font-size = 2
        \override BarNumber.font-name = "Bodoni72"
		\override BarNumber.padding = 1

        autoBeaming = ##f
        \override Beam.breakable = ##t
        \override Beam.damping = 99
        \override Beam.concaveness = #10000
        \override Beam.beam-thickness = #0.75
        \override Beam.length-fraction = 1.5

        \override Clef.layer = 2
        \override Clef.whiteout-style = #'outline
        \override Clef.whiteout = 1

        \override DynamicText.font-size = #-2
        \override DynamicText.layer = 2
        \override DynamicText.whiteout-style = #'outline
        \override DynamicText.whiteout = 1
        \override DynamicLineSpanner.staff-padding = 4

        \override Glissando.thickness = #2
        \override Glissando.breakable = ##t

        \override Hairpin.to-barline = ##f

        \override MetronomeMark.padding = 2.5
        \override MetronomeMark.font-size = 4
        \override MetronomeMark.extra-offset = #'(4.5 . 0)
        \override MetronomeMark.layer = 4
        \override MetronomeMark.whiteout-style = #'outline
        \override MetronomeMark.whiteout = 1

        \override Staff.thickness = #0.5

        \override Stem.stemlet-length = 0.75
        \override Stem.thickness = #0.5
        \override Stem.details.beamed-lengths = #'(6)
        \override Stem.details.lengths = #'(6)

        \override StemTremolo.beam-width = 1.5
        \override StemTremolo.beam-width = 1.5
        \override StemTremolo.flag-count = 4
        \override StemTremolo.slope = 0.5

        \override Tie.stencil = #flare-tie
        \override Tie.height-limit = 6
        \override Tie.thickness = 1.5

        tupletFullLength = ##t
        \override TupletBracket.full-length-to-extent = ##f
        \override TupletNumber.font-size = 1.5
        \override TupletBracket.bracket-visibility = ##t
        \override TupletBracket.layer = 2
        \override TupletBracket.whiteout-style = #'outline
        \override TupletBracket.whiteout = 1
        \override TupletNumber.font-size = 1.5
        \override TupletNumber.layer = 3
        \override TupletNumber.whiteout-style = #'outline
        \override TupletNumber.whiteout = 1
        \override TupletNumber.text = #tuplet-number::calc-fraction-text
        \override TupletBracket #'stencil =
            #(lambda (grob)
               (let* ((pos (ly:grob-property grob 'positions))
                      (dir (ly:grob-property grob 'direction))
                      (new-pos (if (= dir 1)
                                   (max (car pos)(cdr pos))
                                   (min (car pos)(cdr pos)))))
                 (ly:grob-set-property! grob 'positions (cons new-pos new-pos))
                 (ly:tuplet-bracket::print grob)))
    }

    \context {
        \Staff
        fontSize = #-1
        \remove Time_signature_engraver
        \override InstrumentName.self-alignment-X = #CENTER
        \RemoveAllEmptyStaves
    }

    \context {
        \Voice
        \remove Forbid_line_break_engraver
        \override Accidental.font-size = 1
    }
}
%
\paper {
    system-separator-markup = \markup { \slashSeparator }
    system-system-spacing = #'((basic-distance . 16) (minimum-distance . 16) (padding . 2))
    indent = 20\mm
    short-indent = 15\mm
    bottom-margin = 10\mm
    left-margin = 10\mm
    right-margin = 10\mm
    top-margin = 10\mm

    oddHeaderMarkup = \markup ""
    evenHeaderMarkup = \markup ""
    oddFooterMarkup = \markup
        \fill-line {
            "verdad efímera en el final - Trinton"
        \concat {
            \fontsize #3
                \fromproperty #'page:page-number-string
        }
        }

        evenFooterMarkup = \markup
            \fill-line {
                \concat {
                    \fontsize #3
                        \fromproperty #'page:page-number-string
                }
                "verdad efímera en el final - Trinton"
            }
}
