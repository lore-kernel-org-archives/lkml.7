Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15509C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C950020652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfD2NFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:05:50 -0400
Received: from foss.arm.com ([217.140.101.70]:56304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfD2NFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:05:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81232A78;
        Mon, 29 Apr 2019 06:05:49 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15DF73F71A;
        Mon, 29 Apr 2019 06:05:47 -0700 (PDT)
Subject: Re: [PATCH 11/26] iommu/dma: Factor out remapped pages lookup
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-12-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8c04947-0ddb-17c5-8918-5859aabc220c@arm.com>
Date:   Mon, 29 Apr 2019 14:05:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-12-hch@lst.de>
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
> Since we duplicate the find_vm_area() logic a few times in places where
> we only care aboute the pages, factor out a helper to abstract it.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [hch: don't warn when not finding a region, as we'll rely on that later]

Yeah, I did think about that and the things which it might make a little 
easier, but preserved it as-is for the sake of keeping my modifications 
quick and simple. TBH I'm now feeling more inclined to drop the WARNs 
entirely at this point, since it's not like there's ever been any 
general guarantee that freeing the wrong thing shouldn't just crash, but 
that's something we can easily come back to later if need be.

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
>   1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b52c5d6be7b4..8e2d9733113e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -525,6 +525,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   	return pages;
>   }
>   
> +static struct page **__iommu_dma_get_pages(void *cpu_addr)
> +{
> +	struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +	if (!area || !area->pages)
> +		return NULL;
> +	return area->pages;
> +}
> +
>   /**
>    * iommu_dma_free - Free a buffer allocated by __iommu_dma_alloc()
>    * @dev: Device which owns this buffer
> @@ -1023,11 +1032,11 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   		dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
>   		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>   	} else if (is_vmalloc_addr(cpu_addr)){
> -		struct vm_struct *area = find_vm_area(cpu_addr);
> +		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
> -		if (WARN_ON(!area || !area->pages))
> +		if (WARN_ON(!pages))
>   			return;
> -		__iommu_dma_free(dev, area->pages, iosize, &handle);
> +		__iommu_dma_free(dev, pages, iosize, &handle);
>   		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>   	} else {
>   		__iommu_dma_unmap(dev, handle, iosize);
> @@ -1049,7 +1058,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   {
>   	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	unsigned long off = vma->vm_pgoff;
> -	struct vm_struct *area;
> +	struct page **pages;
>   	int ret;
>   
>   	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -1074,11 +1083,10 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		return __iommu_dma_mmap_pfn(vma, pfn, size);
>   	}
>   
> -	area = find_vm_area(cpu_addr);
> -	if (WARN_ON(!area || !area->pages))
> +	pages = __iommu_dma_get_pages(cpu_addr);
> +	if (WARN_ON_ONCE(!pages))
>   		return -ENXIO;
> -
> -	return __iommu_dma_mmap(area->pages, size, vma);
> +	return __iommu_dma_mmap(pages, size, vma);
>   }
>   
>   static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
> @@ -1096,7 +1104,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   		unsigned long attrs)
>   {
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	struct vm_struct *area = find_vm_area(cpu_addr);
> +	struct page **pages;
>   
>   	if (!is_vmalloc_addr(cpu_addr)) {
>   		struct page *page = virt_to_page(cpu_addr);
> @@ -1112,10 +1120,10 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   		return __iommu_dma_get_sgtable_page(sgt, page, size);
>   	}
>   
> -	if (WARN_ON(!area || !area->pages))
> +	pages = __iommu_dma_get_pages(cpu_addr);
> +	if (WARN_ON_ONCE(!pages))
>   		return -ENXIO;
> -
> -	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
> +	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
>   					 GFP_KERNEL);
>   }
>   
> 
