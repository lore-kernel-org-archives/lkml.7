Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D0C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D789F2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfHPSle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:41:34 -0400
Received: from shell.v3.sk ([90.176.6.54]:59047 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfHPSld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:41:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 985F7D6E09;
        Fri, 16 Aug 2019 20:41:28 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O5hE6RKEUtMU; Fri, 16 Aug 2019 20:41:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3AB24D6E29;
        Fri, 16 Aug 2019 20:41:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZWVEJzeSC459; Fri, 16 Aug 2019 20:41:23 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2D1ABD6E09;
        Fri, 16 Aug 2019 20:41:23 +0200 (CEST)
Message-ID: <e0c0cf62a1f087fd6c1d7307e5e2a65603148341.camel@v3.sk>
Subject: Re: [PATCH 05/19] irqchip/mmp: do not use of_address_to_resource()
 to get mux regs
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <maz@kernel.org>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Date:   Fri, 16 Aug 2019 20:41:22 +0200
In-Reply-To: <16d77ca3-7ad1-3af2-650e-722cf6a931ed@kernel.org>
References: <20190809093158.7969-1-lkundrak@v3.sk>
         <20190809093158.7969-6-lkundrak@v3.sk>
         <16d77ca3-7ad1-3af2-650e-722cf6a931ed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 13:12 +0100, Marc Zyngier wrote:
> On 09/08/2019 10:31, Lubomir Rintel wrote:
> > The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
> > are offsets from intc's base, not addresses on the parent bus. At this
> > point it probably can't be fixed.
> > 
> > On an OLPC XO-1.75 machine, the muxes are children of the intc, not the
> > axi bus, and thus of_address_to_resource() won't work. We should treat
> > the values as mere integers as opposed to bus addresses.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> >  drivers/irqchip/irq-mmp.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> > index 14618dc0bd396..af9cba4a51c2e 100644
> > --- a/drivers/irqchip/irq-mmp.c
> > +++ b/drivers/irqchip/irq-mmp.c
> > @@ -424,9 +424,9 @@ IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
> >  static int __init mmp2_mux_of_init(struct device_node *node,
> >  				   struct device_node *parent)
> >  {
> > -	struct resource res;
> >  	int i, ret, irq, j = 0;
> >  	u32 nr_irqs, mfp_irq;
> > +	u32 reg[4];
> >  
> >  	if (!parent)
> >  		return -ENODEV;
> > @@ -438,18 +438,20 @@ static int __init mmp2_mux_of_init(struct device_node *node,
> >  		pr_err("Not found mrvl,intc-nr-irqs property\n");
> >  		return -EINVAL;
> >  	}
> > -	ret = of_address_to_resource(node, 0, &res);
> > +
> > +	/*
> > +	 * For historical reasonsm, the "regs" property of the
> > +	 * mrvl,mmp2-mux-intc is not a regular * "regs" property containing
> > +	 * addresses on the parent bus, but offsets from the intc's base.
> > +	 * That is why we can't use of_address_to_resource() here.
> > +	 */
> > +	ret = of_property_read_u32_array(node, "reg", reg, ARRAY_SIZE(reg));
> 
> This will return 0 even if you've read less than your expected 4 u32s.
> You may want to try of_property_read_variable_u32_array instead.

Will it? Unless I'm reading the of_property_read_u32_array()
documentation wrong, it suggests that would return -EOVERFLOW in that
case.

It ignores the extra values it the property is larger. I guess that is
not a good thing and we still want to use
of_property_read_variable_u32_array() though.

> >  	if (ret < 0) {
> >  		pr_err("Not found reg property\n");
> >  		return -EINVAL;
> >  	}
> > -	icu_data[i].reg_status = mmp_icu_base + res.start;
> > -	ret = of_address_to_resource(node, 1, &res);
> > -	if (ret < 0) {
> > -		pr_err("Not found reg property\n");
> > -		return -EINVAL;
> > -	}
> > -	icu_data[i].reg_mask = mmp_icu_base + res.start;
> > +	icu_data[i].reg_status = mmp_icu_base + reg[0];
> > +	icu_data[i].reg_mask = mmp_icu_base + reg[2];
> >  	icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
> >  	if (!icu_data[i].cascade_irq)
> >  		return -EINVAL;
> > 
> 
> Thanks,
> 
> 	M.

Thanks
Lubo

