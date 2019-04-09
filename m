Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CFCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1C52084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDIPyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:54:35 -0400
Received: from foss.arm.com ([217.140.101.70]:40276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfDIPye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:54:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34DDC15AB;
        Tue,  9 Apr 2019 08:54:34 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84473F68F;
        Tue,  9 Apr 2019 08:54:32 -0700 (PDT)
Subject: Re: [PATCH 10/21] dma-iommu: move __iommu_dma_map
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-11-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b67950f5-dc3d-af5c-f4ff-d8943e5a5532@arm.com>
Date:   Tue, 9 Apr 2019 16:54:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Moving this function up to its unmap counterpart helps to keep related
> code together for the following changes.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 46 +++++++++++++++++++--------------------
>   1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 57f2d8621112..4d46beeea5b7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -435,6 +435,29 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
>   	iommu_dma_free_iova(cookie, dma_addr, size);
>   }
>   
> +static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> +		size_t size, int prot, struct iommu_domain *domain)
> +{
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	size_t iova_off = 0;
> +	dma_addr_t iova;
> +
> +	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
> +		iova_off = iova_offset(&cookie->iovad, phys);
> +		size = iova_align(&cookie->iovad, size + iova_off);
> +	}
> +
> +	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> +	if (!iova)
> +		return DMA_MAPPING_ERROR;
> +
> +	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
> +		iommu_dma_free_iova(cookie, iova, size);
> +		return DMA_MAPPING_ERROR;
> +	}
> +	return iova + iova_off;
> +}
> +
>   static void __iommu_dma_free_pages(struct page **pages, int count)
>   {
>   	while (count--)
> @@ -689,29 +712,6 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
>   }
>   
> -static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot, struct iommu_domain *domain)
> -{
> -	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	size_t iova_off = 0;
> -	dma_addr_t iova;
> -
> -	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
> -		iova_off = iova_offset(&cookie->iovad, phys);
> -		size = iova_align(&cookie->iovad, size + iova_off);
> -	}
> -
> -	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> -	if (!iova)
> -		return DMA_MAPPING_ERROR;
> -
> -	if (iommu_map(domain, iova, phys - iova_off, size, prot)) {
> -		iommu_dma_free_iova(cookie, iova, size);
> -		return DMA_MAPPING_ERROR;
> -	}
> -	return iova + iova_off;
> -}
> -
>   static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
>   		unsigned long offset, size_t size, int prot)
>   {
> 
