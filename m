Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D600BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A604A23404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118533;
	bh=xHkEUC70NyhQrdUtUwDNpqvFabXbH4FNTzDPXPE1tqY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=dm6DbNVEto2zYuNUH6yy9OGbMsa8ztGyrlIClQEX0t99A0aSksUTbQTmLp3VaC7Em
	 Qk29yu7Ayw0VMnI6RmNkacH+kLZL1sJ07Ht3H5x+Zefdi/iigOb9En4/m7NxueiX4p
	 8pK8gHQkaAbl/YavXTXU2Tt9wbIBJ3llZwyzSekk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfH2WmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfH2WmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:42:12 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39D32189D;
        Thu, 29 Aug 2019 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118531;
        bh=xHkEUC70NyhQrdUtUwDNpqvFabXbH4FNTzDPXPE1tqY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LG+7fN41BbkQDRJj56NLA6759Otnvnf3nvVutDii10+eEzLBlDeRKXwPCpCclCsiA
         Cl7GH+XwZzjeaHNfXrbRV8R+5ceePqFPWCu9iGGxmTfFsCxbnOr/pXW9XZEEsWSbYn
         rrnwK2ejARhZqSJAQfOT6+NQJikZVzm+uVGT9078=
Date:   Thu, 29 Aug 2019 15:42:10 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH 04/11] xen/arm: remove xen_dma_ops
In-Reply-To: <20190826121944.515-5-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281458070.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-5-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> arm and arm64 can just use xen_swiotlb_dma_ops directly like x86, no
> need for a pointer indirection.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Julien Grall <julien.grall@arm.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm/mm/dma-mapping.c    | 3 ++-
>  arch/arm/xen/mm.c            | 4 ----
>  arch/arm64/mm/dma-mapping.c  | 3 ++-
>  include/xen/arm/hypervisor.h | 2 --
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 738097396445..2661cad36359 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -35,6 +35,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/system_info.h>
>  #include <asm/dma-contiguous.h>
> +#include <xen/swiotlb-xen.h>
>  
>  #include "dma.h"
>  #include "mm.h"
> @@ -2360,7 +2361,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  
>  #ifdef CONFIG_XEN
>  	if (xen_initial_domain())
> -		dev->dma_ops = xen_dma_ops;
> +		dev->dma_ops = &xen_swiotlb_dma_ops;
>  #endif
>  	dev->archdata.dma_ops_setup = true;
>  }
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 14210ebdea1a..9b3a6c0ca681 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -163,16 +163,12 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
>  }
>  EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
>  
> -const struct dma_map_ops *xen_dma_ops;
> -EXPORT_SYMBOL(xen_dma_ops);
> -
>  int __init xen_mm_init(void)
>  {
>  	struct gnttab_cache_flush cflush;
>  	if (!xen_initial_domain())
>  		return 0;
>  	xen_swiotlb_init(1, false);
> -	xen_dma_ops = &xen_swiotlb_dma_ops;
>  
>  	cflush.op = 0;
>  	cflush.a.dev_bus_addr = 0;
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index bd2b039f43a6..4b244a037349 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -8,6 +8,7 @@
>  #include <linux/cache.h>
>  #include <linux/dma-noncoherent.h>
>  #include <linux/dma-iommu.h>
> +#include <xen/swiotlb-xen.h>
>  
>  #include <asm/cacheflush.h>
>  
> @@ -64,6 +65,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  
>  #ifdef CONFIG_XEN
>  	if (xen_initial_domain())
> -		dev->dma_ops = xen_dma_ops;
> +		dev->dma_ops = &xen_swiotlb_dma_ops;
>  #endif
>  }
> diff --git a/include/xen/arm/hypervisor.h b/include/xen/arm/hypervisor.h
> index 2982571f7cc1..43ef24dd030e 100644
> --- a/include/xen/arm/hypervisor.h
> +++ b/include/xen/arm/hypervisor.h
> @@ -19,8 +19,6 @@ static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
>  	return PARAVIRT_LAZY_NONE;
>  }
>  
> -extern const struct dma_map_ops *xen_dma_ops;
> -
>  #ifdef CONFIG_XEN
>  void __init xen_early_init(void);
>  #else
> -- 
> 2.20.1
> 
