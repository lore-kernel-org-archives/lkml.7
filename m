Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888C0204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYeqadys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfB1SS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:18:28 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42284 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfB1SS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:18:27 -0500
Received: by mail-io1-f66.google.com with SMTP id p196so17337785iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNjyTGLWpJhvDkSOBHdamT+FiXsZ0U7UYZBWfGGXYnk=;
        b=HYeqadysk7inOxlZnb+K6K6ZOoDlNyLLaC+XVpyK9m0VtbW8XZfb3IeavTCSrD5s/z
         pD1sWotbpvGz1p1vRlMYHVBOFeXAoWnWdmbSAvaw3Pl4qOMmbsDAlEklTBTpedxRdvz8
         AE+eUkZNiBqqnI4QY5ok0b6vkuNtPM66XmMf0otQ4cqMEtBlFvdKO4PH4rJcNNhsBqZX
         i0q2gDs59OcG2xChk8pogLs6Udty5N5W8Mgv3qVJH5g2s6H80cVxnXdufu7X6Miu/Ayo
         zfuAgaXj70LgUsKdLT1ff6x12zUTPtcqm5v2gB7ZEUbjO3kq/ZhKUxk0IHu4PNftInj0
         3Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNjyTGLWpJhvDkSOBHdamT+FiXsZ0U7UYZBWfGGXYnk=;
        b=oxjDsDSq24w+g6fiNoIcj5N8P0dIORVMWtdpD1r6Hh6wB3xV0WE3YrkwiTp21Hgqv3
         IeCMqM5/QLz3byBzhht6br8568y/9nE89qRLZnYbCP2HFyKLPugWW8+1zScOWwW4mefO
         jhyrPD5XLbU9SOUlvKfPaULAalTP2HywxrulAfHWncic9S/BfJtoJTCp4nTzfRINDFCh
         uTPQRkWKPyglyF/WsaJgOCWrz5D/zQKSEd+bPcrwfCwKqz3AEXyY4rQrk83b/a3KYZRe
         9W7WKGDy+vl1awQgsyAX9QnKlJtFiXjpxtKoHvEPfsboHj+aOpDd/YHPn5WVtZi8/7sW
         i1Lg==
X-Gm-Message-State: APjAAAVM0rrpMdd/chuFXvgbqo+L6PayOPXO47nzUebjcsgu1qqMtZov
        ehvdSAlNa5crOtzGwDesH4f3AbG/c0kavN7C/hQ8pA==
X-Google-Smtp-Source: APXvYqyxa8etlVSk99qsIwryrCZtVGYlpRngpmqivhZKlBsQZK/iIac7c6CFW3AfSiYqokrNTfF52XHxMurpRCzw93M=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr364392ioc.282.1551377906193;
 Thu, 28 Feb 2019 10:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190228154551.GE32494@hirez.programming.kicks-ass.net> <CACT4Y+ZJpDtHdF-NTy9RrhoOPMtko6VeXwkgR1yjFa5VFfGysQ@mail.gmail.com>
 <20190228174605.GF32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190228174605.GF32494@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 19:18:15 +0100
Message-ID: <CACT4Y+ZYnji8B5Hx9orRQ3Z35ySrV3cVj8VV+1xx+77vR8F1fg@mail.gmail.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 6:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 28, 2019 at 05:03:09PM +0100, Dmitry Vyukov wrote:
>
> > I am missing some knowledge about SMAP to answer this.
> > In short, these tools insert lots of callbacks into runtime for memory
> > accesses, function entry/exit, atomicops and some other. These
> > callbacks can do things of different complexity.
> > Humm... perhaps we could just disable SMAP for KMSAN/KTSAN. It's
> > possible, right? If we have it enabled with KASAN, that should be
> > enough.
>
> SMAP detects access to _PAGE_USER pages; that is, such access is only
> allowed when EFLAGS.AC=1, otherwise they'll fault.
>
> I again don't know enough about KASAN to say if it does that; but I
> suspect it only tracks kernel memory state.
>
> > Also, what's the actual problem with KASAN+SMAP? Is it warnings from
> > static analysis tool? Or there are also some runtime effects? What
> > effects?
>
> Both; so because of the above semantics, things like copy_to_user() will
> have to do STAC (set EFLAGS.AC=1), then do the actual copies to the user
> addresses, and then CLAC (clear the AC flag again).
>
> The desire is to have AC=1 sections as small as possible, such that as
> much code as possible is ran with AC=0 and will trap on unintended
> accesses.
>
> Also; the scheduler doesn't (but I have a patch for that, but I'd prefer
> to not have to use it) context switch EFLAGS. This means that if we land
> in the scheduler while AC=1, the next task will resume with AC=1.
>
> Consequently, if that task returns to userspace before it gets scheduled
> again, we'll continue our previous task (that left with AC=1) with AC=0
> and it'll then fault where no fault were expected.
>
> Anyway; the objtool annotation basically tracks the EFLAGS.AC state
> (through STAC/CLAC instructions -- no PUSHF/POPF) and disallows any
> CALL/RET while AC=1.
>
> This is where the __asan_{load,store}*() stuff went *splat*. GCC inserts
> those calls in the middle of STAC/CLAC (AC=1) and we then have to mark
> the functions as AC-safe. objtool validates those on the same rules, no
> further CALLs that are not also safe.
>
> Things like __fentry__ are inherently unsafe because they use
> preempt_disable/preempt_enable, where the latter has a CALL
> __preempt_schedule (and is thus very unsafe). Similarly with
> kasan_report(), it does all sorts of things that are not safe to do.
>
> > Is it possible to disable the SMAP runtime checks once we enter
> > kasan_report() past report_enabled() check? We could restrict it to
> > "just finish printing this bug report whatever it takes and then
> > whatever" if it makes things simpler.
> > It would be nice if we could restrict it to something like:
> >
> > @@ -291,6 +303,7 @@ void kasan_report(unsigned long addr, size_t size,
> >         if (likely(!report_enabled()))
> >                 return;
> > +       disable_smap();
> >
> > And then enforce panic at the end of report if smap is enabled.
>
> That would be a CLAC, and the current rules disallow CLAC for AC-safe
> functions.
>
> Furthermore, kasan_report() isn't fatal, right? So it would have to
> restore the state on exit. That makes the validation state much more
> complicated.
>
> Let me try and frob some of the report_enabled() stuff before the #UD.

What if do CLAC in the beginning of kasan_report, STAC at the end if
AC was set on entry. And then special-case kasan_report in the static
tool? This looks like a reasonable compromise to me taking into
account that KASAN is not enabled in production builds, so special
casing it in the static tool won't lead to missed bugs in production
code. That's effectively what _BUG_FLAGS will do, right? But just
without involving asm.
Or, perhaps, wrap it into something like:
void smap_call(void (*fn)(void* ctx), void *ctx);
that will do all of this. And then the tool only needs to know about
the smap_call?
