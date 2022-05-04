pageextension 88100 "KMD Time Sheet List Ext" extends "Time Sheet List"
{
    actions
    {
        modify(EditTimeSheet)
        {
            Visible = not false;
        }
        addafter(EditTimeSheet)
        {
            action(KMDEditTimeSheet)
            {
                ApplicationArea = Jobs;
                Caption = '&Edit Time Sheet (KMD)';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Return';
                ToolTip = 'Open the time sheet in edit mode.';
                //Visible = not TimeSheetV2Enabled;

                trigger OnAction()
                begin
                    OpenTimeSheetPage;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        TimeSheetV2Enabled := TimeSheetMgt.TimeSheetV2Enabled();
    end;

    var
        UserSetup: Record "User Setup";
        TimeSheetMgt: Codeunit "Time Sheet Management";
        TimeSheetV2Enabled: Boolean;
        TimeSheetAdminActionsVisible: Boolean;

    local procedure OpenTimeSheetPage()
    var
        TimeSheetLine: Record "Time Sheet Line";
    begin
        if TimeSheetV2Enabled then
            Page.Run(Page::"KMD Time Sheet Card", Rec)
        else begin
            TimeSheetMgt.SetTimeSheetNo(Rec."No.", TimeSheetLine);
            Page.Run(Page::"KMD Time Sheet", TimeSheetLine);
        end;
    end;
}
