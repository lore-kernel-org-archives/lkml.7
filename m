Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06CDC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D0620B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DT8VEuxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbfHHVKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:10:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4716 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbfHHVKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:10:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4c8fbb0000>; Thu, 08 Aug 2019 14:10:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 14:10:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Aug 2019 14:10:17 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 21:10:16 +0000
Subject: Re: [PATCH 6/9] nouveau: simplify nouveau_dmem_migrate_to_ram
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190808153346.9061-1-hch@lst.de>
 <20190808153346.9061-7-hch@lst.de>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <08112ecb-0984-9e32-a463-e731bc014747@nvidia.com>
Date:   Thu, 8 Aug 2019 14:10:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808153346.9061-7-hch@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565298619; bh=oVBAQyD5xUlq4GMTL3CDo5/mxCgb1o2QAFYUcZwvsVY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DT8VEuxuGaFlUgwlrCBl+bxMJ34NfECopfGnQdXhLsvMTrSZTI/OVr3RSJRhwwWRJ
         w/QzZVbGKkx8yjcEIJYg1Ad+ljBOQOv8jG+ZFgmI7KmKcpt1OvYSee6jAWx8cXp2/d
         TXjfEyQaK/wxLWrI62Bn53t1WWNWi7l+8u4Cxw688GJ+8ij5Q7s2d91Tc/RtWWBAIR
         nf7+CHObeaDJ6MyhPbtTqKeOd1GJZxtTEF1dqVIfDf5jxnvRx4q1e8vpUlKCPuWnam
         w5yYUY5HGGmOskuTBVhHSaJNNsAcSwCjfiInxFUovLczrbBIO2I6r4d0fULpuRG1Mh
         JmS0XghUahm8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/8/19 8:33 AM, Christoph Hellwig wrote:
> Factor the main copy page to ram routine out into a helper that acts on
> a single page and which doesn't require the nouveau_dmem_fault
> structure for argument passing.  Also remove the loop over multiple
> pages as we only handle one at the moment, although the structure of
> the main worker function makes it relatively easy to add multi page
> support back if needed in the future.  But at least for now this avoid
> the needed to dynamically allocate memory for the dma addresses in
> what is essentially the page fault path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 159 +++++++------------------
>   1 file changed, 40 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 21052a4aaf69..473195762974 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -86,13 +86,6 @@ static inline struct nouveau_dmem *page_to_dmem(struct page *page)
>   	return container_of(page->pgmap, struct nouveau_dmem, pagemap);
>   }
>   
> -struct nouveau_dmem_fault {
> -	struct nouveau_drm *drm;
> -	struct nouveau_fence *fence;
> -	dma_addr_t *dma;
> -	unsigned long npages;
> -};
> -
>   struct nouveau_migrate {
>   	struct vm_area_struct *vma;
>   	struct nouveau_drm *drm;
> @@ -146,130 +139,57 @@ static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
>   	}
>   }
>   
> -static void
> -nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
> -				  const unsigned long *src_pfns,
> -				  unsigned long *dst_pfns,
> -				  unsigned long start,
> -				  unsigned long end,
> -				  struct nouveau_dmem_fault *fault)
> +static vm_fault_t nouveau_dmem_fault_copy_one(struct nouveau_drm *drm,
> +		struct vm_fault *vmf, struct migrate_vma *args,
> +		dma_addr_t *dma_addr)
>   {
> -	struct nouveau_drm *drm = fault->drm;
>   	struct device *dev = drm->dev->dev;
> -	unsigned long addr, i, npages = 0;
> -	nouveau_migrate_copy_t copy;
> -	int ret;
> -
> +	struct page *dpage, *spage;
> +	vm_fault_t ret = VM_FAULT_SIGBUS;

You can remove this line and return VM_FAULT_SIGBUS in the error path below.

>   
> -	/* First allocate new memory */
> -	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
> -		struct page *dpage, *spage;
> -
> -		dst_pfns[i] = 0;
> -		spage = migrate_pfn_to_page(src_pfns[i]);
> -		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
> -			continue;
> -
> -		dpage = alloc_page_vma(GFP_HIGHUSER, vma, addr);
> -		if (!dpage) {
> -			dst_pfns[i] = MIGRATE_PFN_ERROR;
> -			continue;
> -		}
> -		lock_page(dpage);
> -
> -		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage)) |
> -			      MIGRATE_PFN_LOCKED;
> -		npages++;
> -	}
> +	spage = migrate_pfn_to_page(args->src[0]);
> +	if (!spage || !(args->src[0] & MIGRATE_PFN_MIGRATE))
> +		return 0;
>   
> -	/* Allocate storage for DMA addresses, so we can unmap later. */
> -	fault->dma = kmalloc(sizeof(*fault->dma) * npages, GFP_KERNEL);
> -	if (!fault->dma)
> +	dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
> +	if (!dpage)
>   		goto error;
> +	lock_page(dpage);
>   
> -	/* Copy things over */
> -	copy = drm->dmem->migrate.copy_func;
> -	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
> -		struct page *spage, *dpage;
> -
> -		dpage = migrate_pfn_to_page(dst_pfns[i]);
> -		if (!dpage || dst_pfns[i] == MIGRATE_PFN_ERROR)
> -			continue;
> -
> -		spage = migrate_pfn_to_page(src_pfns[i]);
> -		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
> -			dst_pfns[i] = MIGRATE_PFN_ERROR;
> -			__free_page(dpage);
> -			continue;
> -		}
> -
> -		fault->dma[fault->npages] =
> -			dma_map_page_attrs(dev, dpage, 0, PAGE_SIZE,
> -					   PCI_DMA_BIDIRECTIONAL,
> -					   DMA_ATTR_SKIP_CPU_SYNC);
> -		if (dma_mapping_error(dev, fault->dma[fault->npages])) {
> -			dst_pfns[i] = MIGRATE_PFN_ERROR;
> -			__free_page(dpage);
> -			continue;
> -		}
> +	*dma_addr = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +	if (dma_mapping_error(dev, *dma_addr))
> +		goto error_free_page;
>   
> -		ret = copy(drm, 1, NOUVEAU_APER_HOST,
> -				fault->dma[fault->npages++],
> -				NOUVEAU_APER_VRAM,
> -				nouveau_dmem_page_addr(spage));
> -		if (ret) {
> -			dst_pfns[i] = MIGRATE_PFN_ERROR;
> -			__free_page(dpage);
> -			continue;
> -		}
> -	}
> +	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_HOST, *dma_addr,
> +			NOUVEAU_APER_VRAM, nouveau_dmem_page_addr(spage)))
> +		goto error_dma_unmap;
>   
> -	nouveau_fence_new(drm->dmem->migrate.chan, false, &fault->fence);
> -
> -	return;
> +	args->dst[0] = migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
> +	ret = 0;

This needs to be "return 0;" here so that dpage is not unmapped
while the DMA I/O is in progress. It gets unmapped after the
call to nouveau_dmem_fence_done() in nouveau_dmem_migrate_to_ram().

>   
> +error_dma_unmap:
> +	dma_unmap_page(dev, *dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +error_free_page:
> +	__free_page(dpage);
>   error:
> -	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, ++i) {
> -		struct page *page;
> -
> -		if (!dst_pfns[i] || dst_pfns[i] == MIGRATE_PFN_ERROR)
> -			continue;
> -
> -		page = migrate_pfn_to_page(dst_pfns[i]);
> -		dst_pfns[i] = MIGRATE_PFN_ERROR;
> -		if (page == NULL)
> -			continue;
> -
> -		__free_page(page);
> -	}
> -}
> -
> -static void
> -nouveau_dmem_fault_finalize_and_map(struct nouveau_dmem_fault *fault)
> -{
> -	struct nouveau_drm *drm = fault->drm;
> -
> -	nouveau_dmem_fence_done(&fault->fence);
> -
> -	while (fault->npages--) {
> -		dma_unmap_page(drm->dev->dev, fault->dma[fault->npages],
> -			       PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
> -	}
> -	kfree(fault->dma);
> +	return ret;

	return VM_FAULT_SIGBUS;

>   }
>   
>   static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
>   {
>   	struct nouveau_dmem *dmem = page_to_dmem(vmf->page);
> -	unsigned long src[1] = {0}, dst[1] = {0};
> +	struct nouveau_drm *drm = dmem->drm;
> +	struct nouveau_fence *fence;
> +	unsigned long src = 0, dst = 0;
> +	dma_addr_t dma_addr = 0;
> +	vm_fault_t ret;
>   	struct migrate_vma args = {
>   		.vma		= vmf->vma,
>   		.start		= vmf->address,
>   		.end		= vmf->address + PAGE_SIZE,
> -		.src		= src,
> -		.dst		= dst,
> +		.src		= &src,
> +		.dst		= &dst,
>   	};
> -	struct nouveau_dmem_fault fault = { .drm = dmem->drm };
>   
>   	/*
>   	 * FIXME what we really want is to find some heuristic to migrate more
> @@ -281,16 +201,17 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
>   	if (!args.cpages)
>   		return 0;
>   
> -	nouveau_dmem_fault_alloc_and_copy(args.vma, src, dst, args.start,
> -			args.end, &fault);
> -	migrate_vma_pages(&args);
> -	nouveau_dmem_fault_finalize_and_map(&fault);
> +	ret = nouveau_dmem_fault_copy_one(drm, vmf, &args, &dma_addr);
> +	if (ret || dst == 0)
> +		goto done;
>   
> +	nouveau_fence_new(dmem->migrate.chan, false, &fence);
> +	migrate_vma_pages(&args);
> +	nouveau_dmem_fence_done(&fence);
> +	dma_unmap_page(drm->dev->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +done:
>   	migrate_vma_finalize(&args);
> -	if (dst[0] == MIGRATE_PFN_ERROR)
> -		return VM_FAULT_SIGBUS;
> -
> -	return 0;
> +	return ret;
>   }
>   
>   static const struct dev_pagemap_ops nouveau_dmem_pagemap_ops = {
> 
