Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D69EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4DC206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="htccbprA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AcsiRpjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfCLQiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:38:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfCLQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:38:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7CA4F60ADE; Tue, 12 Mar 2019 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552408690;
        bh=9JTYCyTDls8+w1JR/sxSD/ASPpIZh3WHgt9GmAL0ANE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htccbprAXeRqKwgeFfjpHb39jSGhjc6sYcsZb7zDgQQGEj0aCQCnyJxTsjW7O0eN4
         qMqfYvnQrz3W3Liw3I2Axh4sSopPcwb3/w0DFXc86a31+4d8YE/2sP0BvhQmQnZr5a
         nCuhCD54zHhavJOYHH/iHtW43qJepyEeljWiebuM=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A01C160ADE;
        Tue, 12 Mar 2019 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552408686;
        bh=9JTYCyTDls8+w1JR/sxSD/ASPpIZh3WHgt9GmAL0ANE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcsiRpjwdxgDTptvRtSQ9wd2v0VOBnT2BDiEVZYwaW4MeTDbPZQMnz0jCT6W6lujh
         rSX8oQXBJRc/P4DazFRVbEOqYkTs1yWjWNH80EL4PvYbEY+Fz+hgWMr4r9TyI6OHp4
         XTZChrcOCsn1M3NwqzbV/zMdT8Tq8yoezfbFtpq8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A01C160ADE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 12 Mar 2019 10:38:04 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH v3 4/9] drivers: irqchip: add PDC irqdomain for wakeup
 capable GPIOs
Message-ID: <20190312163804.GC8553@codeaurora.org>
References: <20190222221850.26939-1-ilina@codeaurora.org>
 <20190222221850.26939-5-ilina@codeaurora.org>
 <e13021ca-c159-3fe1-8c56-820ccc26f71e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e13021ca-c159-3fe1-8c56-820ccc26f71e@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11 2019 at 04:42 -0600, Marc Zyngier wrote:
>On 22/02/2019 22:18, Lina Iyer wrote:
>> Introduce a new domain for wakeup capable GPIOs. The domain can be
>> requested using the bus token DOMAIN_BUS_WAKEUP. In the following
>> patches, we will specify PDC as the wakeup-parent for the TLMM GPIO
>> irqchip. Requesting a wakeup GPIO will setup the GPIO and the
>> corresponding PDC interrupt as its parent.
>>
>> Co-developed-by: Stephen Boyd <swboyd@chromium.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v3:
>> 	- Remove PDC GPIO map data (moved to DT)
>> 	- hwirq passed in .alloc() is a PDC pin now
>> Changes in v2:
>> 	- Remove separate file for PDC GPIO map data
>> 	- Error checks and return
>> 	- Whitespace fixes
>> ---
>>  drivers/irqchip/qcom-pdc.c   | 106 ++++++++++++++++++++++++++++++++---
>>  include/linux/soc/qcom/irq.h |  23 ++++++++
>>  2 files changed, 120 insertions(+), 9 deletions(-)
>>  create mode 100644 include/linux/soc/qcom/irq.h
>>
>> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
>> index faa7d61b9d6c..5a64cbeec410 100644
>> --- a/drivers/irqchip/qcom-pdc.c
>> +++ b/drivers/irqchip/qcom-pdc.c
>> @@ -13,12 +13,13 @@
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_device.h>
>> +#include <linux/soc/qcom/irq.h>
>>  #include <linux/spinlock.h>
>> -#include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>>
>>  #define PDC_MAX_IRQS		126
>> +#define PDC_MAX_GPIO_IRQS	256
>>
>>  #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
>>  #define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
>> @@ -32,6 +33,16 @@ struct pdc_pin_region {
>>  	u32 cnt;
>>  };
>>
>> +struct pdc_gpio_pin_map {
>> +	unsigned int gpio;
>> +	u32 pdc_pin;
>> +};
>> +
>> +struct pdc_gpio_pin_data {
>> +	size_t size;
>> +	const struct pdc_gpio_pin_map *map;
>> +};
>
>I can't see this being used anywhere.
>
Thanks for catching this.

This and the ULONG_MAX changes are from a previous idea. We don't need
them anymore.. I will remove them.

>> +
>>  static DEFINE_RAW_SPINLOCK(pdc_lock);
>>  static void __iomem *pdc_base;
>>  static struct pdc_pin_region *pdc_region;
>> @@ -47,9 +58,8 @@ static u32 pdc_reg_read(int reg, u32 i)
>>  	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
>>  }
>>
>> -static void pdc_enable_intr(struct irq_data *d, bool on)
>> +static void pdc_enable_intr(irq_hw_number_t pin_out, bool on)
>>  {
>> -	int pin_out = d->hwirq;
>
>Why do you need this change? As far as I can tell, you can always use
>the irq_data here, and it would reduce the size of the patch.
>
Agreed

>>  	u32 index, mask;
>>  	u32 enable;
>>
>> @@ -65,13 +75,23 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
>>
>>  static void qcom_pdc_gic_mask(struct irq_data *d)
>>  {
>> -	pdc_enable_intr(d, false);
>> +	irq_hw_number_t hwirq = d->hwirq;
>> +
>> +	if (hwirq == ULONG_MAX)
>
>Can you define a specific constant here? PDC_WAKEUP_IRQ? Or something?
>Also, I can't work out where d->hwirq gets set to such value.
>
With an earlier approach, it could, not with this. We could remove them
all.

>> +		return;
>> +
>> +	pdc_enable_intr(hwirq, false);
>>  	irq_chip_mask_parent(d);
>>  }
>>
>>  static void qcom_pdc_gic_unmask(struct irq_data *d)
>>  {
>> -	pdc_enable_intr(d, true);
>> +	irq_hw_number_t hwirq = d->hwirq;
>> +
>> +	if (hwirq == ULONG_MAX)
>> +		return;
>> +
>> +	pdc_enable_intr(hwirq, true);
>>  	irq_chip_unmask_parent(d);
>>  }
>>
>> @@ -111,9 +131,12 @@ enum pdc_irq_config_bits {
>>   */
>>  static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>>  {
>> -	int pin_out = d->hwirq;
>> +	irq_hw_number_t pin_out = d->hwirq;
>>  	enum pdc_irq_config_bits pdc_type;
>>
>> +	if (pin_out == ULONG_MAX)
>> +		return 0;
>> +
>
>It is quite odd that you're accepting any odd trigger, even if they are
>illegal. The API should be consistent, even if you're not applying any
>change.
>
Ok. This should be remvoed.

>>  	switch (type) {
>>  	case IRQ_TYPE_EDGE_RISING:
>>  		pdc_type = PDC_EDGE_RISING;
>> @@ -157,7 +180,7 @@ static struct irq_chip qcom_pdc_gic_chip = {
>>  	.irq_set_affinity	= irq_chip_set_affinity_parent,
>>  };
>>
>> -static irq_hw_number_t get_parent_hwirq(int pin)
>> +static irq_hw_number_t get_parent_hwirq(irq_hw_number_t pin)
>>  {
>>  	int i;
>>  	struct pdc_pin_region *region;
>> @@ -169,7 +192,6 @@ static irq_hw_number_t get_parent_hwirq(int pin)
>>  			return (region->parent_base + pin - region->pin_base);
>>  	}
>>
>> -	WARN_ON(1);
>>  	return ~0UL;
>
>Above, you're using ULONG_MAX, and here ~0UL. You need to make up your
>mind and use one single identifier. Or maybe these are not the same
>thing? In any case, you need to lift the ambiguity.
>
Will do.

>>  }
>>
>> @@ -232,6 +254,60 @@ static const struct irq_domain_ops qcom_pdc_ops = {
>>  	.free		= irq_domain_free_irqs_common,
>>  };
>>
>> +static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
>> +			       unsigned int nr_irqs, void *data)
>> +{
>> +	struct qcom_irq_fwspec *qcom_fwspec = data;
>> +	struct irq_fwspec *fwspec = &qcom_fwspec->fwspec;
>> +	struct irq_fwspec parent_fwspec;
>> +	irq_hw_number_t hwirq, parent_hwirq;
>> +	unsigned int type;
>> +	int ret;
>> +
>> +	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	parent_hwirq = get_parent_hwirq(hwirq);
>> +	if (parent_hwirq == ~0UL)
>> +		return -EINVAL;
>> +
>> +	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>> +					    &qcom_pdc_gic_chip, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	qcom_fwspec->mask = true;
>> +
>> +	if (type & IRQ_TYPE_EDGE_BOTH)
>> +		type = IRQ_TYPE_EDGE_RISING;
>> +
>> +	if (type & IRQ_TYPE_LEVEL_MASK)
>> +		type = IRQ_TYPE_LEVEL_HIGH;
>> +
>> +	parent_fwspec.fwnode      = domain->parent->fwnode;
>> +	parent_fwspec.param_count = 3;
>> +	parent_fwspec.param[0]    = 0;
>> +	parent_fwspec.param[1]    = parent_hwirq;
>> +	parent_fwspec.param[2]    = type;
>> +
>> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
>> +					    &parent_fwspec);
>> +}
>> +
>> +static int qcom_pdc_gpio_domain_select(struct irq_domain *d,
>> +				       struct irq_fwspec *fwspec,
>> +				       enum irq_domain_bus_token bus_token)
>> +{
>> +	return (bus_token == DOMAIN_BUS_WAKEUP);
>> +}
>> +
>> +static const struct irq_domain_ops qcom_pdc_gpio_ops = {
>> +	.select		= qcom_pdc_gpio_domain_select,
>> +	.alloc		= qcom_pdc_gpio_alloc,
>> +	.free		= irq_domain_free_irqs_common,
>> +};
>> +
>>  static int pdc_setup_pin_mapping(struct device_node *np)
>>  {
>>  	int ret, n;
>> @@ -270,7 +346,7 @@ static int pdc_setup_pin_mapping(struct device_node *np)
>>
>>  static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>>  {
>> -	struct irq_domain *parent_domain, *pdc_domain;
>> +	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
>>  	int ret;
>>
>>  	pdc_base = of_iomap(node, 0);
>> @@ -301,6 +377,18 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
>>  		goto fail;
>>  	}
>>
>> +	pdc_gpio_domain = irq_domain_create_hierarchy(parent_domain, 0,
>> +						      PDC_MAX_GPIO_IRQS,
>> +						      of_fwnode_handle(node),
>> +						      &qcom_pdc_gpio_ops, NULL);
>> +	if (!pdc_gpio_domain) {
>> +		pr_err("%pOF: GIC domain add failed for GPIO domain\n", node);
>> +		ret = -ENOMEM;
>> +		goto fail;
>> +	}
>> +
>> +	irq_domain_update_bus_token(pdc_gpio_domain, DOMAIN_BUS_WAKEUP);
>> +
>>  	return 0;
>>
>>  fail:
>> diff --git a/include/linux/soc/qcom/irq.h b/include/linux/soc/qcom/irq.h
>> new file mode 100644
>> index 000000000000..bacc9edbce0d
>> --- /dev/null
>> +++ b/include/linux/soc/qcom/irq.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __QCOM_IRQ_H
>> +#define __QCOM_IRQ_H
>> +
>> +#include <linux/irqdomain.h>
>> +
>> +/**
>> + * struct qcom_irq_fwspec - qcom specific irq fwspec wrapper
>> + * @fwspec: irq fwspec
>> + * @mask: if true, keep the irq masked in the gpio controller
>> + *
>> + * Use this structure to communicate between the parent irq chip, MPM or PDC,
>> + * to the gpio chip, TLMM, about the gpio being allocated in the parent
>> + * and if the gpio chip should keep the line masked because the parent irq
>> + * chip is handling everything about the irq line.
>> + */
>> +struct qcom_irq_fwspec {
>> +	struct irq_fwspec fwspec;
>> +	bool mask;
>> +};
>> +
>> +#endif
>>
Thanks,
Lina
