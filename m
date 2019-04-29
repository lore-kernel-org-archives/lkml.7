Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5121C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D7C20652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfD2N7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:59:47 -0400
Received: from foss.arm.com ([217.140.101.70]:57654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfD2N7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:59:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47E23A78;
        Mon, 29 Apr 2019 06:59:46 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D67293F5C1;
        Mon, 29 Apr 2019 06:59:44 -0700 (PDT)
Subject: Re: [PATCH 14/26] iommu/dma: Refactor iommu_dma_free
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-15-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8321a363-f448-3e48-48f6-58d2b44a2900@arm.com>
Date:   Mon, 29 Apr 2019 14:59:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-15-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> The freeing logic was made particularly horrible by part of it being
> opaque to the arch wrapper, which led to a lot of convoluted repetition
> to ensure each path did everything in the right order. Now that it's
> all private, we can pick apart and consolidate the logically-distinct
> steps of freeing the IOMMU mapping, the underlying pages, and the CPU
> remap (if necessary) into something much more manageable.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [various cosmetic changes to the code flow]

Hmm, I do still prefer my original flow with the dma_common_free_remap() 
call right out of the way at the end rather than being a special case in 
the middle of all the page-freeing (which is the kind of existing 
complexity I was trying to eliminate). I guess you've done this to avoid 
having "if (!dma_release_from_contiguous(...))..." twice like I ended up 
with, which is fair enough I suppose - once we manage to solve the new 
dma_{alloc,free}_contiguous() interface that may tip the balance so I 
can always revisit this then.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 75 ++++++++++++++++++---------------------
>   1 file changed, 35 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4632b9d301a1..9658c4cc3cfe 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -916,6 +916,41 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   	__iommu_dma_unmap(dev, handle, size);
>   }
>   
> +static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		dma_addr_t handle, unsigned long attrs)
> +{
> +	size_t alloc_size = PAGE_ALIGN(size);
> +	int count = alloc_size >> PAGE_SHIFT;
> +	struct page *page = NULL;
> +
> +	__iommu_dma_unmap(dev, handle, size);
> +
> +	/* Non-coherent atomic allocation? Easy */
> +	if (dma_free_from_pool(cpu_addr, alloc_size))
> +		return;
> +
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		/*
> +		 * If it the address is remapped, then it's either non-coherent

s/If it/If/

My "easy; more involved; most complex" narrative definitely doesn't 
translate very well to a different order :)

Otherwise,

Reluctantly-Acked-by: Robin Murphy <robin.murphy@arm.com>

> +		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
> +		 */
> +		struct page **pages = __iommu_dma_get_pages(cpu_addr);
> +
> +		if (pages)
> +			__iommu_dma_free_pages(pages, count);
> +		else
> +			page = vmalloc_to_page(cpu_addr);
> +
> +		dma_common_free_remap(cpu_addr, alloc_size, VM_USERMAP);
> +	} else {
> +		/* Lowmem means a coherent atomic or CMA allocation */
> +		page = virt_to_page(cpu_addr);
> +	}
> +
> +	if (page && !dma_release_from_contiguous(dev, page, count))
> +		__free_pages(page, get_order(alloc_size));
> +}
> +
>   static void *iommu_dma_alloc(struct device *dev, size_t size,
>   		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
>   {
> @@ -985,46 +1020,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   	return addr;
>   }
>   
> -static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> -		dma_addr_t handle, unsigned long attrs)
> -{
> -	size_t iosize = size;
> -
> -	size = PAGE_ALIGN(size);
> -	/*
> -	 * @cpu_addr will be one of 4 things depending on how it was allocated:
> -	 * - A remapped array of pages for contiguous allocations.
> -	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
> -	 *   non-atomic allocations.
> -	 * - A non-cacheable alias from the atomic pool, for atomic
> -	 *   allocations by non-coherent devices.
> -	 * - A normal lowmem address, for atomic allocations by
> -	 *   coherent devices.
> -	 * Hence how dodgy the below logic looks...
> -	 */
> -	if (dma_in_atomic_pool(cpu_addr, size)) {
> -		__iommu_dma_unmap(dev, handle, iosize);
> -		dma_free_from_pool(cpu_addr, size);
> -	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		struct page *page = vmalloc_to_page(cpu_addr);
> -
> -		__iommu_dma_unmap(dev, handle, iosize);
> -		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
> -		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
> -	} else if (is_vmalloc_addr(cpu_addr)){
> -		struct page **pages = __iommu_dma_get_pages(cpu_addr);
> -
> -		if (WARN_ON(!pages))
> -			return;
> -		__iommu_dma_unmap(dev, handle, iosize);
> -		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
> -		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
> -	} else {
> -		__iommu_dma_unmap(dev, handle, iosize);
> -		__free_pages(virt_to_page(cpu_addr), get_order(size));
> -	}
> -}
> -
>   static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
>   			      unsigned long pfn, size_t size)
>   {
> 
