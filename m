Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CA621874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118511;
	bh=zVuq7UiFIvES2V8FNzXq+zN3VeqnlIDeBuJ9TC/EqHQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=vy+CZl4qVPDWGTLv9R3P5l8yWLv2gSzWi8iEKlIAVfuE/cc3fyyr1qm2G3LHBilHh
	 dywXhPAar3z9LkCMeuVxWdc1bBtRCvmCRqOLuxlTSxEiwl5BpmbvXTcaKl4Bg/YhoF
	 C3+jUCs73E1zecixGAfMCRFW31vKNIFDkGsJN5Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfH2Wlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbfH2Wls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:48 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6846D21874;
        Thu, 29 Aug 2019 22:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118507;
        bh=zVuq7UiFIvES2V8FNzXq+zN3VeqnlIDeBuJ9TC/EqHQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=01g0xDT1GOKWzl8KJpALY9PNSe+2ZwSXIuKKWTkED0X8lgSA65Bl88vOV55gJMkv5
         fm/KMz4qjv1wktgJ2HStodSXuMPPdrMSdxXnb0SXhjdvaAxrcKzx+PRIBrSURCsm5+
         z9PyWIKWOk7Fw8ooI3Sb2GNkwAggegQQjDPJR5v0=
Date:   Thu, 29 Aug 2019 15:41:46 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH 02/11] xen/arm: use dev_is_dma_coherent
In-Reply-To: <20190826121944.515-3-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281419010.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-3-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> Use the dma-noncoherent dev_is_dma_coherent helper instead of the home
> grown variant.  Note that both are always initialized to the same
> value in arch_setup_dma_ops.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Julien Grall <julien.grall@arm.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm/include/asm/dma-mapping.h   |  6 ------
>  arch/arm/xen/mm.c                    | 12 ++++++------
>  arch/arm64/include/asm/dma-mapping.h |  9 ---------
>  3 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index dba9355e2484..bdd80ddbca34 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -91,12 +91,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>  }
>  #endif
>  
> -/* do not use this function in a driver */
> -static inline bool is_device_dma_coherent(struct device *dev)
> -{
> -	return dev->archdata.dma_coherent;
> -}
> -
>  /**
>   * arm_dma_alloc - allocate consistent memory for DMA
>   * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index d33b77e9add3..90574d89d0d4 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/cpu.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-noncoherent.h>
>  #include <linux/gfp.h>
>  #include <linux/highmem.h>
>  #include <linux/export.h>
> @@ -99,7 +99,7 @@ void __xen_dma_map_page(struct device *hwdev, struct page *page,
>  	     dma_addr_t dev_addr, unsigned long offset, size_t size,
>  	     enum dma_data_direction dir, unsigned long attrs)
>  {
> -	if (is_device_dma_coherent(hwdev))
> +	if (dev_is_dma_coherent(hwdev))
>  		return;
>  	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
>  		return;
> @@ -112,7 +112,7 @@ void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
>  		unsigned long attrs)
>  
>  {
> -	if (is_device_dma_coherent(hwdev))
> +	if (dev_is_dma_coherent(hwdev))
>  		return;
>  	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
>  		return;
> @@ -123,7 +123,7 @@ void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
>  void __xen_dma_sync_single_for_cpu(struct device *hwdev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>  {
> -	if (is_device_dma_coherent(hwdev))
> +	if (dev_is_dma_coherent(hwdev))
>  		return;
>  	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
>  }
> @@ -131,7 +131,7 @@ void __xen_dma_sync_single_for_cpu(struct device *hwdev,
>  void __xen_dma_sync_single_for_device(struct device *hwdev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>  {
> -	if (is_device_dma_coherent(hwdev))
> +	if (dev_is_dma_coherent(hwdev))
>  		return;
>  	__xen_dma_page_cpu_to_dev(hwdev, handle, size, dir);
>  }
> @@ -159,7 +159,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
>  	 * memory and we are not able to flush the cache.
>  	 */
>  	return (!hypercall_cflush && (xen_pfn != bfn) &&
> -		!is_device_dma_coherent(dev));
> +		!dev_is_dma_coherent(dev));
>  }
>  
>  int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index bdcb0922a40c..67243255a858 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -18,14 +18,5 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>  	return NULL;
>  }
>  
> -/*
> - * Do not use this function in a driver, it is only provided for
> - * arch/arm/mm/xen.c, which is used by arm64 as well.
> - */
> -static inline bool is_device_dma_coherent(struct device *dev)
> -{
> -	return dev->dma_coherent;
> -}
> -
>  #endif	/* __KERNEL__ */
>  #endif	/* __ASM_DMA_MAPPING_H */
> -- 
> 2.20.1
> 
