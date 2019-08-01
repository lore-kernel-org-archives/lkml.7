Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E234C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE47216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564676594;
	bh=7da4WGXGd4/Wm+MdwfjAwCtbHk3H9DFKOpK9DR+Fht0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f3TGXwVQiEAeKB7TFUjoRTF2Ti8c+pLWUAIHKcwrg8RVuj5sNAnWwNxyRW1F1VKv5
	 QiLTP60yq8+tHQH1pMYv6Hzm76UfjzWn6S/vfPlpbjUAs7IfIAHoYOl5AY/nW+Fq+1
	 Mmep8TxZ/CKr+BkzJTzL/zWzCYXyOvcsc5fwZ+EU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbfHAQXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHAQXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:23:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E2020657;
        Thu,  1 Aug 2019 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564676591;
        bh=7da4WGXGd4/Wm+MdwfjAwCtbHk3H9DFKOpK9DR+Fht0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlsTVycC6RXe/dgCwWd0yYSJfb8YeCiUu4zifaD8JdKhyXRQTW1pzp0LcMzGgmEBg
         QZCwX8Em2Vs+vL9ck1KaRJh77jzgQPBim5716wcV2Y8/BFTUSSWnLL9IcDN97Reomr
         hrleDNREQR24xnudRIyOq6iVo4vpwfSZhGR5aMfc=
Date:   Thu, 1 Aug 2019 17:23:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix page attributes for dma_mmap_*
Message-ID: <20190801162305.3m32chycsdjmdejk@willie-the-truck>
References: <20190801142118.21225-1-hch@lst.de>
 <20190801142118.21225-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801142118.21225-2-hch@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 05:21:18PM +0300, Christoph Hellwig wrote:
> All the way back to introducing dma_common_mmap we've defaulyed to mark
> the pages as uncached.  But this is wrong for DMA coherent devices or
> if using DMA_ATTR_NON_CONSISTENT.  Later on DMA_ATTR_WRITE_COMBINE
> also got incorrect treatment as that flag is only treated special on
> the alloc side for non-coherent devices.
> 
> Introduce a new dma_mmap_pgprot helper that deals with the check
> for coherent devices and DMA_ATTR_NON_CONSISTENT so that only the
> remapping cases even reach arch_dma_mmap_pgprot and we thus ensure
> no aliasing of page attributes happens.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/mm/dma-mapping.c        |  4 +---
>  arch/arm64/mm/dma-mapping.c      |  4 +---
>  arch/powerpc/kernel/Makefile     |  3 +--
>  arch/powerpc/kernel/dma-common.c | 17 -----------------
>  drivers/iommu/dma-iommu.c        |  6 +++---
>  include/linux/dma-mapping.h      |  1 +
>  include/linux/dma-noncoherent.h  |  5 -----
>  kernel/dma/mapping.c             | 11 ++++++++++-
>  kernel/dma/remap.c               |  2 +-
>  9 files changed, 18 insertions(+), 35 deletions(-)
>  delete mode 100644 arch/powerpc/kernel/dma-common.c
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 9c9a23e5600d..cfe44df169c5 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2397,9 +2397,7 @@ long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
>  pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
>  		unsigned long attrs)
>  {
> -	if (!dev_is_dma_coherent(dev))
> -		return __get_dma_pgprot(attrs, prot);
> -	return prot;
> +	return __get_dma_pgprot(attrs, prot);
>  }
>  
>  void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 1d3f0b5a9940..bd2b039f43a6 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -14,9 +14,7 @@
>  pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
>  		unsigned long attrs)
>  {
> -	if (!dev_is_dma_coherent(dev) || (attrs & DMA_ATTR_WRITE_COMBINE))
> -		return pgprot_writecombine(prot);
> -	return prot;
> +	return pgprot_writecombine(prot);
>  }

Seems like a sensible cleanup to me:

Acked-by: Will Deacon <will@kernel.org>

Although arch_dma_mmap_pgprot() is a bit of a misnomer now that it only
gets involved in the non-coherent case.

Will
