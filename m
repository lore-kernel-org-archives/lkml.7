Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5D2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FC020872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfDQOPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:15:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45440 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731743AbfDQOPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:15:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9038F374;
        Wed, 17 Apr 2019 07:15:02 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 003573F557;
        Wed, 17 Apr 2019 07:14:57 -0700 (PDT)
Subject: Re: [PATCH v6 09/12] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jason@lakedaemon.net
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
 <20190410041358.16809-10-lokeshvutla@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <58ad996c-c7f6-5906-6516-b39132522903@arm.com>
Date:   Wed, 17 Apr 2019 15:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410041358.16809-10-lokeshvutla@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lokesh,

On 10/04/2019 05:13, Lokesh Vutla wrote:
> Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
> which is an interrupt controller that does the following:
> - Converts events to interrupts that can be understood by
>   an interrupt router.
> - Allows for multiplexing of events to interrupts.
> 
> Configuration of the interrupt aggregator registers can only be done by
> a system co-processor and the driver needs to send a message to this
> co processor over TISCI protocol.
> 
> Add support for Interrupt Aggregator driver with 2 IRQ Domains:
> - INTA MSI domain that interfaces the devices using which interrupts can be
>   allocated dynamically.
> - INTA domain that is parent to the MSI domain that manages the interrupt
>   resources.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v5:
> - Moved all the allocation of events and parent irqs to .irq_request_resources
>   callback of irqchip. This is based on the offline discussion with Marc.
> 
> Marc,
> 	This version has a deviation from our discussion:
> - Could not create separate irq_domains for each output(vint) of INTA, instead
>   stick to a single irq_domain for the entire INTA. Because when creating
>   msi_domain there is no parent available to attach. Even then I create
>   irq_domains for all the available vints during probe, how do we decide
>   which is the parent of msi_domain?

Yeah, you're right. The top-down allocation assumes that we already have
setup the domain hierarchy, and this delayed allocation scheme breaks
it. Oh well, never mind.

> 
> 
>  MAINTAINERS                       |   1 +
>  drivers/irqchip/Kconfig           |  11 +
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-ti-sci-inta.c | 622 ++++++++++++++++++++++++++++++
>  4 files changed, 635 insertions(+)
>  create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90173038f674..ba88b3033fe4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15352,6 +15352,7 @@ F:	drivers/reset/reset-ti-sci.c
>  F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>  F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
>  F:	drivers/irqchip/irq-ti-sci-intr.c
> +F:	drivers/irqchip/irq-ti-sci-inta.c
>  
>  Texas Instruments ASoC drivers
>  M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index a1ff64c1d40d..946c062fcec0 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -436,6 +436,17 @@ config TI_SCI_INTR_IRQCHIP
>  	  If you wish to use interrupt router irq resources managed by the
>  	  TI System Controller, say Y here. Otherwise, say N.
>  
> +config TI_SCI_INTA_IRQCHIP
> +	bool
> +	depends on TI_SCI_PROTOCOL && ARCH_K3
> +	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY
> +	help
> +	  This enables the irqchip driver support for K3 Interrupt aggregator
> +	  over TI System Control Interface available on some new TI's SoCs.
> +	  If you wish to use interrupt aggregator irq resources managed by the
> +	  TI System Controller, say Y here. Otherwise, say N.
> +
>  endmenu
>  
>  config SIFIVE_PLIC
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index fa5c865788b5..8a33013da953 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -98,3 +98,4 @@ obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
>  obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>  obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
> +obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> new file mode 100644
> index 000000000000..3eb935ebe10f
> --- /dev/null
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -0,0 +1,622 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments' K3 Interrupt Aggregator irqchip driver
> + *
> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
> + *	Lokesh Vutla <lokeshvutla@ti.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/msi.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/irqdomain.h>
> +#include <linux/interrupt.h>
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <asm-generic/msi.h>
> +
> +#define TI_SCI_DEV_ID_MASK	0xffff
> +#define TI_SCI_DEV_ID_SHIFT	16
> +#define TI_SCI_IRQ_ID_MASK	0xffff
> +#define TI_SCI_IRQ_ID_SHIFT	0
> +#define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >> (TI_SCI_DEV_ID_SHIFT)) & \
> +				 (TI_SCI_DEV_ID_MASK))
> +#define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
> +
> +#define MAX_EVENTS_PER_VINT	64
> +#define VINT_ENABLE_SET_OFFSET	0x0
> +#define VINT_ENABLE_CLR_OFFSET	0x8
> +#define VINT_STATUS_OFFSET	0x18
> +
> +/**
> + * struct ti_sci_inta_event_desc - Description of an event coming to
> + *				   Interrupt Aggregator. This serves
> + *				   as a mapping table between global
> + *				   event and hwirq.
> + * @global_event:	Global event number corresponding to this event
> + * @hwirq:		Hwirq of the incoming interrupt
> + */
> +struct ti_sci_inta_event_desc {
> +	u16 global_event;
> +	u32 hwirq;
> +};
> +
> +/**
> + * struct ti_sci_inta_vint_desc - Description of a virtual interrupt coming out
> + *				  of Interrupt Aggregator.
> + * @domain:		Pointer to IRQ domain to which this vint belongs.
> + * @list:		List entry for the vint list
> + * @event_map:		Bitmap to manage the allocation of events to vint.
> + * @event_mutex:	Mutex to protect allocation of events.
> + * @events:		Array of event descriptors assigned to this vint.
> + * @parent_virq:	Linux IRQ number that gets attached to parent
> + * @vint_id:		TISCI vint ID
> + */
> +struct ti_sci_inta_vint_desc {
> +	struct irq_domain *domain;
> +	struct list_head list;
> +	unsigned long *event_map;
> +	/* Mutex to protect allocation of events */
> +	struct mutex event_mutex;

As mentioned in another email, this needs to be a spinlock, as the lock
may be taken in atomic context.

> +	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
> +	unsigned int parent_virq;
> +	u16 vint_id;
> +};
> +
> +/**
> + * struct ti_sci_inta_irq_domain - Structure representing a TISCI based
> + *				   Interrupt Aggregator IRQ domain.
> + * @sci:		Pointer to TISCI handle
> + * @vint:		TISCI resource pointer representing IA inerrupts.
> + * @global_event:	TISCI resource pointer representing global events.
> + * @vint_list:		List of the vints active in the system
> + * @vint_mutex:		Mutex to protect vint_list
> + * @base:		Base address of the memory mapped IO registers
> + * @pdev:		Pointer to platform device.
> + */
> +struct ti_sci_inta_irq_domain {
> +	const struct ti_sci_handle *sci;
> +	struct ti_sci_resource *vint;
> +	struct ti_sci_resource *global_event;
> +	struct list_head vint_list;
> +	/* Mutex to protect vint list */
> +	struct mutex vint_mutex;
> +	void __iomem *base;
> +	struct platform_device	*pdev;
> +};
> +
> +/**
> + * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint irqs
> + * @desc:	Pointer to irq_desc corresponding to the irq
> + */
> +static void ti_sci_inta_irq_handler(struct irq_desc *desc)
> +{
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +	struct ti_sci_inta_irq_domain *inta;
> +	struct irq_domain *domain;
> +	unsigned int virq, bit;
> +	u64 val;
> +
> +	vint_desc = irq_desc_get_handler_data(desc);
> +	domain = vint_desc->domain;
> +	inta = domain->host_data;
> +
> +	chained_irq_enter(irq_desc_get_chip(desc), desc);
> +
> +	val = readq_relaxed(inta->base + vint_desc->vint_id * 0x1000 +
> +			    VINT_STATUS_OFFSET);
> +
> +	for (bit = 0; bit < MAX_EVENTS_PER_VINT; bit++) {
> +		if (BIT(bit) & val) {
> +			virq = irq_find_mapping(domain,
> +						vint_desc->events[bit].hwirq);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
> +	}
> +
> +	chained_irq_exit(irq_desc_get_chip(desc), desc);
> +}
> +
> +/**
> + * ti_sci_inta_alloc_parent_irq() - Allocate parent irq to Interrupt aggregator
> + * @domain:	IRQ domain corresponding to Interrupt Aggregator
> + *
> + * Return 0 if all went well else corresponding error value.
> + */
> +static struct ti_sci_inta_vint_desc
> +*ti_sci_inta_alloc_parent_irq(struct irq_domain *domain)

nit: do not split lines like this, specially not with the * on a
different line than the type it applies to.

> +{
> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +	struct irq_fwspec parent_fwspec;
> +	u16 vint_id;
> +
> +	vint_id = ti_sci_get_free_resource(inta->vint);
> +	if (vint_id == TI_SCI_RESOURCE_NULL)
> +		return ERR_PTR(-EINVAL);
> +
> +	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
> +	if (!vint_desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vint_desc->event_map = kcalloc(BITS_TO_LONGS(MAX_EVENTS_PER_VINT),
> +				       sizeof(*vint_desc->event_map),
> +				       GFP_KERNEL);

You already have an array of MAX_EVENTS_PER_VINT (events) in this
structure. Why don't you simply declare it as a
MAX_EVENTS_PER_VINT-sized bitmap and save yourself the allocation?

> +	if (!vint_desc->event_map) {
> +		kfree(vint_desc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	mutex_init(&vint_desc->event_mutex);
> +
> +	vint_desc->domain = domain;
> +	vint_desc->vint_id = vint_id;
> +	INIT_LIST_HEAD(&vint_desc->list);
> +
> +	mutex_lock(&inta->vint_mutex);
> +	list_add_tail(&vint_desc->list, &inta->vint_list);
> +	mutex_unlock(&inta->vint_mutex);
> +
> +	parent_fwspec.fwnode =
> +	of_node_to_fwnode(of_irq_find_parent(dev_of_node(&inta->pdev->dev)));

single line.

> +	parent_fwspec.param_count = 3;
> +	parent_fwspec.param[0] = inta->pdev->id;
> +	parent_fwspec.param[1] = vint_desc->vint_id;
> +	parent_fwspec.param[2] = 1;
> +
> +	vint_desc->parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
> +	if (vint_desc->parent_virq <= 0)
> +		return ERR_PTR(vint_desc->parent_virq);

Don't you need to free vint_desc (and its event_map) here?

> +
> +	irq_set_chained_handler_and_data(vint_desc->parent_virq,
> +					 ti_sci_inta_irq_handler, vint_desc);
> +
> +	return vint_desc;
> +}
> +
> +/**
> + * ti_sci_inta_alloc_event() - Attach an event to a IA vint.
> + * @inta:	Pointer to INTA domain descriptor
> + * @vint_desc:	Pointer to vint_desc to which the event gets attached
> + * @free_bit:	Bit inside vint to which event gets attached
> + * @hwirq:	hwirq of the input event
> + *
> + * Return global_event if all went ok else appropriate error value.
> + */
> +static
> +int ti_sci_inta_alloc_event(struct ti_sci_inta_irq_domain *inta,
> +			    struct ti_sci_inta_vint_desc *vint_desc,
> +			    u16 free_bit, u32 hwirq)
> +{
> +	struct ti_sci_inta_event_desc *event_desc;
> +	u16 dev_id, dev_index;
> +	int err;
> +
> +	dev_id = HWIRQ_TO_DEVID(hwirq);
> +	dev_index = HWIRQ_TO_IRQID(hwirq);
> +	event_desc = &vint_desc->events[free_bit];
> +	mutex_lock(&vint_desc->event_mutex);
> +	event_desc->hwirq = hwirq;
> +	event_desc->global_event = ti_sci_get_free_resource(inta->global_event);
> +	if (event_desc->global_event == TI_SCI_RESOURCE_NULL) {
> +		err = -EINVAL;
> +		goto free_vint_bit;
> +	}
> +
> +	err = inta->sci->ops.rm_irq_ops.set_event_map(inta->sci,
> +						      dev_id, dev_index,
> +						      inta->pdev->id,
> +						      vint_desc->vint_id,
> +						      event_desc->global_event,
> +						      free_bit);
> +	if (err)
> +		goto free_global_event;
> +
> +	mutex_unlock(&vint_desc->event_mutex);
> +	return 0;
> +free_global_event:
> +	ti_sci_release_resource(inta->global_event, event_desc->global_event);
> +free_vint_bit:
> +	clear_bit(free_bit, vint_desc->event_map);
> +	mutex_unlock(&vint_desc->event_mutex);
> +	return err;
> +}
> +
> +/**
> + * ti_sci_inta_alloc_irq() -  Allocate an irq within INTA domain
> + * @domain:	irq_domain pointer corresponding to INTA
> + * @hwirq:	hwirq of the input event
> + *
> + * Note: Allocation happens in the following manner:
> + *	- Find a free bit available in any of the vints available in the list.
> + *	- If not found, allocate a vint from the vint pool
> + *	- Attach the free bit to input hwirq.
> + * Return vint_desc if all went ok else appropriate error value.
> + */
> +static struct ti_sci_inta_vint_desc
> +*ti_sci_inta_alloc_irq(struct irq_domain *domain, u32 hwirq)
> +{
> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
> +	struct ti_sci_inta_vint_desc *vint_desc = NULL;
> +	u16 free_bit;
> +	int ret;
> +
> +	mutex_lock(&inta->vint_mutex);
> +	list_for_each_entry(vint_desc, &inta->vint_list, list) {
> +		mutex_lock(&vint_desc->event_mutex);
> +		free_bit = find_first_zero_bit(vint_desc->event_map,
> +					       MAX_EVENTS_PER_VINT);
> +		if (free_bit != MAX_EVENTS_PER_VINT) {
> +			set_bit(free_bit, vint_desc->event_map);
> +			mutex_unlock(&vint_desc->event_mutex);
> +			mutex_unlock(&inta->vint_mutex);
> +			goto alloc_event;
> +		}
> +		mutex_unlock(&vint_desc->event_mutex);
> +	}
> +	mutex_unlock(&inta->vint_mutex);
> +
> +	/* No free bits available. Allocate a new vint */
> +	vint_desc = ti_sci_inta_alloc_parent_irq(domain);
> +	if (IS_ERR(vint_desc))
> +		return vint_desc;
> +
> +	mutex_lock(&vint_desc->event_mutex);
> +	free_bit = find_first_zero_bit(vint_desc->event_map,
> +				       MAX_EVENTS_PER_VINT);
> +	set_bit(free_bit, vint_desc->event_map);
> +	mutex_unlock(&vint_desc->event_mutex);
> +
> +alloc_event:
> +	ret = ti_sci_inta_alloc_event(inta, vint_desc, free_bit, hwirq);
> +	if (ret)
> +		return ERR_PTR(ret);

Without freeing the allocated bit?

> +
> +	return vint_desc;
> +}
> +
> +/**
> + * __get_event_index() - Convert the hwirq to corresponding bit inside vint.
> + * @vint_desc:	Pointer to vint_desc to which the hwirq is attached
> + * @hwirq:	hwirq number within the domain
> + *
> + * Return the vint bit to which the hwirq is attached.
> + */
> +static int __get_event_index(struct ti_sci_inta_vint_desc *vint_desc, u32 hwirq)
> +{
> +	int i;
> +
> +	mutex_lock(&vint_desc->event_mutex);
> +	for (i = 0; i < MAX_EVENTS_PER_VINT; i++)
> +		if (vint_desc->events[i].hwirq == hwirq) {
> +			mutex_unlock(&vint_desc->event_mutex);
> +			return i;
> +		}
> +
> +	mutex_unlock(&vint_desc->event_mutex);
> +	return -ENODEV;

OK, this is terrible. Having this loop on every mask/unmask/ack, plus
the contention on the lock (64:1, great) is just going to ruin latency.

Can't you spare 5 bits in hwirq to encode the index? Somehow, I don't
really believe that you do have 16bits of DEVID *and* 16bits of IRQID
(whatever the later is). Or allocate some per interrupt data that allows
the retrieval of the index in O(1)?

It would also solve your locking issue...

> +}
> +
> +/**
> + * ti_sci_inta_free_parent_irq() - Free a parent irq to INTA
> + * domain:	domain corresponding to INTA
> + */
> +static void ti_sci_inta_free_parent_irq(struct irq_domain *domain,
> +					struct ti_sci_inta_vint_desc *vint_desc)
> +{
> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
> +
> +	mutex_lock(&inta->vint_mutex);
> +	list_del(&vint_desc->list);
> +	mutex_unlock(&inta->vint_mutex);
> +	irq_dispose_mapping(vint_desc->parent_virq);
> +	ti_sci_release_resource(inta->vint, vint_desc->vint_id);
> +	kfree(vint_desc->event_map);
> +	kfree(vint_desc);
> +}
> +
> +/**
> + * ti_sci_inta_free_irq() - Free an IRQ within INTA domain
> + * domain:	Domain corresponding to INTA
> + * vint_desc:	Pointer to vint_desc from which irq needs to be freed
> + * hwirq:	Hwirq number within INTA domain that needs to be freed
> + */
> +static void ti_sci_inta_free_irq(struct irq_domain *domain,
> +				 struct ti_sci_inta_vint_desc *vint_desc,
> +				 u32 hwirq)
> +{
> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
> +	struct ti_sci_inta_event_desc *event_desc;
> +	int event_index = 0;
> +
> +	/* free event irq */
> +	event_index = __get_event_index(vint_desc, hwirq);
> +	event_desc = &vint_desc->events[event_index];
> +	mutex_lock(&vint_desc->event_mutex);
> +	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
> +						 HWIRQ_TO_DEVID(hwirq),
> +						 HWIRQ_TO_IRQID(hwirq),
> +						 inta->pdev->id,
> +						 vint_desc->vint_id,
> +						 event_desc->global_event,
> +						 event_index);
> +
> +	clear_bit(event_index, vint_desc->event_map);
> +	ti_sci_release_resource(inta->global_event, event_desc->global_event);
> +	event_desc->global_event = TI_SCI_RESOURCE_NULL;
> +	event_desc->hwirq = 0;
> +	mutex_unlock(&vint_desc->event_mutex);
> +
> +	/* Free parent irq */
> +	if (find_first_bit(vint_desc->event_map, MAX_EVENTS_PER_VINT) ==
> +	    MAX_EVENTS_PER_VINT)

Single line. Also, how do you ensure that this doesn't race with the
allocation if you're not holding the lock?

> +		ti_sci_inta_free_parent_irq(domain, vint_desc);
> +}
> +
> +/**
> + * ti_sci_inta_request_resources() - Allocate resources for input irq
> + * @data: Pointer to corresponding irq_data
> + *
> + * Note: This is the core api where the actual allocation happens for input
> + *	 hwirq. This allocation involves creating a parent irq for vint.
> + *	 If this is done in irq_domain_ops.alloc() then a deadlock is reached
> + *	 for allocation. So this allocation is being done in request_resources()
> + *
> + * Return: 0 if all went well else corresponding error.
> + */
> +static int ti_sci_inta_request_resources(struct irq_data *data)
> +{
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +
> +	vint_desc = ti_sci_inta_alloc_irq(data->domain, data->hwirq);
> +	if (IS_ERR(vint_desc))
> +		return PTR_ERR(vint_desc);
> +
> +	data->chip_data = vint_desc;
> +
> +	return 0;
> +}
> +
> +/**
> + * ti_sci_inta_release_resources - Release resources for input irq
> + * @data: Pointer to corresponding irq_data
> + *
> + * Note: Corresponding to request_resources(), all the unmapping and deletion
> + *	 of parent vint irqs happens in this api.
> + */
> +static void ti_sci_inta_release_resources(struct irq_data *data)
> +{
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +
> +	vint_desc = irq_data_get_irq_chip_data(data);
> +	ti_sci_inta_free_irq(data->domain, vint_desc, data->hwirq);
> +}
> +
> +/**
> + * __ti_sci_inta_manage_event() - Control the event based on the offset
> + * @data:	Pointer to corresponding irq_data
> + * @offset:	register offset using which event is controlled.
> + */
> +static void __ti_sci_inta_manage_event(struct irq_data *data, u32 offset)
> +{
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +	struct ti_sci_inta_irq_domain *inta;
> +	int event_index;
> +
> +	vint_desc = irq_data_get_irq_chip_data(data);
> +	inta = data->domain->host_data;
> +	event_index = __get_event_index(vint_desc, data->hwirq);
> +	if (event_index < 0)
> +		return;
> +
> +	writeq_relaxed(BIT(event_index), inta->base +
> +		       vint_desc->vint_id * 0x1000 + offset);
> +}
> +
> +/**
> + * ti_sci_inta_mask_irq() - Mask an event
> + * @data:	Pointer to corresponding irq_data
> + */
> +static void ti_sci_inta_mask_irq(struct irq_data *data)
> +{
> +	__ti_sci_inta_manage_event(data, VINT_ENABLE_CLR_OFFSET);
> +}
> +
> +/**
> + * ti_sci_inta_unmask_irq() - Unmask an event
> + * @data:	Pointer to corresponding irq_data
> + */
> +static void ti_sci_inta_unmask_irq(struct irq_data *data)
> +{
> +	__ti_sci_inta_manage_event(data, VINT_ENABLE_SET_OFFSET);
> +}
> +
> +/**
> + * ti_sci_inta_ack_irq() - Ack an event
> + * @data:	Pointer to corresponding irq_data
> + */
> +static void ti_sci_inta_ack_irq(struct irq_data *data)
> +{
> +	__ti_sci_inta_manage_event(data, VINT_STATUS_OFFSET);
> +}
> +
> +static int ti_sci_inta_set_affinity(struct irq_data *d,
> +				    const struct cpumask *mask_val, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +/**
> + * ti_sci_inta_set_type() - Update the trigger type of the irq.
> + * @data:	Pointer to corresponding irq_data
> + * @type:	Trigger type as specified by user
> + *
> + * Note: This updates the handle_irq callback for level msi.
> + *
> + * Return 0 if all went well else appropriate error.
> + */
> +static int ti_sci_inta_set_type(struct irq_data *data, unsigned int type)
> +{
> +	struct irq_desc *desc = irq_to_desc(data->irq);
> +
> +	/*
> +	 * .alloc default sets handle_edge_irq. But if the user specifies
> +	 * that IRQ is level MSI, then update the handle to handle_level_irq
> +	 */
> +	if (type & IRQF_TRIGGER_HIGH)
> +		desc->handle_irq = handle_level_irq;
> +
> +	return 0;

How about invalid values?

> +}
> +
> +static struct irq_chip ti_sci_inta_irq_chip = {
> +	.name			= "INTA",
> +	.irq_mask		= ti_sci_inta_mask_irq,
> +	.irq_unmask		= ti_sci_inta_unmask_irq,
> +	.irq_ack		= ti_sci_inta_ack_irq,
> +	.irq_set_affinity	= ti_sci_inta_set_affinity,
> +	.irq_request_resources	= ti_sci_inta_request_resources,
> +	.irq_release_resources	= ti_sci_inta_release_resources,
> +	.irq_set_type		= ti_sci_inta_set_type,
> +};
> +
> +/**
> + * ti_sci_inta_irq_domain_free() - Free an IRQ from the IRQ domain
> + * @domain:	Domain to which the irqs belong
> + * @virq:	base linux virtual IRQ to be freed.
> + * @nr_irqs:	Number of continuous irqs to be freed
> + */
> +static void ti_sci_inta_irq_domain_free(struct irq_domain *domain,
> +					unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +
> +	irq_domain_reset_irq_data(data);
> +}
> +
> +/**
> + * ti_sci_inta_irq_domain_alloc() - Allocate Interrupt aggregator IRQs
> + * @domain:	Point to the interrupt aggregator IRQ domain
> + * @virq:	Corresponding Linux virtual IRQ number
> + * @nr_irqs:	Continuous irqs to be allocated
> + * @data:	Pointer to firmware specifier
> + *
> + * No actual allocation happens here.
> + *
> + * Return 0 if all went well else appropriate error value.
> + */
> +static int ti_sci_inta_irq_domain_alloc(struct irq_domain *domain,
> +					unsigned int virq, unsigned int nr_irqs,
> +					void *data)
> +{
> +	msi_alloc_info_t *arg = data;
> +
> +	irq_domain_set_info(domain, virq, arg->hwirq, &ti_sci_inta_irq_chip,
> +			    NULL, handle_edge_irq, NULL, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
> +	.alloc		= ti_sci_inta_irq_domain_alloc,
> +	.free		= ti_sci_inta_irq_domain_free,
> +};
> +
> +static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
> +{
> +	struct irq_domain *parent_domain, *domain;
> +	struct device_node *parent_node, *node;
> +	struct ti_sci_inta_irq_domain *inta;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	node = dev_of_node(dev);
> +	parent_node = of_irq_find_parent(node);
> +	if (!parent_node) {
> +		dev_err(dev, "Failed to get IRQ parent node\n");
> +		return -ENODEV;
> +	}
> +
> +	parent_domain = irq_find_host(parent_node);
> +	if (!parent_domain)
> +		return -EPROBE_DEFER;
> +
> +	inta = devm_kzalloc(dev, sizeof(*inta), GFP_KERNEL);
> +	if (!inta)
> +		return -ENOMEM;
> +
> +	inta->pdev = pdev;
> +	inta->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
> +	if (IS_ERR(inta->sci)) {
> +		ret = PTR_ERR(inta->sci);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "ti,sci read fail %d\n", ret);
> +		inta->sci = NULL;
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id", &pdev->id);
> +	if (ret) {
> +		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
> +		return -EINVAL;
> +	}
> +
> +	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev, pdev->id,
> +						 "ti,sci-rm-range-vint");
> +	if (IS_ERR(inta->vint)) {
> +		dev_err(dev, "VINT resource allocation failed\n");
> +		return PTR_ERR(inta->vint);
> +	}
> +
> +	inta->global_event =
> +		devm_ti_sci_get_of_resource(inta->sci, dev, pdev->id,
> +					    "ti,sci-rm-range-global-event");
> +	if (IS_ERR(inta->global_event)) {
> +		dev_err(dev, "Global event resource allocation failed\n");
> +		return PTR_ERR(inta->global_event);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	inta->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(inta->base))
> +		return -ENODEV;
> +
> +	domain = irq_domain_add_linear(dev_of_node(dev),
> +				       ti_sci_get_num_resources(inta->vint),
> +				       &ti_sci_inta_irq_domain_ops, inta);
> +	if (!domain) {
> +		dev_err(dev, "Failed to allocate IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	INIT_LIST_HEAD(&inta->vint_list);
> +	mutex_init(&inta->vint_mutex);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ti_sci_inta_irq_domain_of_match[] = {
> +	{ .compatible = "ti,sci-inta", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ti_sci_inta_irq_domain_of_match);
> +
> +static struct platform_driver ti_sci_inta_irq_domain_driver = {
> +	.probe = ti_sci_inta_irq_domain_probe,
> +	.driver = {
> +		.name = "ti-sci-inta",
> +		.of_match_table = ti_sci_inta_irq_domain_of_match,
> +	},
> +};
> +module_platform_driver(ti_sci_inta_irq_domain_driver);
> +
> +MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
> +MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
> +MODULE_LICENSE("GPL v2");
> 

The biggest things to fix here is the hwirq thing, which I believe would
simplify the locking a bit.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
