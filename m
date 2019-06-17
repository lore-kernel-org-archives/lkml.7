Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F581C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED11E208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560788001;
	bh=WA5c9iulOrWKZC8nW/LSFI3RRwdwSMrmm9TPJb30RtA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=iVRkYXGgLJcWfEZ1B6xXwI53wPU4xugpvl6Q8YmLT9mvBHhExJFmvBNHsvNEXvVKi
	 ED6jfBhJuQZuMaT6pkdOWx99xx0Ljr6W8gRrvytvJ0bhj8s69ZBbftf+PJQb0+S4w+
	 suygl8Ct7BwTxXXppdJNEPfpfWnZ1onpuTVgAYu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfFQQNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfFQQNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:13:19 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C43208C0;
        Mon, 17 Jun 2019 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560787998;
        bh=WA5c9iulOrWKZC8nW/LSFI3RRwdwSMrmm9TPJb30RtA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=esXlFkxzVe8OeQHrYcltCZb0SHCfcXUzCjMFDK71KIBrBw3fcKKyw2awU7xkaBWXi
         P5Cb/zukHo9q+8f0j6PjgLmzy+ue2MPDNoYGSY07b+AfBWMs3q8jtU1/STDRzL1f9Q
         s1Ucv1S7DZW1BS21uQS90ptCfj9qWOGZzb5QSKLE=
Date:   Mon, 17 Jun 2019 09:13:16 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: fix phys_addr_t overflow warning
In-Reply-To: <20190617132946.2817440-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1906170913080.2072@sstabellini-ThinkPad-T480s>
References: <20190617132946.2817440-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Arnd Bergmann wrote:
> On architectures that have a larger dma_addr_t than phys_addr_t,
> the swiotlb_tbl_map_single() function truncates its return code
> in the failure path, making it impossible to identify the error
> later, as we compare to the original value:
> 
> kernel/dma/swiotlb.c:551:9: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to 'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
>         return DMA_MAPPING_ERROR;
> 
> Use an explicit typecast here to convert it to the narrower type,
> and use the same expression in the error handling later.
> 
> Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> I still think that reverting the original commit would have
> provided clearer semantics for this corner case, but at least
> this patch restores the correct behavior.
> ---
>  drivers/xen/swiotlb-xen.c | 2 +-
>  kernel/dma/swiotlb.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index d53f3493a6b9..cfbe46785a3b 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -402,7 +402,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  
>  	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
>  				     attrs);
> -	if (map == DMA_MAPPING_ERROR)
> +	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return DMA_MAPPING_ERROR;
>  
>  	dev_addr = xen_phys_to_bus(map);
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index e906ef2e6315..a3be651973ad 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -548,7 +548,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
>  			 size, io_tlb_nslabs, tmp_io_tlb_used);
> -	return DMA_MAPPING_ERROR;
> +	return (phys_addr_t)DMA_MAPPING_ERROR;
>  found:
>  	io_tlb_used += nslots;
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> @@ -666,7 +666,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
>  	/* Oh well, have to allocate and map a bounce buffer. */
>  	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
>  			*phys, size, dir, attrs);
> -	if (*phys == DMA_MAPPING_ERROR)
> +	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
>  		return false;
>  
>  	/* Ensure that the address returned is DMA'ble */
> -- 
> 2.20.0
> 
