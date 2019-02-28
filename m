Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F842C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F931218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXgtx3U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbfB1QDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:03:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38569 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732055AbfB1QDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:03:22 -0500
Received: by mail-io1-f65.google.com with SMTP id p18so16999447ioh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afP0OSLujlXEtZlPgxmf6aQ95qZeaRGDn7fdDvSNW5k=;
        b=pXgtx3U1Himv32yI2M1GwnBCwYLER+zIY5da95OA3Y9dT3Ejedt+4LnsIEm9AoHgYq
         cul54uNZcqwn/gFEPdlW9O05QICPkOT2cmV2qxHfQvn8tPz/TI9pHvZ9txauwaaJHR2b
         FYLGqZX0wj8CNhyvoU1IoDACHI4yfE/9aSC1xAw8eRLae/H9Fa86AhLsscxRekfLIS7H
         UchFGXcDI6NVz8kvkHqfsuQewu4qR1CWSvKkm7UEEkH5BlBR54N+0YE7YWQTqAT2QSUk
         c9Qoa79y3hYO/ouMokWhHmCWXcWIGp2awHFwpFtiFMD1CI/Y6vcpDnM7GyQxG9g2ZUN5
         NsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afP0OSLujlXEtZlPgxmf6aQ95qZeaRGDn7fdDvSNW5k=;
        b=V0BjdQ1o8DKfLohsM1ezWWaCGi4THn2JqXJvMlvPJ4XK9Fa9OAH07GpGrxY6Su2WYl
         9aqpavZ4T6LM5eTmgNDDy0E0JlgUn0iBGFz3nsByfy544tPiPtU0AMRFALQKXPeValkK
         iwkufx8vVkRPy3A6jvKMstrE6ac0gpDOBUlQPY6IuMN2K+d138Eemu8nsKxarClWwbjA
         ZNO2ZD5BkYylBM6n/UudzE6iC/QoMwV2MRjmcUXrTD/bpjSmwhqfz/YrF2Ba51Tui0j2
         OnFLlpZSrG1pA0OQkt48qUWTG9RGZ6+aAhzBFthwCyFnGtColQ3LhPyLQHXlB6UkpUeX
         pGEA==
X-Gm-Message-State: APjAAAV3O9kA1NFESqOpuZ9riG9zZOJrvAdiRnpkV47Y3QKwBrxLo3Un
        2GCbhEgLS/HPaJwcepr6+ViI083lHCOdSAi0T60uGA==
X-Google-Smtp-Source: APXvYqzV61wSOYqaAYMv5qpjdeVZBBDnLlPf2oSBuKHaY8YdtRUPVzwXClvXztamROu5450LRzFjfXgxMygckjqtyBs=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr5292642ior.271.1551369800508;
 Thu, 28 Feb 2019 08:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com> <20190228154551.GE32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190228154551.GE32494@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 17:03:09 +0100
Message-ID: <CACT4Y+ZJpDtHdF-NTy9RrhoOPMtko6VeXwkgR1yjFa5VFfGysQ@mail.gmail.com>
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

On Thu, Feb 28, 2019 at 4:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 28, 2019 at 04:22:04PM +0100, Dmitry Vyukov wrote:
> > On Thu, Feb 28, 2019 at 4:05 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Because __asan_{load,store}{N,1,2,4,8,16}_noabort() get called from
> > > UACCESS context, and kasan_report() is most definitely _NOT_ safe to
> > > be called from there, move it into an exception much like BUG/WARN.
> > >
> > > *compile tested only*
> >
> >
> > Please test it by booting KASAN kernel and then loading module
> > produced by CONFIG_TEST_KASAN=y. There are too many subtle aspects to
> > rely on "compile tested only", reviewers can't catch all of them
> > either.
>
> Sure, I'll do that. I just wanted to share the rest of the patches.
>
> A quick test shows it dies _REAAAAAAAALY_ early, as in:
>
> "Booting the kernel."
>
> is the first and very last thing it says... I wonder how I did that :-)
>
> > > +static __always_inline void
> > > +kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> > > +{
> > > +       unsigned long rdi = addr, rsi = size, rdx = is_write, rcx = ip;
> > > +
> > > +       _BUG_FLAGS(ASM_UD2, BUGFLAG_KASAN,
> > > +                  "D" (rdi), "S" (rsi), "d" (rdx), "c" (rcx));
> >
> > Can BUG return?
>
> Yes. Also see the annotate_reachable().
>
> > This should be able to return.
> > We also have other tools coming (KMSAN/KTSAN) where distinction
> > between fast path that does nothing and slower-paths are very blurred
> > and there are dozens of them, I don't think this BUG thunk will be
> > sustainable. What does BUG do what a normal call can't do?
>
> It keeps the SMAP validation rules nice and tight. If we were to add
> (and allow) things like pushf;clac;call ponies;popf or similar things,
> it all becomes complicated real quick.
>
> How would KMSAN/KTSAN interact with SMAP ?


I am missing some knowledge about SMAP to answer this.
In short, these tools insert lots of callbacks into runtime for memory
accesses, function entry/exit, atomicops and some other. These
callbacks can do things of different complexity.
Humm... perhaps we could just disable SMAP for KMSAN/KTSAN. It's
possible, right? If we have it enabled with KASAN, that should be
enough.

And the question from another thread: does SMAP detect bugs that KASAN
can't? If SMAP is not useful during stress testing/fuzzing, then we
could also disable it. But if it finds some bugs that KASAN won't
detect, then it would be pity to disable it.

Also, what's the actual problem with KASAN+SMAP? Is it warnings from
static analysis tool? Or there are also some runtime effects? What
effects?
Is it possible to disable the SMAP runtime checks once we enter
kasan_report() past report_enabled() check? We could restrict it to
"just finish printing this bug report whatever it takes and then
whatever" if it makes things simpler.
It would be nice if we could restrict it to something like:

@@ -291,6 +303,7 @@ void kasan_report(unsigned long addr, size_t size,
        if (likely(!report_enabled()))
                return;
+       disable_smap();

And then enforce panic at the end of report if smap is enabled.


> > > +       annotate_reachable();
> > > +}
> > > @@ -228,7 +228,7 @@ void __asan_unregister_globals(struct ka
> > >  EXPORT_SYMBOL(__asan_unregister_globals);
> > >
> > >  #define DEFINE_ASAN_LOAD_STORE(size)                                   \
> > > -       void __asan_load##size(unsigned long addr)                      \
> > > +       notrace void __asan_load##size(unsigned long addr)              \
> >
> >
> > We already have:
> > CFLAGS_REMOVE_generic.o = -pg
> > Doesn't it imply notrace for all functions?
>
> Indeed so, I'll make these hunks go away.
