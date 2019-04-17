Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB22C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905B720663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732857AbfDQQej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:34:39 -0400
Received: from foss.arm.com ([217.140.101.70]:47578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfDQQei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:34:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 122F0A78;
        Wed, 17 Apr 2019 09:34:37 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC9FD3F557;
        Wed, 17 Apr 2019 09:34:31 -0700 (PDT)
Subject: Re: [PATCH v6 10/12] soc: ti: Add MSI domain bus support for
 Interrupt Aggregator
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
 <20190410041358.16809-11-lokeshvutla@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <8691f4f1-741c-c15d-62d6-3c2f7157cb51@arm.com>
Date:   Wed, 17 Apr 2019 17:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410041358.16809-11-lokeshvutla@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2019 05:13, Lokesh Vutla wrote:
> With the system coprocessor managing the range allocation of the
> inputs to Interrupt Aggregator, it is difficult to represent
> the device IRQs from DT.
> 
> The suggestion is to use MSI in such cases where devices wants
> to allocate and group interrupts dynamically.
> 
> Create a MSI domain bus layer that allocates and frees MSIs for
> a device.
> 
> APIs that are implemented:
> - ti_sci_inta_msi_create_irq_domain() that creates a MSI domain
> - ti_sci_inta_msi_domain_alloc_irqs() that creates MSIs for the
>   specified device and resource.
> - ti_sci_inta_msi_domain_free_irqs() frees the irqs attached to the device.
> - ti_sci_inta_msi_get_virq() for getting the virq attached to a specific event.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v5:
> - Updated the input parametes to all apis
> - Updated the default chip ops.
> - Prefixed all the apis with ti_sci_inta_
> 
> Marc,
> 	Right now ti_sci_resource is being passed for irq allocatons.
> I couldn't get to use resources attached to platform_device. Because
> platform_device resources are allocated in of_device_alloc() and number
> of resources are fixed in it. In order to update the resources, driver
> has to do a krealloc(pdev->resources) and update the num of resources.
> Is it allowed to update the pdev->resources during probe time? If yes,
> Ill be happy to update the patch to use platform_dev resources.

My suggestion was for you to define your own bus, device type and co
(much like the fsl-mc stuff), and not reuse platform devices at all.

> 
> 
>  MAINTAINERS                            |   2 +
>  drivers/soc/ti/Kconfig                 |   6 +
>  drivers/soc/ti/Makefile                |   1 +
>  drivers/soc/ti/ti_sci_inta_msi.c       | 167 +++++++++++++++++++++++++
>  include/linux/irqdomain.h              |   1 +
>  include/linux/msi.h                    |   6 +
>  include/linux/soc/ti/ti_sci_inta_msi.h |  23 ++++
>  7 files changed, 206 insertions(+)
>  create mode 100644 drivers/soc/ti/ti_sci_inta_msi.c
>  create mode 100644 include/linux/soc/ti/ti_sci_inta_msi.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba88b3033fe4..dd31d7cb2fc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15353,6 +15353,8 @@ F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>  F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
>  F:	drivers/irqchip/irq-ti-sci-intr.c
>  F:	drivers/irqchip/irq-ti-sci-inta.c
> +F:	include/linux/soc/ti/ti_sci_inta_msi.h
> +F:	drivers/soc/ti/ti_sci_inta_msi.c
>  
>  Texas Instruments ASoC drivers
>  M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index be4570baad96..82f110fe4953 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -73,4 +73,10 @@ config TI_SCI_PM_DOMAINS
>  	  called ti_sci_pm_domains. Note this is needed early in boot before
>  	  rootfs may be available.
>  
> +config TI_SCI_INTA_MSI_DOMAIN
> +	bool
> +	select GENERIC_MSI_IRQ_DOMAIN
> +	help
> +	  Driver to enable Interrupt Aggregator specific MSI Domain.
> +
>  endif # SOC_TI
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index a22edc0b258a..b3868d392d4f 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
>  obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
>  obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
>  obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
> +obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
> diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
> new file mode 100644
> index 000000000000..247a5e5f216b
> --- /dev/null
> +++ b/drivers/soc/ti/ti_sci_inta_msi.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments' K3 Interrupt Aggregator MSI bus
> + *
> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
> + *	Lokesh Vutla <lokeshvutla@ti.com>
> + */
> +
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/msi.h>

Alphabetical ordering, please.

> +#include <linux/soc/ti/ti_sci_inta_msi.h>
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +
> +static void ti_sci_inta_msi_write_msg(struct irq_data *data,
> +				      struct msi_msg *msg)
> +{
> +	/* Nothing to do */
> +}
> +
> +static void ti_sci_inta_msi_compose_msi_msg(struct irq_data *data,
> +					    struct msi_msg *msg)
> +{
> +	/* Nothing to do */
> +}
> +
> +static int ti_sci_inta_msi_request_resources(struct irq_data *data)
> +{
> +	data = data->parent_data;
> +
> +	return data->chip->irq_request_resources(data);
> +}
> +
> +static void ti_sci_inta_msi_release_resources(struct irq_data *data)
> +{
> +	data = data->parent_data;
> +	data->chip->irq_release_resources(data);
> +}

The two functions above are an implementation of
irq_chip_{request,release}_resource_parent(). Please make them generic
functions, use them and fix drivers/gpio/gpio-thunderx.c to use them too.

> +
> +static void ti_sci_inta_msi_update_chip_ops(struct msi_domain_info *info)
> +{
> +	struct irq_chip *chip = info->chip;
> +
> +	WARN_ON(!chip);

Just doing that isn't going to help, as you'll crash on the following
line...

> +	if (!chip->irq_mask)
> +		chip->irq_mask = irq_chip_mask_parent;
> +	if (!chip->irq_unmask)
> +		chip->irq_unmask = irq_chip_unmask_parent;
> +	if (!chip->irq_ack)
> +		chip->irq_ack = irq_chip_ack_parent;
> +	if (!chip->irq_set_type)
> +		chip->irq_set_type = irq_chip_set_type_parent;
> +	if (!chip->irq_write_msi_msg)
> +		chip->irq_write_msi_msg = ti_sci_inta_msi_write_msg;
> +	if (!chip->irq_compose_msi_msg)
> +		chip->irq_compose_msi_msg = ti_sci_inta_msi_compose_msi_msg;
> +	if (!chip->irq_request_resources)
> +		chip->irq_request_resources = ti_sci_inta_msi_request_resources;
> +	if (!chip->irq_release_resources)
> +		chip->irq_release_resources = ti_sci_inta_msi_release_resources;

Is there any case where a client driver wouldn't use the default all the
time?

> +}
> +
> +struct irq_domain
> +*ti_sci_inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
> +				   struct msi_domain_info *info,
> +				   struct irq_domain *parent)
> +{
> +	struct irq_domain *domain;
> +
> +	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
> +		ti_sci_inta_msi_update_chip_ops(info);

If the answer above is "no", then you can happily ignore this flag and
always populate the callbacks.

> +
> +	domain = msi_create_irq_domain(fwnode, info, parent);
> +	if (domain)
> +		irq_domain_update_bus_token(domain, DOMAIN_BUS_TI_SCI_INTA_MSI);
> +
> +	return domain;
> +}
> +EXPORT_SYMBOL_GPL(ti_sci_inta_msi_create_irq_domain);
> +
> +static void ti_sci_inta_msi_free_descs(struct device *dev)
> +{
> +	struct msi_desc *desc, *tmp;
> +
> +	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
> +		list_del(&desc->list);
> +		free_msi_entry(desc);
> +	}
> +}
> +
> +static int ti_sci_inta_msi_alloc_descs(struct device *dev, u32 dev_id,
> +				       struct ti_sci_resource *res)
> +{
> +	struct msi_desc *msi_desc;
> +	int set, i, count = 0;
> +
> +	for (set = 0; set < res->sets; set++) {
> +		for (i = 0; i < res->desc[set].num; i++) {
> +			msi_desc = alloc_msi_entry(dev, 1, NULL);
> +			if (!msi_desc) {
> +				ti_sci_inta_msi_free_descs(dev);
> +				return -ENOMEM;
> +			}
> +
> +			msi_desc->inta.index = res->desc[set].start + i;
> +			msi_desc->inta.dev_id = dev_id;

I'm highly suspiscious of this. See further down.

> +			INIT_LIST_HEAD(&msi_desc->list);
> +			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
> +			count++;
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +int ti_sci_inta_msi_domain_alloc_irqs(struct platform_device *pdev,
> +				      struct ti_sci_resource *res)
> +{
> +	struct irq_domain *msi_domain;
> +	int ret, nvec;
> +
> +	msi_domain = dev_get_msi_domain(&pdev->dev);
> +	if (!msi_domain)
> +		return -EINVAL;
> +
> +	if (pdev->id < 0)
> +		return -ENODEV;
> +
> +	nvec = ti_sci_inta_msi_alloc_descs(&pdev->dev, pdev->id, res);
> +	if (nvec <= 0)
> +		return nvec;
> +
> +	ret = msi_domain_alloc_irqs(msi_domain, &pdev->dev, nvec);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to allocate IRQs %d\n", ret);
> +		goto cleanup;
> +	}
> +
> +	return 0;
> +
> +cleanup:
> +	ti_sci_inta_msi_free_descs(&pdev->dev);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
> +
> +void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
> +{
> +	msi_domain_free_irqs(dev->msi_domain, dev);
> +	ti_sci_inta_msi_free_descs(dev);
> +}
> +EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
> +
> +unsigned int ti_sci_inta_msi_get_virq(struct platform_device *pdev, u32 index)
> +{
> +	struct msi_desc *desc;
> +
> +	for_each_msi_entry(desc, &pdev->dev)
> +		if (desc->inta.index == index && desc->inta.dev_id == pdev->id)

What is this "index"? Why isn't the right entry the index-th element in
the msi_desc list?  Worse, the dev_id check. The whole point of having a
per-device MSI list is that it is, well, per device.

> +			return desc->irq;
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(ti_sci_inta_msi_get_virq);
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 61706b430907..07ec8b390161 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -82,6 +82,7 @@ enum irq_domain_bus_token {
>  	DOMAIN_BUS_NEXUS,
>  	DOMAIN_BUS_IPI,
>  	DOMAIN_BUS_FSL_MC_MSI,
> +	DOMAIN_BUS_TI_SCI_INTA_MSI,
>  };
>  
>  /**
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 7e9b81c3b50d..7e12dfc4cb39 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -47,6 +47,11 @@ struct fsl_mc_msi_desc {
>  	u16				msi_index;
>  };
>  
> +struct ti_sci_inta_msi_desc {
> +	u16	dev_id;
> +	u16	index;
> +};
> +
>  /**
>   * struct msi_desc - Descriptor structure for MSI based interrupts
>   * @list:	List head for management
> @@ -106,6 +111,7 @@ struct msi_desc {
>  		 */
>  		struct platform_msi_desc platform;
>  		struct fsl_mc_msi_desc fsl_mc;
> +		struct ti_sci_inta_msi_desc inta;
>  	};
>  };
>  
> diff --git a/include/linux/soc/ti/ti_sci_inta_msi.h b/include/linux/soc/ti/ti_sci_inta_msi.h
> new file mode 100644
> index 000000000000..b0ca20ab3f49
> --- /dev/null
> +++ b/include/linux/soc/ti/ti_sci_inta_msi.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Texas Instruments' K3 TI SCI INTA MSI helper
> + *
> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
> + *	Lokesh Vutla <lokeshvutla@ti.com>
> + */
> +
> +#ifndef __INCLUDE_LINUX_TI_SCI_INTA_MSI_H
> +#define __INCLUDE_LINUX_TI_SCI_INTA_MSI_H
> +
> +#include <linux/msi.h>
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +
> +struct irq_domain
> +*ti_sci_inta_msi_create_irq_domain(struct fwnode_handle *fwnode,
> +				   struct msi_domain_info *info,
> +				   struct irq_domain *parent);
> +int ti_sci_inta_msi_domain_alloc_irqs(struct platform_device *pdev,
> +				      struct ti_sci_resource *res);
> +unsigned int ti_sci_inta_msi_get_virq(struct platform_device *dev, u32 index);
> +void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
> +#endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
