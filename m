Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571D1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CD020651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjhVLbQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfHMQhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:37:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46655 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHMQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:37:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so56443810otk.13;
        Tue, 13 Aug 2019 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+rDaHmg0AFJSGfYYUVedTTISFoQ3Y2D4evPtewEfoo=;
        b=gjhVLbQq0PtSOEK+lsGngWKMKah1F9bDZEc0tF9UYs2eSsx2v0BbDM14D88Fh1eitS
         nbV4l6+nLsoKMelVKWaqevVFsFL4IwILcYzSDF/iRvz1a1v1BXX9IvGmfBZpwFQ45iQk
         N88DLpE5t1Ad+nVuEnBhK3V3AjWE6LU9aD5JdnxnrJolT03QenET8BP083O9p08SmdLw
         pDdv6Xdk/oQpe82Ah8QAjQr5sI8HH0nyWz7NicrNWblZN3o62KBmEdFk6vOPl2ZFI7EM
         M4Oz3gqNTq3RuQUUqqwg7fd9pb5tDSsDfn76fxRCFdDrTafRsKegw4a7icf11QLgcgJD
         rwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+rDaHmg0AFJSGfYYUVedTTISFoQ3Y2D4evPtewEfoo=;
        b=nWhZxyyiYmjxV7aVed+6uf+X0Q3ULtqc/inE6OjWEUg5Tu7T6HS07NGC15YOLJ7JCn
         bFax9SEGIHTfcN6eWOmSh5FiNIL3jrQbJRRMV2zQS8RuVeIWM9X/SKJFoX2LmGXZ2iXs
         MOxENNnt3C3HHVK9u6BXc3hUJeBnyj2u9LFmOmyKhO319ySnlgCvxyBXkmNQ/KR36y04
         K1NDy6YiUjMxp7W4t9JpcYo4SFZ7ByVuESvGUlBx/kOx9sa0M/mWT75AUuL54OHC1wYY
         i20dxOwIwmC7QjrhVS3Zd4AoThObGzmOjZWLEdHraPHXkz8VvUu3b5MC8WIY/YQczMYt
         9sgg==
X-Gm-Message-State: APjAAAW/QjloAyrw/IA3TLn+OIb176ip9PVEhOygtj/1ZVgMStiJ+xTO
        uzu+rWMRoAkQjL2KYJYkKDc14zrcL/cuXd1utJM=
X-Google-Smtp-Source: APXvYqz5j9pNz/rjjnJmlKzNnOCGveNOCN3Pnj9xcm5BZeA1KZ0EAEpkp6wy+6tw+iA6LFsao2piTmVzcSgJEi05mmQ=
X-Received: by 2002:a05:6638:143:: with SMTP id y3mr2274329jao.68.1565714227401;
 Tue, 13 Aug 2019 09:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com> <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
 <VI1PR0601MB21113C48E719B2C79EC2FE508FC20@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3yMWbUiQnJgfQhwnW1OM3aoFL3ZFc018E-fxGichi-4Q@mail.gmail.com> <VI1PR0601MB2111A5A4E951F011D389A8978FD90@VI1PR0601MB2111.eurprd06.prod.outlook.com>
In-Reply-To: <VI1PR0601MB2111A5A4E951F011D389A8978FD90@VI1PR0601MB2111.eurprd06.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 13 Aug 2019 11:36:56 -0500
Message-ID: <CABb+yY3Ni7wV+ui1LO7TERWQH_BoakZbPq961wdRPB4X-nwS2A@mail.gmail.com>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding documentation
To:     Morten Borup Petersen <morten_bp@live.dk>
Cc:     Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tushar.2nov@gmail.com" <tushar.2nov@gmail.com>,
        "nd@arm.com" <nd@arm.com>,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 5:41 AM Morten Borup Petersen <morten_bp@live.dk> wrote:
>
>
>
> On 7/31/19 9:31 AM, Jassi Brar wrote:
> > On Sun, Jul 28, 2019 at 4:28 PM Morten Borup Petersen <morten_bp@live.dk> wrote:
> >>
> >>
> >>
> >> On 7/25/19 7:49 AM, Jassi Brar wrote:
> >>> On Sun, Jul 21, 2019 at 4:58 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >>>>
> >>>> On Wed, Jul 17, 2019 at 2:26 PM Tushar Khandelwal
> >>>> <tushar.khandelwal@arm.com> wrote:
> >>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
> >>>>> new file mode 100644
> >>>>> index 000000000000..3a05593414bc
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
> >>>>> @@ -0,0 +1,108 @@
> >>>>> +Arm MHUv2 Mailbox Driver
> >>>>> +========================
> >>>>> +
> >>>>> +The Arm Message-Handling-Unit (MHU) Version 2 is a mailbox controller that has
> >>>>> +between 1 and 124 channel windows to provide unidirectional communication with
> >>>>> +remote processor(s).
> >>>>> +
> >>>>> +Given the unidirectional nature of the device, an MHUv2 mailbox may only be
> >>>>> +written to or read from. If a pair of MHU devices is implemented between two
> >>>>> +processing elements to provide bidirectional communication, these must be
> >>>>> +specified as two separate mailboxes.
> >>>>> +
> >>>>> +A device tree node for an Arm MHUv2 device must specify either a receiver frame
> >>>>> +or a sender frame, indicating which end of the unidirectional MHU device which
> >>>>> +the device node entry describes.
> >>>>> +
> >>>>> +An MHU device must be specified with a transport protocol. The transport
> >>>>> +protocol of an MHU device determines the method of data transmission as well as
> >>>>> +the number of provided mailboxes.
> >>>>> +Following are the possible transport protocol types:
> >>>>> +- Single-word: An MHU device implements as many mailboxes as it
> >>>>> +               provides channel windows. Data is transmitted through
> >>>>> +               the MHU registers.
> >>>>> +- Multi-word:  An MHU device implements a single mailbox. All channel windows
> >>>>> +               will be used during transmission. Data is transmitted through
> >>>>> +               the MHU registers.
> >>>>> +- Doorbell:    An MHU device implements as many mailboxes as there are flag
> >>>>> +               bits available in its channel windows. Optionally, data may
> >>>>> +               be transmitted through a shared memory region, wherein the MHU
> >>>>> +               is used strictly as an interrupt generation mechanism.
> >>>>> +
> >>>>> +Mailbox Device Node:
> >>>>> +====================
> >>>>> +
> >>>>> +Required properties:
> >>>>> +--------------------
> >>>>> +- compatible:  Shall be "arm,mhuv2" & "arm,primecell"
> >>>>> +- reg:         Contains the mailbox register address range (base
> >>>>> +               address and length)
> >>>>> +- #mbox-cells  Shall be 1 - the index of the channel needed.
> >>>>> +- mhu-frame    Frame type of the device.
> >>>>> +               Shall be either "sender" or "receiver"
> >>>>> +- mhu-protocol Transport protocol of the device. Shall be one of the
> >>>>> +               following: "single-word", "multi-word", "doorbell"
> >>>>> +
> >>>>> +Required properties (receiver frame):
> >>>>> +-------------------------------------
> >>>>> +- interrupts:  Contains the interrupt information corresponding to the
> >>>>> +               combined interrupt of the receiver frame
> >>>>> +
> >>>>> +Example:
> >>>>> +--------
> >>>>> +
> >>>>> +       mbox_mw_tx: mhu@10000000 {
> >>>>> +               compatible = "arm,mhuv2","arm,primecell";
> >>>>> +               reg = <0x10000000 0x1000>;
> >>>>> +               clocks = <&refclk100mhz>;
> >>>>> +               clock-names = "apb_pclk";
> >>>>> +               #mbox-cells = <1>;
> >>>>> +               mhu-protocol = "multi-word";
> >>>>> +               mhu-frame = "sender";
> >>>>> +       };
> >>>>> +
> >>>>> +       mbox_sw_tx: mhu@10000000 {
> >>>>> +               compatible = "arm,mhuv2","arm,primecell";
> >>>>> +               reg = <0x11000000 0x1000>;
> >>>>> +               clocks = <&refclk100mhz>;
> >>>>> +               clock-names = "apb_pclk";
> >>>>> +               #mbox-cells = <1>;
> >>>>> +               mhu-protocol = "single-word";
> >>>>> +               mhu-frame = "sender";
> >>>>> +       };
> >>>>> +
> >>>>> +       mbox_db_rx: mhu@10000000 {
> >>>>> +               compatible = "arm,mhuv2","arm,primecell";
> >>>>> +               reg = <0x12000000 0x1000>;
> >>>>> +               clocks = <&refclk100mhz>;
> >>>>> +               clock-names = "apb_pclk";
> >>>>> +               #mbox-cells = <1>;
> >>>>> +               interrupts = <0 45 4>;
> >>>>> +               interrupt-names = "mhu_rx";
> >>>>> +               mhu-protocol = "doorbell";
> >>>>> +               mhu-frame = "receiver";
> >>>>> +       };
> >>>>> +
> >>>>> +       mhu_client: scb@2e000000 {
> >>>>> +       compatible = "fujitsu,mb86s70-scb-1.0";
> >>>>> +       reg = <0 0x2e000000 0x4000>;
> >>>>> +       mboxes =
> >>>>> +               // For multi-word frames, client may only instantiate a single
> >>>>> +               // mailbox for a mailbox controller
> >>>>> +               <&mbox_mw_tx 0>,
> >>>>> +
> >>>>> +               // For single-word frames, client may instantiate as many
> >>>>> +               // mailboxes as there are channel windows in the MHU
> >>>>> +                <&mbox_sw_tx 0>,
> >>>>> +                <&mbox_sw_tx 1>,
> >>>>> +                <&mbox_sw_tx 2>,
> >>>>> +                <&mbox_sw_tx 3>,
> >>>>> +
> >>>>> +               // For doorbell frames, client may instantiate as many mailboxes
> >>>>> +               // as there are bits available in the combined number of channel
> >>>>> +               // windows ((channel windows * 32) mailboxes)
> >>>>> +                <mbox_db_rx 0>,
> >>>>> +                <mbox_db_rx 1>,
> >>>>> +                ...
> >>>>> +                <mbox_db_rx 17>;
> >>>>> +       };
> >>>>
> >>>> If the mhuv2 instance implements, say, 3 channel windows between
> >>>> sender (linux) and receiver (firmware), and Linux runs two protocols
> >>>> each requiring 1 and 2-word sized messages respectively. The hardware
> >>>> supports that by assigning windows [0] and [1,2] to each protocol.
> >>>> However, I don't think the driver can support that. Or does it?
> >>>>
> >>> Thinking about it, IMO, the mbox-cell should carry a 128 (4x32) bit
> >>> mask specifying the set of windows (corresponding to the bits set in
> >>> the mask) associated with the channel.
> >>> And the controller driver should see any channel as associated with
> >>> variable number of windows 'N', where N is [0,124]
> >>>
> >>> mhu_client1: proto1@2e000000 {
> >>>        .....
> >>>        mboxes = <&mbox 0x0 0x0 0x0 0x1>
> >>> }
> >>>
> >>> mhu_client2: proto2@2f000000 {
> >>>        .....
> >>>        mboxes = <&mbox 0x0 0x0 0x0 0x6>
> >>> }
> >>>
> >>> Cheers!
> >>>
> >>
> >> As mentioned in the response to your initial comment, the driver does
> >> not currently support mixing protocols.
> >>
> > Thanks for acknowledging that limitation. But lets also address it.
> >
>
> We are hesitant to dedicate time to developing mixing protocols given
> that we don't have any current usecase nor any current platform which
> would support this.
>
Can you please share the client code against which you tested this driver?
From my past experience, I realise it is much more efficient to tidyup
the code myself, than endlessly trying to explain the benefits.

Thanks
