Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1498BC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CE821479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vjhji0Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfDRFZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:25:37 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46581 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRFZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:25:37 -0400
Received: by mail-vs1-f65.google.com with SMTP id e2so483169vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jq72mIAW+DpXXKzdmdlCRpkn/sofWg7pTQf2H9PeRYA=;
        b=Vjhji0MaAMge7bXj40KL9Z4UP08iRb0l6wKXsWdD6szF6TtGik3LdUi7v4kUyBltqk
         uXEWf/Xmd5Jb5TvOqTmT1keAiZsZEJTLu6CtA2f7onItxqZpkLFTaTGgeIj8SvarRqS5
         gJmbPP8YdEdnm/uN4CBbf+bZjMNpdKMLmHrrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jq72mIAW+DpXXKzdmdlCRpkn/sofWg7pTQf2H9PeRYA=;
        b=RcyIORBkfqeml33xbi8fewXCER2H5Dq8nHaW9vkeqV6MjtvUTUOouxIc2DTEfpRkP/
         pRMlV61HtFE7riDUWi5eAphhbLqbkGQYey2rwMbKR9zH4TP6gawyKQ5Z7a4xyYPL9xK0
         elfijUegMj+K+doSzNa8Kcu4WJzOxyC1O0okthu4tZAPyX/4xdYFaCd/V41nr3jdMSz9
         gj1lWYvBXsM4i13QXtpaGyPeu5+1lKG5yEn7xAtGrTvuzfkmB7v24w3SEauqzSvfJlL/
         H2s/7f/rHi2oubHZOpyzyaWDA3ry8xyTmOcbDwkTTL/xQGOUJ8Mon7Kebe8WWti1x4Ju
         HV/A==
X-Gm-Message-State: APjAAAXeKFzVz8oeztujL0c3D5h+g2iauHQrm+9jLLBnMm+VwcMkmloN
        FfonyA52AMkLp/p+zFCs402JR4PaMDI=
X-Google-Smtp-Source: APXvYqz+YD5ULmxxdzi4n1xh5xH5Kakzy52pTViE23/MSaYKLuqY9BcakrKcL+aINGNZOiR5YPI59Q==
X-Received: by 2002:a67:84d1:: with SMTP id g200mr50735011vsd.69.1555565135536;
        Wed, 17 Apr 2019 22:25:35 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 203sm234855vkt.52.2019.04.17.22.25.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:25:35 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id g127so503730vsd.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:25:35 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr28803360vsp.188.1555564664290;
 Wed, 17 Apr 2019 22:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-5-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-5-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:17:32 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+NV7nfQ044kvsqqSrWpuXH5J6aZEbvg7YpxyBFjdAHyw@mail.gmail.com>
Message-ID: <CAGXu5j+NV7nfQ044kvsqqSrWpuXH5J6aZEbvg7YpxyBFjdAHyw@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] arm64, mm: Move generic mmap layout functions to mm
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
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(

On Wed, Apr 17, 2019 at 12:27 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> arm64 handles top-down mmap layout in a way that can be easily reused
> by other architectures, so make it available in mm.
> It then introduces a new config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> that can be set by other architectures to benefit from those functions.
> Note that this new config depends on MMU being enabled, if selected
> without MMU support, a warning will be thrown.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/Kconfig                       |  8 ++++
>  arch/arm64/Kconfig                 |  1 +
>  arch/arm64/include/asm/processor.h |  2 -
>  arch/arm64/mm/mmap.c               | 76 ------------------------------
>  kernel/sysctl.c                    |  6 ++-
>  mm/util.c                          | 74 ++++++++++++++++++++++++++++-
>  6 files changed, 86 insertions(+), 81 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 33687dddd86a..7c8965c64590 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -684,6 +684,14 @@ config HAVE_ARCH_COMPAT_MMAP_BASES
>           and vice-versa 32-bit applications to call 64-bit mmap().
>           Required for applications doing different bitness syscalls.
>
> +# This allows to use a set of generic functions to determine mmap base
> +# address by giving priority to top-down scheme only if the process
> +# is not in legacy mode (compat task, unlimited stack size or
> +# sysctl_legacy_va_layout).
> +config ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> +       bool
> +       depends on MMU

I'd prefer the comment were moved to the help text. I would include
any details about what the arch still needs to define. For example
right now, I think STACK_RND_MASK is still needed. (Though I think a
common one could be added for this series too...)

> +
>  config HAVE_COPY_THREAD_TLS
>         bool
>         help
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7e34b9eba5de..670719a26b45 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -66,6 +66,7 @@ config ARM64
>         select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG
>         select ARCH_SUPPORTS_NUMA_BALANCING
>         select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
> +       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>         select ARCH_WANT_FRAME_POINTERS
>         select ARCH_HAS_UBSAN_SANITIZE_ALL
>         select ARM_AMBA
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 5d9ce62bdebd..4de2a2fd605a 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -274,8 +274,6 @@ static inline void spin_lock_prefetch(const void *ptr)
>                      "nop") : : "p" (ptr));
>  }
>
> -#define HAVE_ARCH_PICK_MMAP_LAYOUT
> -
>  #endif
>
>  extern unsigned long __ro_after_init signal_minsigstksz; /* sigframe size */
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index ac89686c4af8..c74224421216 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -31,82 +31,6 @@
>
>  #include <asm/cputype.h>
>
> -/*
> - * Leave enough space between the mmap area and the stack to honour ulimit in
> - * the face of randomisation.
> - */

This comment goes missing in the move...

> -#define MIN_GAP (SZ_128M)
> -#define MAX_GAP        (STACK_TOP/6*5)
> -
> -static int mmap_is_legacy(struct rlimit *rlim_stack)
> -{
> -       if (current->personality & ADDR_COMPAT_LAYOUT)
> -               return 1;
> -
> -       if (rlim_stack->rlim_cur == RLIM_INFINITY)
> -               return 1;
> -
> -       return sysctl_legacy_va_layout;
> -}
> -
> -unsigned long arch_mmap_rnd(void)
> -{
> -       unsigned long rnd;
> -
> -#ifdef CONFIG_COMPAT
> -       if (is_compat_task())
> -               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
> -       else
> -#endif
> -               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
> -       return rnd << PAGE_SHIFT;
> -}
> -
> -static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
> -{
> -       unsigned long gap = rlim_stack->rlim_cur;
> -       unsigned long pad = stack_guard_gap;
> -
> -       /* Account for stack randomization if necessary */
> -       if (current->flags & PF_RANDOMIZE)
> -               pad += (STACK_RND_MASK << PAGE_SHIFT);
> -
> -       /* Values close to RLIM_INFINITY can overflow. */
> -       if (gap + pad > gap)
> -               gap += pad;
> -
> -       if (gap < MIN_GAP)
> -               gap = MIN_GAP;
> -       else if (gap > MAX_GAP)
> -               gap = MAX_GAP;
> -
> -       return PAGE_ALIGN(STACK_TOP - gap - rnd);
> -}
> -
> -/*
> - * This function, called very early during the creation of a new process VM
> - * image, sets up which VM layout function to use:
> - */
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> -{
> -       unsigned long random_factor = 0UL;
> -
> -       if (current->flags & PF_RANDOMIZE)
> -               random_factor = arch_mmap_rnd();
> -
> -       /*
> -        * Fall back to the standard layout if the personality bit is set, or
> -        * if the expected stack growth is unlimited:
> -        */
> -       if (mmap_is_legacy(rlim_stack)) {
> -               mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -               mm->get_unmapped_area = arch_get_unmapped_area;
> -       } else {
> -               mm->mmap_base = mmap_base(random_factor, rlim_stack);
> -               mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> -       }
> -}
> -
>  /*
>   * You really shouldn't be using read() or write() on /dev/mem.  This might go
>   * away in the future.
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e5da394d1ca3..eb3414e78986 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -269,7 +269,8 @@ extern struct ctl_table epoll_table[];
>  extern struct ctl_table firmware_config_table[];
>  #endif
>
> -#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
> +    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
>  int sysctl_legacy_va_layout;
>  #endif
>
> @@ -1564,7 +1565,8 @@ static struct ctl_table vm_table[] = {
>                 .proc_handler   = proc_dointvec,
>                 .extra1         = &zero,
>         },
> -#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
> +    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
>         {
>                 .procname       = "legacy_va_layout",
>                 .data           = &sysctl_legacy_va_layout,
> diff --git a/mm/util.c b/mm/util.c
> index a54afb9b4faa..5c3393d32ed1 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -15,7 +15,12 @@
>  #include <linux/vmalloc.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/elf.h>
> +#include <linux/elf-randomize.h>
> +#include <linux/personality.h>
>  #include <linux/random.h>
> +#include <linux/processor.h>
> +#include <linux/sizes.h>
> +#include <linux/compat.h>
>
>  #include <linux/uaccess.h>
>
> @@ -313,7 +318,74 @@ unsigned long randomize_stack_top(unsigned long stack_top)
>  #endif
>  }
>
> -#if defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
> +#ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> +#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE

I think CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT should select
CONFIG_ARCH_HAS_ELF_RANDOMIZE. It would mean moving
arch_randomize_brk() into this patch set too. For arm64 and arm, this
is totally fine: they have identical logic. On MIPS this would mean
bumping the randomization up: arm64 uses SZ_32M for 32-bit and SZ_1G
for 64-bit. MIPS is 8M and 256M respectively. I don't see anything
that indicates this would be a problem. *cross fingers*

It looks like x86 would need bumping too: it uses 32M on both 32-bit
and 64-bit. STACK_RND_MASK is the same though.

> +unsigned long arch_mmap_rnd(void)
> +{
> +       unsigned long rnd;
> +
> +#ifdef CONFIG_COMPAT
> +       if (is_compat_task())
> +               rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
> +       else
> +#endif /* CONFIG_COMPAT */

The ifdefs on is_compat_task() are not needed: is_compat_task()
returns 0 in the !CONFIG_COMPAT case.

> +               rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
> +
> +       return rnd << PAGE_SHIFT;
> +}
> +#endif /* CONFIG_ARCH_HAS_ELF_RANDOMIZE */
> +
> +static int mmap_is_legacy(struct rlimit *rlim_stack)
> +{
> +       if (current->personality & ADDR_COMPAT_LAYOUT)
> +               return 1;
> +
> +       if (rlim_stack->rlim_cur == RLIM_INFINITY)
> +               return 1;
> +
> +       return sysctl_legacy_va_layout;
> +}
> +
> +#define MIN_GAP                (SZ_128M)
> +#define MAX_GAP                (STACK_TOP / 6 * 5)
> +
> +static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
> +{
> +       unsigned long gap = rlim_stack->rlim_cur;
> +       unsigned long pad = stack_guard_gap;
> +
> +       /* Account for stack randomization if necessary */
> +       if (current->flags & PF_RANDOMIZE)
> +               pad += (STACK_RND_MASK << PAGE_SHIFT);
> +
> +       /* Values close to RLIM_INFINITY can overflow. */
> +       if (gap + pad > gap)
> +               gap += pad;
> +
> +       if (gap < MIN_GAP)
> +               gap = MIN_GAP;
> +       else if (gap > MAX_GAP)
> +               gap = MAX_GAP;
> +
> +       return PAGE_ALIGN(STACK_TOP - gap - rnd);
> +}
> +
> +void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> +{
> +       unsigned long random_factor = 0UL;
> +
> +       if (current->flags & PF_RANDOMIZE)
> +               random_factor = arch_mmap_rnd();
> +
> +       if (mmap_is_legacy(rlim_stack)) {
> +               mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> +               mm->get_unmapped_area = arch_get_unmapped_area;
> +       } else {
> +               mm->mmap_base = mmap_base(random_factor, rlim_stack);
> +               mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> +       }
> +}
> +#elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
>  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>  {
>         mm->mmap_base = TASK_UNMAPPED_BASE;
> --
> 2.20.1
>


--
Kees Cook
