Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F59C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF459206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfCDX4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:56:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCDX4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:56:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D31D11596;
        Mon,  4 Mar 2019 15:56:41 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575163F706;
        Mon,  4 Mar 2019 15:56:38 -0800 (PST)
Subject: Re: [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
To:     Arnd Bergmann <arnd@arndb.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190304195951.1118807-1-arnd@arndb.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
Date:   Mon, 4 Mar 2019 23:56:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190304195951.1118807-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2019-03-04 7:59 pm, Arnd Bergmann wrote:
> This reverts commit b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR"), which
> introduced an overflow warning in configurations that have a larger
> dma_addr_t than phys_addr_t:
> 
> In file included from include/linux/dma-direct.h:5,
>                   from kernel/dma/swiotlb.c:23:
> kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
> include/linux/dma-mapping.h:136:28: error: conversion from 'long long unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
>   #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
>                              ^
> kernel/dma/swiotlb.c:544:9: note: in expansion of macro 'DMA_MAPPING_ERROR'
>    return DMA_MAPPING_ERROR;
> 
> The configuration that caused this is on 32-bit ARM, where the DMA address
> space depends on the enabled hardware platforms, while the physical
> address space depends on the type of MMU chosen (classic vs LPAE).

Are these real platforms, or random configs? Realistically I don't see a 
great deal of need to support DMA_ADDR_T_64BIT for non-LPAE. 
Particularly in this case since AFAIK the only selector of SWIOTLB on 
Arm is Xen, and that by definition is never going to be useful on 
non-LPAE hardware.

Fair enough that we don't still don't want even randconfigs generating 
warnings, though. As long as this change doesn't let SWIOTLB_MAP_ERROR 
leak out to logic expecting DMA_MAP_ERROR - which does appear to be the 
case - and is also still OK for the opposite weirdness of 
PHYS_ADDR_T_64BIT && !DMA_ADDR_T_64BIT, then I think it's reasonable.

Robin.

> I tried a couple of alternative approaches, but the previous version
> seems as good as any other, so I went back to that.
> 
> Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/xen/swiotlb-xen.c | 4 ++--
>   include/linux/swiotlb.h   | 3 +++
>   kernel/dma/swiotlb.c      | 4 ++--
>   3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 877baf2a94f4..57a98279bf4f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -406,7 +406,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>   
>   	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
>   				     attrs);
> -	if (map == DMA_MAPPING_ERROR)
> +	if (map == SWIOTLB_MAP_ERROR)
>   		return DMA_MAPPING_ERROR;
>   
>   	dev_addr = xen_phys_to_bus(map);
> @@ -557,7 +557,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>   								 sg_phys(sg),
>   								 sg->length,
>   								 dir, attrs);
> -			if (map == DMA_MAPPING_ERROR) {
> +			if (map == SWIOTLB_MAP_ERROR) {
>   				dev_warn(hwdev, "swiotlb buffer is full\n");
>   				/* Don't panic here, we expect map_sg users
>   				   to do proper error handling. */
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 361f62bb4a8e..a65a36551f58 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -44,6 +44,9 @@ enum dma_sync_target {
>   	SYNC_FOR_DEVICE = 1,
>   };
>   
> +/* define the last possible byte of physical address space as a mapping error */
> +#define SWIOTLB_MAP_ERROR (~(phys_addr_t)0x0)
> +
>   extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>   					  dma_addr_t tbl_dma_addr,
>   					  phys_addr_t phys, size_t size,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 12059b78b631..922880b84387 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -541,7 +541,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>   	spin_unlock_irqrestore(&io_tlb_lock, flags);
>   	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
>   		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
> -	return DMA_MAPPING_ERROR;
> +	return SWIOTLB_MAP_ERROR;
>   found:
>   	io_tlb_used += nslots;
>   	spin_unlock_irqrestore(&io_tlb_lock, flags);
> @@ -659,7 +659,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
>   	/* Oh well, have to allocate and map a bounce buffer. */
>   	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
>   			*phys, size, dir, attrs);
> -	if (*phys == DMA_MAPPING_ERROR)
> +	if (*phys == SWIOTLB_MAP_ERROR)
>   		return false;
>   
>   	/* Ensure that the address returned is DMA'ble */
> 
