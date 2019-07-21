Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75423C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3651C2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqJJAdT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfGUV6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:58:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34928 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfGUV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:58:16 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so69770121ioo.2;
        Sun, 21 Jul 2019 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tev7n6EVMi7iKztYGKAvEisaO6enLdDJrsSjiK4LjPs=;
        b=KqJJAdT/oV6WBkbwztABUDP/snUsIkTbcE/2XWZ8pnjDWIyLGI26TEPVMIJ+fwjHCK
         SvTDnDukqZ4VEOywXYhJMdAMQe+UyIOUMZdsQzqUJtwA8ujaDeAh0bwa7LOLVbA4R5Cw
         7HXf5Hee5qwjZ4yt3SCncmy4CaojFfO5ERdnyp1BsqKSxr32uSE5wiK/Jztk3MBgYmhU
         kUPtlpGmAcMOuuyy+/e2Cx4vyTe7qQMhpIA3nAa6yhbb6P6oKLwu5Q38CyE6B34gs3Fs
         nI6dGTiF4A5BFGoD5OlywZsBlPOgW+FDq3mlCX9E2/5fAZ01qqC9twsGuFZDR4LQVizD
         BkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tev7n6EVMi7iKztYGKAvEisaO6enLdDJrsSjiK4LjPs=;
        b=luJd9Jria97280DuSFTQRf+0hXoRXtc/8n5W91/5GIDPmo8g4b3qHD7DF3R+XLYD8h
         sLEwyzqAGFR0FCR4h4sd3SmFH78gvBHfMsH2+bKnjKl0TzqfnkLZDR0Yf6EAnl2w+K0j
         +9SrnlDm/q+cOHcjFZMNzkWyyHUf1258CcYYjUv6U3bcRCJcy0RsFky6z/LqtKSFf4uJ
         ZOd7PFlki1kAccUsq5IHnzDqMoDnWrz5w2DwwmwOJ7ZcazlQW5qgW36MwvZV4MP4a+10
         AIXdxR/sJMYsYLfHWzSRdzHdm+FNz+XIEYDANswVaeSQdVIPjlpsRC0JKhEAjdxAGWTb
         XKsw==
X-Gm-Message-State: APjAAAX11hFgqKqCCu+40vtdBw3bc60BcuRaBfMw5CsLvBuBtMmxfC6t
        DmgQSop2GvdQSi78buKeqhzxrXrMkBT5g0pMHtw=
X-Google-Smtp-Source: APXvYqwLSajdLhk84YFgrwdbdYp5pcUUKJgeU5jNbnQdwFql5z60ETrzyOJInwIyUPqjYsPQ4kU5VpZQTAceXEY4CKE=
X-Received: by 2002:a02:242a:: with SMTP id f42mr68634598jaa.42.1563746295585;
 Sun, 21 Jul 2019 14:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190717192616.1731-1-tushar.khandelwal@arm.com> <20190717192616.1731-2-tushar.khandelwal@arm.com>
In-Reply-To: <20190717192616.1731-2-tushar.khandelwal@arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sun, 21 Jul 2019 16:58:04 -0500
Message-ID: <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding documentation
To:     Tushar Khandelwal <tushar.khandelwal@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tushar.2nov@gmail.com, morten_bp@live.dk, nd@arm.com,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 2:26 PM Tushar Khandelwal
<tushar.khandelwal@arm.com> wrote:

> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
> new file mode 100644
> index 000000000000..3a05593414bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
> @@ -0,0 +1,108 @@
> +Arm MHUv2 Mailbox Driver
> +========================
> +
> +The Arm Message-Handling-Unit (MHU) Version 2 is a mailbox controller that has
> +between 1 and 124 channel windows to provide unidirectional communication with
> +remote processor(s).
> +
> +Given the unidirectional nature of the device, an MHUv2 mailbox may only be
> +written to or read from. If a pair of MHU devices is implemented between two
> +processing elements to provide bidirectional communication, these must be
> +specified as two separate mailboxes.
> +
> +A device tree node for an Arm MHUv2 device must specify either a receiver frame
> +or a sender frame, indicating which end of the unidirectional MHU device which
> +the device node entry describes.
> +
> +An MHU device must be specified with a transport protocol. The transport
> +protocol of an MHU device determines the method of data transmission as well as
> +the number of provided mailboxes.
> +Following are the possible transport protocol types:
> +- Single-word: An MHU device implements as many mailboxes as it
> +               provides channel windows. Data is transmitted through
> +               the MHU registers.
> +- Multi-word:  An MHU device implements a single mailbox. All channel windows
> +               will be used during transmission. Data is transmitted through
> +               the MHU registers.
> +- Doorbell:    An MHU device implements as many mailboxes as there are flag
> +               bits available in its channel windows. Optionally, data may
> +               be transmitted through a shared memory region, wherein the MHU
> +               is used strictly as an interrupt generation mechanism.
> +
> +Mailbox Device Node:
> +====================
> +
> +Required properties:
> +--------------------
> +- compatible:  Shall be "arm,mhuv2" & "arm,primecell"
> +- reg:         Contains the mailbox register address range (base
> +               address and length)
> +- #mbox-cells  Shall be 1 - the index of the channel needed.
> +- mhu-frame    Frame type of the device.
> +               Shall be either "sender" or "receiver"
> +- mhu-protocol Transport protocol of the device. Shall be one of the
> +               following: "single-word", "multi-word", "doorbell"
> +
> +Required properties (receiver frame):
> +-------------------------------------
> +- interrupts:  Contains the interrupt information corresponding to the
> +               combined interrupt of the receiver frame
> +
> +Example:
> +--------
> +
> +       mbox_mw_tx: mhu@10000000 {
> +               compatible = "arm,mhuv2","arm,primecell";
> +               reg = <0x10000000 0x1000>;
> +               clocks = <&refclk100mhz>;
> +               clock-names = "apb_pclk";
> +               #mbox-cells = <1>;
> +               mhu-protocol = "multi-word";
> +               mhu-frame = "sender";
> +       };
> +
> +       mbox_sw_tx: mhu@10000000 {
> +               compatible = "arm,mhuv2","arm,primecell";
> +               reg = <0x11000000 0x1000>;
> +               clocks = <&refclk100mhz>;
> +               clock-names = "apb_pclk";
> +               #mbox-cells = <1>;
> +               mhu-protocol = "single-word";
> +               mhu-frame = "sender";
> +       };
> +
> +       mbox_db_rx: mhu@10000000 {
> +               compatible = "arm,mhuv2","arm,primecell";
> +               reg = <0x12000000 0x1000>;
> +               clocks = <&refclk100mhz>;
> +               clock-names = "apb_pclk";
> +               #mbox-cells = <1>;
> +               interrupts = <0 45 4>;
> +               interrupt-names = "mhu_rx";
> +               mhu-protocol = "doorbell";
> +               mhu-frame = "receiver";
> +       };
> +
> +       mhu_client: scb@2e000000 {
> +       compatible = "fujitsu,mb86s70-scb-1.0";
> +       reg = <0 0x2e000000 0x4000>;
> +       mboxes =
> +               // For multi-word frames, client may only instantiate a single
> +               // mailbox for a mailbox controller
> +               <&mbox_mw_tx 0>,
> +
> +               // For single-word frames, client may instantiate as many
> +               // mailboxes as there are channel windows in the MHU
> +                <&mbox_sw_tx 0>,
> +                <&mbox_sw_tx 1>,
> +                <&mbox_sw_tx 2>,
> +                <&mbox_sw_tx 3>,
> +
> +               // For doorbell frames, client may instantiate as many mailboxes
> +               // as there are bits available in the combined number of channel
> +               // windows ((channel windows * 32) mailboxes)
> +                <mbox_db_rx 0>,
> +                <mbox_db_rx 1>,
> +                ...
> +                <mbox_db_rx 17>;
> +       };

If the mhuv2 instance implements, say, 3 channel windows between
sender (linux) and receiver (firmware), and Linux runs two protocols
each requiring 1 and 2-word sized messages respectively. The hardware
supports that by assigning windows [0] and [1,2] to each protocol.
However, I don't think the driver can support that. Or does it?

Also I see problem with implementing "protocol modes" in the
controller driver - 'mhu-protocol' property should go away.  And
'mhu-frame' is unncessary - presence of interrupt property could imply
'receiver', otherwise 'sender'.

Cheers!
