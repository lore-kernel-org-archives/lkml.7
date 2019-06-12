Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD418C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B317521019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqyGGNem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfFLOMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:12:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46890 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbfFLOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:12:54 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so13034847iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fXeSKZUU3yYcblyjjUr+PT/LFbKmVa2WZrUUbFVZZ0=;
        b=RqyGGNemS8/TLIB5Dxl8WKbnhdoc9LMeuNFDMIXpzQjCM/HDctfvLF5YywpxKCA/Ig
         7yPInDXKSM+OBgqGqsVrQpGGSMEQJnBZzRWTeXWniVKBg7SCoM2gvK6O3d0P8Rg8Knn+
         7kPR7R8/O8zpOPULyC4Ksbu0LYVjAmgEBBVgfE++N7YLTYojHXFhqZ0vW6rhH6pMWPEh
         znEfqS3UxP9YqmjVyDU0ZSD9qVP5VjHuDoMiJyK4TV0iN4rGvAIFGHXw8tdLPBeeAWW2
         UoTRDFKFZJo64q4YbPRkTQD0aMhiZQZ2yxkHKkLHVCVoyrmFLNaqdcqQ0dSaWHA8CBfu
         d5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fXeSKZUU3yYcblyjjUr+PT/LFbKmVa2WZrUUbFVZZ0=;
        b=NJxg6U+lAMvliauM7M2hwaVHA9bjQKf54EOZ0+IImcf/P6UUzrb5VFZd1k4Kl7l8Ae
         a3MBnKQdI0Jabd7oWmxqL2BF9L76zKRPE4Kt6xGNIoLHzF52RhqN7Q1woaj47l1scA7e
         tn1DjNvkgcgJRod6wsR5+SLBrhl0Az09vLVcVtw1mCTSpZDcqI5i6FGPCvmy+XLSDfSV
         6cxc92JitZr9XgtFdhUCWiE8P806glrL1/TkIFq44z8dlrmLF2TiWjxAIQP13gh+Evxl
         cJQHk2vGShfJMZIcGccTFf/MyL2askNLsNAsgOBs6UoA56bAyonKcDyxdFNAwApNGtTU
         /gCg==
X-Gm-Message-State: APjAAAW61JlssORPbjfhglwwSKfnL6eLmjGEI7mj7h6EXhK3WW+Q7t5b
        TM1BSAO/kbYX+DBnem/UZaZgF7/kLg/yFaEBPKOlKg==
X-Google-Smtp-Source: APXvYqwkiG/FnYs/yUolUcw3GIjfphJ0LlTz9nHHhg4BtY4TBFOFyCbFjrLUlM9TyKIfKg7WWD3xL1yeGraiKF5DRHU=
X-Received: by 2002:a6b:641a:: with SMTP id t26mr7794304iog.3.1560348773474;
 Wed, 12 Jun 2019 07:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190531150828.157832-1-elver@google.com> <20190531150828.157832-3-elver@google.com>
 <CANpmjNP_-J5dZVtDeHUeDk2TBBkOgoPvGKq42Qd7rezbnFWNGg@mail.gmail.com>
In-Reply-To: <CANpmjNP_-J5dZVtDeHUeDk2TBBkOgoPvGKq42Qd7rezbnFWNGg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Jun 2019 16:12:29 +0200
Message-ID: <CACT4Y+a0H0NiMmydmw1qOA=zUXDmBZXHmh6-fp9nU0UtAPZvxQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86: Use static_cpu_has in uaccess region to avoid instrumentation
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 11:44 AM Marco Elver <elver@google.com> wrote:
>
> Gentle ping.  I would appreciate quick feedback if this approach is reasonable.
>
> Peter: since you suggested that we should not change objtool, did you
> have a particular approach in mind that is maybe different from v2 and
> v3? Or is this what you were thinking of?
>
> Many thanks!
>
> On Fri, 31 May 2019 at 17:11, Marco Elver <elver@google.com> wrote:
> >
> > This patch is a pre-requisite for enabling KASAN bitops instrumentation;
> > using static_cpu_has instead of boot_cpu_has avoids instrumentation of
> > test_bit inside the uaccess region. With instrumentation, the KASAN
> > check would otherwise be flagged by objtool.
> >
> > For consistency, kernel/signal.c was changed to mirror this change,
> > however, is never instrumented with KASAN (currently unsupported under
> > x86 32bit).
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Suggested-by: H. Peter Anvin <hpa@zytor.com>
> > ---
> > Changes in v3:
> > * Use static_cpu_has instead of moving boot_cpu_has outside uaccess
> >   region.
> >
> > Changes in v2:
> > * Replaces patch: 'tools/objtool: add kasan_check_* to uaccess
> >   whitelist'
> > ---
> >  arch/x86/ia32/ia32_signal.c | 2 +-
> >  arch/x86/kernel/signal.c    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> > index 629d1ee05599..1cee10091b9f 100644
> > --- a/arch/x86/ia32/ia32_signal.c
> > +++ b/arch/x86/ia32/ia32_signal.c
> > @@ -358,7 +358,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
> >                 put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
> >
> >                 /* Create the ucontext.  */
> > -               if (boot_cpu_has(X86_FEATURE_XSAVE))
> > +               if (static_cpu_has(X86_FEATURE_XSAVE))


Peter Z or A, does it look good to you? Could you please Ack this?


> >                         put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
> >                 else
> >                         put_user_ex(0, &frame->uc.uc_flags);
> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > index 364813cea647..52eb1d551aed 100644
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> >                 put_user_ex(&frame->uc, &frame->puc);
> >
> >                 /* Create the ucontext.  */
> > -               if (boot_cpu_has(X86_FEATURE_XSAVE))
> > +               if (static_cpu_has(X86_FEATURE_XSAVE))
> >                         put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
> >                 else
> >                         put_user_ex(0, &frame->uc.uc_flags);
> > --
> > 2.22.0.rc1.257.g3120a18244-goog
> >
