Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AEAC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E494206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfFEMWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:22:10 -0400
Received: from foss.arm.com ([217.140.101.70]:58996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfFEMWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:22:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DDAC15BF;
        Wed,  5 Jun 2019 05:22:08 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 705B03F73F;
        Wed,  5 Jun 2019 05:22:05 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna Labs
 Fabric Interrupt Controller Driver
To:     Talel Shenhar <talel@amazon.com>, nicolas.ferre@microchip.com,
        jason@lakedaemon.net, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     dwmw@amazon.co.uk, benh@kernel.crashing.org, jonnyc@amazon.com,
        hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-3-git-send-email-talel@amazon.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <fa6e5a95-d9dd-19f6-43e3-3046e0898bda@arm.com>
Date:   Wed, 5 Jun 2019 13:22:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559731921-14023-3-git-send-email-talel@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Talel,

On 05/06/2019 11:52, Talel Shenhar wrote:
> The Amazon's Annapurna Labs Fabric Interrupt Controller has 32 inputs
> lines. A FIC (Fabric Interrupt Controller) may be cascaded into another FIC

Really? :-(

> or directly to the main CPU Interrupt Controller (e.g. GIC).
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  MAINTAINERS                  |   6 +
>  drivers/irqchip/Kconfig      |  11 ++
>  drivers/irqchip/Makefile     |   1 +
>  drivers/irqchip/irq-al-fic.c | 289 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 307 insertions(+)
>  create mode 100644 drivers/irqchip/irq-al-fic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f485597..b4f5255 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1209,6 +1209,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
>  F:	drivers/irqchip/irq-vic.c
>  
> +AMAZON ANNAPURNA LABS FIC DRIVER
> +M:	Talel Shenhar <talel@amazon.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> +F:	drivers/irqchip/irq-al-fic.c
> +
>  ARM SMMU DRIVERS
>  M:	Will Deacon <will.deacon@arm.com>
>  R:	Robin Murphy <robin.murphy@arm.com>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 51a5ef0..1e51f0f 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -89,6 +89,17 @@ config ALPINE_MSI
>  	select PCI_MSI
>  	select GENERIC_IRQ_CHIP
>  
> +config AL_FIC
> +	bool "Amazon's Annapurna Labs Fabric Interrupt Controller"
> +	depends on OF || COMPILE_TEST
> +	select GENERIC_IRQ_CHIP
> +	select IRQ_DOMAIN
> +	select GENERIC_IRQ_MULTI_HANDLER
> +	select IRQ_DOMAIN_HIERARCHY
> +	select SPARSE_IRQ

GENERIC_IRQ_MULTI_HANDLER and SPARSE_IRQ are to be selected by the
architecture only, and not the individual irqchip drivers.
IRQ_DOMAIN_HIERARCHY is bizarre as well, as this driver doesn't use
hierarchical domains at all.

> +	help
> +	  Support Amazon's Annapurna Labs Fabric Interrupt Controller.
> +
>  config ATMEL_AIC_IRQ
>  	bool
>  	select GENERIC_IRQ_CHIP
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 794c13d..a20eba5 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_IRQCHIP)			+= irqchip.o
>  
> +obj-$(CONFIG_AL_FIC)			+= irq-al-fic.o
>  obj-$(CONFIG_ALPINE_MSI)		+= irq-alpine-msi.o
>  obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
>  obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
> diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
> new file mode 100644
> index 0000000..484ef18
> --- /dev/null
> +++ b/drivers/irqchip/irq-al-fic.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +/* FIC Registers */
> +#define AL_FIC_CAUSE		0x00
> +#define AL_FIC_MASK		0x10
> +#define AL_FIC_CONTROL		0x28
> +
> +#define CONTROL_TRIGGER_RISING	BIT(3)
> +#define CONTROL_MASK_MSI_X	BIT(5)
> +
> +#define NR_FIC_IRQS 32
> +
> +MODULE_AUTHOR("Talel Shenhar");
> +MODULE_DESCRIPTION("Amazon's Annapurna Labs Interrupt Controller Driver");
> +MODULE_LICENSE("GPL v2");
> +
> +enum al_fic_state {
> +	AL_FIC_CLEAN = 0,

What does "CLEAN" mean in this context? Shouldn't it be "UNCONFIGURED"
instead?

> +	AL_FIC_CONFIGURED_LEVEL,
> +	AL_FIC_CONFIGURED_RAISING_EDGE,

s/RAISING/RISING/

> +};
> +
> +struct al_fic {
> +	void __iomem *base;
> +	struct irq_domain *domain;
> +	const char *name;
> +	unsigned int parent_irq;
> +	enum al_fic_state state;
> +};
> +
> +static void al_fic_set_trigger(struct al_fic *fic,
> +			       struct irq_chip_generic *gc,
> +			       enum al_fic_state new_state)
> +{
> +	irq_flow_handler_t handler;
> +	u32 control = readl(fic->base + AL_FIC_CONTROL);

Please use relaxed accessors for all MMIO accesses. Nothing in this code
seem to warrant a bunch of DSBs.

> +
> +	if (new_state == AL_FIC_CONFIGURED_LEVEL) {
> +		handler = handle_level_irq;
> +		control &= ~CONTROL_TRIGGER_RISING;
> +	} else {
> +		handler = handle_edge_irq;
> +		control |= CONTROL_TRIGGER_RISING;
> +	}
> +	gc->chip_types->handler = handler;
> +	fic->state = new_state;
> +	writel(control, fic->base + AL_FIC_CONTROL);
> +}
> +
> +static int al_fic_irq_set_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
> +	struct al_fic *fic = gc->private;
> +	enum al_fic_state new_state;
> +	int ret = 0;
> +
> +	irq_gc_lock(gc);
> +
> +	if (!(flow_type & IRQ_TYPE_LEVEL_HIGH) &&
> +	    !(flow_type & IRQ_TYPE_EDGE_RISING)) {

And what if this gets passed EDGE_BOTH?

> +		pr_err("fic doesn't support flow type %d\n", flow_type);

Drop the pr_err. Returning the error should be enough.

> +		ret = -EPERM;

EPERM? What's the rational for such error code? I'd expect EINVAL.

> +		goto err;
> +	}
> +
> +	new_state = (flow_type & IRQ_TYPE_LEVEL_HIGH) ?
> +		AL_FIC_CONFIGURED_LEVEL : AL_FIC_CONFIGURED_RAISING_EDGE;
> +
> +	/* A given FIC instance can be either all level or all edge triggered.

Comment format.

> +	 * This is generally fixed depending on what pieces of HW it's wired up
> +	 * to.
> +	 *
> +	 * We configure it based on the sensitivity of the first source
> +	 * being setup, and reject any subsequent attempt at configuring it in a
> +	 * different way.

Is that a reliable guess? It also strikes me that the DT binding doesn't
allow for the trigger type to be passed, meaning the individual drivers
have to request the trigger as part of their request_irq() call. I'd
rather you have a complete interrupt specifier in DT, and document the
various limitations of the HW.

> +	 */
> +	if (fic->state == AL_FIC_CLEAN) {
> +		al_fic_set_trigger(fic, gc, new_state);
> +	} else if (fic->state != new_state) {
> +		pr_err("fic %s state already configured to %d\n",
> +		       fic->name, fic->state);
> +		ret = -EPERM;

Same as above.

> +		goto err;
> +	}
> +
> +err:
> +	irq_gc_unlock(gc);
> +
> +	return ret;
> +}
> +
> +static void al_fic_irq_handler(struct irq_desc *desc)
> +{
> +	struct al_fic *fic = irq_desc_get_handler_data(desc);
> +	struct irq_domain *domain = fic->domain;
> +	struct irq_chip *irqchip = irq_desc_get_chip(desc);
> +	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
> +	unsigned long pending;
> +	unsigned int irq;
> +	u32 hwirq;
> +
> +	chained_irq_enter(irqchip, desc);
> +
> +	pending = readl(fic->base + AL_FIC_CAUSE);
> +	pending &= ~gc->mask_cache;
> +
> +	for_each_set_bit(hwirq, &pending, domain->revmap_size) {

I'd rather you don't rely on the internals of the irqdomain
implementation by using revmap_size. You know the exact number of
interrupts, as it is a hardcoded constant. Just use that.

> +		irq = irq_find_mapping(domain, hwirq);
> +		generic_handle_irq(irq);
> +	}
> +
> +	chained_irq_exit(irqchip, desc);
> +}
> +
> +static int al_fic_register(struct device_node *node,
> +			   struct al_fic *fic)
> +{
> +	struct irq_chip_generic *gc;
> +	int ret;
> +
> +	fic->domain = irq_domain_add_linear(node,
> +					    NR_FIC_IRQS,
> +					    &irq_generic_chip_ops,
> +					    fic);
> +	if (!fic->domain) {
> +		pr_err("fail to add irq domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = irq_alloc_domain_generic_chips(fic->domain,
> +					     NR_FIC_IRQS,
> +					     1, fic->name,
> +					     handle_level_irq,
> +					     0, 0, IRQ_GC_INIT_MASK_CACHE);
> +	if (ret) {
> +		pr_err("fail to allocate generic chip (%d)\n", ret);
> +		goto err_domain_remove;
> +	}
> +
> +	gc = irq_get_domain_generic_chip(fic->domain, 0);
> +	gc->reg_base = fic->base;
> +	gc->chip_types->regs.mask = AL_FIC_MASK;
> +	gc->chip_types->regs.ack = AL_FIC_CAUSE;
> +	gc->chip_types->chip.irq_mask = irq_gc_mask_set_bit;
> +	gc->chip_types->chip.irq_unmask = irq_gc_mask_clr_bit;
> +	gc->chip_types->chip.irq_ack = irq_gc_ack_clr_bit;
> +	gc->chip_types->chip.irq_set_type = al_fic_irq_set_type;
> +	gc->chip_types->chip.flags = IRQCHIP_SKIP_SET_WAKE;
> +	gc->private = fic;
> +
> +	irq_set_chained_handler_and_data(fic->parent_irq,
> +					 al_fic_irq_handler,
> +					 fic);
> +	return 0;
> +
> +err_domain_remove:
> +	irq_domain_remove(fic->domain);
> +
> +	return ret;
> +}
> +
> +static void al_fic_hw_init(struct al_fic *fic)
> +{
> +	u32 control = CONTROL_MASK_MSI_X;
> +
> +	/* mask out all interrupts */
> +	writel(0xFFFFFFFF, fic->base + AL_FIC_MASK);> +
> +	/* clear any pending interrupt */
> +	writel(0, fic->base + AL_FIC_CAUSE);
> +
> +	writel(control, fic->base + AL_FIC_CONTROL);

nit: You can directly write CONTROL_MASK_MSI_X there, no need for the
extra variable. And while you're at it, move this function into its caller.

> +}
> +
> +/**
> + * al_fic_wire_init() - initialize and configure fic in wire mode
> + * @of_node: optional pointer to interrupt controller's device tree node.
> + * @base: mmio to fic register
> + * @name: name of the fic
> + * @parent_irq: interrupt of parent
> + *
> + * This API will configure the fic hardware to to work in wire mode.
> + * In wire mode, fic hardware is generating a wire ("wired") interrupt.
> + * Interrupt can be generated based on positive edge or level - configuration is
> + * to be determined based on connected hardware to this fic.
> + *
> + * Returns fic context that allows the user to obtain the irq_domain by using
> + * al_fic_wire_get_domain().

This function is now thankfully gone.

> + */
> +static struct al_fic *al_fic_wire_init(struct device_node *node,
> +				       void __iomem *base,
> +				       const char *name,
> +				       unsigned int parent_irq)
> +{
> +	struct al_fic *fic;
> +	int ret;
> +
> +	if (!base)
> +		return ERR_PTR(-EINVAL);

How can this happen?

> +
> +	fic = kzalloc(sizeof(*fic), GFP_KERNEL);
> +	if (!fic)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fic->base = base;
> +	fic->parent_irq = parent_irq;
> +	fic->name = (name ?: "al-fic-wire");

Under which circumstance can name be NULL?

> +
> +	al_fic_hw_init(fic);
> +
> +	ret = al_fic_register(node, fic);
> +	if (ret) {
> +		pr_err("fail to register irqchip\n");
> +		goto err_free;
> +	}
> +
> +	pr_debug("%s initialized successfully in Legacy mode (parent-irq=%u)\n",
> +		 fic->name, parent_irq);
> +
> +	return fic;
> +
> +err_free:
> +	kfree(fic);
> +	return ERR_PTR(ret);
> +}
> +
> +static int __init al_fic_init_dt(struct device_node *node,
> +				 struct device_node *parent)
> +{
> +	int ret;
> +	void __iomem *base;
> +	unsigned int parent_irq;
> +	struct al_fic *fic;
> +
> +	if (!parent) {
> +		pr_err("%s: unsupported - device require a parent\n",
> +		       node->name);
> +		return -EINVAL;
> +	}
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s: fail to map memory\n", node->name);
> +		return -ENOMEM;
> +	}
> +
> +	parent_irq = irq_of_parse_and_map(node, 0);
> +	if (!parent_irq) {
> +		pr_err("%s: fail to map irq\n", node->name);
> +		ret = -EINVAL;
> +		goto err_unmap;
> +	}
> +
> +	fic = al_fic_wire_init(node,
> +			       base,
> +			       node->name,
> +			       parent_irq);
> +	if (IS_ERR(fic)) {
> +		pr_err("%s: fail to initialize irqchip (%lu)\n",
> +		       node->name,
> +		       PTR_ERR(fic));
> +		ret = PTR_ERR(fic);
> +		goto err_irq_dispose;
> +	}
> +
> +	return 0;
> +
> +err_irq_dispose:
> +	irq_dispose_mapping(parent_irq);
> +err_unmap:
> +	iounmap(base);
> +
> +	return ret;
> +}
> +
> +IRQCHIP_DECLARE(al_fic, "amazon,al-fic", al_fic_init_dt);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
