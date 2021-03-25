module Main exposing (main)

import Browser exposing (Document)
import Css exposing (..)
import Css.Global exposing (generalSiblings, global)
import Css.Reset exposing (ress)
import Html.Styled exposing (Html, div, header, input, label, main_, nav, text, toUnstyled)
import Html.Styled.Attributes exposing (css, for, id, type_)


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    {}


init : () -> ( Model, Cmd Msg )
init _ =
    ( {}
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Document Msg
view _ =
    { title = ""
    , body =
        List.map toUnstyled
            [ global ress
            , header
                [ css
                    [ displayFlex
                    , justifyContent flexEnd
                    , marginBottom (px 20)
                    , borderBottom3 (px 1) solid (hex "#999")
                    ]
                ]
                [ nav
                    [ css [ displayFlex ] ]
                    [ menuItem
                        { id = "dropdown_1"
                        , label = "menu 1"
                        , flyoutContent = "flyout 1"
                        }
                    , menuItem
                        { id = "dropdown_2"
                        , label = "menu 2"
                        , flyoutContent = "flyout 2"
                        }
                    ]
                ]
            , main_ [] [ text "elm-supercell" ]
            ]
    }


menuItem : { id : String, label : String, flyoutContent : String } -> Html msg
menuItem item =
    div [ css [ position relative ] ]
        [ input
            [ id item.id
            , type_ "checkbox"
            , css
                [ marginRight (px 5)
                , generalSiblings
                    [ Css.Global.div [ display none ] ]
                , Css.checked
                    [ generalSiblings
                        [ Css.Global.div [ display block ] ]
                    ]
                ]
            ]
            []
        , label
            [ for item.id
            , css
                [ display block
                , padding2 (px 15) (px 15)
                , cursor pointer
                ]
            ]
            [ text item.label ]
        , flyout item.flyoutContent
        ]


flyout : String -> Html msg
flyout content =
    div
        [ css
            [ position absolute
            , top (px 60)
            , right zero
            , width (px 300)
            , padding (px 15)
            , backgroundColor (hex "#FFF")
            , border3 (px 1) solid (hex "#666")
            ]
        ]
        [ text content ]
