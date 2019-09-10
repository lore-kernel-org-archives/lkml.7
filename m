Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC4EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C69D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390244AbfIJJiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:38:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45745 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbfIJJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:38:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so16218660qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BZdQMWt/4gR8KdMEOxeANPATM7+OW7WAKZb9Cg8SzQ=;
        b=Z7OGTfQ+LxfKSKU1UavhwtLfodbyShLBUYk+90kGieOQGxSx4WXoI6Re5bs5qOJszO
         Q3fmX6sF5IU3PaJSQPIfvRsqLWAsOTT+56R7pFvZAJIedd+RmHaY8tVBBswgn28vslGQ
         ONGRm6mnVlnI57cOsfg9Wm1+tv6hdp5eA+XOIMo0Sud61gvbg4QMxQoGID2ehkMkI/UE
         t0zplJqCMhv+3xln0xJEndrT6acUNe7v6nVwDbKtfihC3OwpQLv8d3ql3iFOSfGzEP3D
         ZG+pyZFwVdI0PQbp7ntkfkwVqTdvQOtfgpJ2p3JEAt67Nv1YHGDX/cNbQ/v0AZWTFS8U
         NpLQ==
X-Gm-Message-State: APjAAAUldd7oYZ/fHgwUdLRyyBiYDSaU3HiMUbMkERqKlqWvpj0ObSQd
        J5DpJATxq6QGUh1HZOvuzwsV2DoIUTCK7T0eI00=
X-Google-Smtp-Source: APXvYqygubpVqiS/wSXVGWFNayc7m09LJvYEQNsdOSnjyL1XZ4yHTZgAN89jOwGLzB/ZJAVK3JgfKGVy21wh0HHzwvc=
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr7667748qkg.3.1568108334116;
 Tue, 10 Sep 2019 02:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190909202153.144970-1-arnd@arndb.de> <20190910092324.GI9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190910092324.GI9720@e119886-lin.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Sep 2019 11:38:37 +0200
Message-ID: <CAK8P3a2Vk+KSUGJyPTRuLPD=KPEAR43SZ1ofB6k+KeQi3fSERw@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

On Tue, Sep 10, 2019 at 11:23 AM Andrew Murray <andrew.murray@arm.com> wrote:

>
> >  arch/arm64/include/asm/cmpxchg.h | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > index a1398f2f9994..fd64dc8a235f 100644
> > --- a/arch/arm64/include/asm/cmpxchg.h
> > +++ b/arch/arm64/include/asm/cmpxchg.h
> > @@ -19,7 +19,7 @@
> >   * acquire+release for the latter.
> >   */
> >  #define __XCHG_CASE(w, sfx, name, sz, mb, nop_lse, acq, acq_lse, rel, cl)    \
> > -static inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)              \
> > +static __always_inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)\
>
> This hunk isn't needed, there is no BUILD_BUG here.

Right, I noticed this, but it seemed like a good idea regardless given the small
size of the function compared with the overhead of a function call.  We clearly
want these to be inlined all the time.

Same for the others.

> Alternatively is it possible to replace the BUILD_BUG's with something else?
>
> I think because we use BUILD_BUG at the end of a switch statement, we make
> the assumption that size is known at compile time, for this reason we should
> ensure the function containing the BUILD_BUG is __always_inline.
>
> Looking across the kernel where BUILD_BUG is used as a default in a switch
> statment ($ git grep -B 3 BUILD_BUG\( | grep default), most instances are
> within macros, but many are found in an __always_inline function:
>
> arch/x86/kvm/cpuid.h
> mm/kasan/generic.c
>
> Though some are not:
>
> include/linux/signal.h
> arch/arm64/include/asm/arm_dsu/pmu.h
>
> I wonder if there may be a latent mole ready to whack with pmu.h?

Right, it can't hurt to annotate those as well. I actually have another
fixup for linux/signal.h that I would have to revisit at some point.
See https://bugs.llvm.org/show_bug.cgi?id=38789, I think this is
fixed with clang-9 now, but maybe not with clang-8.

      Arnd
