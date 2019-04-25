Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E372BC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BE220675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HCieBeQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfDYRmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:42:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35289 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:42:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so211193pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=86BiqtuaE9Uuzh6uQTzGh9piSST8UhnDgUvET+cCroc=;
        b=HCieBeQn5i/68nu0Wldu/PGMV3yIGWHhqHc7ygCuzWkbpZX8mT4yoSzf84TUqvUhp+
         N1IxYNXPpNf8FTSQZIARmPEBlzX18NwCxXzoixJX7ZIRRRajtp6Huvs3/OmtQ+G/tcdc
         wvoUrFySlutusERjTfH/I7cUsTTOBMheQHaRLm6K7EkpXFvH4ckzdLtoBqI0vEx6wv/1
         rqFEFH7MnvIrP3JR7yjLBzPAKzwT0ykYdI/xDlw5aMJvG1W67MEId+Gvj31KJsPKM4DK
         6J+YfAChCQWfEk1VdxLFOaejHsyuwbvgMIoZEeiaR2gsHZd3Xmb8KfcvlSoCjW10xya5
         h+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=86BiqtuaE9Uuzh6uQTzGh9piSST8UhnDgUvET+cCroc=;
        b=UwCO7Odo1h2ZjYSSARarrT/5qMxTFRP1txrnSkfz/UexNKOIsFGGRporh4AH+H7MJX
         J34wtkXYKcdmBVh8E8oI3Nq9/ZUz6d85suBsLyNEQd/+QIdiE2DJCnGdCJDBYewEPytv
         uFnqoh+W59d226jooFjwoCz+AYIwwBaERAKIjSevRblDdaM7onYTLStyjppMZkgEY/fn
         sJrAK3HFqRv5xS4tceBfjC2SlzXcT5AYZU9TREspnO7KpgGJ4Dl0zZ9AVNZ2GQN5RQU0
         FfRcY2PnqvEDXxXqEdLmsvfwfDSH0U5FPvouWL+4AQbgnwuCoPkAPzy4x2AlQBgoYvOV
         LemA==
X-Gm-Message-State: APjAAAXnLbHgljl77U2qzQDzSg6Ijs4SsFuBmlR/wQY+h4Nv1M13nmXQ
        IzNMz/rwuA0U5ZDISomildhRLtvxieE=
X-Google-Smtp-Source: APXvYqwZh3jLz2nak9BgfuoKLyG2XmvcfvwtoluyObn7I08ywB1zpsk+47kwzWfpQJRqmBXZrCfTmA==
X-Received: by 2002:a62:524e:: with SMTP id g75mr41211465pfb.106.1556214164330;
        Thu, 25 Apr 2019 10:42:44 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id 4sm3975816pfj.45.2019.04.25.10.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 10:42:43 -0700 (PDT)
Date:   Thu, 25 Apr 2019 10:42:43 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 09:28:24 PDT (-0700)
Subject:     Re: [PATCH v2 1/2] x86, arm64: Move ARCH_WANT_HUGE_PMD_SHARE config in arch/Kconfig
In-Reply-To: <20190409061449.5083-2-alex@ghiti.fr>
CC:     Christoph Hellwig <hch@infradead.org>, mike.kravetz@oracle.com,
        aou@eecs.berkeley.edu, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@sifive.com>
To:     alex@ghiti.fr, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Message-ID: <mhng-4d1d4acb-f65f-4ed4-bc86-85a14b7c3e16@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Apr 2019 23:14:48 PDT (-0700), alex@ghiti.fr wrote:
> ARCH_WANT_HUGE_PMD_SHARE config was declared in both architectures:
> move this declaration in arch/Kconfig and make those architectures
> select it.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/Kconfig       | 3 +++
>  arch/arm64/Kconfig | 2 +-
>  arch/x86/Kconfig   | 4 +---
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8c858bb133c9..273cefc6b787 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -567,6 +567,9 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
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
> index 870ef86a64ed..8b7870974961 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -68,6 +68,7 @@ config ARM64
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
>  	select ARCH_WANT_FRAME_POINTERS
> +	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
> @@ -885,7 +886,6 @@ config SYS_SUPPORTS_HUGETLBFS
>  	def_bool y
>
>  config ARCH_WANT_HUGE_PMD_SHARE
> -	def_bool y if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>
>  config ARCH_HAS_CACHE_LINE_SIZE
>  	def_bool y
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0f2ab09da060..fd5fc2d288be 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -82,6 +82,7 @@ config X86
>  	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> +	select ARCH_WANT_HUGE_PMD_SHARE
>  	select ARCH_WANTS_THP_SWAP		if X86_64
>  	select BUILDTIME_EXTABLE_SORT
>  	select CLKEVT_I8253
> @@ -298,9 +299,6 @@ config ARCH_HIBERNATION_POSSIBLE
>  config ARCH_SUSPEND_POSSIBLE
>  	def_bool y
>
> -config ARCH_WANT_HUGE_PMD_SHARE
> -	def_bool y
> -
>  config ARCH_WANT_GENERAL_HUGETLB
>  	def_bool y

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Let me know if you want this via my tree, as I'd also like patch 2 which
depends on this one.  I've tenatively added both to my for-next tree for now.
