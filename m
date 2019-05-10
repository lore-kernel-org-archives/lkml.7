Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EF5C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D054E217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557476777;
	bh=rrSz/31XqvMlkj82ObMAQ7OInQmjbId1PH81Aw70gB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W5g+OVFmOMq5D/9BCjZNFeDCLzRHDlVQr7YBSDbXz6D2ct4sLC+n4hxQCcxBOR2IF
	 5U4rZ0u9lCJ7ArF4mZ3PNDv9hVjaf4L7hlxzOB+LXV9mOyZxukX9hyZ3O/etIUHdl9
	 KZqDVvB7PTZRh35ERA0jkM19/wRpE1Iok4lj8JdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfEJI0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfEJI0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:26:16 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093DA20850;
        Fri, 10 May 2019 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557476774;
        bh=rrSz/31XqvMlkj82ObMAQ7OInQmjbId1PH81Aw70gB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfiINcs2CIy1PNYYB1NrXVZFepO1zcvf3dnrv22dV2sknUx3pReWvpNeSGWZnkyla
         p5RSSyF2sZ4Q1mhsdt2421yuJJX1oFrDgyXD52xkF2C2m7/aVGOddy583xCCviXt9s
         FSh9VzCNPHI6AYJTd2OTrHZagoR/8qgSweo8lVxg=
Date:   Fri, 10 May 2019 16:25:10 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 4/7] irqchip/irq-csky-mpintc: Add triger type and
 priority
Message-ID: <20190510082510.GA25926@guoren-Inspiron-7460>
References: <1550455483-11710-1-git-send-email-guoren@kernel.org>
 <1550455483-11710-4-git-send-email-guoren@kernel.org>
 <20190218143823.593e7b5b@why.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218143823.593e7b5b@why.wild-wind.fr.eu.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Marc,

Sorry for late reply:

On Mon, Feb 18, 2019 at 02:38:23PM +0000, Marc Zyngier wrote:
> On Mon, 18 Feb 2019 10:04:40 +0800
> guoren@kernel.org wrote:
> 
> > From: Guo Ren <ren_guo@c-sky.com>
> > 
> > Support 4 triger types:
> >  - IRQ_TYPE_LEVEL_HIGH
> >  - IRQ_TYPE_LEVEL_LOW
> >  - IRQ_TYPE_EDGE_RISING
> >  - IRQ_TYPE_EDGE_FALLING
> > 
> > Support 0-255 priority setting for each irq.
> > 
> > Changelog:
> >  - Fixup this_cpu_read() preempted problem.
> >  - Optimize the coding style.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  drivers/irqchip/irq-csky-mpintc.c | 105 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 104 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
> > index 99d3f3f..07a3752 100644
> > --- a/drivers/irqchip/irq-csky-mpintc.c
> > +++ b/drivers/irqchip/irq-csky-mpintc.c
> > @@ -17,6 +17,7 @@
> >  #include <asm/reg_ops.h>
> >  
> >  static struct irq_domain *root_domain;
> > +
> >  static void __iomem *INTCG_base;
> >  static void __iomem *INTCL_base;
> >  
> > @@ -29,9 +30,12 @@ static void __iomem *INTCL_base;
> >  
> >  #define INTCG_ICTLR	0x0
> >  #define INTCG_CICFGR	0x100
> > +#define INTCG_CIPRTR	0x200
> >  #define INTCG_CIDSTR	0x1000
> >  
> >  #define INTCL_PICTLR	0x0
> > +#define INTCL_CFGR	0x14
> > +#define INTCL_PRTR	0x20
> >  #define INTCL_SIGR	0x60
> >  #define INTCL_RDYIR	0x6c
> >  #define INTCL_SENR	0xa0
> > @@ -40,6 +44,51 @@ static void __iomem *INTCL_base;
> >  
> >  static DEFINE_PER_CPU(void __iomem *, intcl_reg);
> >  
> > +static unsigned long *__trigger;
> > +static unsigned long *__priority;
> > +
> > +#define IRQ_OFFSET(irq) ((irq < COMM_IRQ_BASE) ? irq : (irq - COMM_IRQ_BASE))
> > +
> > +#define TRIG_BYTE_OFFSET(i)	((((i) * 2) / 32) * 4)
> > +#define TRIG_BIT_OFFSET(i)	 (((i) * 2) % 32)
> > +
> > +#define PRI_BYTE_OFFSET(i)	((((i) * 8) / 32) * 4)
> > +#define PRI_BIT_OFFSET(i)	 (((i) * 8) % 32)
> > +
> > +#define TRIG_VAL(trigger, irq)	(trigger << TRIG_BIT_OFFSET(IRQ_OFFSET(irq)))
> > +#define TRIG_VAL_MSK(irq)	    (~(3 << TRIG_BIT_OFFSET(IRQ_OFFSET(irq))))
> > +#define PRI_VAL(priority, irq)	(priority << PRI_BIT_OFFSET(IRQ_OFFSET(irq)))
> > +#define PRI_VAL_MSK(irq)	  (~(0xff << PRI_BIT_OFFSET(IRQ_OFFSET(irq))))
> > +
> > +#define TRIG_BASE(irq) \
> > +	(TRIG_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
> > +	(this_cpu_read(intcl_reg) + INTCL_CFGR) : (INTCG_base + INTCG_CICFGR)))
> > +
> > +#define PRI_BASE(irq) \
> > +	(PRI_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
> > +	(this_cpu_read(intcl_reg) + INTCL_PRTR) : (INTCG_base + INTCG_CIPRTR)))
> > +
> > +static DEFINE_SPINLOCK(setup_lock);
> > +static void setup_trigger_priority(unsigned long irq, unsigned long trigger,
> > +				   unsigned long priority)
> > +{
> > +	unsigned int tmp;
> > +
> > +	spin_lock(&setup_lock);
> > +
> > +	/* setup trigger */
> > +	tmp = readl_relaxed(TRIG_BASE(irq)) & TRIG_VAL_MSK(irq);
> > +
> > +	writel_relaxed(tmp | TRIG_VAL(trigger, irq), TRIG_BASE(irq));
> > +
> > +	/* setup priority */
> > +	tmp = readl_relaxed(PRI_BASE(irq)) & PRI_VAL_MSK(irq);
> > +
> > +	writel_relaxed(tmp | PRI_VAL(priority, irq), PRI_BASE(irq));
> > +
> > +	spin_unlock(&setup_lock);
> > +}
> > +
> >  static void csky_mpintc_handler(struct pt_regs *regs)
> >  {
> >  	void __iomem *reg_base = this_cpu_read(intcl_reg);
> > @@ -52,6 +101,9 @@ static void csky_mpintc_enable(struct irq_data *d)
> >  {
> >  	void __iomem *reg_base = this_cpu_read(intcl_reg);
> >  
> > +	setup_trigger_priority(d->hwirq, __trigger[d->hwirq],
> > +				 __priority[d->hwirq]);
> > +
> >  	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
> >  }
> >  
> > @@ -69,6 +121,28 @@ static void csky_mpintc_eoi(struct irq_data *d)
> >  	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
> >  }
> >  
> > +static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +	switch (type & IRQ_TYPE_SENSE_MASK) {
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		__trigger[d->hwirq] = 0;
> > +		break;
> > +	case IRQ_TYPE_LEVEL_LOW:
> > +		__trigger[d->hwirq] = 1;
> > +		break;
> > +	case IRQ_TYPE_EDGE_RISING:
> > +		__trigger[d->hwirq] = 2;
> > +		break;
> > +	case IRQ_TYPE_EDGE_FALLING:
> > +		__trigger[d->hwirq] = 3;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  #ifdef CONFIG_SMP
> >  static int csky_irq_set_affinity(struct irq_data *d,
> >  				 const struct cpumask *mask_val,
> > @@ -101,6 +175,7 @@ static struct irq_chip csky_irq_chip = {
> >  	.irq_eoi	= csky_mpintc_eoi,
> >  	.irq_enable	= csky_mpintc_enable,
> >  	.irq_disable	= csky_mpintc_disable,
> > +	.irq_set_type	= csky_mpintc_set_type,
> >  #ifdef CONFIG_SMP
> >  	.irq_set_affinity = csky_irq_set_affinity,
> >  #endif
> > @@ -121,9 +196,29 @@ static int csky_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >  	return 0;
> >  }
> >  
> > +static int csky_irq_domain_xlate_cells(struct irq_domain *d,
> > +		struct device_node *ctrlr, const u32 *intspec,
> > +		unsigned int intsize, unsigned long *out_hwirq,
> > +		unsigned int *out_type)
> > +{
> > +	if (WARN_ON(intsize < 1))
> > +		return -EINVAL;
> > +
> > +	*out_hwirq = intspec[0];
> > +	if (intsize > 1)
> > +		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
> > +	else
> > +		*out_type = IRQ_TYPE_NONE;
> 
> What does IRQ_TYPE_NONE mean in this context? Shouldn't it actually be
> whatever the HW defaults to? Or even better, whatever was expected in
> the previous definition of the DT binding?
Yes, it shouldn't use IRQ_TYPE_NONE and I'll use IRQ_TYPE_LEVEL_HIGH.

> 
> > +
> > +	if (intsize > 2)
> > +		__priority[*out_hwirq] = intspec[2];
> 
> And what is the used priority in this case?
C-SKY MPINTC could support interrupt's priority and this will be set in
INTCG_CIPRTR register. It is set in csky_mpintc_enable function.

> 
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct irq_domain_ops csky_irqdomain_ops = {
> >  	.map	= csky_irqdomain_map,
> > -	.xlate	= irq_domain_xlate_onecell,
> > +	.xlate	= csky_irq_domain_xlate_cells,
> >  };
> >  
> >  #ifdef CONFIG_SMP
> > @@ -157,6 +252,14 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
> >  	if (ret < 0)
> >  		nr_irq = INTC_IRQS;
> >  
> > +	__priority = kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL);
> > +	if (__priority == NULL)
> > +		return -ENXIO;
> > +
> > +	__trigger  = kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL);
> > +	if (__trigger == NULL)
> > +		return -ENXIO;
> 
> Maybe you should consider initializing these arrays to something that
> makes sense for the case where the DT doesn't carry this information
> (which is 100% of the DTs up to this point).
Yes, and zero is enough.

/**
 * kcalloc - allocate memory for an array. The memory is set to zero.
 * @n: number of elements.
 * @size: element size.
 * @flags: the type of memory to allocate (see kmalloc).
 */
static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
{
	return kmalloc_array(n, size, flags | __GFP_ZERO);
}

> 
> > +
> >  	if (INTCG_base == NULL) {
> >  		INTCG_base = ioremap(mfcr("cr<31, 14>"),
> >  				     INTCL_SIZE*nr_cpu_ids + INTCG_SIZE);
> 
> 
> Not directly related to this patch: Please add a cover letter to you
> patch series, and describe the goal of the whole series as well as the
> changes you make along the way. It will definitely help the reviewers.
I'll seperate them first.

Best Regards
 Guo Ren
