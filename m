Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A745C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682B82080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfFSKvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:51:10 -0400
Received: from verein.lst.de ([213.95.11.211]:52653 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfFSKvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:51:09 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BE4D768AA6; Wed, 19 Jun 2019 12:50:39 +0200 (CEST)
Date:   Wed, 19 Jun 2019 12:50:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     Larry.Finger@lwfinger.net, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, aaro.koskinen@iki.fi
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
Message-ID: <20190619105039.GA10118@lst.de>
References: <20190613082446.18685-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613082446.18685-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any chance this could get picked up to fix the regression?

On Thu, Jun 13, 2019 at 10:24:46AM +0200, Christoph Hellwig wrote:
> With the strict dma mask checking introduced with the switch to
> the generic DMA direct code common wifi chips on 32-bit powerbooks
> stopped working.  Add a 30-bit ZONE_DMA to the 32-bit pmac builds
> to allow them to reliably allocate dma coherent memory.
> 
> Fixes: 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/include/asm/page.h         | 7 +++++++
>  arch/powerpc/mm/mem.c                   | 3 ++-
>  arch/powerpc/platforms/powermac/Kconfig | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index b8286a2013b4..0d52f57fca04 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -319,6 +319,13 @@ struct vm_area_struct;
>  #endif /* __ASSEMBLY__ */
>  #include <asm/slice.h>
>  
> +/*
> + * Allow 30-bit DMA for very limited Broadcom wifi chips on many powerbooks.
> + */
> +#ifdef CONFIG_PPC32
> +#define ARCH_ZONE_DMA_BITS 30
> +#else
>  #define ARCH_ZONE_DMA_BITS 31
> +#endif
>  
>  #endif /* _ASM_POWERPC_PAGE_H */
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index cba29131bccc..2540d3b2588c 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -248,7 +248,8 @@ void __init paging_init(void)
>  	       (long int)((top_of_ram - total_ram) >> 20));
>  
>  #ifdef CONFIG_ZONE_DMA
> -	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
> +	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> +			((1UL << ARCH_ZONE_DMA_BITS) - 1) >> PAGE_SHIFT);
>  #endif
>  	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>  #ifdef CONFIG_HIGHMEM
> diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
> index f834a19ed772..c02d8c503b29 100644
> --- a/arch/powerpc/platforms/powermac/Kconfig
> +++ b/arch/powerpc/platforms/powermac/Kconfig
> @@ -7,6 +7,7 @@ config PPC_PMAC
>  	select PPC_INDIRECT_PCI if PPC32
>  	select PPC_MPC106 if PPC32
>  	select PPC_NATIVE
> +	select ZONE_DMA if PPC32
>  	default y
>  
>  config PPC_PMAC64
> -- 
> 2.20.1
---end quoted text---
