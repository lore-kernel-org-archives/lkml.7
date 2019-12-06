Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB138C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8752121823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575624776;
	bh=kSyRMi68SgBDafODQr22pNfggBMhQgkSpnzQIYbg1R8=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=0Yj4b3G2zn/V4R312N+/e9JR2TVtkji6RO9/ufXBT7QTd+HyFQ/Vh7t5fLXB8kiEL
	 Pm174x273Lr8DZyMw7xf+TF6AZISKVvO9qeB53CwjNj0gOg6qCevgLpYhQecWacPDb
	 t75YidH+va9FMA95PC8DphuCDa0X8AuDJdsVfGYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLFJcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:32:55 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:50177 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfLFJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:32:54 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1id9yl-0008Mk-IS; Fri, 06 Dec 2019 10:32:51 +0100
To:     Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Add support for multiple PLICs
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Dec 2019 09:32:51 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20191206023156.24732-1-atish.patra@wdc.com>
References: <20191206023156.24732-1-atish.patra@wdc.com>
Message-ID: <1839bf9ef91de2358a7e8ecade361f7a@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: atish.patra@wdc.com, linux-kernel@vger.kernel.org, anup.patel@wdc.com, jason@lakedaemon.net, linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Fixing Palmer's email address]

On 2019-12-06 02:31, Atish Patra wrote:
> Current, PLIC driver can support only 1 PLIC on the board. However,
> there can be multiple PLICs present on a two socket systems in 
> RISC-V.
>
> Modify the driver so that each PLIC handler can have a information
> about individual PLIC registers and an irqdomain associated with it.
>
> Tested on two socket RISC-V system based on VCU118 FPGA connected via
> OmniXtend protocol.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

There seem to be some confusion here about who the author of the patch 
is.
If this is a co-development, please use the appropriate tag.

> ---
>  drivers/irqchip/irq-sifive-plic.c | 81 
> +++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c
> index c72c036aea76..aea1f2f0f0d5 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -55,7 +55,11 @@
>  #define     CONTEXT_THRESHOLD		0x00
>  #define     CONTEXT_CLAIM		0x04
>
> -static void __iomem *plic_regs;
> +struct plic_hw {
> +	struct cpumask lmask;
> +	struct irq_domain *irqdomain;
> +	void __iomem *regs;
> +};

The '_hw' suffix is a bit unfortunate, as there is mostly SW constructs
in this structure. Maybe something more general like 'context' would
be more appropriate.

>
>  struct plic_handler {
>  	bool			present;
> @@ -66,6 +70,7 @@ struct plic_handler {
>  	 */
>  	raw_spinlock_t		enable_lock;
>  	void __iomem		*enable_base;
> +	struct plic_hw		*hw;
>  };
>  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
>
> @@ -84,31 +89,40 @@ static inline void plic_toggle(struct
> plic_handler *handler,
>  }
>
>  static inline void plic_irq_toggle(const struct cpumask *mask,
> -				   int hwirq, int enable)
> +				   struct irq_data *d, int enable)
>  {
>  	int cpu;
> +	struct plic_hw *hw = d->domain->host_data;

The usual construct is to transfer the domain->host_data pointer to
the irq_data->chip_data pointer at map() time, using 
irq_set_chip_data().

You can then retrieve the pointer with irq_get_chip_data(), and save
yourselves some pointer chasing.

>
> -	writel(enable, plic_regs + PRIORITY_BASE + hwirq * 
> PRIORITY_PER_ID);
> +	writel(enable, hw->regs + PRIORITY_BASE + d->hwirq * 
> PRIORITY_PER_ID);
>  	for_each_cpu(cpu, mask) {
>  		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
>
> -		if (handler->present)
> -			plic_toggle(handler, hwirq, enable);
> +		if (handler->present &&
> +		    cpumask_test_cpu(cpu, &handler->hw->lmask))
> +			plic_toggle(handler, d->hwirq, enable);
>  	}
>  }
>
>  static void plic_irq_enable(struct irq_data *d)
>  {
> -	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> -					   cpu_online_mask);
> +	struct cpumask amask;
> +	unsigned int cpu;
> +	struct plic_hw *hw = d->domain->host_data;
> +
> +	cpumask_and(&amask, &hw->lmask, cpu_online_mask);
> +	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> +					   &amask);
>  	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
>  		return;
> -	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
> +	plic_irq_toggle(cpumask_of(cpu), d, 1);
>  }
>
>  static void plic_irq_disable(struct irq_data *d)
>  {
> -	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
> +	struct plic_hw *hw = d->domain->host_data;
> +
> +	plic_irq_toggle(&hw->lmask, d, 0);
>  }
>
>  #ifdef CONFIG_SMP
> @@ -116,18 +130,22 @@ static int plic_set_affinity(struct irq_data 
> *d,
>  			     const struct cpumask *mask_val, bool force)
>  {
>  	unsigned int cpu;
> +	struct cpumask amask;
> +	struct plic_hw *hw = d->domain->host_data;
> +
> +	cpumask_and(&amask, &hw->lmask, mask_val);

So this means that an interrupt cannot move between sockets?
How is that going to work with CPU hotplug? This seems like
a pretty bad restriction for anything but the most basic
experimental platform.

>
>  	if (force)
> -		cpu = cpumask_first(mask_val);
> +		cpu = cpumask_first(&amask);
>  	else
> -		cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +		cpu = cpumask_any_and(&amask, cpu_online_mask);
>
>  	if (cpu >= nr_cpu_ids)
>  		return -EINVAL;
>
>  	if (!irqd_irq_disabled(d)) {
> -		plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
> -		plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
> +		plic_irq_toggle(&hw->lmask, d, 0);
> +		plic_irq_toggle(cpumask_of(cpu), d, 1);
>  	}
>
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> @@ -163,8 +181,6 @@ static const struct irq_domain_ops 
> plic_irqdomain_ops = {
>  	.xlate		= irq_domain_xlate_onecell,
>  };
>
> -static struct irq_domain *plic_irqdomain;
> -
>  /*
>   * Handling an interrupt is a two-step process: first you claim the
> interrupt
>   * by reading the claim register, then you complete the interrupt by 
> writing
> @@ -181,7 +197,7 @@ static void plic_handle_irq(struct pt_regs *regs)
>
>  	csr_clear(sie, SIE_SEIE);
>  	while ((hwirq = readl(claim))) {
> -		int irq = irq_find_mapping(plic_irqdomain, hwirq);
> +		int irq = irq_find_mapping(handler->hw->irqdomain, hwirq);
>
>  		if (unlikely(irq <= 0))
>  			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
> @@ -212,15 +228,17 @@ static int __init plic_init(struct device_node 
> *node,
>  {
>  	int error = 0, nr_contexts, nr_handlers = 0, i;
>  	u32 nr_irqs;
> +	struct plic_hw *hw;
>
> -	if (plic_regs) {
> -		pr_warn("PLIC already present.\n");
> -		return -ENXIO;
> -	}
> +	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
> +	if (!hw)
> +		return -ENOMEM;
>
> -	plic_regs = of_iomap(node, 0);
> -	if (WARN_ON(!plic_regs))
> -		return -EIO;
> +	hw->regs = of_iomap(node, 0);
> +	if (WARN_ON(!hw->regs)) {
> +		error = -EIO;
> +		goto out_freehw;
> +	}
>
>  	error = -EINVAL;
>  	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
> @@ -234,9 +252,9 @@ static int __init plic_init(struct device_node 
> *node,
>  		goto out_iounmap;
>
>  	error = -ENOMEM;
> -	plic_irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> -			&plic_irqdomain_ops, NULL);
> -	if (WARN_ON(!plic_irqdomain))
> +	hw->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
> +			&plic_irqdomain_ops, hw);
> +	if (WARN_ON(!hw->irqdomain))
>  		goto out_iounmap;
>
>  	for (i = 0; i < nr_contexts; i++) {
> @@ -279,13 +297,14 @@ static int __init plic_init(struct device_node 
> *node,
>  			goto done;
>  		}
>
> +		cpumask_set_cpu(cpu, &hw->lmask);
>  		handler->present = true;
>  		handler->hart_base =
> -			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> +			hw->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
>  		raw_spin_lock_init(&handler->enable_lock);
>  		handler->enable_base =
> -			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
> -
> +			hw->regs + ENABLE_BASE + i * ENABLE_PER_HART;
> +		handler->hw = hw;
>  done:
>  		/* priority must be > threshold to trigger an interrupt */
>  		writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
> @@ -300,7 +319,9 @@ static int __init plic_init(struct device_node 
> *node,
>  	return 0;
>
>  out_iounmap:
> -	iounmap(plic_regs);
> +	iounmap(hw->regs);
> +out_freehw:
> +	kfree(hw);
>  	return error;
>  }

This otherwise seems like a very straightforward change.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
