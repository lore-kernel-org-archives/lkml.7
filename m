Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819FC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4472173C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562679076;
	bh=3wGKLVeO3fCGNI21pE8g2mlHTvyGrxaYU5GH0XBhbZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bsbJmiBcI07NaQyirT+yTMT17vNkwgyJvMhy4ACi+NPJey78jP/Yf3DPKQNLGRQes
	 WfTAswEcDAYgLvpf/+nqL79UTdyXQIWhIu+HG7uqtA2kI58NWSWHjxQPKnbNdse6it
	 7ig/mJ03eSF4SGukZSF/bXPeBPPbDbPNuUqjK4q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGINbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 09:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfGINbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:31:14 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E241D2177B;
        Tue,  9 Jul 2019 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562679074;
        bh=3wGKLVeO3fCGNI21pE8g2mlHTvyGrxaYU5GH0XBhbZo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oJK3Q6RYanmyImqByoLRPXFSyqVQo0YKDjCdIGRapuZc4R0OQICLdUxpTi1+uXk72
         g6G5OAuEdlx8j1zpQ7HYca1h5rjHXc5e4+ro5jra58ERLlYOklGQ5kuKTmK0Mgc5vf
         6zy7EVJXD7EK1s9Fw456w4dpPUTUN+4v+uIpA9KY=
Received: by mail-qt1-f178.google.com with SMTP id h21so19398082qtn.13;
        Tue, 09 Jul 2019 06:31:13 -0700 (PDT)
X-Gm-Message-State: APjAAAV84MEHrQwzLspxmyRNzKYg02o+Pk101JiH0Kao+fGgK7Yx6/NR
        qDZr3MJU3UY9NynOfwRSCt+l43u28gjjwOWjqA==
X-Google-Smtp-Source: APXvYqytEduM93n88NZkMIr8ful2eqPnknrfJRQvFdxqesowuhzWWeW5qOJcaL15ql5Jgia252bFJ1RdwE61vkN36F8=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr19512118qve.148.1562679073072;
 Tue, 09 Jul 2019 06:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190603083005.4304-1-peng.fan@nxp.com> <20190603083005.4304-2-peng.fan@nxp.com>
 <20190708221947.GA13552@bogus> <AM0PR04MB44816C38C43A3C8E09E8FFF588F10@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44816C38C43A3C8E09E8FFF588F10@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Jul 2019 07:31:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+YK0mNiNK_wuoGcor6aKVx-hQYy_awc2AQg9jQe6iVQ@mail.gmail.com>
Message-ID: <CAL_JsqK+YK0mNiNK_wuoGcor6aKVx-hQYy_awc2AQg9jQe6iVQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC mailbox
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 7:40 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Rob,
>
> > Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
> > mailbox
> >
> > On Mon, Jun 03, 2019 at 04:30:04PM +0800, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The ARM SMC mailbox binding describes a firmware interface to trigger
> > > actions in software layers running in the EL2 or EL3 exception levels.
> > > The term "ARM" here relates to the SMC instruction as part of the ARM
> > > instruction set, not as a standard endorsed by ARM Ltd.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V2:
> > > Introduce interrupts as a property.
> > >
> > > V1:
> > > arm,func-ids is still kept as an optional property, because there is
> > > no defined SMC funciton id passed from SCMI. So in my test, I still
> > > use arm,func-ids for ARM SIP service.
> > >
> > >  .../devicetree/bindings/mailbox/arm-smc.txt        | 101
> > +++++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > new file mode 100644
> > > index 000000000000..401887118c09
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > @@ -0,0 +1,101 @@
> > > +ARM SMC Mailbox Interface
> > > +=========================
> > > +
> > > +This mailbox uses the ARM smc (secure monitor call) instruction to
> > > +trigger a mailbox-connected activity in firmware, executing on the
> > > +very same core as the caller. By nature this operation is synchronous
> > > +and this mailbox provides no way for asynchronous messages to be
> > > +delivered the other way round, from firmware to the OS, but
> > > +asynchronous notification could also be supported. However the value
> > > +of r0/w0/x0 the firmware returns after the smc call is delivered as a
> > > +received message to the mailbox framework, so a synchronous
> > > +communication can be established, for a asynchronous notification, no
> > > +value will be returned. The exact meaning of both the action the
> > > +mailbox triggers as well as the return value is defined by their users and is
> > not subject to this binding.
> > > +
> > > +One use case of this mailbox is the SCMI interface, which uses shared
> > > +memory to transfer commands and parameters, and a mailbox to trigger
> > > +a function call. This allows SoCs without a separate management
> > > +processor (or when such a processor is not available or used) to use
> > > +this standardized interface anyway.
> > > +
> > > +This binding describes no hardware, but establishes a firmware interface.
> > > +Upon receiving an SMC using one of the described SMC function
> > > +identifiers, the firmware is expected to trigger some mailbox connected
> > functionality.
> > > +The communication follows the ARM SMC calling convention[1].
> > > +Firmware expects an SMC function identifier in r0 or w0. The
> > > +supported identifiers are passed from consumers, or listed in the the
> > > +arm,func-ids properties as described below. The firmware can return
> > > +one value in the first SMC result register, it is expected to be an
> > > +error value, which shall be propagated to the mailbox client.
> > > +
> > > +Any core which supports the SMC or HVC instruction can be used, as
> > > +long as a firmware component running in EL3 or EL2 is handling these calls.
> > > +
> > > +Mailbox Device Node:
> > > +====================
> > > +
> > > +This node is expected to be a child of the /firmware node.
> > > +
> > > +Required properties:
> > > +--------------------
> > > +- compatible:              Shall be "arm,smc-mbox"
> > > +- #mbox-cells              Shall be 1 - the index of the channel needed.
> > > +- arm,num-chans            The number of channels supported.
> > > +- method:          A string, either:
> > > +                   "hvc": if the driver shall use an HVC call, or
> > > +                   "smc": if the driver shall use an SMC call.
> > > +
> > > +Optional properties:
> > > +- arm,func-ids             An array of 32-bit values specifying the function
> > > +                   IDs used by each mailbox channel. Those function IDs
> > > +                   follow the ARM SMC calling convention standard [1].
> > > +                   There is one identifier per channel and the number
> > > +                   of supported channels is determined by the length
> > > +                   of this array.
> > > +- interrupts               SPI interrupts may be listed for notification,
> > > +                   each channel should use a dedicated interrupt
> > > +                   line.
> > > +
> > > +Example:
> > > +--------
> > > +
> > > +   sram@910000 {
> > > +           compatible = "mmio-sram";
> > > +           reg = <0x0 0x93f000 0x0 0x1000>;
> > > +           #address-cells = <1>;
> > > +           #size-cells = <1>;
> > > +           ranges = <0 0x0 0x93f000 0x1000>;
> > > +
> > > +           cpu_scp_lpri: scp-shmem@0 {
> > > +                   compatible = "arm,scmi-shmem";
> > > +                   reg = <0x0 0x200>;
> > > +           };
> > > +
> > > +           cpu_scp_hpri: scp-shmem@200 {
> > > +                   compatible = "arm,scmi-shmem";
> > > +                   reg = <0x200 0x200>;
> > > +           };
> > > +   };
> > > +
> > > +   smc_mbox: mailbox {
> >
> > This should be a child of 'firmware' node at least and really a child of the
> > firmware component that implements the feature.
>
> I checked other mbox driver, including the mbox used by ti sci, mbox used by
> i.MX8QXP. both mbox dts node not a child a firmware node,

Because those are actual h/w blocks and not implemented in firmware calls?

> I am not sure why put mbox node into a child a firmware node here.

If it is an interface provided by firmware, then it goes under /firmware.

Rob
