Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A91BC0650F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 03:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A1B2086A
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 03:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="SUC1VGFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbfHCDEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 23:04:10 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:61780 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbfHCDEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 23:04:09 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x7333p6K016272
        for <linux-kernel@vger.kernel.org>; Sat, 3 Aug 2019 12:03:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x7333p6K016272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564801432;
        bh=xefQyfTB9Thx4g2/D9xmFX+SV4M+SYdJ8qvtaBfCpAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SUC1VGFbvjNg8TR0m4Z87KXocg7RZz45mbiRV7swbIZT0WRXi9ALyqgclZXRJEv4T
         yXqjNZp4g8F37AXTqUoreM5Hr2PGSJLNn9uysPtc4Xe77eIoxvfKK0prkFFTPFRWrA
         Q87gD+uj4EDPcPJg0a2UYvA6LXkSpThO0BQ/zgerrgWtthJcRj/5hwm/xZLeUBCvQu
         1ctdBoHVof+BhMFHQJe4CG80jFdU6fowK3TEmlietpMBV6pBsoEWCkFVu2MTn7YPml
         vUwV8kREgQ1S/dUqys2svs8Pd5icHMpSkJ1d98JsXjrXrMAJ6D/fEIlUwq1dC3+ZwZ
         hoSdsMRO6ay3g==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id h28so52556337vsl.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 20:03:51 -0700 (PDT)
X-Gm-Message-State: APjAAAVAL8PqoQMNGw7b5dthwDsGSygfwm+cV0KCLNueMtfMGIY0pNi4
        PikYNEcDbxi4XLHJ7GOA6ooKvnsqTP9Q6w7TBcE=
X-Google-Smtp-Source: APXvYqwGrIuOtQ1jgTbAYjL1Q5OITIAE7rGKKcJ5TAj3RMbTaYMdU2sPG3dVW1Sww+/uAQpMYJ+hlAb8wIyfbcEv2WY=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr64840206vsd.215.1564801430468;
 Fri, 02 Aug 2019 20:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com> <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
 <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
 <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
 <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com> <20190802181853.GA809@rikard>
In-Reply-To: <20190802181853.GA809@rikard>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 3 Aug 2019 12:03:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
Message-ID: <CAK7LNAT+cNxna4SER04MdkBsq_LDg4TwYR_U1ioNNxYOZWXigA@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK inputs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 3, 2019 at 3:19 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> On Fri, Aug 02, 2019 at 12:25:06PM +0900, Masahiro Yamada wrote:
> > On Fri, Aug 2, 2019 at 12:14 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Fri, 2019-08-02 at 10:40 +0900, Masahiro Yamada wrote:
> > > > On Thu, Aug 1, 2019 at 4:27 AM Joe Perches <joe@perches.com> wrote:
> > > > > On Wed, 2019-07-31 at 21:03 +0200, Rikard Falkeborn wrote:
> > > > > > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > > > > > as the first argument and the low bit as the second argument. Mixing
> > > > > > them will return a mask with zero bits set.
> > > > > >
> > > > > > Recent commits show getting this wrong is not uncommon, see e.g.
> > > > > > commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> > > > > > commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> > > > > > macro").
> > > > > >
> > > > > > To prevent such mistakes from appearing again, add compile time sanity
> > > > > > checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> > > > > > arguments are known at compile time, and the low bit is higher than the
> > > > > > high bit, break the build to detect the mistake immediately.
> > > > > >
> > > > > > Since GENMASK() is used in declarations, BUILD_BUG_OR_ZERO() must be
> > > > > > used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> > > > > > of __builtin_constant_p().
> > > > > >
> > > > > > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > > > > > available in assembly") made the macros in linux/bits.h available in
> > > > > > assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> > > > > > compatible, disable the checks if the file is included in an asm file.
> > > > > >
> > > > > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > > > > ---
> > > > > > Joe Perches sent a series to fix the existing misuses of GENMASK() that
> > > > > > needs to be merged before this to avoid build failures. Currently, 7 of
> > > > > > the patches were not in Linus tree, and 2 were not in linux-next.
> > > > > >
> > > > > > Also, there's currently no asm users of bits.h, but since it was made
> > > > > > asm-compatible just two weeks ago it would be a shame to break it right
> > > > > > away...
> > > > > []
> > > > > > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > > > > []
> > > > > > @@ -18,12 +18,22 @@
> > > > > >   * position @h. For example
> > > > > >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > > > > >   */
> > > > > > +#ifndef __ASSEMBLY__
> > > > > > +#include <linux/build_bug.h>
> > > > > > +#define GENMASK_INPUT_CHECK(h, l)  BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > > > > > +             __is_constexpr(h) && __is_constexpr(l), (l) > (h), 0))
> > > > > > +#else
> > > > > > +#define GENMASK_INPUT_CHECK(h, l) 0
> > > > >
> > > > > A few things:
> > > > >
> > > > > o Reading the final code is a bit confusing.
> > > > >   Perhaps add a comment description saying it's not checked
> > > > >   in asm .h uses.
> > > > >
> > > > > o Maybe use:
> > > > >   #define GENMASK_INPUT_CHECK(h, l) UL(0)
> > > >
> > > > Why?
> > >
> > > Consistency with the uses in what's now called __GENMASK
> >
> > Inconsistent with __GENMASK_ULL.
>
> Would you prefer to add GENMASK_ULL_INPUT_CHECK?

No.

> Or replace UL(0) with
> 0 and then probably move the cast of BUILD_BUG_OR_ZERO (to avoid
> GENMASK be of type size_t) to GENMASK and GENMASK_ULL?

No.



Your original code is absolutely fine.


C aligns the types to the wider one.


(unsigned long)      + (int)  ->  (unsigned long)
(unsigned long long) + (int)  ->  (unsigned long long)


Having GENMASK_INPUT_CHECK to return 'int' is OK.
The resulted GENMASK(), GENMASK_ULL() still
have unsigned long, unsigned long long, respectively.




BTW, v2 is already inconsistent.
If you wanted GENMASK_INPUT_CHECK() to return 'unsigned long',,
you would have to cast (low) > (high) as well:

               (unsigned long)((low) > (high)), UL(0))))

This is totally redundant, and weird.





-- 
Best Regards
Masahiro Yamada
