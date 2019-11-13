Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB4EC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C35D222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2JtYD8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfKMKLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:11:47 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44144 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfKMKLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:11:47 -0500
Received: by mail-qv1-f66.google.com with SMTP id d3so551801qvs.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 02:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRCEH7uGRv9k5bHRL7hYJEWrGzCPbbtWyq1WoRT6sfg=;
        b=A2JtYD8GEyM9hA5io3b2TDwlOYbWABlLimE+zfeiS0xytpNa7+WeJlwTaE/mn/+VrK
         Hmqd6EotYQV/xlEiSVhWq0aaBmhhvbiKc7Z5YqHdmFEjHtA3V4gcMKfLFzB0LqlIkC/O
         6F2TZZ7Ds4cubv7rbblRXeOPizcPu+X0X5KsXayqrXg1JwBLf1kPJmCGpf8VQd9aSbZX
         YpI9Kq80WaDK0Lu2kMgMnOdtXLtlwCf6pU+bWdOj6zx0Aseq9Uuif1FGx4mvI1Nd2xRo
         utgS3KANGwGDzIYOH/OHBXZUn2QpgjrfH00bd3PZzES2y1BS6Eg4KhWZcUVOSE7vP7tM
         QZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRCEH7uGRv9k5bHRL7hYJEWrGzCPbbtWyq1WoRT6sfg=;
        b=aoYTE4gD3K71DQHF2I0VM3HVjLjoPt8Ld9c8XfvV1H0cJuxTM4Hs3JW2PcWdZpTfB+
         PxoBmpijXAOGNKJOtW0+EvAEGqC9utwIkTalttt+G4Ppz3IkoF1TcnM1EInp/cEB9614
         Mqhne16GY1T9gJNVlcJkhoR6kfyqEbUwh2kchXUojldTjsfi8f8rhjhdyNMfOcElOG+I
         qVW8y3GoG1F/CcDsZtZoVw7wnkOnV8uXf8Cg64sVXfODjMi4tu3A2kGoyhqbrBCFEZKn
         j3tJXnIQ1VvjRnY5ngKgYsAh34KI4UPl5BUvFRLSuGPW+84I81JdNnPTiUHvT/2rQbEE
         4tWg==
X-Gm-Message-State: APjAAAUb9GQVF7DRX5WL2zIBdhhHC4JpQQFWkzlUW4U92hwzmh5WFvgc
        S3SMjXhDtK5GqKzcd4Z2XEUrkcZim9Cosn3KqUzTAw==
X-Google-Smtp-Source: APXvYqwpC4/YCS8ZDGTIuWDJIysku0/7ac4ZMVKSBb9vq372K5m17JRkYWNf9pM1uD70gMK1BI2M3BN2IyqmCN1fylk=
X-Received: by 2002:a05:6214:8ee:: with SMTP id dr14mr2106594qvb.122.1573639905171;
 Wed, 13 Nov 2019 02:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20191112211002.128278-1-jannh@google.com> <20191112211002.128278-3-jannh@google.com>
In-Reply-To: <20191112211002.128278-3-jannh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 13 Nov 2019 11:11:33 +0100
Message-ID: <CACT4Y+aojSsss3+Y2FB9Rw=OPxXgsFrGF0YiAJ9eo2wJM0ruWg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/kasan: Print original address on #GP
To:     Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:10 PM 'Jann Horn' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Make #GP exceptions caused by out-of-bounds KASAN shadow accesses easier
> to understand by computing the address of the original access and
> printing that. More details are in the comments in the patch.
>
> This turns an error like this:
>
>     kasan: CONFIG_KASAN_INLINE enabled
>     kasan: GPF could be caused by NULL-ptr deref or user memory access
>     traps: dereferencing non-canonical address 0xe017577ddf75b7dd
>     general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
>
> into this:
>
>     traps: dereferencing non-canonical address 0xe017577ddf75b7dd
>     kasan: maybe dereferencing invalid pointer in range
>             [0x00badbeefbadbee8-0x00badbeefbadbeef]
>     general protection fault: 0000 [#3] PREEMPT SMP KASAN PTI
>     [...]

Nice!

+Andrey, do you see any issues for TAGS mode? Or, Jann, did you test
it by any chance?


> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/include/asm/kasan.h |  6 +++++
>  arch/x86/kernel/traps.c      |  2 ++
>  arch/x86/mm/kasan_init_64.c  | 52 +++++++++++++++++++++++++-----------
>  3 files changed, 44 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
> index 13e70da38bed..eaf624a758ed 100644
> --- a/arch/x86/include/asm/kasan.h
> +++ b/arch/x86/include/asm/kasan.h
> @@ -25,6 +25,12 @@
>
>  #ifndef __ASSEMBLY__
>
> +#ifdef CONFIG_KASAN_INLINE
> +void kasan_general_protection_hook(unsigned long addr);
> +#else
> +static inline void kasan_general_protection_hook(unsigned long addr) { }
> +#endif
> +
>  #ifdef CONFIG_KASAN
>  void __init kasan_early_init(void);
>  void __init kasan_init(void);
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 479cfc6e9507..e271a5a1ddd4 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -58,6 +58,7 @@
>  #include <asm/umip.h>
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
> +#include <asm/kasan.h>
>
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -544,6 +545,7 @@ static void print_kernel_gp_address(struct pt_regs *regs)
>                 return;
>
>         pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> +       kasan_general_protection_hook(addr_ref);
>  #endif
>  }
>
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index 296da58f3013..9ef099309489 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -246,20 +246,44 @@ static void __init kasan_map_early_shadow(pgd_t *pgd)
>  }
>
>  #ifdef CONFIG_KASAN_INLINE
> -static int kasan_die_handler(struct notifier_block *self,
> -                            unsigned long val,
> -                            void *data)
> +/*
> + * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
> + * canonical half of the address space) cause out-of-bounds shadow memory reads
> + * before the actual access. For addresses in the low canonical half of the
> + * address space, as well as most non-canonical addresses, that out-of-bounds
> + * shadow memory access lands in the non-canonical part of the address space,
> + * causing #GP to be thrown.
> + * Help the user figure out what the original bogus pointer was.
> + */
> +void kasan_general_protection_hook(unsigned long addr)
>  {
> -       if (val == DIE_GPF) {
> -               pr_emerg("CONFIG_KASAN_INLINE enabled\n");
> -               pr_emerg("GPF could be caused by NULL-ptr deref or user memory access\n");
> -       }
> -       return NOTIFY_OK;
> -}
> +       unsigned long orig_addr;
> +       const char *addr_type;
> +
> +       if (addr < KASAN_SHADOW_OFFSET)
> +               return;

Thinking how much sense it makes to compare addr with KASAN_SHADOW_END...
If the addr is > KASAN_SHADOW_END, we know it's not a KASAN access,
but do we ever get GP on canonical addresses?

>
> -static struct notifier_block kasan_die_notifier = {
> -       .notifier_call = kasan_die_handler,
> -};
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
> +               addr_type = "dereferencing kernel NULL pointer";
> +       else if (orig_addr < TASK_SIZE_MAX)
> +               addr_type = "probably dereferencing invalid pointer";

This is access to user memory, right? In outline mode we call it
"user-memory-access". We could say about "user" part here as well.

> +       else
> +               addr_type = "maybe dereferencing invalid pointer";
> +       pr_alert("%s in range [0x%016lx-0x%016lx]\n", addr_type,
> +                orig_addr, orig_addr + (1 << KASAN_SHADOW_SCALE_SHIFT) - 1);

"(1 << KASAN_SHADOW_SCALE_SHIFT) - 1)" part may be replaced with
KASAN_SHADOW_MASK.
Overall it can make sense to move this mm/kasan/report.c b/c we are
open-coding a number of things here (e.g. reverse address mapping). If
another arch will do the same, it will need all of this code too (?).

But in general I think it's a very good usability improvement for KASAN.

> +}
>  #endif
>
>  void __init kasan_early_init(void)
> @@ -298,10 +322,6 @@ void __init kasan_init(void)
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
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191112211002.128278-3-jannh%40google.com.
