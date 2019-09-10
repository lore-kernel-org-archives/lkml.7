Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46132C4740C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 00:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061EA21A4C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 00:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568074712;
	bh=YgqPgucJuky5FcSp0vrxNvRL/Fngfl3HUuoywRnLxy0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=2PMLsMT0pM8eFgqZeIJ6Os3ToSfl+hQPehmS/lXjF+kaYZabjo6QP9LwYwXN7dobe
	 NyNUVTQ1FCeLFffezTz5PI1iHixLbhzqLKv7j7aZraTE3f22GepVqbO7I3vRBVmXIn
	 eB3avtxJUDuAkEYDbBbHvGt5XQXPLNCjY9w8lLrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbfIJASb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 20:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfIJASa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 20:18:30 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C351C21670;
        Tue, 10 Sep 2019 00:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568074709;
        bh=YgqPgucJuky5FcSp0vrxNvRL/Fngfl3HUuoywRnLxy0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jDdg6bjkfqRkN2qiY8xoU/nMdM+W40s+tBS17TmDrDcR3MECdp1nBG0NCqvoH4YvV
         BhBFaNaLjghh08U+HyVFYhOT2bdGVC30dg4Fe3ALVyp/kGUA3+wG2mX1tAtaVHNUem
         LmajRzth9Ln8b9KkbWlaJjYNjxw9p2XvDczARe2k=
Date:   Mon, 9 Sep 2019 17:18:27 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, boris.ostrovsky@oracle.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] xen/arm: use dma-noncoherent.h calls for xen-swiotlb
 cache maintainance
In-Reply-To: <20190905113408.3104-2-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1909091659220.29131@sstabellini-ThinkPad-T480s>
References: <20190905113408.3104-1-hch@lst.de> <20190905113408.3104-2-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Christoph Hellwig wrote:
> Copy the arm64 code that uses the dma-direct/swiotlb helpers for DMA
> on-coherent devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This is much better and much more readable.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  arch/arm/include/asm/device.h            |  3 -
>  arch/arm/include/asm/xen/page-coherent.h | 72 +++++++++---------------
>  arch/arm/mm/dma-mapping.c                |  8 +--
>  drivers/xen/swiotlb-xen.c                | 20 -------
>  4 files changed, 28 insertions(+), 75 deletions(-)
> 
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> index f6955b55c544..c675bc0d5aa8 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -14,9 +14,6 @@ struct dev_archdata {
>  #endif
>  #ifdef CONFIG_ARM_DMA_USE_IOMMU
>  	struct dma_iommu_mapping	*mapping;
> -#endif
> -#ifdef CONFIG_XEN
> -	const struct dma_map_ops *dev_dma_ops;
>  #endif
>  	unsigned int dma_coherent:1;
>  	unsigned int dma_ops_setup:1;
> diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
> index 2c403e7c782d..602ac02f154c 100644
> --- a/arch/arm/include/asm/xen/page-coherent.h
> +++ b/arch/arm/include/asm/xen/page-coherent.h
> @@ -6,23 +6,37 @@
>  #include <asm/page.h>
>  #include <xen/arm/page-coherent.h>
>  
> -static inline const struct dma_map_ops *xen_get_dma_ops(struct device *dev)
> -{
> -	if (dev && dev->archdata.dev_dma_ops)
> -		return dev->archdata.dev_dma_ops;
> -	return get_arch_dma_ops(NULL);
> -}
> -
>  static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
>  {
> -	return xen_get_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
> +	return dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
>  }
>  
>  static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
>  {
> -	xen_get_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
> +	dma_direct_free(hwdev, size, cpu_addr, dma_handle, attrs);
> +}
> +
> +static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +
> +	if (pfn_valid(pfn))
> +		dma_direct_sync_single_for_cpu(hwdev, handle, size, dir);
> +	else
> +		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> +}
> +
> +static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> +		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> +{
> +	unsigned long pfn = PFN_DOWN(handle);
> +	if (pfn_valid(pfn))
> +		dma_direct_sync_single_for_device(hwdev, handle, size, dir);
> +	else
> +		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
>  }
>  
>  static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> @@ -36,17 +50,8 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
>  	bool local = (page_pfn <= dev_pfn) &&
>  		(dev_pfn - page_pfn < compound_pages);
>  
> -	/*
> -	 * Dom0 is mapped 1:1, while the Linux page can span across
> -	 * multiple Xen pages, it's not possible for it to contain a
> -	 * mix of local and foreign Xen pages. So if the first xen_pfn
> -	 * == mfn the page is local otherwise it's a foreign page
> -	 * grant-mapped in dom0. If the page is local we can safely
> -	 * call the native dma_ops function, otherwise we call the xen
> -	 * specific function.
> -	 */
>  	if (local)
> -		xen_get_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
> +		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
>  	else
>  		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
>  }
> @@ -63,33 +68,10 @@ static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
>  	 * safely call the native dma_ops function, otherwise we call the xen
>  	 * specific function.
>  	 */
> -	if (pfn_valid(pfn)) {
> -		if (xen_get_dma_ops(hwdev)->unmap_page)
> -			xen_get_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
> -	} else
> +	if (pfn_valid(pfn))
> +		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
> +	else
>  		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
>  }
>  
> -static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	if (pfn_valid(pfn)) {
> -		if (xen_get_dma_ops(hwdev)->sync_single_for_cpu)
> -			xen_get_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
> -	} else
> -		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
> -}
> -
> -static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> -{
> -	unsigned long pfn = PFN_DOWN(handle);
> -	if (pfn_valid(pfn)) {
> -		if (xen_get_dma_ops(hwdev)->sync_single_for_device)
> -			xen_get_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
> -	} else
> -		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
> -}
> -
>  #endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index d42557ee69c2..738097396445 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1132,10 +1132,6 @@ static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
>  	 * 32-bit DMA.
>  	 * Use the generic dma-direct / swiotlb ops code in that case, as that
>  	 * handles bounce buffering for us.
> -	 *
> -	 * Note: this checks CONFIG_ARM_LPAE instead of CONFIG_SWIOTLB as the
> -	 * latter is also selected by the Xen code, but that code for now relies
> -	 * on non-NULL dev_dma_ops.  To be cleaned up later.
>  	 */
>  	if (IS_ENABLED(CONFIG_ARM_LPAE))
>  		return NULL;
> @@ -2363,10 +2359,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	set_dma_ops(dev, dma_ops);
>  
>  #ifdef CONFIG_XEN
> -	if (xen_initial_domain()) {
> -		dev->archdata.dev_dma_ops = dev->dma_ops;
> +	if (xen_initial_domain())
>  		dev->dma_ops = xen_dma_ops;
> -	}
>  #endif
>  	dev->archdata.dma_ops_setup = true;
>  }
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index ae1df496bf38..eee86cc7046b 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -557,11 +557,6 @@ xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>  		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		     unsigned long attrs)
>  {
> -#ifdef CONFIG_ARM
> -	if (xen_get_dma_ops(dev)->mmap)
> -		return xen_get_dma_ops(dev)->mmap(dev, vma, cpu_addr,
> -						    dma_addr, size, attrs);
> -#endif
>  	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
>  }
>  
> @@ -574,21 +569,6 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>  			void *cpu_addr, dma_addr_t handle, size_t size,
>  			unsigned long attrs)
>  {
> -#ifdef CONFIG_ARM
> -	if (xen_get_dma_ops(dev)->get_sgtable) {
> -#if 0
> -	/*
> -	 * This check verifies that the page belongs to the current domain and
> -	 * is not one mapped from another domain.
> -	 * This check is for debug only, and should not go to production build
> -	 */
> -		unsigned long bfn = PHYS_PFN(dma_to_phys(dev, handle));
> -		BUG_ON (!page_is_ram(bfn));
> -#endif
> -		return xen_get_dma_ops(dev)->get_sgtable(dev, sgt, cpu_addr,
> -							   handle, size, attrs);
> -	}
> -#endif
>  	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
>  }
>  
> -- 
> 2.20.1
> 
