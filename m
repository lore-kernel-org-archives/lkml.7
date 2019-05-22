Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B1DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D586D20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfEVNey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:34:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51586 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfEVNex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:34:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0AC080D;
        Wed, 22 May 2019 06:34:52 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4356C3F575;
        Wed, 22 May 2019 06:34:51 -0700 (PDT)
Subject: Re: [PATCH 07/24] iommu/dma: Move domain lookup into
 __iommu_dma_{map, unmap}
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <20190520072948.11412-1-hch@lst.de>
 <20190520072948.11412-8-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b2ef2d14-ec58-a1d6-1741-7834840498ee@arm.com>
Date:   Wed, 22 May 2019 14:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520072948.11412-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2019 08:29, Christoph Hellwig wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Most of the callers don't care, and the couple that do already have the
> domain to hand for other reasons are in slow paths where the (trivial)
> overhead of a repeated lookup will be utterly immaterial.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [hch: dropped the hunk touching iommu_dma_get_msi_page to avoid a
>   conflict with another series]

Since the MSI changes made it into 5.2, do you want to resurrect that 
hunk here, or shall I spin it up as a follow-on patch?

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c406abe3be01..6ece8f477fc8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -448,9 +448,10 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>   				size >> iova_shift(iovad));
>   }
>   
> -static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
> +static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>   		size_t size)
>   {
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	size_t iova_off = iova_offset(iovad, dma_addr);
> @@ -465,8 +466,9 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot, struct iommu_domain *domain)
> +		size_t size, int prot)
>   {
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	size_t iova_off = 0;
>   	dma_addr_t iova;
> @@ -565,7 +567,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   static void __iommu_dma_free(struct device *dev, struct page **pages,
>   		size_t size, dma_addr_t *handle)
>   {
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
> +	__iommu_dma_unmap(dev, *handle, size);
>   	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
>   	*handle = DMA_MAPPING_ERROR;
>   }
> @@ -718,14 +720,13 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
>   		unsigned long offset, size_t size, int prot)
>   {
> -	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
> -			iommu_get_dma_domain(dev));
> +	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
>   }
>   
>   static void __iommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
> +	__iommu_dma_unmap(dev, handle, size);
>   }
>   
>   static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> @@ -734,11 +735,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   {
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	bool coherent = dev_is_dma_coherent(dev);
> +	int prot = dma_info_to_prot(dir, coherent, attrs);
>   	dma_addr_t dma_handle;
>   
> -	dma_handle =__iommu_dma_map(dev, phys, size,
> -			dma_info_to_prot(dir, coherent, attrs),
> -			iommu_get_dma_domain(dev));
> +	dma_handle =__iommu_dma_map(dev, phys, size, prot);
>   	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>   	    dma_handle != DMA_MAPPING_ERROR)
>   		arch_sync_dma_for_device(dev, phys, size, dir);
> @@ -750,7 +750,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>   {
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), dma_handle, size);
> +	__iommu_dma_unmap(dev, dma_handle, size);
>   }
>   
>   /*
> @@ -931,21 +931,20 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		sg = tmp;
>   	}
>   	end = sg_dma_address(sg) + sg_dma_len(sg);
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), start, end - start);
> +	__iommu_dma_unmap(dev, start, end - start);
>   }
>   
>   static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	return __iommu_dma_map(dev, phys, size,
> -			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
> -			iommu_get_dma_domain(dev));
> +			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
>   }
>   
>   static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
> +	__iommu_dma_unmap(dev, handle, size);
>   }
>   
>   static void *iommu_dma_alloc(struct device *dev, size_t size,
> @@ -1222,7 +1221,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   	if (!msi_page)
>   		return NULL;
>   
> -	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
> +	iova = __iommu_dma_map(dev, msi_addr, size, prot);
>   	if (iova == DMA_MAPPING_ERROR)
>   		goto out_free_page;
>   
> 
