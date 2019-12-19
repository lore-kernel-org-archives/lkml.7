Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD604C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F5F2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnU7Uy9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSKWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:22:04 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45684 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLSKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:22:04 -0500
Received: by mail-qv1-f68.google.com with SMTP id l14so1987794qvu.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxF/3xVlUS8ynULbPMYetj7WI4OWmavmAlIDGJ3QWsE=;
        b=mnU7Uy9c4RjOMQCYwRrfhEO/MlAIGDXYKa1kofKUJit561ETC/3JKdAYC7+3fKQIKR
         msaJydYZ3Fv1tV0Xw0BusryjX+/HbgYScWAjG1qOrc4y2ryHDI7ovaXnG0rGbFqr8JR+
         9sN73JIR3m377cVIfwMc6vMrbbK3TNmVEzjoRLNi/43f9Re+AQiFlbrjAi80pn1ejuLc
         Ow3dlAWcYXEjbjFk+FNSYql46vL8P50SkbXExKjLsocfobvfs/uTJF6JEIxZnfAn5Zl7
         k2St4sxO9RfBAKResusCXeOqq4KBnRgXjTTGP8oGJTY7PYzR+xTzs7r4nugv/T3c2xNp
         iN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxF/3xVlUS8ynULbPMYetj7WI4OWmavmAlIDGJ3QWsE=;
        b=tu1xtu6CPbmPC0oRQa5oEUl/HtSUOXFJupsYCPIf+MqYscZYli8qzYmWmag1cuIMuT
         jEDXQuGi1kcFfaAr4z33KI8QCJs5F6SD4n1zoJHMSIngkIt+6f45TBkgFk6fRZ48rUoQ
         kQKqXADuS+s/XaCHeW/OrGTaIkWZ7p/oHdp/z00JzRZtPFPVZEr1ixkdi81ADXsVh0vY
         JG/4zIh+yRh8GF+UflnefqBqFOmzqkeAbzaK3bg9CxrXzg/NfDgfcrnCPKpHSrFKIRo0
         oZQR7OpVQoGW+d7awYDM2zABVXqBr5lQozPkJNTSeWacGHRF4DnaJj2yQZ6uWLYVn2qT
         QGGQ==
X-Gm-Message-State: APjAAAUL/nw1t1GJPUfN6lcf9Y2frCmJGR9HmFLkz5zuzEafdRYqiH5h
        H3jONneEO9EOcluT4JX0KYIMdk3LrUqaW425kqSoCA==
X-Google-Smtp-Source: APXvYqykDgu2fIyEwsnVjjcafYBfJKGgpr03PqoCs1HL+UIf8vYq9aPLCz5s5do5q37GDcLARuY6BXzPZaI+Fyi9RWw=
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr6769571qvs.159.1576750922197;
 Thu, 19 Dec 2019 02:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20191218231150.12139-1-jannh@google.com> <20191218231150.12139-4-jannh@google.com>
In-Reply-To: <20191218231150.12139-4-jannh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Dec 2019 11:21:51 +0100
Message-ID: <CACT4Y+bKioQorPESS0B83s4TkU0ZSo7M2JpNxJD06W=OihrK9A@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] x86/kasan: Print original address on #GP
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:12 AM Jann Horn <jannh@google.com> wrote:
>
> Make #GP exceptions caused by out-of-bounds KASAN shadow accesses easier
> to understand by computing the address of the original access and
> printing that. More details are in the comments in the patch.
>
> This turns an error like this:
>
>     kasan: CONFIG_KASAN_INLINE enabled
>     kasan: GPF could be caused by NULL-ptr deref or user memory access
>     general protection fault, probably for non-canonical address
>         0xe017577ddf75b7dd: 0000 [#1] PREEMPT SMP KASAN PTI
>
> into this:
>
>     general protection fault, probably for non-canonical address
>         0xe017577ddf75b7dd: 0000 [#1] PREEMPT SMP KASAN PTI
>     KASAN: maybe wild-memory-access in range
>         [0x00badbeefbadbee8-0x00badbeefbadbeef]
>
> The hook is placed in architecture-independent code, but is currently
> only wired up to the X86 exception handler because I'm not sufficiently
> familiar with the address space layout and exception handling mechanisms
> on other architectures.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>
> Notes:
>     v2:
>      - move to mm/kasan/report.c (Dmitry)
>      - change hook name to be more generic
>      - use TASK_SIZE instead of TASK_SIZE_MAX for compiling on non-x86
>      - don't open-code KASAN_SHADOW_MASK (Dmitry)
>      - add "KASAN: " prefix, but not "BUG: " (Andrey, Dmitry)
>      - use same naming scheme as get_wild_bug_type (Andrey)
>      - this version was "Reviewed-by: Dmitry Vyukov <dvyukov@google.com>"
>     v3:
>      - adjusted example output in commit message based on
>        changes in preceding patch
>      - ensure that KASAN output happens after bust_spinlocks(1)
>      - moved hook in arch/x86/kernel/traps.c such that output
>        appears after the first line of KASAN-independent error report
>     v4:
>      - adjust patch to changes in x86/traps patch
>     v5:
>      - adjust patch to changes in x86/traps patch
>      - fix bug introduced in v3: remove die() call after oops_end()
>     v6:
>      - adjust sample output in commit message
>     v7:
>      - instead of open-coding __die_header()+__die_body() in traps.c,
>        insert a hook call into die_body(), introduced in patch 3/4
>        (Borislav)
>
>  arch/x86/kernel/dumpstack.c |  2 ++
>  arch/x86/mm/kasan_init_64.c | 21 -------------------
>  include/linux/kasan.h       |  6 ++++++
>  mm/kasan/report.c           | 40 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 8995bf10c97c..ae64ec7f752f 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -427,6 +427,8 @@ void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr)
>         int sig = SIGSEGV;
>
>         __die_header(str, regs, err);
> +       if (gp_addr)
> +               kasan_non_canonical_hook(gp_addr);
>         if (__die_body(str, regs, err))
>                 sig = 0;
>         oops_end(flags, regs, sig);
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index cf5bc37c90ac..763e71abc0fe 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -288,23 +288,6 @@ static void __init kasan_shallow_populate_pgds(void *start, void *end)
>         } while (pgd++, addr = next, addr != (unsigned long)end);
>  }
>
> -#ifdef CONFIG_KASAN_INLINE
> -static int kasan_die_handler(struct notifier_block *self,
> -                            unsigned long val,
> -                            void *data)
> -{
> -       if (val == DIE_GPF) {
> -               pr_emerg("CONFIG_KASAN_INLINE enabled\n");
> -               pr_emerg("GPF could be caused by NULL-ptr deref or user memory access\n");
> -       }
> -       return NOTIFY_OK;
> -}
> -
> -static struct notifier_block kasan_die_notifier = {
> -       .notifier_call = kasan_die_handler,
> -};
> -#endif
> -
>  void __init kasan_early_init(void)
>  {
>         int i;
> @@ -341,10 +324,6 @@ void __init kasan_init(void)
>         int i;
>         void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
>
> -#ifdef CONFIG_KASAN_INLINE
> -       register_die_notifier(&kasan_die_notifier);
> -#endif
> -
>         memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
>
>         /*
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 4f404c565db1..e0238af0388f 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -225,4 +225,10 @@ static inline void kasan_release_vmalloc(unsigned long start,
>                                          unsigned long free_region_end) {}
>  #endif
>
> +#ifdef CONFIG_KASAN_INLINE
> +void kasan_non_canonical_hook(unsigned long addr);
> +#else /* CONFIG_KASAN_INLINE */
> +static inline void kasan_non_canonical_hook(unsigned long addr) { }
> +#endif /* CONFIG_KASAN_INLINE */
> +
>  #endif /* LINUX_KASAN_H */
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 621782100eaa..5ef9f24f566b 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -512,3 +512,43 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
>
>         end_report(&flags);
>  }
> +
> +#ifdef CONFIG_KASAN_INLINE
> +/*
> + * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
> + * canonical half of the address space) cause out-of-bounds shadow memory reads
> + * before the actual access. For addresses in the low canonical half of the
> + * address space, as well as most non-canonical addresses, that out-of-bounds
> + * shadow memory access lands in the non-canonical part of the address space.
> + * Help the user figure out what the original bogus pointer was.
> + */
> +void kasan_non_canonical_hook(unsigned long addr)
> +{
> +       unsigned long orig_addr;
> +       const char *bug_type;
> +
> +       if (addr < KASAN_SHADOW_OFFSET)
> +               return;
> +
> +       orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;
> +       /*
> +        * For faults near the shadow address for NULL, we can be fairly certain
> +        * that this is a KASAN shadow memory access.
> +        * For faults that correspond to shadow for low canonical addresses, we
> +        * can still be pretty sure - that shadow region is a fairly narrow
> +        * chunk of the non-canonical address space.
> +        * But faults that look like shadow for non-canonical addresses are a
> +        * really large chunk of the address space. In that case, we still
> +        * print the decoded address, but make it clear that this is not
> +        * necessarily what's actually going on.
> +        */
> +       if (orig_addr < PAGE_SIZE)
> +               bug_type = "null-ptr-deref";
> +       else if (orig_addr < TASK_SIZE)
> +               bug_type = "probably user-memory-access";
> +       else
> +               bug_type = "maybe wild-memory-access";
> +       pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
> +                orig_addr, orig_addr + KASAN_SHADOW_MASK);
> +}
> +#endif

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!
