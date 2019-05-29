Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA33C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1746624129
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+S4dzKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfE2UKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:10:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45436 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfE2UKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:10:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so2321142pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l4laiGZ+6EAxTzYgyOLxq6AQ0ebW5F8MPaRp0yaenB4=;
        b=T+S4dzKkP0QeUP0gvmQYme6HE9FvwMG4qznuFtH/nyALnyYufIZl5Zude490BxgiIt
         TM/MxYm5xSz69G1obZoGJM1LDIeY9X8HJLMu8K1/UHH+gmEEyXz0iVgKFgUxlRbExavm
         GdYNYHEiXPSCZWG+4ftE4ubEET85V+Ow68jzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l4laiGZ+6EAxTzYgyOLxq6AQ0ebW5F8MPaRp0yaenB4=;
        b=Dv3IEKC/VLbHTd2olrX6eYG8LAKLUnOu6pQ0578IhFA7tnBzgas09HKe1Fp8HT7WV5
         wOmXhzkLKmrfaTOW8PxVrmJ3G1VO7ZnUeBYeofpObvl1iWA7gInQeQoREMyi4r2/bRuL
         LMKp2EZWt6ky1D/5XoalNguaskg37YDbQYKnNr9qmbKCf2I25W4IVtg9ga1Bx1OnIFtv
         FXgLMfOb2Fi/Eo1UC+pinTqEaBxU/yQpRyjszyAFvcPYVzp1KP7rTYWqg9yEn94TTbGI
         o5fFQQznf6PN1h/siIJYpQKTGnMd4Izj9a4+2i2g3hdD4ti/04UJXk+kjUISdk4/BuUT
         KlCw==
X-Gm-Message-State: APjAAAUihI794XrsTOMYYFLczadzTiFwAosaEH4yyEexeW7MqiYtYpR6
        s3mXR0QtZhBdcgYDV72PVJyRNQ==
X-Google-Smtp-Source: APXvYqxcX+GEqaFki9ts9gcHnI+DJ4J45UmF6NQ3tBHikewn3dAB757SCx8zHdqTJ17A6V/LaCRYWA==
X-Received: by 2002:a63:6c83:: with SMTP id h125mr92843035pgc.86.1559160652464;
        Wed, 29 May 2019 13:10:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2sm216631pgq.50.2019.05.29.13.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:10:51 -0700 (PDT)
Date:   Wed, 29 May 2019 13:10:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 05/14] arm64, mm: Make randomization selected by
 generic topdown mmap layout
Message-ID: <201905291310.E27265DACF@keescook>
References: <20190526134746.9315-1-alex@ghiti.fr>
 <20190526134746.9315-6-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-6-alex@ghiti.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 09:47:37AM -0400, Alexandre Ghiti wrote:
> This commits selects ARCH_HAS_ELF_RANDOMIZE when an arch uses the generic
> topdown mmap layout functions so that this security feature is on by
> default.
> Note that this commit also removes the possibility for arm64 to have elf
> randomization and no MMU: without MMU, the security added by randomization
> is worth nothing.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/Kconfig                |  1 +
>  arch/arm64/Kconfig          |  1 -
>  arch/arm64/kernel/process.c |  8 --------
>  mm/util.c                   | 11 +++++++++--
>  4 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index df3ab04270fa..3732654446cc 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -710,6 +710,7 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
>  config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>  	bool
>  	depends on MMU
> +	select ARCH_HAS_ELF_RANDOMIZE
>  
>  config HAVE_COPY_THREAD_TLS
>  	bool
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3d754c19c11e..403bd3fffdbc 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -15,7 +15,6 @@ config ARM64
>  	select ARCH_HAS_DMA_MMAP_PGPROT
>  	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
> -	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 3767fb21a5b8..3f85f8f2d665 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -535,14 +535,6 @@ unsigned long arch_align_stack(unsigned long sp)
>  	return sp & ~0xf;
>  }
>  
> -unsigned long arch_randomize_brk(struct mm_struct *mm)
> -{
> -	if (is_compat_task())
> -		return randomize_page(mm->brk, SZ_32M);
> -	else
> -		return randomize_page(mm->brk, SZ_1G);
> -}
> -
>  /*
>   * Called from setup_new_exec() after (COMPAT_)SET_PERSONALITY.
>   */
> diff --git a/mm/util.c b/mm/util.c
> index 717f5d75c16e..8a38126edc74 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -319,7 +319,15 @@ unsigned long randomize_stack_top(unsigned long stack_top)
>  }
>  
>  #ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> -#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE
> +unsigned long arch_randomize_brk(struct mm_struct *mm)
> +{
> +	/* Is the current task 32bit ? */
> +	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
> +		return randomize_page(mm->brk, SZ_32M);
> +
> +	return randomize_page(mm->brk, SZ_1G);
> +}
> +
>  unsigned long arch_mmap_rnd(void)
>  {
>  	unsigned long rnd;
> @@ -333,7 +341,6 @@ unsigned long arch_mmap_rnd(void)
>  
>  	return rnd << PAGE_SHIFT;
>  }
> -#endif /* CONFIG_ARCH_HAS_ELF_RANDOMIZE */
>  
>  static int mmap_is_legacy(struct rlimit *rlim_stack)
>  {
> -- 
> 2.20.1
> 

-- 
Kees Cook
