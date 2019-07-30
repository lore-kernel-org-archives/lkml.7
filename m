Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB36DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E264206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iPy1JeRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfG3Nuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:50:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33514 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfG3Nux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:50:53 -0400
Received: from pendragon.ideasonboard.com (p443174-ipngn12901marunouchi.tokyo.ocn.ne.jp [153.201.242.174])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32557CC;
        Tue, 30 Jul 2019 15:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564494652;
        bh=yXsA4lQrDxWLRkikj1nrZdK3Kmxtui4EhkpZyACr6yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPy1JeRrk8mVG5FvMJNU6zdJm/7JpfLibA4+/WJQnWBwNA4NLRUwj7yuiVPgb7cet
         Xj6LkV4c5kqSO259vtm+pmccbU1m+oL+Uk3cGYzsBcr6FrA0RSkplFdZGF50B8CbDR
         xrf9Wc8F+UGSbbQLOPgIAEhwmYIkibFKJujlWykg=
Date:   Tue, 30 Jul 2019 16:50:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove dma_{alloc,free,mmap}_writecombine
Message-ID: <20190730135045.GA4806@pendragon.ideasonboard.com>
References: <20190730061849.29686-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730061849.29686-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thank you for the patch.

On Tue, Jul 30, 2019 at 09:18:49AM +0300, Christoph Hellwig wrote:
> We can already use DMA_ATTR_WRITE_COMBINE or the _wc prefixed version,
> so remove the third way of doing things.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 11 +++++------
>  include/linux/dma-mapping.h         |  9 ---------
>  2 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index 785c5546067a..c70f3246a552 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -4609,11 +4609,10 @@ static int dispc_errata_i734_wa_init(struct dispc_device *dispc)
>  	i734_buf.size = i734.ovli.width * i734.ovli.height *
>  		color_mode_to_bpp(i734.ovli.fourcc) / 8;
>  
> -	i734_buf.vaddr = dma_alloc_writecombine(&dispc->pdev->dev,
> -						i734_buf.size, &i734_buf.paddr,
> -						GFP_KERNEL);
> +	i734_buf.vaddr = dma_alloc_wc(&dispc->pdev->dev, i734_buf.size,
> +			&i734_buf.paddr, GFP_KERNEL);

I would have indented this line to match the rest. Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	if (!i734_buf.vaddr) {
> -		dev_err(&dispc->pdev->dev, "%s: dma_alloc_writecombine failed\n",
> +		dev_err(&dispc->pdev->dev, "%s: dma_alloc_wc failed\n",
>  			__func__);
>  		return -ENOMEM;
>  	}
> @@ -4626,8 +4625,8 @@ static void dispc_errata_i734_wa_fini(struct dispc_device *dispc)
>  	if (!dispc->feat->has_gamma_i734_bug)
>  		return;
>  
> -	dma_free_writecombine(&dispc->pdev->dev, i734_buf.size, i734_buf.vaddr,
> -			      i734_buf.paddr);
> +	dma_free_wc(&dispc->pdev->dev, i734_buf.size, i734_buf.vaddr,
> +		    i734_buf.paddr);
>  }
>  
>  static void dispc_errata_i734_wa(struct dispc_device *dispc)
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f7d1eea32c78..633dae466097 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -786,9 +786,6 @@ static inline void *dma_alloc_wc(struct device *dev, size_t size,
>  
>  	return dma_alloc_attrs(dev, size, dma_addr, gfp, attrs);
>  }
> -#ifndef dma_alloc_writecombine
> -#define dma_alloc_writecombine dma_alloc_wc
> -#endif
>  
>  static inline void dma_free_wc(struct device *dev, size_t size,
>  			       void *cpu_addr, dma_addr_t dma_addr)
> @@ -796,9 +793,6 @@ static inline void dma_free_wc(struct device *dev, size_t size,
>  	return dma_free_attrs(dev, size, cpu_addr, dma_addr,
>  			      DMA_ATTR_WRITE_COMBINE);
>  }
> -#ifndef dma_free_writecombine
> -#define dma_free_writecombine dma_free_wc
> -#endif
>  
>  static inline int dma_mmap_wc(struct device *dev,
>  			      struct vm_area_struct *vma,
> @@ -808,9 +802,6 @@ static inline int dma_mmap_wc(struct device *dev,
>  	return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size,
>  			      DMA_ATTR_WRITE_COMBINE);
>  }
> -#ifndef dma_mmap_writecombine
> -#define dma_mmap_writecombine dma_mmap_wc
> -#endif
>  
>  #ifdef CONFIG_NEED_DMA_MAP_STATE
>  #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)        dma_addr_t ADDR_NAME

-- 
Regards,

Laurent Pinchart
