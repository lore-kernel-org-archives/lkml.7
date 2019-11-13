Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ADEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2BF222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P58mPzYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfKMPTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:19:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37301 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKMPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:19:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so1877594pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 07:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAzyCDiMhQgDTvcJf/hx8upE6E8G92HV2i4vTyZKSjU=;
        b=P58mPzYU0tuHfAJmfQmwqHqTLpSW88BSMXX6Wz1tQiZriZPP7DiK4Cf8/c+DTmmglD
         yNbdfca4pwgdnGaGyDsfmlCKomUkVTrIDoSarblL33500ZPcaKk7lrezdH7+XUNPOBE3
         IWRACgkb/Wx2C0gb+gr1xx63xyxHvpnQ7/0k4pogt4sY1bSAREiDxFScFX8jlkynLfWm
         81Z05bc0oBbPvgE9a3zZoxqxIMAP478zkICEGzlKg6v8MzElOqusskn3lLW2GJURUbSp
         rEx/4ScaCU+Pjzy5p/kRR1no7iW90e0BJjeMdmuZpykqGWzkMwhCj20I+EFgBydvP/rf
         0DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAzyCDiMhQgDTvcJf/hx8upE6E8G92HV2i4vTyZKSjU=;
        b=bya0oG8P8jxlwetBZ21Fc6LCDdttPVN8VuvSg/a4r+auFj1DSLEhB/5nZCbzmuYeah
         D3EVg7xJ6iQvxjskUEGm6RK4jfGZv5H5loBW0nNNHHNCflFywH65xS+RewQqOLnJDY+Q
         VDuB00X1zxKgb6LzN4HTxlUYW/qYBqLpFCgjyLMj9t+BgfE+B0xtwn8XHzxYMhwZUwTe
         uaTVy5nan+4+yXd62jR/XS9Nqu7Ir9YM94PNKmPP0fXHaDFmxzfKE/If9J+knrRHLLu7
         zxC0EvPekQgblzDqOtIVbVbABsAV1Ps5zjsoQQKVijtGMJuxMD9SiEPTVWtLmUSyCQ8R
         izXg==
X-Gm-Message-State: APjAAAUCvZdDnQx/EuRV2i5vTk8WOGKbQ9Y/Wl4tCRg7B0N86vVSk0eG
        LzxsPHo5TPP0hCsNCoAQo2BIIgf7oRJcc8DfbqYCiw==
X-Google-Smtp-Source: APXvYqyjK3cl80QIVz/Bf5694+rHns4NS+Hsxwdlsvzzz3xBbPgmmxl+Y114q8hfOcarzqglmNkoCT0+bqi2iBxQ5/w=
X-Received: by 2002:aa7:9806:: with SMTP id e6mr5123522pfl.25.1573658352964;
 Wed, 13 Nov 2019 07:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20191112211002.128278-1-jannh@google.com> <20191112211002.128278-3-jannh@google.com>
 <CACT4Y+aojSsss3+Y2FB9Rw=OPxXgsFrGF0YiAJ9eo2wJM0ruWg@mail.gmail.com>
In-Reply-To: <CACT4Y+aojSsss3+Y2FB9Rw=OPxXgsFrGF0YiAJ9eo2wJM0ruWg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 13 Nov 2019 16:19:01 +0100
Message-ID: <CAAeHK+zy1dTvn-VSGYjoNKcp1jHS65ZAoM5M259T1_OE411WUg@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86/kasan: Print original address on #GP
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Nov 13, 2019 at 11:11 AM 'Dmitry Vyukov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Tue, Nov 12, 2019 at 10:10 PM 'Jann Horn' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Make #GP exceptions caused by out-of-bounds KASAN shadow accesses easier
> > to understand by computing the address of the original access and
> > printing that. More details are in the comments in the patch.
> >
> > This turns an error like this:
> >
> >     kasan: CONFIG_KASAN_INLINE enabled
> >     kasan: GPF could be caused by NULL-ptr deref or user memory access
> >     traps: dereferencing non-canonical address 0xe017577ddf75b7dd
> >     general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
> >
> > into this:
> >
> >     traps: dereferencing non-canonical address 0xe017577ddf75b7dd
> >     kasan: maybe dereferencing invalid pointer in range
> >             [0x00badbeefbadbee8-0x00badbeefbadbeef]
> >     general protection fault: 0000 [#3] PREEMPT SMP KASAN PTI
> >     [...]

Would it make sense to use the common "BUG: KASAN: <bug-type>" report
format here? Something like:

BUG: KASAN: invalid-ptr-deref in range ...

Otherwise this looks amazing, distinguishing NULL pointer accesses
from wild memory accesses is much more convenient with this. Thanks
Jann!

>
> Nice!
>
> +Andrey, do you see any issues for TAGS mode? Or, Jann, did you test
> it by any chance?

Hm, this looks like x86-specific change, so I don't think it
interferes with the TAGS mode.

>
>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/x86/include/asm/kasan.h |  6 +++++
> >  arch/x86/kernel/traps.c      |  2 ++
> >  arch/x86/mm/kasan_init_64.c  | 52 +++++++++++++++++++++++++-----------
> >  3 files changed, 44 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
> > index 13e70da38bed..eaf624a758ed 100644
> > --- a/arch/x86/include/asm/kasan.h
> > +++ b/arch/x86/include/asm/kasan.h
> > @@ -25,6 +25,12 @@
> >
> >  #ifndef __ASSEMBLY__
> >
> > +#ifdef CONFIG_KASAN_INLINE
> > +void kasan_general_protection_hook(unsigned long addr);
> > +#else
> > +static inline void kasan_general_protection_hook(unsigned long addr) { }
> > +#endif
> > +
> >  #ifdef CONFIG_KASAN
> >  void __init kasan_early_init(void);
> >  void __init kasan_init(void);
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 479cfc6e9507..e271a5a1ddd4 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -58,6 +58,7 @@
> >  #include <asm/umip.h>
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> > +#include <asm/kasan.h>
> >
> >  #ifdef CONFIG_X86_64
> >  #include <asm/x86_init.h>
> > @@ -544,6 +545,7 @@ static void print_kernel_gp_address(struct pt_regs *regs)
> >                 return;
> >
> >         pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> > +       kasan_general_protection_hook(addr_ref);
> >  #endif
> >  }
> >
> > diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> > index 296da58f3013..9ef099309489 100644
> > --- a/arch/x86/mm/kasan_init_64.c
> > +++ b/arch/x86/mm/kasan_init_64.c
> > @@ -246,20 +246,44 @@ static void __init kasan_map_early_shadow(pgd_t *pgd)
> >  }
> >
> >  #ifdef CONFIG_KASAN_INLINE
> > -static int kasan_die_handler(struct notifier_block *self,
> > -                            unsigned long val,
> > -                            void *data)
> > +/*
> > + * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
> > + * canonical half of the address space) cause out-of-bounds shadow memory reads
> > + * before the actual access. For addresses in the low canonical half of the
> > + * address space, as well as most non-canonical addresses, that out-of-bounds
> > + * shadow memory access lands in the non-canonical part of the address space,
> > + * causing #GP to be thrown.
> > + * Help the user figure out what the original bogus pointer was.
> > + */
> > +void kasan_general_protection_hook(unsigned long addr)
> >  {
> > -       if (val == DIE_GPF) {
> > -               pr_emerg("CONFIG_KASAN_INLINE enabled\n");
> > -               pr_emerg("GPF could be caused by NULL-ptr deref or user memory access\n");
> > -       }
> > -       return NOTIFY_OK;
> > -}
> > +       unsigned long orig_addr;
> > +       const char *addr_type;
> > +
> > +       if (addr < KASAN_SHADOW_OFFSET)
> > +               return;
>
> Thinking how much sense it makes to compare addr with KASAN_SHADOW_END...
> If the addr is > KASAN_SHADOW_END, we know it's not a KASAN access,
> but do we ever get GP on canonical addresses?
>
> >
> > -static struct notifier_block kasan_die_notifier = {
> > -       .notifier_call = kasan_die_handler,
> > -};
> > +       orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;
> > +       /*
> > +        * For faults near the shadow address for NULL, we can be fairly certain
> > +        * that this is a KASAN shadow memory access.
> > +        * For faults that correspond to shadow for low canonical addresses, we
> > +        * can still be pretty sure - that shadow region is a fairly narrow
> > +        * chunk of the non-canonical address space.
> > +        * But faults that look like shadow for non-canonical addresses are a
> > +        * really large chunk of the address space. In that case, we still
> > +        * print the decoded address, but make it clear that this is not
> > +        * necessarily what's actually going on.
> > +        */
> > +       if (orig_addr < PAGE_SIZE)
> > +               addr_type = "dereferencing kernel NULL pointer";
> > +       else if (orig_addr < TASK_SIZE_MAX)
> > +               addr_type = "probably dereferencing invalid pointer";
>
> This is access to user memory, right? In outline mode we call it
> "user-memory-access". We could say about "user" part here as well.

I think we should use the same naming scheme here as in
get_wild_bug_type(): null-ptr-deref, user-memory-access and
wild-memory-access.

>
> > +       else
> > +               addr_type = "maybe dereferencing invalid pointer";
> > +       pr_alert("%s in range [0x%016lx-0x%016lx]\n", addr_type,
> > +                orig_addr, orig_addr + (1 << KASAN_SHADOW_SCALE_SHIFT) - 1);
>
> "(1 << KASAN_SHADOW_SCALE_SHIFT) - 1)" part may be replaced with
> KASAN_SHADOW_MASK.
> Overall it can make sense to move this mm/kasan/report.c b/c we are
> open-coding a number of things here (e.g. reverse address mapping). If
> another arch will do the same, it will need all of this code too (?).
>
> But in general I think it's a very good usability improvement for KASAN.
>
> > +}
> >  #endif
> >
> >  void __init kasan_early_init(void)
> > @@ -298,10 +322,6 @@ void __init kasan_init(void)
> >         int i;
> >         void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
> >
> > -#ifdef CONFIG_KASAN_INLINE
> > -       register_die_notifier(&kasan_die_notifier);
> > -#endif
> > -
> >         memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
> >
> >         /*
> > --
> > 2.24.0.432.g9d3f5f5b63-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191112211002.128278-3-jannh%40google.com.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CACT4Y%2BaojSsss3%2BY2FB9Rw%3DOPxXgsFrGF0YiAJ9eo2wJM0ruWg%40mail.gmail.com.
