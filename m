Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A384CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E95322CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118894;
	bh=qahLSZidWBqyiJ9KPLWGgOnki/Ohn0lpoN98VUjbdJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=d13RirOBpsXJqyoDfJDVPRbnuGbHHZsx4mRygg8txhU0yCV/aML4aUopzA6UnuZwh
	 9kQXvm6LzZ3e4NIxufPyKNl5ETr+QZeJhEnr345vncRLRfrCqXkCx23IsS8MjyWWU0
	 v0Ktne8RYE9CjSNVYbyakHNgDcVU98GXI0yPcG8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfH2WsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbfH2WsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:48:13 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A476C21874;
        Thu, 29 Aug 2019 22:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118892;
        bh=qahLSZidWBqyiJ9KPLWGgOnki/Ohn0lpoN98VUjbdJo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lox9/f+oJeZihIIKB+HOTjYdPrpnsEmbhUNTlvyPbLyIuqorYqCD/5ugnctXNXr5S
         h9zmT10Nj3xoPfMfmjrctVtlI6lWBTjpTEDIPjzV13CX8jSzyEDs3QtOFIQ8vJWNJn
         iP9g2neD8o6CjtcvfTYgSj6BBKHMbvfVJOT8Yk/g=
Date:   Thu, 29 Aug 2019 15:48:11 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] swiotlb-xen: merge xen_unmap_single into
 xen_swiotlb_unmap_page
In-Reply-To: <20190826121944.515-11-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281526470.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-11-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> No need for a no-op wrapper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  drivers/xen/swiotlb-xen.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 95911ff9c11c..384304a77020 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -414,9 +414,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>   * After this call, reads by the cpu to the buffer are guaranteed to see
>   * whatever the device wrote there.
>   */
> -static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
> -			     size_t size, enum dma_data_direction dir,
> -			     unsigned long attrs)
> +static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	phys_addr_t paddr = xen_bus_to_phys(dev_addr);
>  
> @@ -430,13 +429,6 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
>  		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
>  }
>  
> -static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> -			    size_t size, enum dma_data_direction dir,
> -			    unsigned long attrs)
> -{
> -	xen_unmap_single(hwdev, dev_addr, size, dir, attrs);
> -}
> -
>  static void
>  xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
>  		size_t size, enum dma_data_direction dir)
> @@ -477,7 +469,8 @@ xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
>  	BUG_ON(dir == DMA_NONE);
>  
>  	for_each_sg(sgl, sg, nelems, i)
> -		xen_unmap_single(hwdev, sg->dma_address, sg_dma_len(sg), dir, attrs);
> +		xen_swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg),
> +				dir, attrs);
>  
>  }
>  
> -- 
> 2.20.1
> 
