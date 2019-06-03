Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882D9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A27C27281
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfFCRTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:19:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56306 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfFCRTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:19:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3258480D;
        Mon,  3 Jun 2019 10:19:16 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0D223F5AF;
        Mon,  3 Jun 2019 10:19:13 -0700 (PDT)
Date:   Mon, 3 Jun 2019 18:18:56 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, <peng.fan@nxp.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>, <shawnguo@kernel.org>, <festevam@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <van.freenix@gmail.com>
Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
Message-ID: <20190603181856.34996aaa@donnerap.cambridge.arm.com>
In-Reply-To: <20190603165651.GA12196@e107155-lin>
References: <20190603083005.4304-1-peng.fan@nxp.com>
        <20190603083005.4304-2-peng.fan@nxp.com>
        <ae4c79f0-4aec-250e-e312-20aba5554665@gmail.com>
        <20190603165651.GA12196@e107155-lin>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 17:56:51 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

Hi,

> On Mon, Jun 03, 2019 at 09:22:16AM -0700, Florian Fainelli wrote:
> > On 6/3/19 1:30 AM, peng.fan@nxp.com wrote:  
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
> > > arm,func-ids is still kept as an optional property, because there is no
> > > defined SMC funciton id passed from SCMI. So in my test, I still use
> > > arm,func-ids for ARM SIP service.
> > >
> > >  .../devicetree/bindings/mailbox/arm-smc.txt        | 101 +++++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > new file mode 100644
> > > index 000000000000..401887118c09
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > > @@ -0,0 +1,101 @@  
> 
> [...]
> 
> > > +Optional properties:
> > > +- arm,func-ids		An array of 32-bit values specifying the function
> > > +			IDs used by each mailbox channel. Those function IDs
> > > +			follow the ARM SMC calling convention standard [1].
> > > +			There is one identifier per channel and the number
> > > +			of supported channels is determined by the length
> > > +			of this array.
> > > +- interrupts		SPI interrupts may be listed for notification,
> > > +			each channel should use a dedicated interrupt
> > > +			line.  
> >
> > I would not go about defining a specific kind of interrupt, since SPI is
> > a GIC terminology, this firmware interface could be used in premise with
> > any parent interrupt controller, for which the concept of a SPI/PPI/SGI
> > may not be relevant.
> >  
> 
> While I agree the binding document may not contain specifics, I still
> don't see how to use SGI with this. Also note it's generally reserved
> for OS future use(IPC) and using this for other than IPC may be bit
> challenging IMO. It opens up lots of questions.

Well, a PPI might be possible to use, although it's somewhat dodgy to hijack the GIC's (re-)distributor from EL3 to write to GICD_ISPENDR<n>. Need to ask Marc about his feelings towards this. But it's definitely possible from a hypervisor to inject arbitrary interrupts into a guest.

But more importantly: is there any actual reason this needs to be a GIC interrupt? If I understand the code correctly, this could just be any interrupt, including one of an interrupt combiner or a GPIO chip. So why not just use the standard wording of: "exactly one interrupt specifier for each channel"?

By the way: Shouldn't new bindings use the YAML format instead?

Cheers,
Andre.
