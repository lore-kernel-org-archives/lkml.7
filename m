Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8109A22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118816;
	bh=5i8UCHTKfxI1RiMfkzSc2sP1EbSS0hZk+I67qfUo5Vk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=bo1Yu75KezKf3xCUWMfGu3LT/DoJ8vBbupSLMgEdETmPdsgSArr+rDjeBYXPF8+v7
	 nzMdqxryVW/wshiHTRhOu44U+IU3/xu0NdCS6ngEz4eFdGUYB8WbU7Qii7h6mVXcmK
	 d0Rq+v25f7JnoFnsHjXJEG0ygi8c32aruYxX6sbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfH2Wqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbfH2Wqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:46:55 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A007921874;
        Thu, 29 Aug 2019 22:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118814;
        bh=5i8UCHTKfxI1RiMfkzSc2sP1EbSS0hZk+I67qfUo5Vk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nByf2uix/jKaDvvUZ1qwUvvrxJTXcNbZh5hDsGTEjOY4Jt22C9npxp8mXinRLNkdh
         Ng+zNwUuJ/ZBTQDt7J+XMvSaC6k/RUWNR4LtRYT4no+c2PpjB1n5k0rxg9rEf88n1e
         eJGIHBop60nSe3P/MlgsYuNqtBD9h718EzAH7onw=
Date:   Thu, 29 Aug 2019 15:46:53 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH 06/11] swiotlb-xen: always use dma-direct helpers to
 alloc coherent pages
In-Reply-To: <20190826121944.515-7-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281501120.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-7-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Boris, Juergen

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> x86 currently calls alloc_pages, but using dma-direct works as well
> there, with the added benefit of using the CMA pool if available.
> The biggest advantage is of course to remove a pointless bit of
> architecture specific code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/xen/page-coherent.h | 16 ----------------
>  drivers/xen/swiotlb-xen.c                |  7 +++----
>  include/xen/arm/page-coherent.h          | 12 ------------
>  3 files changed, 3 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/include/asm/xen/page-coherent.h b/arch/x86/include/asm/xen/page-coherent.h
> index 116777e7f387..8ee33c5edded 100644
> --- a/arch/x86/include/asm/xen/page-coherent.h
> +++ b/arch/x86/include/asm/xen/page-coherent.h
> @@ -5,22 +5,6 @@
>  #include <asm/page.h>
>  #include <linux/dma-mapping.h>
>  
> -static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flags,
> -		unsigned long attrs)
> -{
> -	void *vstart = (void*)__get_free_pages(flags, get_order(size));
> -	*dma_handle = virt_to_phys(vstart);

This is where we need Boris and Juergen's opinion. From an ARM POV it
looks OK.


> -	return vstart;
> -}
> -
> -static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> -		void *cpu_addr, dma_addr_t dma_handle,
> -		unsigned long attrs)
> -{
> -	free_pages((unsigned long) cpu_addr, get_order(size));
> -}
> -
>  static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
>  	     dma_addr_t dev_addr, unsigned long offset, size_t size,
>  	     enum dma_data_direction dir, unsigned long attrs) { }
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index b8808677ae1d..f9dd4cb6e4b3 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -299,8 +299,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>  	 * address. In fact on ARM virt_to_phys only works for kernel direct
>  	 * mapped RAM memory. Also see comment below.
>  	 */
> -	ret = xen_alloc_coherent_pages(hwdev, size, dma_handle, flags, attrs);
> -
> +	ret = dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
>  	if (!ret)
>  		return ret;
>  
> @@ -319,7 +318,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>  	else {
>  		if (xen_create_contiguous_region(phys, order,
>  						 fls64(dma_mask), dma_handle) != 0) {
> -			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
> +			dma_direct_free(hwdev, size, ret, (dma_addr_t)phys, attrs);
>  			return NULL;
>  		}
>  		SetPageXenRemapped(virt_to_page(ret));
> @@ -351,7 +350,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	    TestClearPageXenRemapped(virt_to_page(vaddr)))
>  		xen_destroy_contiguous_region(phys, order);
>  
> -	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
> +	dma_direct_free(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
>  }
>  
>  /*
> diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
> index a840d6949a87..0e244f4fec1a 100644
> --- a/include/xen/arm/page-coherent.h
> +++ b/include/xen/arm/page-coherent.h
> @@ -16,18 +16,6 @@ void __xen_dma_sync_single_for_cpu(struct device *hwdev,
>  void __xen_dma_sync_single_for_device(struct device *hwdev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir);
>  
> -static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
> -{
> -	return dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
> -}
> -
> -static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
> -		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	dma_direct_free(hwdev, size, cpu_addr, dma_handle, attrs);
> -}
> -
>  static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>  {
> -- 
> 2.20.1
> 
