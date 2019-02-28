Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC556C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFFD218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rG/GoMIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbfB1Pwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:52:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42313 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfB1Pwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:52:42 -0500
Received: by mail-io1-f66.google.com with SMTP id p196so16916825iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYyPko4AxKOeDIPbp9vSMZUva/IbD2ByQTR5cjvOOtI=;
        b=rG/GoMICy2VMUrI80P8opVeTZOl0ugNF8VySTwo1xrkva9OBPAgTjPSyswzDakxaV3
         lAIig1rfV17tDkqi3aCHyso8xIj78GYm5TN97p5yn8QLQW6sYdKmF787okwT4ENrqAOg
         n7PHd3CCVFJ+8bt4S1RCNZ0qOiieTiIYUgenpXwEQqQRStd4GoOi6f7jXJq80WEfSVTx
         hmdPLkxoXfNFOL39BaDlLjdInCEvwr7OE8woJbJfoizNAOvaI6i4DZsRa/BN3U9XE781
         +KSguAqEqoOsWiNSrxpnoYvSf2LxFFOTISqV0mVsU75yh7T/e4OQ5+8lxbQ5AV6KdbbY
         iJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYyPko4AxKOeDIPbp9vSMZUva/IbD2ByQTR5cjvOOtI=;
        b=K5ZEHdt5ZGPQOZJRvDicCbzGkRcPFWL5DURAWHcRw1ti81jBIa+6OKy1s8KiwG4ika
         EZrBH5atdYqA3R0F/ecbPXfqgTZIH3+q0uEVJx9uAcbiQxGNLPYNwkVSaUwTOixdoUYO
         vcs1+w/C+Q2QagVTdQoUe/sMm0EzzN8greoH0WG7QcDX4a/vzm4Xl2jwYAzZxols26v0
         a6Oe1PTv3zxro2Q6d5xLxmxURijVmvHUnMqRYhUXXlIzA39ZvklrO6wAyQBaZD/j5FyX
         z34oEKOu6A9TBiAV7HPtf91PJSBoJpa3sPTkcpVjeeTlC2PxZE8WSxSrtQPzmhaG8W/O
         F90Q==
X-Gm-Message-State: APjAAAWZOJm5qtaeZA1wBV0qc5IIAv2S4/fBrhe4UO05RMg4Yt45BBPi
        iy3Z3n7znysFhGF6mKotQaRStRZZlAK7qfdprvem8A==
X-Google-Smtp-Source: APXvYqy2uAR3JPlQHCl7FID2HcVS9qROOkuWOZsinBKVLbXXQaanIpPZtHsZ5CrUNI4nUnCMi+/rolt3cE+/DqF3+mw=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr4861626ioc.282.1551369161333;
 Thu, 28 Feb 2019 07:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com> <20190228154551.GE32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190228154551.GE32494@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Feb 2019 16:52:30 +0100
Message-ID: <CACT4Y+aEx5-8g-YDoK37gtntCxy8_8sSWdG7FeU+fc=B3C3axA@mail.gmail.com>
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

One thing is that during early boot kasan_report is called multiple
times, but these are false positives related to the fact that we don't
have a proper shadow yet (setup later). So during early boot we set
kasan_disable=1 (or some global or per-task flag), and then
kasan_report checks it and returns.
Once we setup proper shadow, the flag is reset and from now on
kasan_report actually reports bug.


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
>
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
