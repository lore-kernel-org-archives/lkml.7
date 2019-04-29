Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB54C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA99920673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfD2OpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:45:23 -0400
Received: from foss.arm.com ([217.140.101.70]:59094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbfD2OpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:45:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7829780D;
        Mon, 29 Apr 2019 07:45:20 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EADA83F5C1;
        Mon, 29 Apr 2019 07:45:17 -0700 (PDT)
Subject: Re: [PATCH 20/26] iommu/dma: Refactor iommu_dma_alloc, part 2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-21-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9412baed-0d13-dab7-0bdc-90cfdf8e92f0@arm.com>
Date:   Mon, 29 Apr 2019 15:45:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-21-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> From: Robin Murphy <robin.murphy@arm.com>

Honestly I don't think anything left of my patch here...

> Apart from the iommu_dma_alloc_remap() case which remains sufficiently
> different that it's better off being self-contained, the rest of the
> logic can now be consolidated into a single flow which separates the
> logcially-distinct steps of allocating pages, getting the CPU address,
> and finally getting the IOMMU address.

...and it certainly doesn't do that any more.

It's clear that we have fundamentally different ways of reading code, so 
I don't think it's productive to keep arguing personal preference - I 
still find the end result here a fair bit more tolerable than before, so 
if you update the commit message to reflect the actual change (at which 
point there's really nothing left of my authorship) I can live with it.

Robin.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [hch: split the page allocation into a new helper to simplify the flow]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++------------------
>   1 file changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9b269f0792f3..acdfe866cb29 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -955,35 +955,14 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   	__iommu_dma_free(dev, size, cpu_addr);
>   }
>   
> -static void *iommu_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
> +static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
> +		struct page **pagep, gfp_t gfp, unsigned long attrs)
>   {
>   	bool coherent = dev_is_dma_coherent(dev);
> -	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
>   	size_t alloc_size = PAGE_ALIGN(size);
>   	struct page *page = NULL;
>   	void *cpu_addr;
>   
> -	gfp |= __GFP_ZERO;
> -
> -	if (gfpflags_allow_blocking(gfp) &&
> -	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> -		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
> -
> -	if (!gfpflags_allow_blocking(gfp) && !coherent) {
> -		cpu_addr = dma_alloc_from_pool(alloc_size, &page, gfp);
> -		if (!cpu_addr)
> -			return NULL;
> -
> -		*handle = __iommu_dma_map(dev, page_to_phys(page), size,
> -					  ioprot);
> -		if (*handle == DMA_MAPPING_ERROR) {
> -			dma_free_from_pool(cpu_addr, alloc_size);
> -			return NULL;
> -		}
> -		return cpu_addr;
> -	}
> -
>   	if (gfpflags_allow_blocking(gfp))
>   		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
>   						 get_order(alloc_size),
> @@ -993,33 +972,59 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   	if (!page)
>   		return NULL;
>   
> -	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
> -	if (*handle == DMA_MAPPING_ERROR)
> -		goto out_free_pages;
> -
>   	if (!coherent || PageHighMem(page)) {
>   		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
>   
>   		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
>   				VM_USERMAP, prot, __builtin_return_address(0));
>   		if (!cpu_addr)
> -			goto out_unmap;
> +			goto out_free_pages;
>   
>   		if (!coherent)
>   			arch_dma_prep_coherent(page, size);
>   	} else {
>   		cpu_addr = page_address(page);
>   	}
> +
> +	*pagep = page;
>   	memset(cpu_addr, 0, alloc_size);
>   	return cpu_addr;
> -out_unmap:
> -	__iommu_dma_unmap(dev, *handle, size);
>   out_free_pages:
>   	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
>   		__free_pages(page, get_order(alloc_size));
>   	return NULL;
>   }
>   
> +static void *iommu_dma_alloc(struct device *dev, size_t size,
> +		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
> +{
> +	bool coherent = dev_is_dma_coherent(dev);
> +	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
> +	struct page *page = NULL;
> +	void *cpu_addr;
> +
> +	gfp |= __GFP_ZERO;
> +
> +	if (gfpflags_allow_blocking(gfp) &&
> +	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> +		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
> +
> +	if (!gfpflags_allow_blocking(gfp) && !coherent)
> +		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
> +	else
> +		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
> +	if (!cpu_addr)
> +		return NULL;
> +
> +	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
> +	if (*handle == DMA_MAPPING_ERROR) {
> +		__iommu_dma_free(dev, size, cpu_addr);
> +		return NULL;
> +	}
> +
> +	return cpu_addr;
> +}
> +
>   static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
>   			      unsigned long pfn, size_t size)
>   {
> 
