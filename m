Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7881C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B666721955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfGVSp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:45:26 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36211 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfGVSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:45:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so26937754vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0oC255nlMTJCbfZqi2fsaWmaMOyLtXK3narxYZHsJ+g=;
        b=b6FASxVeA9Kh4XenvxeD561sYuDNRW8lxMcV15TzZBtSuozaO9vnzUdysy5eU4f5/d
         yAp1HL7i3iQ/BDcOgDuSVHalE9j+TPOCIu/9EU/2KfisOhINKO3FQmmLl35HC71tvBM+
         csyZBad86KZ60ugn6pTazPfyavGy9HATVdTwQbazUG+TtrUk3B5Df+bHXHdE3GZUTHN/
         DF7d8ssIQix9IHtvvLE8tl/59KSgQe8+PXI7YfqJtPA747ZR9rBRGVuyJlNYf5n2pnY7
         mqVjXc8zqMsZIF+uzbW2yX8oP5jbRg58o2+d+gF+URON8FeND9TrLEoNmfiCzvavHYK0
         zNpg==
X-Gm-Message-State: APjAAAVlNEBW14yqjdkRNc2RR/xXY4Vn8FbAPgAEuro04YlnSkufEv1h
        UMsPHKMdIuVTnon6vhWJ4DzcKg==
X-Google-Smtp-Source: APXvYqy1dMOsoJwK19xN4gvienu0+UYNi8SU4/cq7VQCMGv+XWMnqskbibzUi+xg/xwOJYk7B7n4Xw==
X-Received: by 2002:a67:7a11:: with SMTP id v17mr45678796vsc.114.1563821125566;
        Mon, 22 Jul 2019 11:45:25 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id u8sm15327600vke.34.2019.07.22.11.45.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:45:24 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:45:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-mapping: Use dma_get_mask in
 dma_addressing_limited
Message-ID: <20190722143724-mutt-send-email-mst@kernel.org>
References: <20190722165149.3763-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722165149.3763-1-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 06:51:49PM +0200, Eric Auger wrote:
> We currently have cases where the dma_addressing_limited() gets
> called with dma_mask unset. This causes a NULL pointer dereference.
> 
> Use dma_get_mask() accessor to prevent the crash.
> 
> Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

If possible I really prefer this approach: avoids changing all callers
and uses documented interfaces.

> ---
> 
> v1 -> v2:
> - was [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
>   against NULL dma_mask
> - Use dma_get_mask
> ---
>  include/linux/dma-mapping.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index e11b115dd0e4..f7d1eea32c78 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -689,8 +689,8 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
>   */
>  static inline bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> -		dma_get_required_mask(dev);
> +	return min_not_zero(dma_get_mask(dev), dev->bus_dma_mask) <
> +			    dma_get_required_mask(dev);
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> -- 
> 2.20.1
