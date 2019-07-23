Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D35DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B26223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRAh43Dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390890AbfGWQtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:49:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35844 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfGWQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:49:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id r6so44727330oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/ukJIx+SOx9JE2DP2ABaOJWk92MtaCXggShecwUP5o=;
        b=XRAh43DhYHr6hqbYWH2TPLCxkWTRBuf0im761f4sciXdQQBq28WEAawzlWsQmVK5xY
         jalcZFxUeB96wU0xx5DAAjnvu2wLtNWupPF+ahljpX5MoAtBMzXth62D85W/XjbEanon
         1watVi0MXu7uKcu7u4yPN/cKECawgxtLOuRc6OlzaFMbSw02IgdGAERs5y8tTbhQJCIh
         UBS5oFzobf4oV0e4kW5cFqkS2xe5hPjmOMHdLBLFNBovKrLA7klqMYw+Cvnr69RCCT5A
         Zxtonyc4GZVbfl9/dPaq8hVc2zeC6J8aIEWNoyCNKJFm14i3cMEt5Wx2bUqGLn8iFtaY
         02sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/ukJIx+SOx9JE2DP2ABaOJWk92MtaCXggShecwUP5o=;
        b=B4ShOeSHJlJV9RVHf2BxsGhtlmjV8LOknoStdD3s+DBoZ356i5A1FYuGctgyH0ZgsS
         yPGzIdPujxTxFQzQGZnWdPOKrPvrLmo6nUPV+E9RtiVWDzNxCF/fJHRdJLrQnt/1ThuB
         BEHwmIQMFiufxa9MkNhx/HpA5yQueZ7SwcNJCfKcdcLRCtJoVBIhIoYAUt5BnmyYOR0R
         IPngcmwiIRk0AHmumIX/VSn6qlD7etmmp+jV23pwZ4gT3zL+W4+ff7ZkhodH4ytDzQSy
         zmse16eGZIVIYQuuj6gT4VsfJfyeBLcZvwyRmcYb+GOEiYJaS3klP89DBP2s10Sk4HML
         5Cdw==
X-Gm-Message-State: APjAAAUPevMcNIbtfO/BlMMx8ObGsZJap93a5zQnic55K1UWzNWay3T+
        MheqjXyrdbOT8ton5qyh9LT8PSy0fSMpC3G3X1Agug==
X-Google-Smtp-Source: APXvYqw+HuUPJV0ODoUb07iAqyJpAxk8VEJtXY+c/SjCdkA/Vcw7bhcNo9in2KX18dXcdv+P2URlJfEcMVeDfAYpyJY=
X-Received: by 2002:a9d:560f:: with SMTP id e15mr22483518oti.251.1563900554830;
 Tue, 23 Jul 2019 09:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190719132818.40258-1-elver@google.com> <20190719132818.40258-2-elver@google.com>
 <20190723162403.GA56959@lakrids.cambridge.arm.com>
In-Reply-To: <20190723162403.GA56959@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Jul 2019 18:49:03 +0200
Message-ID: <CANpmjNPBNUQXoPUNw46=iieH3SS1Pk8PxNvQ1FPdNCoU4g8F2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/test_kasan: Add stack overflow test
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 at 18:24, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Jul 19, 2019 at 03:28:18PM +0200, Marco Elver wrote:
> > Adds a simple stack overflow test, to check the error being reported on
> > an overflow. Without CONFIG_STACK_GUARD_PAGE, the result is typically
> > some seemingly unrelated KASAN error message due to accessing random
> > other memory.
>
> Can't we use the LKDTM_EXHAUST_STACK case to check this?
>
> I was also under the impression that the other KASAN self-tests weren't
> fatal, and IIUC this will kill the kernel.
>
> Given that, and given this is testing non-KASAN functionality, I'm not
> sure it makes sense to bundle this with the KASAN tests.

Thanks for pointing out LKDTM_EXHAUST_STACK.

This patch can be dropped!

-- Marco

> Thanks,
> Mark.
>
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Andrey Konovalov <andreyknvl@google.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kasan-dev@googlegroups.com
> > ---
> >  lib/test_kasan.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index b63b367a94e8..3092ec01189d 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/mman.h>
> >  #include <linux/module.h>
> >  #include <linux/printk.h>
> > +#include <linux/sched/task_stack.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/uaccess.h>
> > @@ -709,6 +710,32 @@ static noinline void __init kmalloc_double_kzfree(void)
> >       kzfree(ptr);
> >  }
> >
> > +#ifdef CONFIG_STACK_GUARD_PAGE
> > +static noinline void __init stack_overflow_via_recursion(void)
> > +{
> > +     volatile int n = 512;
> > +
> > +     BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROWSUP));
> > +
> > +     /* About to overflow: overflow via alloca'd array and try to write. */
> > +     if (!object_is_on_stack((void *)&n - n)) {
> > +             volatile char overflow[n];
> > +
> > +             overflow[0] = overflow[0];
> > +             return;
> > +     }
> > +
> > +     stack_overflow_via_recursion();
> > +}
> > +
> > +static noinline void __init kasan_stack_overflow(void)
> > +{
> > +     pr_info("stack overflow begin\n");
> > +     stack_overflow_via_recursion();
> > +     pr_info("stack overflow end\n");
> > +}
> > +#endif
> > +
> >  static int __init kmalloc_tests_init(void)
> >  {
> >       /*
> > @@ -753,6 +780,15 @@ static int __init kmalloc_tests_init(void)
> >       kasan_bitops();
> >       kmalloc_double_kzfree();
> >
> > +#ifdef CONFIG_STACK_GUARD_PAGE
> > +     /*
> > +      * Only test with CONFIG_STACK_GUARD_PAGE, as without we get other
> > +      * random KASAN violations, due to accessing other random memory (we
> > +      * want to avoid actually corrupting memory in these tests).
> > +      */
> > +     kasan_stack_overflow();
> > +#endif
> > +
> >       kasan_restore_multi_shot(multishot);
> >
> >       return -EAGAIN;
> > --
> > 2.22.0.657.g960e92d24f-goog
> >
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190723162403.GA56959%40lakrids.cambridge.arm.com.
