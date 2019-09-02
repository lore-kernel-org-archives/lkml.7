Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB7C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D357721881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfIBNyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:54:31 -0400
Received: from foss.arm.com ([217.140.110.172]:55098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfIBNyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:54:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCDDD337;
        Mon,  2 Sep 2019 06:54:27 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F7683F59C;
        Mon,  2 Sep 2019 06:54:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] iommu: Implement of_iommu_get_resv_regions()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-2-thierry.reding@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0b7e050a-cec6-6ce7-9ed6-2146eabb2fe8@arm.com>
Date:   Mon, 2 Sep 2019 14:54:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190829111407.17191-2-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 12:14, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This is an implementation that IOMMU drivers can use to obtain reserved
> memory regions from a device tree node. It uses the reserved-memory DT
> bindings to find the regions associated with a given device. These
> regions will be used to create 1:1 mappings in the IOMMU domain that
> the devices will be attached to.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   drivers/iommu/of_iommu.c | 39 +++++++++++++++++++++++++++++++++++++++
>   include/linux/of_iommu.h |  8 ++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 614a93aa5305..0d47f626b854 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -9,6 +9,7 @@
>   #include <linux/iommu.h>
>   #include <linux/limits.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
>   #include <linux/of_iommu.h>
>   #include <linux/of_pci.h>
>   #include <linux/slab.h>
> @@ -225,3 +226,41 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   
>   	return ops;
>   }
> +
> +/**
> + * of_iommu_get_resv_regions - reserved region driver helper for device tree
> + * @dev: device for which to get reserved regions
> + * @list: reserved region list
> + *
> + * IOMMU drivers can use this to implement their .get_resv_regions() callback
> + * for memory regions attached to a device tree node. See the reserved-memory
> + * device tree bindings on how to use these:
> + *
> + *   Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> + */
> +void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
> +{
> +	struct of_phandle_iterator it;
> +	int err;
> +
> +	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
> +		struct iommu_resv_region *region;
> +		struct resource res;
> +
> +		err = of_address_to_resource(it.node, 0, &res);
> +		if (err < 0) {
> +			dev_err(dev, "failed to parse memory region %pOF: %d\n",
> +				it.node, err);
> +			continue;
> +		}

What if the device node has memory regions for other purposes, like 
private CMA carveouts? We wouldn't want to force mappings of those (and 
in the very worst case doing so could even render them unusable).

Robin.

> +
> +		region = iommu_alloc_resv_region(res.start, resource_size(&res),
> +						 IOMMU_READ | IOMMU_WRITE,
> +						 IOMMU_RESV_DIRECT_RELAXABLE);
> +		if (!region)
> +			continue;
> +
> +		list_add_tail(&region->list, list);
> +	}
> +}
> +EXPORT_SYMBOL(of_iommu_get_resv_regions);
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index f3d40dd7bb66..fa16b26f55bc 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -15,6 +15,9 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
>   extern const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					struct device_node *master_np);
>   
> +extern void of_iommu_get_resv_regions(struct device *dev,
> +				      struct list_head *list);
> +
>   #else
>   
>   static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
> @@ -30,6 +33,11 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>   	return NULL;
>   }
>   
> +static inline void of_iommu_get_resv_regions(struct device *dev,
> +					     struct list_head *list)
> +{
> +}
> +
>   #endif	/* CONFIG_OF_IOMMU */
>   
>   #endif /* __OF_IOMMU_H */
> 
