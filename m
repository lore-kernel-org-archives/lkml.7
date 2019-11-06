Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C3C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD742067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="PNo3xZ45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfKFSLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:11:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38694 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732434AbfKFSLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:11:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so4498336pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=j8eNwULKpZxPZC3Ue7l8WChG2Sw1ZeM6zGQJhcLB2q4=;
        b=PNo3xZ45pD8y2N6reebfbfZpOdqqiBr1Lz+k6yQFI0L0/2p4rg9rq6quFNZC0fUzEy
         WlsJw4SBofaliFzu25uc3GL+jfLPaDDaxBBSeFuxKZdU+M46CbuLmJCyYZ3YubRPMmb4
         KJuh7ZayA7bBdQZfTwcK1CQOU3wgdx+7HYStjSw481T2P1SlQpPljbqXrje6nW+uncab
         xnl2WqnQq3h3MzYeukOBvYmW22S70Ab9cogKRn6Y5e/sTOn8Whd6Q8gV3t9/yTSsvIJH
         qW1nfHNHClKIYFKkd63n+sMzCsL83vOlxoTHUSAO8sIcR8NpgIG3bG3BN+f8kRlw/+Kv
         8mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=j8eNwULKpZxPZC3Ue7l8WChG2Sw1ZeM6zGQJhcLB2q4=;
        b=Z3oufWuOHYhWWZ7ouzoJ7MEEh/QMtNQbiWJaNS/0ikDEGM0LmyoDoWsOQB2i5aR4kQ
         HQEPqZhv8NV+b934imUxb+cskb5alG5EyRDkQwthsGV6pHB+YyvyTwmGTtQBI00hIyCN
         X7mO3nxNVnmvtMbjjUgUQhXdYBWuVkR4eClAIAj5Q1NgiJ/67BFekRq6/3HU+HVorfgC
         IX0WFxaJPfR8boOi3mCZ99TCKV79ZdgxrusSY2rcxOgU9Me/xfKVK2bLUBHq1DFw2bLP
         Qg5m3j/QhAGoB6xUe+EPcaj5EFzs45FmLM1w2xmV1U+jLCQi9hqnlZSGxng4RcfrsafX
         NVEA==
X-Gm-Message-State: APjAAAXhQ2RnNE+lyHCj0QWtk3MwmxdnxLzrKtbzqkM/tdJ2Iuyc8t7/
        0LnLi+TW0mlD+zbzw56+L98cxQ==
X-Google-Smtp-Source: APXvYqyi7QvVvwFbCwtrCcolLw/HV05dOHLVSXF3jAYddzEgRk4byr6sPDxWkoeeO54icKRZXqVAsQ==
X-Received: by 2002:a62:170b:: with SMTP id 11mr4988303pfx.85.1573063899585;
        Wed, 06 Nov 2019 10:11:39 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i5sm12394738pfo.52.2019.11.06.10.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 10:11:37 -0800 (PST)
Date:   Wed, 06 Nov 2019 10:11:37 -0800 (PST)
X-Google-Original-Date: Wed, 06 Nov 2019 10:11:28 PST (-0800)
Subject:     Re: [PATCH 11/21] asm-generic: don't provide ioremap for CONFIG_MMU
In-Reply-To: <20191029064834.23438-12-hch@lst.de>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org, monstr@monstr.eu,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-33ea9141-2440-4a2d-8133-62094486fc48@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 23:48:24 PDT (-0700), Christoph Hellwig wrote:
> All MMU-enabled ports have a non-trivial ioremap and should thus provide
> the prototype for their implementation instead of providing a generic
> one unless a different symbol is not defined.  Note that this only
> affects sparc32 nds32 as all others do provide their own version.
>
> Also update the kerneldoc comments in asm-generic/io.h to explain the
> situation around the default ioremap* implementations correctly.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/nds32/include/asm/io.h    |  2 ++
>  arch/sparc/include/asm/io_32.h |  1 +
>  include/asm-generic/io.h       | 29 ++++++++---------------------
>  3 files changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
> index 16f262322b8f..fb0e8a24c7af 100644
> --- a/arch/nds32/include/asm/io.h
> +++ b/arch/nds32/include/asm/io.h
> @@ -6,6 +6,7 @@
>
>  #include <linux/types.h>
>
> +void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>  extern void iounmap(volatile void __iomem *addr);
>  #define __raw_writeb __raw_writeb
>  static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
> @@ -80,4 +81,5 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
>  #define writew(v,c)	({ __iowmb(); writew_relaxed((v),(c)); })
>  #define writel(v,c)	({ __iowmb(); writel_relaxed((v),(c)); })
>  #include <asm-generic/io.h>
> +
>  #endif /* __ASM_NDS32_IO_H */
> diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
> index df2dc1784673..9a52d9506f80 100644
> --- a/arch/sparc/include/asm/io_32.h
> +++ b/arch/sparc/include/asm/io_32.h
> @@ -127,6 +127,7 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst,
>   * Bus number may be embedded in the higher bits of the physical address.
>   * This is why we have no bus number argument to ioremap().
>   */
> +void __iomem *ioremap(phys_addr_t offset, size_t size);
>  void iounmap(volatile void __iomem *addr);
>  /* Create a virtual mapping cookie for an IO port range */
>  void __iomem *ioport_map(unsigned long port, unsigned int nr);
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index a98ed6325727..6a5edc23afe2 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -922,28 +922,16 @@ static inline void *phys_to_virt(unsigned long address)
>  /**
>   * DOC: ioremap() and ioremap_*() variants
>   *
> - * If you have an IOMMU your architecture is expected to have both ioremap()
> - * and iounmap() implemented otherwise the asm-generic helpers will provide a
> - * direct mapping.
> + * Architectures with an MMU are expected to provide ioremap() and iounmap()
> + * themselves.  For NOMMU architectures we provide a default nop-op
> + * implementation that expect that the physical address used for MMIO are
> + * already marked as uncached, and can be used as kernel virtual addresses.
>   *
> - * There are ioremap_*() call variants, if you have no IOMMU we naturally will
> - * default to direct mapping for all of them, you can override these defaults.
> - * If you have an IOMMU you are highly encouraged to provide your own
> - * ioremap variant implementation as there currently is no safe architecture
> - * agnostic default. To avoid possible improper behaviour default asm-generic
> - * ioremap_*() variants all return NULL when an IOMMU is available. If you've
> - * defined your own ioremap_*() variant you must then declare your own
> - * ioremap_*() variant as defined to itself to avoid the default NULL return.
> + * ioremap_wc() and ioremap_wt() can provide more relaxed caching attributes
> + * for specific drivers if the architecture choses to implement them.  If they
> + * are not implemented we fall back to plain ioremap.
>   */
>  #ifndef CONFIG_MMU
> -
> -/*
> - * Change "struct page" to physical address.
> - *
> - * This implementation is for the no-MMU case only... if you have an MMU
> - * you'll need to provide your own definitions.
> - */
> -
>  #ifndef ioremap
>  #define ioremap ioremap
>  static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
> @@ -954,14 +942,13 @@ static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
>
>  #ifndef iounmap
>  #define iounmap iounmap
> -
>  static inline void iounmap(void __iomem *addr)
>  {
>  }
>  #endif
>  #endif /* CONFIG_MMU */
> +
>  #ifndef ioremap_nocache
> -void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>  #define ioremap_nocache ioremap_nocache
>  static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>  {

It looks like the difference in prototype between the architectures is between

    void __iomem *ioremap(resource_size_t, size_t)
    void __iomem *ioremap(phys_addr_t, size_t)
    void __iomem *ioremap(phys_addr_t, unsigned long)
    void __iomem *ioremap(unsigned long, unsigned long)

shouldn't they all just be that first one?  In other words, wouldn't it be 
better to always provide the generic ioremap prototype and unify the ports 
instead?
