Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B44C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE74E2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHPNiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:38:02 -0400
Received: from foss.arm.com ([217.140.110.172]:57178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfHPNiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:38:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E95ED344;
        Fri, 16 Aug 2019 06:38:00 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF273F694;
        Fri, 16 Aug 2019 06:37:59 -0700 (PDT)
Subject: Re: [PATCH 03/11] xen/arm: pass one less argument to dma_cache_maint
To:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190816130013.31154-1-hch@lst.de>
 <20190816130013.31154-4-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8585fb27-14e0-888c-6749-6862b4e16418@arm.com>
Date:   Fri, 16 Aug 2019 14:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190816130013.31154-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2019 14:00, Christoph Hellwig wrote:
> Instead of taking apart the dma address in both callers do it inside
> dma_cache_maint itself.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm/xen/mm.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 90574d89d0d4..d9da24fda2f7 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -43,13 +43,15 @@ static bool hypercall_cflush = false;
>   
>   /* functions called by SWIOTLB */
>   
> -static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
> -	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
> +static void dma_cache_maint(dma_addr_t handle, size_t size,
> +		enum dma_data_direction dir, enum dma_cache_op op)
>   {
>   	struct gnttab_cache_flush cflush;
>   	unsigned long xen_pfn;
> +	unsigned long offset = handle & ~PAGE_MASK;
>   	size_t left = size;
>   
> +	offset &= PAGE_MASK;

Ahem... presumably that should be handle, not offset.

Robin.

>   	xen_pfn = (handle >> XEN_PAGE_SHIFT) + offset / XEN_PAGE_SIZE;
>   	offset %= XEN_PAGE_SIZE;
>   
> @@ -86,13 +88,13 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
>   static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
>   		size_t size, enum dma_data_direction dir)
>   {
> -	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_UNMAP);
> +	dma_cache_maint(handle, size, dir, DMA_UNMAP);
>   }
>   
>   static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
>   		size_t size, enum dma_data_direction dir)
>   {
> -	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_MAP);
> +	dma_cache_maint(handle, size, dir, DMA_MAP);
>   }
>   
>   void __xen_dma_map_page(struct device *hwdev, struct page *page,
> 
