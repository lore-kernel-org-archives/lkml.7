Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3470FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F82216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="POMfKb/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfG2XVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:21:43 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10849 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfG2XVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:21:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3f7f8e0000>; Mon, 29 Jul 2019 16:21:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Jul 2019 16:21:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Jul 2019 16:21:42 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jul
 2019 23:21:40 +0000
Subject: Re: [PATCH 3/9] nouveau: factor out device memory address calculation
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-4-hch@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <95ddc61c-edb9-b751-4e15-0d3f0aaca2e1@nvidia.com>
Date:   Mon, 29 Jul 2019 16:21:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729142843.22320-4-hch@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564442510; bh=Ck0Fwz/3L8okeuwUnKILoh2bth9zQ838mb2LNvYCu5c=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=POMfKb/YMF0u6+QGiDqjGdH9lbOIf7G6w6JvD3Msf4yBRa7229kVJVax+KSS+cY2C
         d5sL+sjwl/l/cPBDDZ6mr9yOs4LmD+lnKlb2a4UWkgi29cfcPUkE3Hjh6QRDNITc++
         6Hgfj18O7Qm9bo8QE4+aUxtixOr8Re8PDf2XSG89G3LI3hGIm3e4cA3bOEOO23SOw2
         VB6snRW8LBYrVdYdYH+rkI9VIp3FMPJcIbB+0K61vvzQed4J36ReyESE1XXv0qBsOi
         0SY7ti+YSimYNOBZrgriBZ3Nrutk/Qy/u6XFJ8Ss725m+jHO8fOeb8PPE0vKXsCdIv
         y3TxYfGGepEjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/19 7:28 AM, Christoph Hellwig wrote:
> Factor out the repeated device memory address calculation into
> a helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 42 +++++++++++---------------
>   1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index e696157f771e..d469bc334438 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -102,6 +102,14 @@ struct nouveau_migrate {
>   	unsigned long dma_nr;
>   };
>   
> +static unsigned long nouveau_dmem_page_addr(struct page *page)
> +{
> +	struct nouveau_dmem_chunk *chunk = page->zone_device_data;
> +	unsigned long idx = page_to_pfn(page) - chunk->pfn_first;
> +
> +	return (idx << PAGE_SHIFT) + chunk->bo->bo.offset;
> +}
> +
>   static void nouveau_dmem_page_free(struct page *page)
>   {
>   	struct nouveau_dmem_chunk *chunk = page->zone_device_data;
> @@ -169,9 +177,7 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
>   	/* Copy things over */
>   	copy = drm->dmem->migrate.copy_func;
>   	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
> -		struct nouveau_dmem_chunk *chunk;
>   		struct page *spage, *dpage;
> -		u64 src_addr, dst_addr;
>   
>   		dpage = migrate_pfn_to_page(dst_pfns[i]);
>   		if (!dpage || dst_pfns[i] == MIGRATE_PFN_ERROR)
> @@ -194,14 +200,10 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
>   			continue;
>   		}
>   
> -		dst_addr = fault->dma[fault->npages++];
> -
> -		chunk = spage->zone_device_data;
> -		src_addr = page_to_pfn(spage) - chunk->pfn_first;
> -		src_addr = (src_addr << PAGE_SHIFT) + chunk->bo->bo.offset;
> -
> -		ret = copy(drm, 1, NOUVEAU_APER_HOST, dst_addr,
> -				   NOUVEAU_APER_VRAM, src_addr);
> +		ret = copy(drm, 1, NOUVEAU_APER_HOST,
> +				fault->dma[fault->npages++],
> +				NOUVEAU_APER_VRAM,
> +				nouveau_dmem_page_addr(spage));
>   		if (ret) {
>   			dst_pfns[i] = MIGRATE_PFN_ERROR;
>   			__free_page(dpage);
> @@ -687,18 +689,12 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
>   	/* Copy things over */
>   	copy = drm->dmem->migrate.copy_func;
>   	for (addr = start, i = 0; addr < end; addr += PAGE_SIZE, i++) {
> -		struct nouveau_dmem_chunk *chunk;
>   		struct page *spage, *dpage;
> -		u64 src_addr, dst_addr;
>   
>   		dpage = migrate_pfn_to_page(dst_pfns[i]);
>   		if (!dpage || dst_pfns[i] == MIGRATE_PFN_ERROR)
>   			continue;
>   
> -		chunk = dpage->zone_device_data;
> -		dst_addr = page_to_pfn(dpage) - chunk->pfn_first;
> -		dst_addr = (dst_addr << PAGE_SHIFT) + chunk->bo->bo.offset;
> -
>   		spage = migrate_pfn_to_page(src_pfns[i]);
>   		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE)) {
>   			nouveau_dmem_page_free_locked(drm, dpage);
> @@ -716,10 +712,10 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
>   			continue;
>   		}
>   
> -		src_addr = migrate->dma[migrate->dma_nr++];
> -
> -		ret = copy(drm, 1, NOUVEAU_APER_VRAM, dst_addr,
> -				   NOUVEAU_APER_HOST, src_addr);
> +		ret = copy(drm, 1, NOUVEAU_APER_VRAM,
> +				nouveau_dmem_page_addr(dpage),
> +				NOUVEAU_APER_HOST,
> +				migrate->dma[migrate->dma_nr++]);
>   		if (ret) {
>   			nouveau_dmem_page_free_locked(drm, dpage);
>   			dst_pfns[i] = 0;
> @@ -846,7 +842,6 @@ nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
>   
>   	npages = (range->end - range->start) >> PAGE_SHIFT;
>   	for (i = 0; i < npages; ++i) {
> -		struct nouveau_dmem_chunk *chunk;
>   		struct page *page;
>   		uint64_t addr;
>   
> @@ -864,10 +859,7 @@ nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
>   			continue;
>   		}
>   
> -		chunk = page->zone_device_data;
> -		addr = page_to_pfn(page) - chunk->pfn_first;
> -		addr = (addr + chunk->bo->bo.mem.start) << PAGE_SHIFT;
> -
> +		addr = nouveau_dmem_page_addr(page);
>   		range->pfns[i] &= ((1UL << range->pfn_shift) - 1);
>   		range->pfns[i] |= (addr >> PAGE_SHIFT) << range->pfn_shift;
>   	}
> 
