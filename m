Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA509C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1CE23405
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118915;
	bh=ZGRvcaq/a8pJd+ywMIWiJwEFzqT0vsYzNvrp/+e8HkA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=NZnu8KyAK4yWH8JJukcSF05uxq8pYXIdlzRSRWxonWoEKgq6xNcAXpg6YBRxzHF3H
	 XsoQwopcyW91b2Hv9m2aN9RuwTYFploZqeLKhP9IidpfMniFnW9/0hIBCx9b4OhdCh
	 FhpZ+/muOfM38OcFTljbH+4hCoejCrBRAjmw15Wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfH2Wse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfH2Wse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:48:34 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7AD72189D;
        Thu, 29 Aug 2019 22:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118913;
        bh=ZGRvcaq/a8pJd+ywMIWiJwEFzqT0vsYzNvrp/+e8HkA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=wnkNFIIv+4LJV93bbLL55j9Hxy9G2m3QtVn4rgC4iUTgVBDhTaNaO2ubx36Anoprj
         /xtSvbGDC2SgW8e7dEuJQF71Y045fGovXpA3c1vi7wuauPYe1W8Ib/cgSSGlSTK4Qd
         G4oXD/PaKu6vmQypn5BNG22/goyVDTLPSBwEAb58=
Date:   Thu, 29 Aug 2019 15:48:32 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 11/11] arm64: use asm-generic/dma-mapping.h
In-Reply-To: <20190826121944.515-12-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281527130.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-12-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> Now that the Xen special cases are gone nothing worth mentioning is
> left in the arm64 <asm/dma-mapping.h> file, so switch to use the
> asm-generic version instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Will Deacon <will@kernel.org>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm64/include/asm/Kbuild        |  1 +
>  arch/arm64/include/asm/dma-mapping.h | 22 ----------------------
>  arch/arm64/mm/dma-mapping.c          |  1 +
>  3 files changed, 2 insertions(+), 22 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/dma-mapping.h
> 
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index c52e151afab0..98a5405c8558 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -4,6 +4,7 @@ generic-y += delay.h
>  generic-y += div64.h
>  generic-y += dma.h
>  generic-y += dma-contiguous.h
> +generic-y += dma-mapping.h
>  generic-y += early_ioremap.h
>  generic-y += emergency-restart.h
>  generic-y += hw_irq.h
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> deleted file mode 100644
> index 67243255a858..000000000000
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2012 ARM Ltd.
> - */
> -#ifndef __ASM_DMA_MAPPING_H
> -#define __ASM_DMA_MAPPING_H
> -
> -#ifdef __KERNEL__
> -
> -#include <linux/types.h>
> -#include <linux/vmalloc.h>
> -
> -#include <xen/xen.h>
> -#include <asm/xen/hypervisor.h>
> -
> -static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
> -{
> -	return NULL;
> -}
> -
> -#endif	/* __KERNEL__ */
> -#endif	/* __ASM_DMA_MAPPING_H */
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 4b244a037349..6578abcfbbc7 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -8,6 +8,7 @@
>  #include <linux/cache.h>
>  #include <linux/dma-noncoherent.h>
>  #include <linux/dma-iommu.h>
> +#include <xen/xen.h>
>  #include <xen/swiotlb-xen.h>
>  
>  #include <asm/cacheflush.h>
> -- 
> 2.20.1
> 
