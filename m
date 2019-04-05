Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC66CC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB0A2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfDERq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:46:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53770 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbfDERq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D054D168F;
        Fri,  5 Apr 2019 10:46:58 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 632883F557;
        Fri,  5 Apr 2019 10:46:57 -0700 (PDT)
Subject: Re: [PATCH 05/21] dma-iommu: remove the flush_page callback
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-6-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <43cf29fb-f329-048c-ada2-4727b039a09f@arm.com>
Date:   Fri, 5 Apr 2019 18:46:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> We now have a arch_dma_prep_coherent architecture hook that is used
> for the generic DMA remap allocator, and we should use the same
> interface for the dma-iommu code.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c | 8 +-------
>   drivers/iommu/dma-iommu.c   | 8 +++-----
>   include/linux/dma-iommu.h   | 3 +--
>   3 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index e54288921e72..54787a3d4ad9 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -94,12 +94,6 @@ arch_initcall(arm64_dma_init);
>   #include <linux/platform_device.h>
>   #include <linux/amba/bus.h>
>   
> -/* Thankfully, all cache ops are by VA so we can ignore phys here */
> -static void flush_page(struct device *dev, const void *virt, phys_addr_t phys)
> -{
> -	__dma_flush_area(virt, PAGE_SIZE);
> -}
> -
>   static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>   				 dma_addr_t *handle, gfp_t gfp,
>   				 unsigned long attrs)
> @@ -176,7 +170,7 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
>   		struct page **pages;
>   
>   		pages = iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
> -					handle, flush_page);
> +					handle);
>   		if (!pages)
>   			return NULL;
>   
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 77aabe637a60..77d704c8f565 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -22,6 +22,7 @@
>   #include <linux/acpi_iort.h>
>   #include <linux/device.h>
>   #include <linux/dma-iommu.h>
> +#include <linux/dma-noncoherent.h>
>   #include <linux/gfp.h>
>   #include <linux/huge_mm.h>
>   #include <linux/iommu.h>
> @@ -531,8 +532,6 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
>    * @attrs: DMA attributes for this allocation
>    * @prot: IOMMU mapping flags
>    * @handle: Out argument for allocated DMA handle
> - * @flush_page: Arch callback which must ensure PAGE_SIZE bytes from the
> - *		given VA/PA are visible to the given non-coherent device.
>    *
>    * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
>    * but an IOMMU which supports smaller pages might not map the whole thing.
> @@ -541,8 +540,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
>    *	   or NULL on failure.
>    */
>   struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> -		unsigned long attrs, int prot, dma_addr_t *handle,
> -		void (*flush_page)(struct device *, const void *, phys_addr_t))
> +		unsigned long attrs, int prot, dma_addr_t *handle)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> @@ -586,7 +584,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   		 */
>   		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
>   		while (sg_miter_next(&miter))
> -			flush_page(dev, miter.addr, page_to_phys(miter.page));
> +			arch_dma_prep_coherent(miter.page, PAGE_SIZE);
>   		sg_miter_stop(&miter);
>   	}
>   
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 3e206f4ee173..10ef708a605c 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -45,8 +45,7 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
>    * the arch code to take care of attributes and cache maintenance
>    */
>   struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> -		unsigned long attrs, int prot, dma_addr_t *handle,
> -		void (*flush_page)(struct device *, const void *, phys_addr_t));
> +		unsigned long attrs, int prot, dma_addr_t *handle);
>   void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
>   		dma_addr_t *handle);
>   
> 
