Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D39C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDFC20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfD2Oqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:46:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbfD2Oqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:46:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C24A80D;
        Mon, 29 Apr 2019 07:46:31 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA8DB3F5C1;
        Mon, 29 Apr 2019 07:46:29 -0700 (PDT)
Subject: Re: [PATCH 23/26] iommu/dma: Don't depend on CONFIG_DMA_DIRECT_REMAP
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-24-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <57ecaf25-ac9a-ec34-d552-bcbc1891875e@arm.com>
Date:   Mon, 29 Apr 2019 15:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-24-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> For entirely dma coherent architectures there is no requirement to ever
> remap dma coherent allocation.  Move all the remap and pool code under
> IS_ENABLED() checks and drop the Kconfig dependency.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/Kconfig     |  1 -
>   drivers/iommu/dma-iommu.c | 16 +++++++++-------
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index bdc14baf2ee5..6f07f3b21816 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -95,7 +95,6 @@ config IOMMU_DMA
>   	select IOMMU_API
>   	select IOMMU_IOVA
>   	select NEED_SG_DMA_LENGTH
> -	depends on DMA_DIRECT_REMAP
>   
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 8fc6098c1eeb..278a9a960107 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -923,10 +923,11 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>   	struct page *page = NULL;
>   
>   	/* Non-coherent atomic allocation? Easy */
> -	if (dma_free_from_pool(cpu_addr, alloc_size))
> +	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> +	    dma_free_from_pool(cpu_addr, alloc_size))
>   		return;
>   
> -	if (is_vmalloc_addr(cpu_addr)) {
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
>   		/*
>   		 * If it the address is remapped, then it's either non-coherent
>   		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
> @@ -972,7 +973,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>   	if (!page)
>   		return NULL;
>   
> -	if (!coherent || PageHighMem(page)) {
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && (!coherent || PageHighMem(page))) {
>   		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
>   
>   		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
> @@ -1005,11 +1006,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   
>   	gfp |= __GFP_ZERO;
>   
> -	if (gfpflags_allow_blocking(gfp) &&
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && gfpflags_allow_blocking(gfp) &&
>   	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
>   		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
>   
> -	if (!gfpflags_allow_blocking(gfp) && !coherent)
> +	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> +	    !gfpflags_allow_blocking(gfp) && !coherent)
>   		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
>   	else
>   		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
> @@ -1041,7 +1043,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
>   		return -ENXIO;
>   
> -	if (is_vmalloc_addr(cpu_addr)) {
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
>   		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
>   		if (pages)
> @@ -1063,7 +1065,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   	struct page *page;
>   	int ret;
>   
> -	if (is_vmalloc_addr(cpu_addr)) {
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
>   		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
>   		if (pages) {
> 
