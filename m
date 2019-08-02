Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0AAC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53536206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CXijuyKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbfHBBlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:41:22 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30781 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbfHBBlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:41:21 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x721fF1U029735
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 10:41:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x721fF1U029735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564710076;
        bh=aKdLE8wx2u+7odpbXwBHXRxWu+Y7lWABFR3kwATccXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CXijuyKLs8ctwH3VGs+HPUQvGdo8SZCX7MREYXCiDRGwPYdRta04qxr0gEly7ImUi
         9bXe5B7ZwkmRHB2xxI6PbFfJDX2zpV3lg15jyvQ5y4zqW9aTv3ctINUh9Gjl7fF6/9
         a8BDMM3X1JFvYCdy6M8hjoj4RLK0egrkk7QKMiV4W2NMDCrRZxkipYhsROmJwjYVae
         q98YSwaT6OvtVX4VxWN6TjpPy/JewnMbICRSQJ0CkypW4PNZLv3KDQ4qAmzI9YhlZh
         YSlC0dL027hPAP3e8Mxcp0ECjyfjFgpUYUoh2cV3Vio2EiNg2bKNYGG1Q7SwcOeDBk
         VKq7/WLr4ODrQ==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id j26so50295098vsn.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:41:15 -0700 (PDT)
X-Gm-Message-State: APjAAAW3YmZ1IXyw0nv0D8FHDYeImqhsXyClASLopCcae9AuKPSdPllx
        yopgxHsIBkKv0Pvxsm5hxpk/aZ5zFVC47MaYo+s=
X-Google-Smtp-Source: APXvYqyf3mlA1z4uJLvTfK/fP3la3aeojoOD6X0fqAy+/dt1FXcmPLHdoIx0GBxxus9X5oO/Uji+SVjFlSOggdXM0Tg=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr22842997vsq.179.1564710074722;
 Thu, 01 Aug 2019 18:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com> <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
In-Reply-To: <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 2 Aug 2019 10:40:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
Message-ID: <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK inputs
To:     Joe Perches <joe@perches.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 4:27 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-07-31 at 21:03 +0200, Rikard Falkeborn wrote:
> > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > as the first argument and the low bit as the second argument. Mixing
> > them will return a mask with zero bits set.
> >
> > Recent commits show getting this wrong is not uncommon, see e.g.
> > commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> > commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> > macro").
> >
> > To prevent such mistakes from appearing again, add compile time sanity
> > checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> > arguments are known at compile time, and the low bit is higher than the
> > high bit, break the build to detect the mistake immediately.
> >
> > Since GENMASK() is used in declarations, BUILD_BUG_OR_ZERO() must be
> > used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> > of __builtin_constant_p().
> >
> > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > available in assembly") made the macros in linux/bits.h available in
> > assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> > compatible, disable the checks if the file is included in an asm file.
> >
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> > Joe Perches sent a series to fix the existing misuses of GENMASK() that
> > needs to be merged before this to avoid build failures. Currently, 7 of
> > the patches were not in Linus tree, and 2 were not in linux-next.
> >
> > Also, there's currently no asm users of bits.h, but since it was made
> > asm-compatible just two weeks ago it would be a shame to break it right
> > away...
> []
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> []
> > @@ -18,12 +18,22 @@
> >   * position @h. For example
> >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> >   */
> > +#ifndef __ASSEMBLY__
> > +#include <linux/build_bug.h>
> > +#define GENMASK_INPUT_CHECK(h, l)  BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > +             __is_constexpr(h) && __is_constexpr(l), (l) > (h), 0))
> > +#else
> > +#define GENMASK_INPUT_CHECK(h, l) 0
>
> A few things:
>
> o Reading the final code is a bit confusing.
>   Perhaps add a comment description saying it's not checked
>   in asm .h uses.
>
> o Maybe use:
>   #define GENMASK_INPUT_CHECK(h, l) UL(0)

Why?


> o The compiler error message when the arguments are in the
>   wrong order isn't obvious.  Is there some way to improve
>   the compiler error output, maybe by using BUILD_BUG_ON_MSG
>   or some other mechanism?
>
>


-- 
Best Regards
Masahiro Yamada
