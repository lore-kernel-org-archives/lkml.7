Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D44CC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F9F206DF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566065935;
	bh=ajbTeKxBc5eehrIoCvTp7T61OlNRVuznELfGxUMvpVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FrCcPUA9lBYJjQL4TxC7ORBtEbERBLvZd2bKOzOgJmubmW62by3ezAZza0+oKlxtM
	 mt6+Ymx2COBGr4LzXskA401TvpDkaCIx0vOpHLmq1Sfz0ztcj/a87k4Ab5XewuLGML
	 RCZ1iIiGaHfUBPwHLdLfzGnORvJQYXtMiPvlbV8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfHQSR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 14:17:29 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:54133 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfHQSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 14:17:28 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1hz3GL-0002bG-LD; Sat, 17 Aug 2019 20:17:13 +0200
Date:   Sat, 17 Aug 2019 19:17:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/19] irqchip/mmp: do not use of_address_to_resource()
 to get mux regs
Message-ID: <20190817191710.539daa01@why>
In-Reply-To: <e0c0cf62a1f087fd6c1d7307e5e2a65603148341.camel@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk>
        <20190809093158.7969-6-lkundrak@v3.sk>
        <16d77ca3-7ad1-3af2-650e-722cf6a931ed@kernel.org>
        <e0c0cf62a1f087fd6c1d7307e5e2a65603148341.camel@v3.sk>
Organization: Approximate
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: lkundrak@v3.sk, olof@lixom.net, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, kishon@ti.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, pavel@ucw.cz
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 20:41:22 +0200
Lubomir Rintel <lkundrak@v3.sk> wrote:

> On Fri, 2019-08-09 at 13:12 +0100, Marc Zyngier wrote:
> > On 09/08/2019 10:31, Lubomir Rintel wrote:  
> > > The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
> > > are offsets from intc's base, not addresses on the parent bus. At this
> > > point it probably can't be fixed.
> > > 
> > > On an OLPC XO-1.75 machine, the muxes are children of the intc, not the
> > > axi bus, and thus of_address_to_resource() won't work. We should treat
> > > the values as mere integers as opposed to bus addresses.
> > > 
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > ---
> > >  drivers/irqchip/irq-mmp.c | 20 +++++++++++---------
> > >  1 file changed, 11 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> > > index 14618dc0bd396..af9cba4a51c2e 100644
> > > --- a/drivers/irqchip/irq-mmp.c
> > > +++ b/drivers/irqchip/irq-mmp.c
> > > @@ -424,9 +424,9 @@ IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
> > >  static int __init mmp2_mux_of_init(struct device_node *node,
> > >  				   struct device_node *parent)
> > >  {
> > > -	struct resource res;
> > >  	int i, ret, irq, j = 0;
> > >  	u32 nr_irqs, mfp_irq;
> > > +	u32 reg[4];
> > >  
> > >  	if (!parent)
> > >  		return -ENODEV;
> > > @@ -438,18 +438,20 @@ static int __init mmp2_mux_of_init(struct device_node *node,
> > >  		pr_err("Not found mrvl,intc-nr-irqs property\n");
> > >  		return -EINVAL;
> > >  	}
> > > -	ret = of_address_to_resource(node, 0, &res);
> > > +
> > > +	/*
> > > +	 * For historical reasonsm, the "regs" property of the
> > > +	 * mrvl,mmp2-mux-intc is not a regular * "regs" property containing
> > > +	 * addresses on the parent bus, but offsets from the intc's base.
> > > +	 * That is why we can't use of_address_to_resource() here.
> > > +	 */
> > > +	ret = of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));  
> > 
> > This will return 0 even if you've read less than your expected 4 u32s.
> > You may want to try of_property_read_variable_u32_array instead.  
> 
> Will it? Unless I'm reading the of_property_read_u32_array()
> documentation wrong, it suggests that would return -EOVERFLOW in that
> case.

You're appear to be right, and I read it wrong.

> 
> It ignores the extra values it the property is larger. I guess that is
> not a good thing and we still want to use
> of_property_read_variable_u32_array() though.

It doesn't hurt to check for all possible problems, specially given
that this machine doesn't appear to have a mainline DT (and its OF
implementation looks a bit buggy).

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
