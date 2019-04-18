Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ADCC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2B12183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZmIDWwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfDRFvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:51:33 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34600 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:51:32 -0400
Received: by mail-vk1-f193.google.com with SMTP id x84so228935vkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsXAYO0c8zFLQiUk70GsGhFvh+QJiSpbjT3b+4rW66I=;
        b=WZmIDWwIQt+p2U8OFcegWRRVLp6nJI1rwc15/sOJzGCUmcSGRFPVv48qDCitMPl6bn
         rM78n9VYubygolMm6Ghe0eVh8aEQd+wbbsAcLH0uKTj/Hr9dtxdm7CrqSOZUwvjdwtFp
         4/y4Gx8iiVq8g1yfl8tKAiGgIRUjAi38RRMeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsXAYO0c8zFLQiUk70GsGhFvh+QJiSpbjT3b+4rW66I=;
        b=TVxqSau0n+8geOI58QFNfFJBC0x57hwDvqlE8U7Sjyo0YwLP9ItaHaQcJMB+tuwe4H
         vEizCa+MN4zozTIoQshUP8KhGiJOwfxp/sv/pBJIQKkGgt472cROVsopTRuDYACch048
         sC4oM2H2p2Jtfmd5qhgHW3HZnF/aTj6BtRyHVfeF7IglPJuU0zCGig0ZQUFQo/kXa9B/
         jsCzv8oKiNhh/vztnST2zUp3y1AuEN+AmP1R+M8H2LbJOMIb0KAs7VKqmUqmiOeAu3Jf
         ZcP51fQZtPnp1Vz+SbbSbwzmvphq9/81WaO5kToxQOrpWVZa7+2mz2xkhd2Ok8aHK4/u
         uitA==
X-Gm-Message-State: APjAAAX5E6E8nZTswy48MCRX3IY2plA4aDd1dhuXJBTdjIQDwm99xvx4
        iwd6+hrpJ7s7L1esTsI1dWYAZoZYwm4=
X-Google-Smtp-Source: APXvYqy5i/G8NOIxuhj7JziCPL94GnQ1W+/wAGr0FR2RkGr6f9jXn2+YCrQ0oJRXcVWHpMOsufPmrg==
X-Received: by 2002:a1f:32c7:: with SMTP id y190mr52139885vky.15.1555566691227;
        Wed, 17 Apr 2019 22:51:31 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id r199sm317654vke.30.2019.04.17.22.51.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 22:51:31 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id o187so223027vkg.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:51:30 -0700 (PDT)
X-Received: by 2002:a1f:7245:: with SMTP id n66mr38243289vkc.40.1555565326448;
 Wed, 17 Apr 2019 22:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-8-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-8-alex@ghiti.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Apr 2019 00:28:34 -0500
X-Gmail-Original-Message-ID: <CAGXu5jLhZS3+tiDCMsQQ=s9_f5ZBTLEYfcSfmtDRYv8Pp-KF2Q@mail.gmail.com>
Message-ID: <CAGXu5jLhZS3+tiDCMsQQ=s9_f5ZBTLEYfcSfmtDRYv8Pp-KF2Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] arm: Use generic mmap top-down layout
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
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:30 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> arm uses a top-down mmap layout by default that exactly fits the generic
> functions, so get rid of arch specific code and use the generic version
> by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/Kconfig                 |  1 +
>  arch/arm/include/asm/processor.h |  2 --
>  arch/arm/mm/mmap.c               | 62 --------------------------------
>  3 files changed, 1 insertion(+), 64 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 850b4805e2d1..f8f603da181f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -28,6 +28,7 @@ config ARM
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>         select ARCH_WANT_IPC_PARSE_VERSION
>         select BUILDTIME_EXTABLE_SORT if MMU
>         select CLONE_BACKWARDS
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 57fe73ea0f72..944ef1fb1237 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -143,8 +143,6 @@ static inline void prefetchw(const void *ptr)
>  #endif
>  #endif
>
> -#define HAVE_ARCH_PICK_MMAP_LAYOUT
> -
>  #endif
>
>  #endif /* __ASM_ARM_PROCESSOR_H */
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 0b94b674aa91..b8d912ac9e61 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -17,43 +17,6 @@
>         ((((addr)+SHMLBA-1)&~(SHMLBA-1)) +      \
>          (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
>
> -/* gap between mmap and stack */
> -#define MIN_GAP                (128*1024*1024UL)
> -#define MAX_GAP                ((STACK_TOP)/6*5)
> -#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))
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
>  /*
>   * We need to ensure that shared mappings are correctly aligned to
>   * avoid aliasing issues with VIPT caches.  We need to ensure that
> @@ -181,31 +144,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>         return addr;
>  }
>
> -unsigned long arch_mmap_rnd(void)
> -{
> -       unsigned long rnd;
> -
> -       rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
> -
> -       return rnd << PAGE_SHIFT;
> -}
> -
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> -{
> -       unsigned long random_factor = 0UL;
> -
> -       if (current->flags & PF_RANDOMIZE)
> -               random_factor = arch_mmap_rnd();
> -
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
>   * You really shouldn't be using read() or write() on /dev/mem.  This
>   * might go away in the future.
> --
> 2.20.1
>


-- 
Kees Cook
