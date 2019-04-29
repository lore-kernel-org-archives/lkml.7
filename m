Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E0DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40552084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfD2OLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:11:40 -0400
Received: from foss.arm.com ([217.140.101.70]:58090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbfD2OLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:11:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9284FA78;
        Mon, 29 Apr 2019 07:11:39 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B8C23F5C1;
        Mon, 29 Apr 2019 07:11:38 -0700 (PDT)
Subject: Re: [PATCH 19/26] iommu/dma: Cleanup variable naming in
 iommu_dma_alloc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-20-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <49314f40-0676-629c-379f-fc05e75fb078@arm.com>
Date:   Mon, 29 Apr 2019 15:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-20-hch@lst.de>
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
> Most importantly clear up the size / iosize confusion.  Also rename addr
> to cpu_addr to match the surrounding code and make the intention a little
> more clear.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [hch: split from a larger patch]

I can't bring myself to actually ack "my" patch, but I am perfectly 
happy with the split :)

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 45 +++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 95a12e975994..9b269f0792f3 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -960,64 +960,63 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   {
>   	bool coherent = dev_is_dma_coherent(dev);
>   	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
> -	size_t iosize = size;
> +	size_t alloc_size = PAGE_ALIGN(size);
>   	struct page *page = NULL;
> -	void *addr;
> +	void *cpu_addr;
>   
> -	size = PAGE_ALIGN(size);
>   	gfp |= __GFP_ZERO;
>   
>   	if (gfpflags_allow_blocking(gfp) &&
>   	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> -		return iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
> +		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
>   
>   	if (!gfpflags_allow_blocking(gfp) && !coherent) {
> -		addr = dma_alloc_from_pool(size, &page, gfp);
> -		if (!addr)
> +		cpu_addr = dma_alloc_from_pool(alloc_size, &page, gfp);
> +		if (!cpu_addr)
>   			return NULL;
>   
> -		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize,
> +		*handle = __iommu_dma_map(dev, page_to_phys(page), size,
>   					  ioprot);
>   		if (*handle == DMA_MAPPING_ERROR) {
> -			dma_free_from_pool(addr, size);
> +			dma_free_from_pool(cpu_addr, alloc_size);
>   			return NULL;
>   		}
> -		return addr;
> +		return cpu_addr;
>   	}
>   
>   	if (gfpflags_allow_blocking(gfp))
> -		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
> -						 get_order(size),
> +		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
> +						 get_order(alloc_size),
>   						 gfp & __GFP_NOWARN);
>   	if (!page)
> -		page = alloc_pages(gfp, get_order(size));
> +		page = alloc_pages(gfp, get_order(alloc_size));
>   	if (!page)
>   		return NULL;
>   
> -	*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
> +	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
>   	if (*handle == DMA_MAPPING_ERROR)
>   		goto out_free_pages;
>   
>   	if (!coherent || PageHighMem(page)) {
>   		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
>   
> -		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
> -				__builtin_return_address(0));
> -		if (!addr)
> +		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
> +				VM_USERMAP, prot, __builtin_return_address(0));
> +		if (!cpu_addr)
>   			goto out_unmap;
>   
>   		if (!coherent)
> -			arch_dma_prep_coherent(page, iosize);
> +			arch_dma_prep_coherent(page, size);
>   	} else {
> -		addr = page_address(page);
> +		cpu_addr = page_address(page);
>   	}
> -	memset(addr, 0, size);
> -	return addr;
> +	memset(cpu_addr, 0, alloc_size);
> +	return cpu_addr;
>   out_unmap:
> -	__iommu_dma_unmap(dev, *handle, iosize);
> +	__iommu_dma_unmap(dev, *handle, size);
>   out_free_pages:
> -	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
> -		__free_pages(page, get_order(size));
> +	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
> +		__free_pages(page, get_order(alloc_size));
>   	return NULL;
>   }
>   
> 
