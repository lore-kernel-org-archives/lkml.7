Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5816DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2216A2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDIQjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:39:03 -0400
Received: from foss.arm.com ([217.140.101.70]:41050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDIQjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:39:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BF6C15BE;
        Tue,  9 Apr 2019 09:39:02 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AAF43F68F;
        Tue,  9 Apr 2019 09:39:01 -0700 (PDT)
Subject: Re: [PATCH 11/21] dma-iommu: refactor page array remap helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-12-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9fe28aa4-3b7c-ee98-3f73-f10271f06c3a@arm.com>
Date:   Tue, 9 Apr 2019 17:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Move the call to dma_common_pages_remap / dma_common_free_remap  into
> __iommu_dma_alloc / __iommu_dma_free and rename those functions to
> better describe what they do.  This keeps the functionality that
> allocates and remaps a non-contigous array of pages nicely abstracted
> out from the calling code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 75 +++++++++++++++++++--------------------
>   1 file changed, 36 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4d46beeea5b7..2013c650718a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -524,51 +524,57 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   }
>   
>   /**
> - * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
> + * iommu_dma_free_remap - Free a buffer allocated by iommu_dma_alloc_remap

Unmap and free a buffer allocated by iommu_dma_alloc_remap()

>    * @dev: Device which owns this buffer
> - * @pages: Array of buffer pages as returned by __iommu_dma_alloc()
>    * @size: Size of buffer in bytes
> + * @cpu_address: Virtual address of the buffer
>    * @handle: DMA address of buffer

@dma_handle

>    *
>    * Frees both the pages associated with the buffer, and the array
>    * describing them

and removes the CPU mapping.

>    */
> -static void __iommu_dma_free(struct device *dev, struct page **pages,
> -		size_t size, dma_addr_t *handle)
> +static void iommu_dma_free_remap(struct device *dev, size_t size,
> +		void *cpu_addr, dma_addr_t dma_handle)
>   {
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
> -	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> -	*handle = DMA_MAPPING_ERROR;
> +	struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +	if (WARN_ON(!area || !area->pages))
> +		return;
> +	__iommu_dma_unmap(iommu_get_dma_domain(dev), dma_handle, size);
> +	__iommu_dma_free_pages(area->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> +	dma_common_free_remap(cpu_addr, PAGE_ALIGN(size), VM_USERMAP);
>   }
>   
>   /**
> - * __iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
> + * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space

I'm not sure of a succinct way to update that one :(

Other than kerneldoc nits, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>    * @dev: Device to allocate memory for. Must be a real device
>    *	 attached to an iommu_dma_domain
>    * @size: Size of buffer in bytes
> + * @dma_handle: Out argument for allocated DMA handle
>    * @gfp: Allocation flags
>    * @attrs: DMA attributes for this allocation
> - * @prot: IOMMU mapping flags
> - * @handle: Out argument for allocated DMA handle
>    *
>    * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
>    * but an IOMMU which supports smaller pages might not map the whole thing.
>    *
> - * Return: Array of struct page pointers describing the buffer,
> - *	   or NULL on failure.
> + * Return: Mapped virtual address, or NULL on failure.
>    */
> -static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
> -		gfp_t gfp, unsigned long attrs, int prot, dma_addr_t *handle)
> +static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
> +	bool coherent = dev_is_dma_coherent(dev);
> +	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
> +	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
> +	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
>   	struct page **pages;
>   	struct sg_table sgt;
>   	dma_addr_t iova;
> -	unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
> +	void *vaddr;
>   
> -	*handle = DMA_MAPPING_ERROR;
> +	*dma_handle = DMA_MAPPING_ERROR;
>   
>   	min_size = alloc_sizes & -alloc_sizes;
>   	if (min_size < PAGE_SIZE) {
> @@ -594,7 +600,7 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
>   	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
>   		goto out_free_iova;
>   
> -	if (!(prot & IOMMU_CACHE)) {
> +	if (!(ioprot & IOMMU_CACHE)) {
>   		struct scatterlist *sg;
>   		int i;
>   
> @@ -602,14 +608,21 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
>   			arch_dma_prep_coherent(sg_page(sg), sg->length);
>   	}
>   
> -	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
> +	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, ioprot)
>   			< size)
>   		goto out_free_sg;
>   
> -	*handle = iova;
> +	vaddr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
> +			__builtin_return_address(0));
> +	if (!vaddr)
> +		goto out_unmap;
> +
> +	*dma_handle = iova;
>   	sg_free_table(&sgt);
> -	return pages;
> +	return vaddr;
>   
> +out_unmap:
> +	__iommu_dma_unmap(domain, iova, size);
>   out_free_sg:
>   	sg_free_table(&sgt);
>   out_free_iova:
> @@ -1013,18 +1026,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   						    size >> PAGE_SHIFT);
>   		}
>   	} else {
> -		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
> -		struct page **pages;
> -
> -		pages = __iommu_dma_alloc(dev, iosize, gfp, attrs, ioprot,
> -					handle);
> -		if (!pages)
> -			return NULL;
> -
> -		addr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
> -					      __builtin_return_address(0));
> -		if (!addr)
> -			__iommu_dma_free(dev, pages, iosize, handle);
> +		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
>   	}
>   	return addr;
>   }
> @@ -1038,7 +1040,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   	/*
>   	 * @cpu_addr will be one of 4 things depending on how it was allocated:
>   	 * - A remapped array of pages for contiguous allocations.
> -	 * - A remapped array of pages from __iommu_dma_alloc(), for all
> +	 * - A remapped array of pages from iommu_dma_alloc_remap(), for all
>   	 *   non-atomic allocations.
>   	 * - A non-cacheable alias from the atomic pool, for atomic
>   	 *   allocations by non-coherent devices.
> @@ -1056,12 +1058,7 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
>   		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>   	} else if (is_vmalloc_addr(cpu_addr)){
> -		struct vm_struct *area = find_vm_area(cpu_addr);
> -
> -		if (WARN_ON(!area || !area->pages))
> -			return;
> -		__iommu_dma_free(dev, area->pages, iosize, &handle);
> -		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
> +		iommu_dma_free_remap(dev, iosize, cpu_addr, handle);
>   	} else {
>   		__iommu_dma_unmap_page(dev, handle, iosize, 0, 0);
>   		__free_pages(virt_to_page(cpu_addr), get_order(size));
> 
