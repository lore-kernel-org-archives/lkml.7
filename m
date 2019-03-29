Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C58C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52052184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfC2Ouj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:50:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33384 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbfC2Ouj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:50:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEE4A78;
        Fri, 29 Mar 2019 07:50:38 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F028C3F557;
        Fri, 29 Mar 2019 07:50:36 -0700 (PDT)
Subject: Re: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
To:     laurentiu.tudor@nxp.com, netdev@vger.kernel.org,
        madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com,
        leoyang.li@nxp.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-3-laurentiu.tudor@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
Date:   Fri, 29 Mar 2019 14:50:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329140014.8126-3-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2019 14:00, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Add a one-to-one iommu mapping for bman private data memory (FBPR).
> This is required for BMAN to work without faults behind an iommu.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index 7c3cc968053c..b209c79511bb 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -29,6 +29,7 @@
>    */
>   
>   #include "bman_priv.h"
> +#include <linux/iommu.h>
>   
>   u16 bman_ip_rev;
>   EXPORT_SYMBOL(bman_ip_rev);
> @@ -178,6 +179,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>   	int ret, err_irq;
>   	struct device *dev = &pdev->dev;
>   	struct device_node *node = dev->of_node;
> +	struct iommu_domain *domain;
>   	struct resource *res;
>   	u16 id, bm_pool_cnt;
>   	u8 major, minor;
> @@ -225,6 +227,15 @@ static int fsl_bman_probe(struct platform_device *pdev)
>   
>   	dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
>   
> +	/* Create an 1-to-1 iommu mapping for FBPR area */
> +	domain = iommu_get_domain_for_dev(dev);

If that's expected to be the default domain that you're grabbing, then 
this is *incredibly* fragile. There's nothing to stop the IOVA that you 
forcibly map from being automatically allocated later and causing some 
other DMA mapping to fail noisily and unexpectedly. Furthermore, have 
you tried this with "iommu.passthrough=1"?

That said, I really don't understand what's going on here anyway :/

As far as I can tell from qbman_init_private_mem(), fbpr_a comes from 
dma_alloc_coherent() and thus would already be a mapped IOVA - isn't 
this the stuff that Roy converted to nicely use shared-dma-pool regions 
a while ago?

Robin.

> +	if (domain) {
> +		ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> +		if (ret)
> +			dev_warn(dev, "failed to iommu_map() %d\n", ret);
> +	}
> +
>   	bm_set_memory(fbpr_a, fbpr_sz);
>   
>   	err_irq = platform_get_irq(pdev, 0);
> 
