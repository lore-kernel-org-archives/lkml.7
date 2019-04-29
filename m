Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF18C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E0F2177B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfD2OJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:09:02 -0400
Received: from foss.arm.com ([217.140.101.70]:57994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbfD2OJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:09:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3072FA78;
        Mon, 29 Apr 2019 07:09:01 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBEE43F5C1;
        Mon, 29 Apr 2019 07:08:59 -0700 (PDT)
Subject: Re: [PATCH 21/26] iommu/dma: Refactor iommu_dma_get_sgtable
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-22-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <10b0710c-b2b4-7647-6846-71d9df4bd038@arm.com>
Date:   Mon, 29 Apr 2019 15:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-22-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> Inline __iommu_dma_get_sgtable_page into the main function, and use the
> fact that __iommu_dma_get_pages return NULL for remapped contigous
> allocations to simplify the code flow a bit.

Yeah, even I was a bit dubious about the readability of "if (page)... 
else if (pages)..." that my attempt ended up with, so I don't really 
have anything to complain about here.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 45 +++++++++++++++------------------------
>   1 file changed, 17 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index acdfe866cb29..138b85e675c8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1070,42 +1070,31 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	return __iommu_dma_mmap(pages, size, vma);
>   }
>   
> -static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
> -		size_t size)
> -{
> -	int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> -
> -	if (!ret)
> -		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> -	return ret;
> -}
> -
>   static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   		unsigned long attrs)
>   {
> -	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	struct page **pages;
> +	struct page *page;
> +	int ret;
>   
> -	if (!is_vmalloc_addr(cpu_addr)) {
> -		struct page *page = virt_to_page(cpu_addr);
> -		return __iommu_dma_get_sgtable_page(sgt, page, size);
> -	}
> +	if (is_vmalloc_addr(cpu_addr)) {
> +		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
> -	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> -		/*
> -		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> -		 */
> -		struct page *page = vmalloc_to_page(cpu_addr);
> -		return __iommu_dma_get_sgtable_page(sgt, page, size);
> +		if (pages) {
> +			return sg_alloc_table_from_pages(sgt, pages,
> +					PAGE_ALIGN(size) >> PAGE_SHIFT,
> +					0, size, GFP_KERNEL);
> +		}
> +
> +		page = vmalloc_to_page(cpu_addr);
> +	} else {
> +		page = virt_to_page(cpu_addr);
>   	}
>   
> -	pages = __iommu_dma_get_pages(cpu_addr);
> -	if (WARN_ON_ONCE(!pages))
> -		return -ENXIO;
> -	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
> -					 GFP_KERNEL);
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (!ret)
> +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> +	return ret;
>   }
>   
>   static const struct dma_map_ops iommu_dma_ops = {
> 
