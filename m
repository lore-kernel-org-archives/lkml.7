Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B70C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3202070D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558881757;
	bh=98W8IPoVXGBuzfthzZ0Viq69Xn/SHuNpB2sD+YLf57k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQXr70LInbnqbcRCxXLvWDjIx34GE/kkjwAI9eSFtmQI1awVDgzyWR55Rd+aMhb8G
	 O5X4hd5q2+QcylyLgE4pafg/kHiV8SzquuEg5FBHuGAeU6WGyZTWLUBk+UvloHJ7Rk
	 +xQbqU6dedqf66oXsxSHLCIg7aSZXIPeDeOw9k8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfEZOmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 10:42:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35600 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfEZOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 10:42:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so7238519wmi.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Jc4sO30EHRrfMknAHHzVrJgrARHyBdt4KcFxsTnWW4=;
        b=kZqY6/9U2aXYB0+PivvRG/0EZvp1fvoxyT3c45tkGVmfC4/e9dy+hrfcgmrZGRLy8F
         GZn5Fcdv9W6+EG0+HpnNhGPu6ty3tLYFsHWvLtMY2+EOTbbWUnKaTEFIOR3FJMAzoGBb
         wIeiMRIAQ1A5tWu9BW4gOY1PulRcSsWcZlHOUeHQ2RTxRA9hMUQxxq6/p9ube593cCVk
         /YnBMNZnytvf3lfK7f+NYW8NEi5zVf5dVcvQtFM/byZPraz13zyJIDKyH5gPQLZAtyDG
         KnNvz+K4mLyV8PnoXkWKCmA2hon1TqOOBoqQNp3OjuoeHSNQgKi062bLW0O3WC+y/vHs
         iS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Jc4sO30EHRrfMknAHHzVrJgrARHyBdt4KcFxsTnWW4=;
        b=nMH6gBqtGtiSPK6PqM55sBzu7TkpSeCDDRJ2Zvj2QGcQQH/zXHWkISrdDWbpaqIzsU
         7DbFU/I5chqwDzUitx2c9UVnhXG1dW4rgGlCWzTpT+4qLRzoMWaeHJbGwLiOEB4+vTzT
         pMVFUYnCWoHAYgae26CNujpdLEd4wL3D3YvoT6qnl9mH813/e5RI13GMzLL5XErC8IVy
         9MZVX9XTTF4/ttvHULA18vYZD5+EKU+i44pgWAcz56u4FmJPnNYleCS9GfnOjeq7LhXt
         JrbYlSlrHpgLq84sS+9Lm7+Of6d1Hmn9E7WifK1RA6GJR1P4JAk53rln34hGwgw4iTnL
         +5jg==
X-Gm-Message-State: APjAAAXmy3A+B8Y8jtO06eygRNgKi7vX8XFpdOpDPp71eOxuDS4WMb9e
        pFAYqeFUUJmhLkvZvISmjRA=
X-Google-Smtp-Source: APXvYqw5Ns1JM3P7xKflG+zD8xW+7XcRAC9D5p29qkjHX4kJkAZxEFsVfB+lfQo6LcL9QNKTSE8P5g==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr24065933wmb.58.1558881753913;
        Sun, 26 May 2019 07:42:33 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o20sm8014462wro.2.2019.05.26.07.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 07:42:32 -0700 (PDT)
Date:   Sun, 26 May 2019 16:42:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH REBASE v2 1/2] x86, arm64: Move ARCH_WANT_HUGE_PMD_SHARE
 config in arch/Kconfig
Message-ID: <20190526144230.GA13220@gmail.com>
References: <20190526125038.8419-1-alex@ghiti.fr>
 <20190526125038.8419-2-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526125038.8419-2-alex@ghiti.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexandre Ghiti <alex@ghiti.fr> wrote:

> ARCH_WANT_HUGE_PMD_SHARE config was declared in both architectures:
> move this declaration in arch/Kconfig and make those architectures
> select it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/Kconfig       | 3 +++
>  arch/arm64/Kconfig | 2 +-
>  arch/x86/Kconfig   | 4 +---
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index c47b328eada0..d2f212dc8e72 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -577,6 +577,9 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>  config HAVE_ARCH_HUGE_VMAP
>  	bool
>  
> +config ARCH_WANT_HUGE_PMD_SHARE
> +	bool
> +
>  config HAVE_ARCH_SOFT_DIRTY
>  	bool
>  
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4780eb7af842..dee7f750c42f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -70,6 +70,7 @@ config ARM64
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select ARCH_WANT_FRAME_POINTERS
> +	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
> @@ -884,7 +885,6 @@ config SYS_SUPPORTS_HUGETLBFS
>  	def_bool y
>  
>  config ARCH_WANT_HUGE_PMD_SHARE
> -	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>  
>  config ARCH_HAS_CACHE_LINE_SIZE
>  	def_bool y
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2bbbd4d1ba31..fa021ec38803 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -93,6 +93,7 @@ config X86
>  	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> +	select ARCH_WANT_HUGE_PMD_SHARE
>  	select ARCH_WANTS_THP_SWAP		if X86_64
>  	select BUILDTIME_EXTABLE_SORT
>  	select CLKEVT_I8253
> @@ -301,9 +302,6 @@ config ARCH_HIBERNATION_POSSIBLE
>  config ARCH_SUSPEND_POSSIBLE
>  	def_bool y
>  
> -config ARCH_WANT_HUGE_PMD_SHARE
> -	def_bool y
> -
>  config ARCH_WANT_GENERAL_HUGETLB
>  	def_bool y

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
