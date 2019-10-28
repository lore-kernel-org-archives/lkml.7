Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4ECCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677E9208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbfJ1Nwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:52:53 -0400
Received: from foss.arm.com ([217.140.110.172]:40098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfJ1Nww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:52:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 253DA1F1;
        Mon, 28 Oct 2019 06:52:52 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51443F6C4;
        Mon, 28 Oct 2019 06:52:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/dma: wire-up new dma map op .get_virt_addr
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Madalin Bucur <madalin.bucur@nxp.com>
References: <20191024124130.16871-1-laurentiu.tudor@nxp.com>
 <20191024124130.16871-3-laurentiu.tudor@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8c472ff4-1de4-42c7-f4f1-7b26043d81af@arm.com>
Date:   Mon, 28 Oct 2019 13:52:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191024124130.16871-3-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2019 13:41, Laurentiu Tudor wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Add an implementation of the newly introduced dma map op in the
> generic DMA IOMMU generic glue layer and wire it up.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/iommu/dma-iommu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f321279baf9e..15e76232d697 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1091,6 +1091,21 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>   	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>   }
>   
> +static void *iommu_dma_get_virt_addr(struct device *dev, dma_addr_t dma_handle)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);

Note that we'd generally use the iommu_get_dma_domain() fastpath...

> +
> +	if (domain) {

...wherein we can also assume that the device having iommu_dma_ops 
assigned at all implies that a DMA ops domain is in place.

Robin.

> +		phys_addr_t phys;
> +
> +		phys = iommu_iova_to_phys(domain, dma_handle);
> +		if (phys)
> +			return phys_to_virt(phys);
> +	}
> +
> +	return NULL;
> +}
> +
>   static const struct dma_map_ops iommu_dma_ops = {
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
> @@ -1107,6 +1122,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>   	.map_resource		= iommu_dma_map_resource,
>   	.unmap_resource		= iommu_dma_unmap_resource,
>   	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> +	.get_virt_addr		= iommu_dma_get_virt_addr,
>   };
>   
>   /*
> 
