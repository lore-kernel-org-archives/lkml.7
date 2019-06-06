Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F5C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311EB2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFFG3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:29:07 -0400
Received: from verein.lst.de ([213.95.11.211]:47324 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFG3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:29:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9166C68B05; Thu,  6 Jun 2019 08:28:40 +0200 (CEST)
Date:   Thu, 6 Jun 2019 08:28:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, hch@lst.de, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Apply dma_{alloc,free}_contiguous functions
Message-ID: <20190606062840.GD26745@lst.de>
References: <20190603225259.21994-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603225259.21994-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me.  Robin, any comments?

On Mon, Jun 03, 2019 at 03:52:59PM -0700, Nicolin Chen wrote:
> This patch replaces dma_{alloc,release}_from_contiguous() with
> dma_{alloc,free}_contiguous() to simplify those function calls.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/dma-iommu.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 0cd49c2d3770..cc3d39dbbe1a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -951,8 +951,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>  
>  	if (pages)
>  		__iommu_dma_free_pages(pages, count);
> -	if (page && !dma_release_from_contiguous(dev, page, count))
> -		__free_pages(page, get_order(alloc_size));
> +	if (page)
> +		dma_free_contiguous(dev, page, alloc_size);
>  }
>  
>  static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
> @@ -970,12 +970,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>  	struct page *page = NULL;
>  	void *cpu_addr;
>  
> -	if (gfpflags_allow_blocking(gfp))
> -		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
> -						 get_order(alloc_size),
> -						 gfp & __GFP_NOWARN);
> -	if (!page)
> -		page = alloc_pages(gfp, get_order(alloc_size));
> +	page = dma_alloc_contiguous(dev, alloc_size, gfp);
>  	if (!page)
>  		return NULL;
>  
> @@ -997,8 +992,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>  	memset(cpu_addr, 0, alloc_size);
>  	return cpu_addr;
>  out_free_pages:
> -	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
> -		__free_pages(page, get_order(alloc_size));
> +	dma_free_contiguous(dev, page, alloc_size);
>  	return NULL;
>  }
>  
> -- 
> 2.17.1
---end quoted text---
