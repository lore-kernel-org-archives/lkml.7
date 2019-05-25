Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D80C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 20:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F9A2081C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 20:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bTw29r2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfEYUjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 16:39:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15571 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEYUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 16:39:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce9a8000000>; Sat, 25 May 2019 13:39:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 25 May 2019 13:39:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 25 May 2019 13:39:37 -0700
Received: from [10.2.167.13] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 25 May
 2019 20:39:32 +0000
Subject: Re: [PATCH V1 10/12] gpio: tegra: implement wake event support for
 Tegra210 and prior GPIO
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <jckuo@nvidia.com>, <talho@nvidia.com>,
        <josephl@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-11-git-send-email-skomatineni@nvidia.com>
 <20190522132413.GL30938@ulmo>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <8f37c4d8-44d4-50d0-26c4-af31706a1d0c@nvidia.com>
Date:   Sat, 25 May 2019 13:39:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522132413.GL30938@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558816771; bh=uta99uJTUgmK29m3hWS1FvdurN+vedEqaC5OAOyKPTk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=bTw29r2JvPqYskVwMHBLXjmTwGJsF3QHZH47zSGc4fwhaRDsTq++zHn5kZYbRTeDn
         uLf+IugL0q05733yIC7/lAs+YDWhW8eGcF2DnOWqBK5gkKrWrq1kMbzZguut0uj62h
         WGe2ZYczRibIt14vmo0vqrfsKqNJDjhZdU10A108rl3NkZG+bRhL5ghsSwKr1g/w2U
         uv8xZjO4lwunRUgThuQuAqKmrLfRQnn0ZgjVhWSscYo5uJbaH0sP8Krk6Ii8zJjsdd
         Q+TblfY8O/JD+gH11rNcxnHDCD4gow/jnCI3qxsE+KGtEbf02+2XAMoq+2dKm/fekJ
         NkXPmMKzHm4wg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/22/19 6:24 AM, Thierry Reding wrote:
> On Tue, May 21, 2019 at 04:31:21PM -0700, Sowjanya Komatineni wrote:
>> The GPIO controller doesn't have any controls to enable the system to
>> wake up from low power states based on activity on GPIO pins. An extra
>> hardware block that is part of the power management controller (PMC)
>> contains these controls. In order for the GPIO controller to be able
>> to cooperate with the PMC, obtain a reference to the PMC's IRQ domain
>> and make it a parent to the GPIO controller's IRQ domain. This way the
>> PMC gets an opportunity to program the additional registers required
>> to enable wakeup sources on suspend.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/gpio/gpio-tegra.c | 109 +++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 103 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
>> index 6d9b6906b9d0..d57e33050d0c 100644
>> --- a/drivers/gpio/gpio-tegra.c
>> +++ b/drivers/gpio/gpio-tegra.c
>> @@ -32,6 +32,8 @@
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/pm.h>
>>   
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>>   #define GPIO_BANK(x)		((x) >> 5)
>>   #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
>>   #define GPIO_BIT(x)		((x) & 0x7)
>> @@ -275,8 +277,22 @@ static int tegra_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
>>   static int tegra_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
>>   {
>>   	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
>> +	struct irq_domain *domain = tgi->irq_domain;
>> +
>> +	if (!gpiochip_irqchip_irq_valid(chip, offset))
>> +		return -ENXIO;
>> +
>> +	if (irq_domain_is_hierarchy(domain)) {
>> +		struct irq_fwspec spec;
>> +
>> +		spec.fwnode = domain->fwnode;
>> +		spec.param_count = 2;
>> +		spec.param[0] = offset;
>> +		spec.param[1] = IRQ_TYPE_NONE;
>> +		return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec);
>> +	}
>>   
>> -	return irq_find_mapping(tgi->irq_domain, offset);
>> +	return irq_find_mapping(domain, offset);
>>   }
>>   
>>   static void tegra_gpio_irq_ack(struct irq_data *d)
>> @@ -365,7 +381,10 @@ static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>>   	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>>   		irq_set_handler_locked(d, handle_edge_irq);
>>   
>> -	return 0;
>> +	if (d->parent_data)
>> +		return irq_chip_set_type_parent(d, type);
>> +	else
>> +		return 0;
> Why is this needed?

Invoking GPIO irq_domain parent's set_type to configure PMC wake level 
based on the type for those GPIO's

that are wake-able thru specified PMC wake events.

>
>>   }
>>   
>>   static void tegra_gpio_irq_shutdown(struct irq_data *d)
>> @@ -566,10 +585,79 @@ static const struct dev_pm_ops tegra_gpio_pm_ops = {
>>   	SET_SYSTEM_SLEEP_PM_OPS(tegra_gpio_suspend, tegra_gpio_resume)
>>   };
>>   
>> +static int tegra_gpio_irq_domain_translate(struct irq_domain *domain,
>> +					   struct irq_fwspec *fwspec,
>> +					   unsigned long *hwirq,
>> +					   unsigned int *type)
>> +{
>> +	if (WARN_ON(fwspec->param_count < 2))
>> +		return -EINVAL;
>> +
>> +	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
>> +	*hwirq = fwspec->param[0];
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_gpio_irq_domain_alloc(struct irq_domain *domain,
>> +				       unsigned int virq,
>> +				       unsigned int num_irqs, void *data)
>> +{
>> +	struct tegra_gpio_info *tgi = gpiochip_get_data(domain->host_data);
>> +	struct irq_fwspec *fwspec = data;
>> +	struct irq_fwspec spec;
> You can put the above two lines onto a single line.
>
Will fix in next version
>> +	struct tegra_gpio_bank *bank;
>> +	unsigned long hwirq;
>> +	unsigned int type;
>> +	int err = 0;
>> +
>> +	if (WARN_ON(fwspec->param_count < 2))
>> +		return -EINVAL;
>> +
>> +	if (!irq_domain_get_of_node(domain->parent))
>> +		return -EINVAL;
> Can this ever fail?
Will remove in next version of updated series..
>
>> +
>> +	err = tegra_gpio_irq_domain_translate(domain, fwspec, &hwirq, &type);
>> +	if (err)
>> +		return err;
>> +
>> +	bank = &tgi->bank_info[GPIO_BANK(hwirq)];
>> +	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>> +					    &tgi->ic, bank);
>> +
>> +	if (err < 0)
>> +		return err;
>> +
>> +	spec.fwnode = domain->parent->fwnode;
>> +	spec.param_count = 3;
>> +	spec.param[0] = GIC_SPI;
>> +	spec.param[1] = fwspec->param[0];
>> +	spec.param[2] = fwspec->param[1];
>> +
>> +	return irq_domain_alloc_irqs_parent(domain, virq, 1, &spec);
> What if num_irqs is different from 1? I'm not exactly sure what to pass
> as &spec, but likely we'd have to create an array of struct irq_fwspec
> and pass that along. It seems like some drivers catch that case and
> refuse to work rather than pass potentially rubbish information along.
> See for example drivers/irqchip/irq-meson-gpio.c.
Will fix in next version
>> +}
>> +
>> +static const struct irq_domain_ops tegra_gpio_irq_domain_ops = {
>> +	.translate = tegra_gpio_irq_domain_translate,
>> +	.alloc = tegra_gpio_irq_domain_alloc,
>> +};
>> +
>> +static const struct of_device_id tegra_pmc_of_match[] = {
>> +	{ .compatible = "nvidia,tegra210-pmc" },
>> +	{ .compatible = "nvidia,tegra132-pmc" },
>> +	{ .compatible = "nvidia,tegra124-pmc" },
>> +	{ .compatible = "nvidia,tegra114-pmc" },
>> +	{ .compatible = "nvidia,tegra30-pmc" },
>> +	{ .compatible = "nvidia,tegra20-pmc" },
>> +	{ }
>> +};
>> +
>>   static int tegra_gpio_probe(struct platform_device *pdev)
>>   {
>>   	struct tegra_gpio_info *tgi;
>>   	struct tegra_gpio_bank *bank;
>> +	struct device_node *np;
>> +	struct irq_domain *parent_domain = NULL;
>>   	unsigned int gpio, i, j;
>>   	int ret;
>>   
>> @@ -612,8 +700,15 @@ static int tegra_gpio_probe(struct platform_device *pdev)
>>   	tgi->ic.irq_set_type		= tegra_gpio_irq_set_type;
>>   	tgi->ic.irq_shutdown		= tegra_gpio_irq_shutdown;
>>   #ifdef CONFIG_PM_SLEEP
>> -	tgi->ic.irq_set_wake		= tegra_gpio_irq_set_wake;
>> +	tgi->ic.irq_set_wake		= irq_chip_set_wake_parent;
> This doesn't seem right. What about tegra_gpio_irq_set_wake()? If it's
> no longer needed, just remove it. But then, what about the extra logic
> in that function that causes the interrupts to be enabled during
> suspend? Is that no longer necessary? Maybe that's no longer needed on
> Tegra210, but what about other Tegra generations?
>
> Thierry
>
Missed this. Will fix in next version
>>   #endif
>> +	np = of_find_matching_node(NULL, tegra_pmc_of_match);
>> +	if (np) {
>> +		parent_domain = irq_find_host(np);
>> +		of_node_put(np);
>> +		if (!parent_domain)
>> +			return -EPROBE_DEFER;
>> +	}
>>   
>>   	platform_set_drvdata(pdev, tgi);
>>   
>> @@ -625,9 +720,11 @@ static int tegra_gpio_probe(struct platform_device *pdev)
>>   	if (!tgi->bank_info)
>>   		return -ENOMEM;
>>   
>> -	tgi->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
>> -						tgi->gc.ngpio,
>> -						&irq_domain_simple_ops, NULL);
>> +	tgi->irq_domain = irq_domain_add_hierarchy(parent_domain, 0,
>> +						   tgi->gc.ngpio,
>> +						   pdev->dev.of_node,
>> +						   &tegra_gpio_irq_domain_ops,
>> +						   &tgi->gc);
>>   	if (!tgi->irq_domain)
>>   		return -ENODEV;
>>   
>> -- 
>> 2.7.4
>>
