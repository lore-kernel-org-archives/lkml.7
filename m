Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70CDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973F52759A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfFCQ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:57:04 -0400
Received: from foss.arm.com ([217.140.101.70]:55640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfFCQ5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:57:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC65A80D;
        Mon,  3 Jun 2019 09:56:59 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D30F3F5AF;
        Mon,  3 Jun 2019 09:56:57 -0700 (PDT)
Date:   Mon, 3 Jun 2019 17:56:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     peng.fan@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jassisinghbrar@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        shawnguo@kernel.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andre.przywara@arm.com,
        van.freenix@gmail.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC
 mailbox
Message-ID: <20190603165651.GA12196@e107155-lin>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-2-peng.fan@nxp.com>
 <ae4c79f0-4aec-250e-e312-20aba5554665@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4c79f0-4aec-250e-e312-20aba5554665@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:22:16AM -0700, Florian Fainelli wrote:
> On 6/3/19 1:30 AM, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The ARM SMC mailbox binding describes a firmware interface to trigger
> > actions in software layers running in the EL2 or EL3 exception levels.
> > The term "ARM" here relates to the SMC instruction as part of the ARM
> > instruction set, not as a standard endorsed by ARM Ltd.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> > Introduce interrupts as a property.
> >
> > V1:
> > arm,func-ids is still kept as an optional property, because there is no
> > defined SMC funciton id passed from SCMI. So in my test, I still use
> > arm,func-ids for ARM SIP service.
> >
> >  .../devicetree/bindings/mailbox/arm-smc.txt        | 101 +++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > new file mode 100644
> > index 000000000000..401887118c09
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> > @@ -0,0 +1,101 @@

[...]

> > +Optional properties:
> > +- arm,func-ids		An array of 32-bit values specifying the function
> > +			IDs used by each mailbox channel. Those function IDs
> > +			follow the ARM SMC calling convention standard [1].
> > +			There is one identifier per channel and the number
> > +			of supported channels is determined by the length
> > +			of this array.
> > +- interrupts		SPI interrupts may be listed for notification,
> > +			each channel should use a dedicated interrupt
> > +			line.
>
> I would not go about defining a specific kind of interrupt, since SPI is
> a GIC terminology, this firmware interface could be used in premise with
> any parent interrupt controller, for which the concept of a SPI/PPI/SGI
> may not be relevant.
>

While I agree the binding document may not contain specifics, I still
don't see how to use SGI with this. Also note it's generally reserved
for OS future use(IPC) and using this for other than IPC may be bit
challenging IMO. It opens up lots of questions.

--
Regards,
Sudeep
