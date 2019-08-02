Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D59C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B06206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392076AbfHBK7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:59:43 -0400
Received: from foss.arm.com ([217.140.110.172]:49810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfHBK7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:59:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FD5344;
        Fri,  2 Aug 2019 03:59:42 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9DAF3F71F;
        Fri,  2 Aug 2019 03:59:40 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:59:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tushar.2nov@gmail.com, morten_bp@live.dk, nd@arm.com,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
Message-ID: <20190802105938.GG23424@e107155-lin>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com>
 <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 04:58:04PM -0500, Jassi Brar wrote:
> On Wed, Jul 17, 2019 at 2:26 PM Tushar Khandelwal
> <tushar.khandelwal@arm.com> wrote:
>
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
> > new file mode 100644
> > index 000000000000..3a05593414bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
> > @@ -0,0 +1,108 @@
> > +Arm MHUv2 Mailbox Driver
> > +========================
> > +
> > +The Arm Message-Handling-Unit (MHU) Version 2 is a mailbox controller that has
> > +between 1 and 124 channel windows to provide unidirectional communication with
> > +remote processor(s).
> > +
> > +Given the unidirectional nature of the device, an MHUv2 mailbox may only be
> > +written to or read from. If a pair of MHU devices is implemented between two
> > +processing elements to provide bidirectional communication, these must be
> > +specified as two separate mailboxes.
> > +
> > +A device tree node for an Arm MHUv2 device must specify either a receiver frame
> > +or a sender frame, indicating which end of the unidirectional MHU device which
> > +the device node entry describes.
> > +
> > +An MHU device must be specified with a transport protocol. The transport
> > +protocol of an MHU device determines the method of data transmission as well as
> > +the number of provided mailboxes.
> > +Following are the possible transport protocol types:
> > +- Single-word: An MHU device implements as many mailboxes as it
> > +               provides channel windows. Data is transmitted through
> > +               the MHU registers.
> > +- Multi-word:  An MHU device implements a single mailbox. All channel windows
> > +               will be used during transmission. Data is transmitted through
> > +               the MHU registers.
> > +- Doorbell:    An MHU device implements as many mailboxes as there are flag
> > +               bits available in its channel windows. Optionally, data may
> > +               be transmitted through a shared memory region, wherein the MHU
> > +               is used strictly as an interrupt generation mechanism.
> > +
> > +Mailbox Device Node:
> > +====================
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:  Shall be "arm,mhuv2" & "arm,primecell"
> > +- reg:         Contains the mailbox register address range (base
> > +               address and length)
> > +- #mbox-cells  Shall be 1 - the index of the channel needed.
> > +- mhu-frame    Frame type of the device.
> > +               Shall be either "sender" or "receiver"
> > +- mhu-protocol Transport protocol of the device. Shall be one of the
> > +               following: "single-word", "multi-word", "doorbell"
> > +
> > +Required properties (receiver frame):
> > +-------------------------------------
> > +- interrupts:  Contains the interrupt information corresponding to the
> > +               combined interrupt of the receiver frame
> > +
> > +Example:
> > +--------
> > +
> > +       mbox_mw_tx: mhu@10000000 {
> > +               compatible = "arm,mhuv2","arm,primecell";
> > +               reg = <0x10000000 0x1000>;
> > +               clocks = <&refclk100mhz>;
> > +               clock-names = "apb_pclk";
> > +               #mbox-cells = <1>;
> > +               mhu-protocol = "multi-word";
> > +               mhu-frame = "sender";
> > +       };
> > +
> > +       mbox_sw_tx: mhu@10000000 {
> > +               compatible = "arm,mhuv2","arm,primecell";
> > +               reg = <0x11000000 0x1000>;
> > +               clocks = <&refclk100mhz>;
> > +               clock-names = "apb_pclk";
> > +               #mbox-cells = <1>;
> > +               mhu-protocol = "single-word";
> > +               mhu-frame = "sender";
> > +       };
> > +
> > +       mbox_db_rx: mhu@10000000 {
> > +               compatible = "arm,mhuv2","arm,primecell";
> > +               reg = <0x12000000 0x1000>;
> > +               clocks = <&refclk100mhz>;
> > +               clock-names = "apb_pclk";
> > +               #mbox-cells = <1>;
> > +               interrupts = <0 45 4>;
> > +               interrupt-names = "mhu_rx";
> > +               mhu-protocol = "doorbell";
> > +               mhu-frame = "receiver";
> > +       };
> > +
> > +       mhu_client: scb@2e000000 {
> > +       compatible = "fujitsu,mb86s70-scb-1.0";
> > +       reg = <0 0x2e000000 0x4000>;
> > +       mboxes =
> > +               // For multi-word frames, client may only instantiate a single
> > +               // mailbox for a mailbox controller
> > +               <&mbox_mw_tx 0>,
> > +
> > +               // For single-word frames, client may instantiate as many
> > +               // mailboxes as there are channel windows in the MHU
> > +                <&mbox_sw_tx 0>,
> > +                <&mbox_sw_tx 1>,
> > +                <&mbox_sw_tx 2>,
> > +                <&mbox_sw_tx 3>,
> > +
> > +               // For doorbell frames, client may instantiate as many mailboxes
> > +               // as there are bits available in the combined number of channel
> > +               // windows ((channel windows * 32) mailboxes)
> > +                <mbox_db_rx 0>,
> > +                <mbox_db_rx 1>,
> > +                ...
> > +                <mbox_db_rx 17>;
> > +       };
>
> If the mhuv2 instance implements, say, 3 channel windows between
> sender (linux) and receiver (firmware), and Linux runs two protocols
> each requiring 1 and 2-word sized messages respectively. The hardware
> supports that by assigning windows [0] and [1,2] to each protocol.
> However, I don't think the driver can support that. Or does it?
>

FWIW, the IP is designed to cover wide range of usecase from IoT to servers
with variable window length. I don't see the need to complicate the driver
supporting mix-n-match at the cost of latency. Each platform choose one
transport protocol for all it's use.

--
Regards,
Sudeep
