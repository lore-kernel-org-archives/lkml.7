Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A005BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6982F206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgFrNR38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfKRIgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:36:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46655 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfKRIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:36:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id r20so19259463qtp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqpfOa+eDbyWdbseRYm3zOhbqqwwfORj1AqplMRUi+w=;
        b=YgFrNR38/JA2gm9khV7YWCGxCQuzkhNGurY4QDn9gGbAXhb0Uujj9Y3wxTaLqW6YMr
         8Bn5fhHu88WgRgUm49BT/QYdUZY4zn6Vrd91n5HBKsgh+TuxP38gVozFfdrNTwTCc51y
         gSxPQWLd8uq69IdPSgckc+p0IM/sJ2WMCEfSgVDJZ/2deoSXcuq3STZLDGUN1tQRXvoV
         xVNnTUR9wc0zP1GS+ecMj1P0XNuZo8PtQYxTstrVoadx7y0wRc9QQr7eKk+98VZBmSmg
         3n4pZdCPIF+KRw/GnFEU93vG6vQ2Wus0u0/P2OcShX7l1sKLbnkch83BSwedEoP1UYVC
         I/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqpfOa+eDbyWdbseRYm3zOhbqqwwfORj1AqplMRUi+w=;
        b=lEyFursB3KGe48smo6oSrx2bBbxsNGRRWTxUpGboMNYJIWW7r6sfsIKlwG1vxxQBiy
         pQuSwKx3/LDH3enOysBENFPyHwqBS2CMHFDa+V33lklWjss7x+h0dlJETT7+jKJ/EhBV
         VzF+bkEJgS+ZShxxR9rx0AFjMUBbCoAw227V3lE511/DZ9RZxZkhkU69BvosszQ1qGJY
         accRsXiZjebsK2dDOBQaW05VuNR4ch4xtgSsbn+YT5+EVWoBDjbKUqdMbedPXdiaokBw
         8LBjUAEZcj6mRGh2rHYW7y9RdjpsaXimh4VHZ6dFi9+lGdaGM/njJGB+Cne1ftc9JL+P
         k9hg==
X-Gm-Message-State: APjAAAUaej7sye//dKEYDzIE6jDx2pRr853LKwI80tsrpr8oJ+QURl2d
        0xq1Jtg+mIumfqcRrV1ngtfOmSmmPMaQOWqrhSAMsw==
X-Google-Smtp-Source: APXvYqyeBbiZSQxUZ3SyZ5Crt8n3zxsQIu7J7Po+5Ek5F2Qv731hQvcE4cq/ITz1DTKw7PRSc+e859EYLiU9jWaKTB0=
X-Received: by 2002:aed:24af:: with SMTP id t44mr25440361qtc.57.1574066174427;
 Mon, 18 Nov 2019 00:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20191115191728.87338-1-jannh@google.com> <20191115191728.87338-3-jannh@google.com>
In-Reply-To: <20191115191728.87338-3-jannh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 18 Nov 2019 09:36:03 +0100
Message-ID: <CACT4Y+ZmAupVG204VuL_73a8FdbM1NHwgV9oC4mK09ELnYujbA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86/kasan: Print original address on #GP
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

On Fri, Nov 15, 2019 at 8:17 PM Jann Horn <jannh@google.com> wrote:
>
> Make #GP exceptions caused by out-of-bounds KASAN shadow accesses easier
> to understand by computing the address of the original access and
> printing that. More details are in the comments in the patch.
>
> This turns an error like this:
>
>     kasan: CONFIG_KASAN_INLINE enabled
>     kasan: GPF could be caused by NULL-ptr deref or user memory access
>     traps: probably dereferencing non-canonical address 0xe017577ddf75b7dd
>     general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
>
> into this:
>
>     traps: dereferencing non-canonical address 0xe017577ddf75b7dd
>     traps: probably dereferencing non-canonical address 0xe017577ddf75b7dd
>     KASAN: maybe wild-memory-access in range
>             [0x00badbeefbadbee8-0x00badbeefbadbeef]
>     general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
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
>
>  arch/x86/kernel/traps.c     |  2 ++
>  arch/x86/mm/kasan_init_64.c | 21 -------------------
>  include/linux/kasan.h       |  6 ++++++
>  mm/kasan/report.c           | 40 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 12d42697a18e..87b52682a37a 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -37,6 +37,7 @@
>  #include <linux/mm.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> +#include <linux/kasan.h>
>  #include <asm/stacktrace.h>
>  #include <asm/processor.h>
>  #include <asm/debugreg.h>
> @@ -540,6 +541,7 @@ static void print_kernel_gp_address(struct pt_regs *regs)
>
>         pr_alert("probably dereferencing non-canonical address 0x%016lx\n",
>                  addr_ref);
> +       kasan_non_canonical_hook(addr_ref);
>  #endif
>  }
>
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index 296da58f3013..69c437fb21cc 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -245,23 +245,6 @@ static void __init kasan_map_early_shadow(pgd_t *pgd)
>         } while (pgd++, addr = next, addr != end);
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
> @@ -298,10 +281,6 @@ void __init kasan_init(void)
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
> index cc8a03cc9674..7305024b44e3 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -194,4 +194,10 @@ static inline void *kasan_reset_tag(const void *addr)
>
>  #endif /* CONFIG_KASAN_SW_TAGS */
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
> --
> 2.24.0.432.g9d3f5f5b63-goog


Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!
