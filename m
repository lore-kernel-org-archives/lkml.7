Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E297C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6CE233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118522;
	bh=K4rt8zt90Kmj60EUr8Ldv/KP5AZNgIOkytellVQSzmc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=YEvb3y1caNAw7Se5gFeoG9x43gq1XrSVKH3UV3wYr3hcCNdN3lzZPkbxRBJrQoL33
	 8BJC/tayJIaeA3NMweJtBsM3ConzeYF38SN4LT0fLZNU4ghtoyQaaOqWWoQ90bKuwJ
	 p/8JI/8ieZufzs4KlGXMgDYlUvQkEqEtqIR4NyFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfH2WmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbfH2Wl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:59 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31312189D;
        Thu, 29 Aug 2019 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118519;
        bh=K4rt8zt90Kmj60EUr8Ldv/KP5AZNgIOkytellVQSzmc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=1YN/3xioK/sOkd2EHLYyrqoX59ZRTxCvQ8FvQpisRpYOU/0fSb7JKuj23nCZQH6hu
         /RlPCh5ef2sQ3bgqTFLrsqntATI/sGsYVmmUrwpiJsHK6U8JdkHPxtUByH2AGJpzQ0
         jVl7lnqoqH4YW8dX0danw5b7kBAaiscoagXBaJPM=
Date:   Thu, 29 Aug 2019 15:41:58 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] xen/arm: simplify dma_cache_maint
In-Reply-To: <20190826121944.515-4-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281431390.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-4-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> Calculate the required operation in the caller, and pass it directly
> instead of recalculating it for each page, and use simple arithmetics
> to get from the physical address to Xen page size aligned chunks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/xen/mm.c | 62 +++++++++++++++++------------------------------
>  1 file changed, 22 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 90574d89d0d4..14210ebdea1a 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -35,64 +35,46 @@ unsigned long xen_get_swiotlb_free_pages(unsigned int order)
>  	return __get_free_pages(flags, order);
>  }
>  
> -enum dma_cache_op {
> -       DMA_UNMAP,
> -       DMA_MAP,
> -};
>  static bool hypercall_cflush = false;
>  
> -/* functions called by SWIOTLB */
> -
> -static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
> -	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
> +/* buffers in highmem or foreign pages cannot cross page boundaries */
> +static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
>  {
>  	struct gnttab_cache_flush cflush;
> -	unsigned long xen_pfn;
> -	size_t left = size;
>  
> -	xen_pfn = (handle >> XEN_PAGE_SHIFT) + offset / XEN_PAGE_SIZE;
> -	offset %= XEN_PAGE_SIZE;
> +	cflush.a.dev_bus_addr = handle & XEN_PAGE_MASK;
> +	cflush.offset = xen_offset_in_page(handle);
> +	cflush.op = op;
>  
>  	do {
> -		size_t len = left;
> -	
> -		/* buffers in highmem or foreign pages cannot cross page
> -		 * boundaries */
> -		if (len + offset > XEN_PAGE_SIZE)
> -			len = XEN_PAGE_SIZE - offset;
> -
> -		cflush.op = 0;
> -		cflush.a.dev_bus_addr = xen_pfn << XEN_PAGE_SHIFT;
> -		cflush.offset = offset;
> -		cflush.length = len;
> -
> -		if (op == DMA_UNMAP && dir != DMA_TO_DEVICE)
> -			cflush.op = GNTTAB_CACHE_INVAL;
> -		if (op == DMA_MAP) {
> -			if (dir == DMA_FROM_DEVICE)
> -				cflush.op = GNTTAB_CACHE_INVAL;
> -			else
> -				cflush.op = GNTTAB_CACHE_CLEAN;
> -		}
> -		if (cflush.op)
> -			HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
> +		if (size + cflush.offset > XEN_PAGE_SIZE)
> +			cflush.length = XEN_PAGE_SIZE - cflush.offset;
> +		else
> +			cflush.length = size;

isn't it missing a:

  cflush.a.dev_bus_addr = handle & XEN_PAGE_MASK;

here?


> +		HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
> +
> +		handle += cflush.length;
> +		size -= cflush.length;
>  
> -		offset = 0;
> -		xen_pfn++;
> -		left -= len;
> -	} while (left);
> +		cflush.offset = 0;
> +	} while (size);
>  }
>  
>  static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir)
>  {
> -	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_UNMAP);
> +	if (dir != DMA_TO_DEVICE)
> +		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
>  }
>  
>  static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
>  		size_t size, enum dma_data_direction dir)
>  {
> -	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_MAP);
> +	if (dir == DMA_FROM_DEVICE)
> +		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
> +	else
> +		dma_cache_maint(handle, size, GNTTAB_CACHE_CLEAN);
>  }
>  
>  void __xen_dma_map_page(struct device *hwdev, struct page *page,
> -- 
> 2.20.1
> 
