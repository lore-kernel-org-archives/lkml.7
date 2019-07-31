Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F28C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8695208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/4XiCRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfGaHcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:32:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38146 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfGaHcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:32:00 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so14359690ioa.5;
        Wed, 31 Jul 2019 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmRH5cyyTa+pu28tKgSAoxuUUc49EzcBtnBvXftrvkE=;
        b=i/4XiCRB6NhtZp65i/Y4J0IPpXeIgduMTL8gVPuT4q4TC0gTl8C5mi7BHUwNPjeWU4
         5z/5IpRwtpOUd3+jm+hFPf34yqv2e/ay5p2dVabMnqjHLVTQtZaePGMrKZolBs5hUWea
         tRPHJnKvzb2PcI0rj7YqQH56TJXSCGF/CritwRgCpBuxVm1pLeSWz8jFc58lXzkLXdN9
         p9rQvxLDcYGk9WiZs+y4fx7M8JG/sUquTbx6a9+oD3zVrtcMdPlTXj3GSokdSG7SSQL+
         2wGAExf1ggxcgvzIUDFNO6jt/TLeHcyhWOjM1OANJA7Gp53z9jBkTZLO0gRZaH2Jd4GB
         MYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmRH5cyyTa+pu28tKgSAoxuUUc49EzcBtnBvXftrvkE=;
        b=j1w6GVr0ouj6mDJcDQE4zTLD0JJylMZs/LhS6jPWziLoYs9tLf9jEG0NAr/EQjIC+Q
         ZLQnveO5AhnLcVH+327QLnt9McxV1sj/tqtUJ/V8nipSE/2PFvsg3Jl9OxnJmM8uV6wd
         uEawAzmriBA9zYPFrzP1C0JvS1cvfpWY5qPHLNaAWAgHG3NPCO/M9nywY7rj59LDRPP3
         LnTVtCVIADn7FXpPUyoKqM4pLXfptuIQJRbODUbv06sSfbKIztVLAlEyiGNvnuqVSWl/
         w4256Fbp5O/Vdg5s9KK6jH5Ud37jAPEuToP8UvBnLe5GSzbT0OD6YIwU9b5sSdc3O0IN
         v7Dg==
X-Gm-Message-State: APjAAAWcITwNRtXZ9uulPtee/I+s6SYzlKTI5is7UkVb73EfkCsidAS1
        R16xf/dNmohoFPnM520/gLJEum/lYNk/4Z3vo38X0w==
X-Google-Smtp-Source: APXvYqy/wNaiH1PbhpPL1I3msyKbCMcewdGWIiHkhish88uB3f3bzURV8ZGANL4VTJqvc6cfNk7fXUiRFtIW+M+Vcgw=
X-Received: by 2002:a02:a703:: with SMTP id k3mr55128556jam.12.1564558319165;
 Wed, 31 Jul 2019 00:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com> <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com> <VI1PR0601MB21113C48E719B2C79EC2FE508FC20@VI1PR0601MB2111.eurprd06.prod.outlook.com>
In-Reply-To: <VI1PR0601MB21113C48E719B2C79EC2FE508FC20@VI1PR0601MB2111.eurprd06.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 31 Jul 2019 02:31:48 -0500
Message-ID: <CABb+yY3yMWbUiQnJgfQhwnW1OM3aoFL3ZFc018E-fxGichi-4Q@mail.gmail.com>
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

On Sun, Jul 28, 2019 at 4:28 PM Morten Borup Petersen <morten_bp@live.dk> wrote:
>
>
>
> On 7/25/19 7:49 AM, Jassi Brar wrote:
> > On Sun, Jul 21, 2019 at 4:58 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >>
> >> On Wed, Jul 17, 2019 at 2:26 PM Tushar Khandelwal
> >> <tushar.khandelwal@arm.com> wrote:
> >>
> >>> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
> >>> new file mode 100644
> >>> index 000000000000..3a05593414bc
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
> >>> @@ -0,0 +1,108 @@
> >>> +Arm MHUv2 Mailbox Driver
> >>> +========================
> >>> +
> >>> +The Arm Message-Handling-Unit (MHU) Version 2 is a mailbox controller that has
> >>> +between 1 and 124 channel windows to provide unidirectional communication with
> >>> +remote processor(s).
> >>> +
> >>> +Given the unidirectional nature of the device, an MHUv2 mailbox may only be
> >>> +written to or read from. If a pair of MHU devices is implemented between two
> >>> +processing elements to provide bidirectional communication, these must be
> >>> +specified as two separate mailboxes.
> >>> +
> >>> +A device tree node for an Arm MHUv2 device must specify either a receiver frame
> >>> +or a sender frame, indicating which end of the unidirectional MHU device which
> >>> +the device node entry describes.
> >>> +
> >>> +An MHU device must be specified with a transport protocol. The transport
> >>> +protocol of an MHU device determines the method of data transmission as well as
> >>> +the number of provided mailboxes.
> >>> +Following are the possible transport protocol types:
> >>> +- Single-word: An MHU device implements as many mailboxes as it
> >>> +               provides channel windows. Data is transmitted through
> >>> +               the MHU registers.
> >>> +- Multi-word:  An MHU device implements a single mailbox. All channel windows
> >>> +               will be used during transmission. Data is transmitted through
> >>> +               the MHU registers.
> >>> +- Doorbell:    An MHU device implements as many mailboxes as there are flag
> >>> +               bits available in its channel windows. Optionally, data may
> >>> +               be transmitted through a shared memory region, wherein the MHU
> >>> +               is used strictly as an interrupt generation mechanism.
> >>> +
> >>> +Mailbox Device Node:
> >>> +====================
> >>> +
> >>> +Required properties:
> >>> +--------------------
> >>> +- compatible:  Shall be "arm,mhuv2" & "arm,primecell"
> >>> +- reg:         Contains the mailbox register address range (base
> >>> +               address and length)
> >>> +- #mbox-cells  Shall be 1 - the index of the channel needed.
> >>> +- mhu-frame    Frame type of the device.
> >>> +               Shall be either "sender" or "receiver"
> >>> +- mhu-protocol Transport protocol of the device. Shall be one of the
> >>> +               following: "single-word", "multi-word", "doorbell"
> >>> +
> >>> +Required properties (receiver frame):
> >>> +-------------------------------------
> >>> +- interrupts:  Contains the interrupt information corresponding to the
> >>> +               combined interrupt of the receiver frame
> >>> +
> >>> +Example:
> >>> +--------
> >>> +
> >>> +       mbox_mw_tx: mhu@10000000 {
> >>> +               compatible = "arm,mhuv2","arm,primecell";
> >>> +               reg = <0x10000000 0x1000>;
> >>> +               clocks = <&refclk100mhz>;
> >>> +               clock-names = "apb_pclk";
> >>> +               #mbox-cells = <1>;
> >>> +               mhu-protocol = "multi-word";
> >>> +               mhu-frame = "sender";
> >>> +       };
> >>> +
> >>> +       mbox_sw_tx: mhu@10000000 {
> >>> +               compatible = "arm,mhuv2","arm,primecell";
> >>> +               reg = <0x11000000 0x1000>;
> >>> +               clocks = <&refclk100mhz>;
> >>> +               clock-names = "apb_pclk";
> >>> +               #mbox-cells = <1>;
> >>> +               mhu-protocol = "single-word";
> >>> +               mhu-frame = "sender";
> >>> +       };
> >>> +
> >>> +       mbox_db_rx: mhu@10000000 {
> >>> +               compatible = "arm,mhuv2","arm,primecell";
> >>> +               reg = <0x12000000 0x1000>;
> >>> +               clocks = <&refclk100mhz>;
> >>> +               clock-names = "apb_pclk";
> >>> +               #mbox-cells = <1>;
> >>> +               interrupts = <0 45 4>;
> >>> +               interrupt-names = "mhu_rx";
> >>> +               mhu-protocol = "doorbell";
> >>> +               mhu-frame = "receiver";
> >>> +       };
> >>> +
> >>> +       mhu_client: scb@2e000000 {
> >>> +       compatible = "fujitsu,mb86s70-scb-1.0";
> >>> +       reg = <0 0x2e000000 0x4000>;
> >>> +       mboxes =
> >>> +               // For multi-word frames, client may only instantiate a single
> >>> +               // mailbox for a mailbox controller
> >>> +               <&mbox_mw_tx 0>,
> >>> +
> >>> +               // For single-word frames, client may instantiate as many
> >>> +               // mailboxes as there are channel windows in the MHU
> >>> +                <&mbox_sw_tx 0>,
> >>> +                <&mbox_sw_tx 1>,
> >>> +                <&mbox_sw_tx 2>,
> >>> +                <&mbox_sw_tx 3>,
> >>> +
> >>> +               // For doorbell frames, client may instantiate as many mailboxes
> >>> +               // as there are bits available in the combined number of channel
> >>> +               // windows ((channel windows * 32) mailboxes)
> >>> +                <mbox_db_rx 0>,
> >>> +                <mbox_db_rx 1>,
> >>> +                ...
> >>> +                <mbox_db_rx 17>;
> >>> +       };
> >>
> >> If the mhuv2 instance implements, say, 3 channel windows between
> >> sender (linux) and receiver (firmware), and Linux runs two protocols
> >> each requiring 1 and 2-word sized messages respectively. The hardware
> >> supports that by assigning windows [0] and [1,2] to each protocol.
> >> However, I don't think the driver can support that. Or does it?
> >>
> > Thinking about it, IMO, the mbox-cell should carry a 128 (4x32) bit
> > mask specifying the set of windows (corresponding to the bits set in
> > the mask) associated with the channel.
> > And the controller driver should see any channel as associated with
> > variable number of windows 'N', where N is [0,124]
> >
> > mhu_client1: proto1@2e000000 {
> >        .....
> >        mboxes = <&mbox 0x0 0x0 0x0 0x1>
> > }
> >
> > mhu_client2: proto2@2f000000 {
> >        .....
> >        mboxes = <&mbox 0x0 0x0 0x0 0x6>
> > }
> >
> > Cheers!
> >
>
> As mentioned in the response to your initial comment, the driver does
> not currently support mixing protocols.
>
Thanks for acknowledging that limitation. But lets also address it.

> If mixing protocols is to be supported in the future, then this seems
> like a suitable way of specifying which channels are associated with
> which mailboxes (especially for mixing single- and multi-word modes).
>
We can not change DT bindings again when we feel like updating the driver.
The bindings should precisely and completely define the h/w, not what
mode we currently implement.
It is not for pure idealism, it actually makes the code simpler and futureproof.

> However, there still is an issue in that both single-word and doorbell
> requires only 1 channel window - and as such, the transport protocol
> cannot be deduced from merely the number of masked channel windows.
>
I don't see why the driver should worry -- the channel carries 32-bit
message or some random value just to trigger an interrupt is purely
upto the client driver.

> Furthermore, for doorbell, a mbox may be registered for _each_ available
> bit within a channel window (further complicating things if we were to
> include mixing protocols in this initial driver version), making
> assigning channel windows to mailboxes semantically different from when
> assigning to single- or multi-word.
>
Not sure about that, that would be implementing virtual channels. Each
window carries one signal, and that is the minimum bandwidth assigned
to a channel.

Thanks
