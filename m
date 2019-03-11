Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742C6206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCKKlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:41:07 -0400
Received: from foss.arm.com ([217.140.101.70]:52354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfCKKlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:41:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA889374;
        Mon, 11 Mar 2019 03:41:05 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06C413F703;
        Mon, 11 Mar 2019 03:41:03 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] drivers: irqchip: add PDC irqdomain for wakeup
 capable GPIOs
To:     Lina Iyer <ilina@codeaurora.org>, swboyd@chromium.org,
        evgreen@chromium.org
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
References: <20190222221850.26939-1-ilina@codeaurora.org>
 <20190222221850.26939-5-ilina@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <e13021ca-c159-3fe1-8c56-820ccc26f71e@arm.com>
Date:   Mon, 11 Mar 2019 10:41:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222221850.26939-5-ilina@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2019 22:18, Lina Iyer wrote:
> Introduce a new domain for wakeup capable GPIOs. The domain can be
> requested using the bus token DOMAIN_BUS_WAKEUP. In the following
> patches, we will specify PDC as the wakeup-parent for the TLMM GPIO
> irqchip. Requesting a wakeup GPIO will setup the GPIO and the
> corresponding PDC interrupt as its parent.
> 
> Co-developed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v3:
> 	- Remove PDC GPIO map data (moved to DT)
> 	- hwirq passed in .alloc() is a PDC pin now
> Changes in v2:
> 	- Remove separate file for PDC GPIO map data
> 	- Error checks and return
> 	- Whitespace fixes
> ---
>  drivers/irqchip/qcom-pdc.c   | 106 ++++++++++++++++++++++++++++++++---
>  include/linux/soc/qcom/irq.h |  23 ++++++++
>  2 files changed, 120 insertions(+), 9 deletions(-)
>  create mode 100644 include/linux/soc/qcom/irq.h
> 
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index faa7d61b9d6c..5a64cbeec410 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -13,12 +13,13 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/soc/qcom/irq.h>
>  #include <linux/spinlock.h>
> -#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  
>  #define PDC_MAX_IRQS		126
> +#define PDC_MAX_GPIO_IRQS	256
>  
>  #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
>  #define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
> @@ -32,6 +33,16 @@ struct pdc_pin_region {
>  	u32 cnt;
>  };
>  
> +struct pdc_gpio_pin_map {
> +	unsigned int gpio;
> +	u32 pdc_pin;
> +};
> +
> +struct pdc_gpio_pin_data {
> +	size_t size;
> +	const struct pdc_gpio_pin_map *map;
> +};

I can't see this being used anywhere.

> +
>  static DEFINE_RAW_SPINLOCK(pdc_lock);
>  static void __iomem *pdc_base;
>  static struct pdc_pin_region *pdc_region;
> @@ -47,9 +58,8 @@ static u32 pdc_reg_read(int reg, u32 i)
>  	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
>  }
>  
> -static void pdc_enable_intr(struct irq_data *d, bool on)
> +static void pdc_enable_intr(irq_hw_number_t pin_out, bool on)
>  {
> -	int pin_out = d->hwirq;

Why do you need this change? As far as I can tell, you can always use
the irq_data here, and it would reduce the size of the patch.

>  	u32 index, mask;
>  	u32 enable;
>  
> @@ -65,13 +75,23 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
>  
>  static void qcom_pdc_gic_mask(struct irq_data *d)
>  {
> -	pdc_enable_intr(d, false);
> +	irq_hw_number_t hwirq = d->hwirq;
> +
> +	if (hwirq == ULONG_MAX)

Can you define a specific constant here? PDC_WAKEUP_IRQ? Or something?
Also, I can't work out where d->hwirq gets set to such value.

> +		return;
> +
> +	pdc_enable_intr(hwirq, false);
>  	irq_chip_mask_parent(d);
>  }
>  
>  static void qcom_pdc_gic_unmask(struct irq_data *d)
>  {
> -	pdc_enable_intr(d, true);
> +	irq_hw_number_t hwirq = d->hwirq;
> +
> +	if (hwirq == ULONG_MAX)
> +		return;
> +
> +	pdc_enable_intr(hwirq, true);
>  	irq_chip_unmask_parent(d);
>  }
>  
> @@ -111,9 +131,12 @@ enum pdc_irq_config_bits {
>   */
>  static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>  {
> -	int pin_out = d->hwirq;
> +	irq_hw_number_t pin_out = d->hwirq;
>  	enum pdc_irq_config_bits pdc_type;
>  
> +	if (pin_out == ULONG_MAX)
> +		return 0;
> +

It is quite odd that you're accepting any odd trigger, even if they are
illegal. The API should be consistent, even if you're not applying any
change.

>  	switch (type) {
>  	case IRQ_TYPE_EDGE_RISING:
>  		pdc_type = PDC_EDGE_RISING;
> @@ -157,7 +180,7 @@ static struct irq_chip qcom_pdc_gic_chip = {
>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
>  };
>  
> -static irq_hw_number_t get_parent_hwirq(int pin)
> +static irq_hw_number_t get_parent_hwirq(irq_hw_number_t pin)
>  {
>  	int i;
>  	struct pdc_pin_region *region;
> @@ -169,7 +192,6 @@ static irq_hw_number_t get_parent_hwirq(int pin)
>  			return (region->parent_base + pin - region->pin_base);
>  	}
>  
> -	WARN_ON(1);
>  	return ~0UL;

Above, you're using ULONG_MAX, and here ~0UL. You need to make up your
mind and use one single identifier. Or maybe these are not the same
thing? In any case, you need to lift the ambiguity.

>  }
>  
> @@ -232,6 +254,60 @@ static const struct irq_domain_ops qcom_pdc_ops = {
>  	.free		= irq_domain_free_irqs_common,
>  };
>  
> +static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
> +			       unsigned int nr_irqs, void *data)
> +{
> +	struct qcom_irq_fwspec *qcom_fwspec = data;
> +	struct irq_fwspec *fwspec = &qcom_fwspec->fwspec;
> +	struct irq_fwspec parent_fwspec;
> +	irq_hw_number_t hwirq, parent_hwirq;
> +	unsigned int type;
> +	int ret;
> +
> +	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
> +	if (ret)
> +		return -EINVAL;
> +
> +	parent_hwirq = get_parent_hwirq(hwirq);
> +	if (parent_hwirq == ~0UL)
> +		return -EINVAL;
> +
> +	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
> +					    &qcom_pdc_gic_chip, NULL);
> +	if (ret)
> +		return ret;
> +
> +	qcom_fwspec->mask = true;
> +
> +	if (type & IRQ_TYPE_EDGE_BOTH)
> +		type = IRQ_TYPE_EDGE_RISING;
> +
> +	if (type & IRQ_TYPE_LEVEL_MASK)
> +		type = IRQ_TYPE_LEVEL_HIGH;
> +
> +	parent_fwspec.fwnode      = domain->parent->fwnode;
> +	parent_fwspec.param_count = 3;
> +	parent_fwspec.param[0]    = 0;
> +	parent_fwspec.param[1]    = parent_hwirq;
> +	parent_fwspec.param[2]    = type;
> +
> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
> +					    &parent_fwspec);
> +}
> +
> +static int qcom_pdc_gpio_domain_select(struct irq_domain *d,
> +				       struct irq_fwspec *fwspec,
> +				       enum irq_domain_bus_token bus_token)
> +{
> +	return (bus_token == DOMAIN_BUS_WAKEUP);
> +}
> +
> +static const struct irq_domain_ops qcom_pdc_gpio_ops = {
> +	.select		= qcom_pdc_gpio_domain_select,
> +	.alloc		= qcom_pdc_gpio_alloc,
> +	.free		= irq_domain_free_irqs_common,
> +};
> +
>  static int pdc_setup_pin_mapping(struct device_node *np)
>  {
>  	int ret, n;
> @@ -270,7 +346,7 @@ static int pdc_setup_pin_mapping(struct device_node *np)
>  
>  static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>  {
> -	struct irq_domain *parent_domain, *pdc_domain;
> +	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
>  	int ret;
>  
>  	pdc_base = of_iomap(node, 0);
> @@ -301,6 +377,18 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>  		goto fail;
>  	}
>  
> +	pdc_gpio_domain = irq_domain_create_hierarchy(parent_domain, 0,
> +						      PDC_MAX_GPIO_IRQS,
> +						      of_fwnode_handle(node),
> +						      &qcom_pdc_gpio_ops, NULL);
> +	if (!pdc_gpio_domain) {
> +		pr_err("%pOF: GIC domain add failed for GPIO domain\n", node);
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	irq_domain_update_bus_token(pdc_gpio_domain, DOMAIN_BUS_WAKEUP);
> +
>  	return 0;
>  
>  fail:
> diff --git a/include/linux/soc/qcom/irq.h b/include/linux/soc/qcom/irq.h
> new file mode 100644
> index 000000000000..bacc9edbce0d
> --- /dev/null
> +++ b/include/linux/soc/qcom/irq.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __QCOM_IRQ_H
> +#define __QCOM_IRQ_H
> +
> +#include <linux/irqdomain.h>
> +
> +/**
> + * struct qcom_irq_fwspec - qcom specific irq fwspec wrapper
> + * @fwspec: irq fwspec
> + * @mask: if true, keep the irq masked in the gpio controller
> + *
> + * Use this structure to communicate between the parent irq chip, MPM or PDC,
> + * to the gpio chip, TLMM, about the gpio being allocated in the parent
> + * and if the gpio chip should keep the line masked because the parent irq
> + * chip is handling everything about the irq line.
> + */
> +struct qcom_irq_fwspec {
> +	struct irq_fwspec fwspec;
> +	bool mask;
> +};
> +
> +#endif
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
