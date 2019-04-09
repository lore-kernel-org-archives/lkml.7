Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3350CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B63F208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDIP3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:29:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfDIP3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:29:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4099015AB;
        Tue,  9 Apr 2019 08:29:10 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCB543F68F;
        Tue,  9 Apr 2019 08:29:08 -0700 (PDT)
Subject: Re: [PATCH 08/21] dma-iommu: refactor iommu_dma_mmap
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-9-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <adf139e2-a595-fa08-e287-f358c06d7e91@arm.com>
Date:   Tue, 9 Apr 2019 16:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Move the vm_area handling into __iommu_dma_mmap, which is renamed
> to iommu_dma_mmap_remap.
> 
> Inline __iommu_dma_mmap_pfn into the main function to simplify the code
> flow a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 50 ++++++++++++++-------------------------
>   1 file changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d14fe9f8c692..43bd3c7e0f6b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -597,23 +597,27 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
>   }
>   
>   /**
> - * __iommu_dma_mmap - Map a buffer into provided user VMA
> - * @pages: Array representing buffer from __iommu_dma_alloc()
> + * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
> + * @cpu_addr: virtual address of the memory to be remapped
>    * @size: Size of buffer in bytes
>    * @vma: VMA describing requested userspace mapping
>    *
> - * Maps the pages of the buffer in @pages into @vma. The caller is responsible
> + * Maps the pages pointed to by @cpu_addr into @vma. The caller is responsible
>    * for verifying the correct size and protection of @vma beforehand.
>    */
> -static int __iommu_dma_mmap(struct page **pages, size_t size,
> +static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
>   		struct vm_area_struct *vma)
>   {
> +	struct vm_struct *area = find_vm_area(cpu_addr);
>   	unsigned long uaddr = vma->vm_start;
>   	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	int ret = -ENXIO;
>   
> +	if (WARN_ON(!area || !area->pages))
> +		return -ENXIO;
> +
>   	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -		ret = vm_insert_page(vma, uaddr, pages[i]);
> +		ret = vm_insert_page(vma, uaddr, area->pages[i]);
>   		if (ret)
>   			break;
>   		uaddr += PAGE_SIZE;
> @@ -1052,21 +1056,13 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   	}
>   }
>   
> -static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
> -			      unsigned long pfn, size_t size)
> -{
> -	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> -			       vma->vm_end - vma->vm_start,
> -			       vma->vm_page_prot);
> -}
> -
>   static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs)
>   {
>   	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	unsigned long off = vma->vm_pgoff;
> -	struct vm_struct *area;
> +	unsigned long pfn;
>   	int ret;
>   
>   	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -1077,25 +1073,15 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
>   		return -ENXIO;
>   
> -	if (!is_vmalloc_addr(cpu_addr)) {
> -		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
> -	}
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
> +			return iommu_dma_mmap_remap(cpu_addr, size, vma);
> +		pfn = vmalloc_to_pfn(cpu_addr);
> +	} else
> +		pfn = page_to_pfn(virt_to_page(cpu_addr));

Nit: braces around the else clause for correct style.

Otherwise, this seems to make sense;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   
> -	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		/*
> -		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> -		 */
> -		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
> -	}
> -
> -	area = find_vm_area(cpu_addr);
> -	if (WARN_ON(!area || !area->pages))
> -		return -ENXIO;
> -
> -	return __iommu_dma_mmap(area->pages, size, vma);
> +	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> +			vma_pages(vma) << PAGE_SHIFT, vma->vm_page_prot);
>   }
>   
>   static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
> 
