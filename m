Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EA6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1872D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qcXNzlf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405869AbfIJKSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:18:01 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:54769 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfIJKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:18:00 -0400
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x8AAHubj009939
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 19:17:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x8AAHubj009939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568110677;
        bh=yIKQfh97GgxHjqDfeFwoaAFGiMM6pmiH8tsXc3yeVNw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qcXNzlf0KcUbgOr3KW95A3rcl0cUA+VpAOeAMVZzYVAUb/lSyUpg84Xk0PZCcQ/L8
         1i1yxRELBst0CCKtXFJog61y3lndYOyJcp+RZsiBeK6p9FPi5DAIUDmSKs0EH6Mkqr
         T0jjlnf9qUUCsbMRa5n+HsgxeqG6zH+tGJzGbeyPZhpXrX9hRqzRneUWzwkWuw6gdW
         HPT+y5fo15tbWvu78wWNJ8G+4SLDhxu5orDsd5iQlWX1FLT5QudK5u/sGXXcuimz3Q
         eAH8eplTtqkBY5FVXUlYFAbka7cSVnwKP6RBTBtAhQWSJ3mj0o7mE7QS9ic+yb0LmG
         cFR92SJOcZOPg==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id s28so1620863vkm.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:17:56 -0700 (PDT)
X-Gm-Message-State: APjAAAXO6XDHjwDR5JkDz1vRazzk+AUKOu9GVuueq4XXQXZpRXdl4HMT
        DflUU8x5uI+m1KOH5mzkecGD1Ql5NWmyP4U/SFA=
X-Google-Smtp-Source: APXvYqy/cswSnc8WfFFL71roXbz40cEs77mBG+d9RGmyXNZx/2NEp/U4gXNVKHOOAIEYpjdCWmMQjdyo+yofpY8FAww=
X-Received: by 2002:a1f:60c2:: with SMTP id u185mr1443841vkb.0.1568110675632;
 Tue, 10 Sep 2019 03:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190909202153.144970-1-arnd@arndb.de> <20190910092324.GI9720@e119886-lin.cambridge.arm.com>
 <CAK8P3a2Vk+KSUGJyPTRuLPD=KPEAR43SZ1ofB6k+KeQi3fSERw@mail.gmail.com>
In-Reply-To: <CAK8P3a2Vk+KSUGJyPTRuLPD=KPEAR43SZ1ofB6k+KeQi3fSERw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 10 Sep 2019 19:17:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbjPhDqN9ZeC_qnxzMAhPdrSpG4te0HmRrnxuuM6bquw@mail.gmail.com>
Message-ID: <CAK7LNAQbjPhDqN9ZeC_qnxzMAhPdrSpG4te0HmRrnxuuM6bquw@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 6:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 10, 2019 at 11:23 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> >
> > >  arch/arm64/include/asm/cmpxchg.h | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > > index a1398f2f9994..fd64dc8a235f 100644
> > > --- a/arch/arm64/include/asm/cmpxchg.h
> > > +++ b/arch/arm64/include/asm/cmpxchg.h
> > > @@ -19,7 +19,7 @@
> > >   * acquire+release for the latter.
> > >   */
> > >  #define __XCHG_CASE(w, sfx, name, sz, mb, nop_lse, acq, acq_lse, rel, cl)    \
> > > -static inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)              \
> > > +static __always_inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)\
> >
> > This hunk isn't needed, there is no BUILD_BUG here.
>
> Right, I noticed this, but it seemed like a good idea regardless given the small
> size of the function compared with the overhead of a function call.  We clearly
> want these to be inlined all the time.


Generally speaking, this should be judged by the compiler, not by humans.
If the function size is quite small compared with the cost of function call,
the compiler will determine to inline it anyway.
(If the compiler's inlining heuristic is not good, we should fix the compiler.)

So, I personally agree with Andrew Murray.
We should use __always_inline only when we must to do so.

Masahiro Yamada



>
> Same for the others.
>
> > Alternatively is it possible to replace the BUILD_BUG's with something else?
> >
> > I think because we use BUILD_BUG at the end of a switch statement, we make
> > the assumption that size is known at compile time, for this reason we should
> > ensure the function containing the BUILD_BUG is __always_inline.
> >
> > Looking across the kernel where BUILD_BUG is used as a default in a switch
> > statment ($ git grep -B 3 BUILD_BUG\( | grep default), most instances are
> > within macros, but many are found in an __always_inline function:
> >
> > arch/x86/kvm/cpuid.h
> > mm/kasan/generic.c
> >
> > Though some are not:
> >
> > include/linux/signal.h
> > arch/arm64/include/asm/arm_dsu/pmu.h
> >
> > I wonder if there may be a latent mole ready to whack with pmu.h?
>
> Right, it can't hurt to annotate those as well. I actually have another
> fixup for linux/signal.h that I would have to revisit at some point.
> See https://bugs.llvm.org/show_bug.cgi?id=38789, I think this is
> fixed with clang-9 now, but maybe not with clang-8.
>
>       Arnd



-- 
Best Regards
Masahiro Yamada
