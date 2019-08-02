Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289AAC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC82420679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LEKxmWny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfHBD0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:26:09 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:22561 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbfHBD0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:26:09 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x723Pg16011603
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 12:25:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x723Pg16011603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564716343;
        bh=ssjsPr4WP9okAPt/bXtctmL7QnQF1VG4HOIPeNSaxYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LEKxmWnyo4xtXr1BMkwhIhg2uXtQ8C8vCc5wNsUmbm0VA+v0fw5ZUxdaUeiKaWoip
         OTvuAPYBX+ppqugtuGATJuC8kLCoEd5/l8C5895X6VxcUuv/kGmjZDgkPHecThvpvq
         z3XL72u1HdoebFQQZM+zpYSJxDSzgxgLs7Ytu8wih0V2oO5D7t4445n0Sse/d6vui8
         f2yYqhDrEiCilFU5ZDQoB5D9tTwancR8sSXzqvuK6Sknk5WcUcYtAAV9Hg1dl0m5fD
         HzI8ASzUtRXSvniJAFarQ2As6cb3vGsCsINhpNIp3F/V2wP0CfbLulOLrM0IEe5DSW
         CJ4Zj5Psr1Adw==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id r3so50376295vsr.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 20:25:43 -0700 (PDT)
X-Gm-Message-State: APjAAAWQV3h8/eWWuWo15y/6AvX/SsMBEkqFWaL5G1dkboOryVBqcCRe
        VR7GioFvIwb2jFsYVIRY2p7NoSyyAiPniGThbx8=
X-Google-Smtp-Source: APXvYqwF5mYJGi6FSezyKTszoTEmupbaBODbzXNvLLgHnKa2V195R6JL3ciEvVZgr0738/KGOW43Fb2so36wWo5WNpM=
X-Received: by 2002:a67:f495:: with SMTP id o21mr84639027vsn.54.1564716342291;
 Thu, 01 Aug 2019 20:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
 <20190731190309.19909-1-rikard.falkeborn@gmail.com> <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
 <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com> <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
In-Reply-To: <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 2 Aug 2019 12:25:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
Message-ID: <CAK7LNASw+Fraio3t=bZw-FzJihScTuDR=p2EktFVOmdLH4GTGA@mail.gmail.com>
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

On Fri, Aug 2, 2019 at 12:14 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-08-02 at 10:40 +0900, Masahiro Yamada wrote:
> > On Thu, Aug 1, 2019 at 4:27 AM Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2019-07-31 at 21:03 +0200, Rikard Falkeborn wrote:
> > > > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > > > as the first argument and the low bit as the second argument. Mixing
> > > > them will return a mask with zero bits set.
> > > >
> > > > Recent commits show getting this wrong is not uncommon, see e.g.
> > > > commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> > > > commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> > > > macro").
> > > >
> > > > To prevent such mistakes from appearing again, add compile time sanity
> > > > checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> > > > arguments are known at compile time, and the low bit is higher than the
> > > > high bit, break the build to detect the mistake immediately.
> > > >
> > > > Since GENMASK() is used in declarations, BUILD_BUG_OR_ZERO() must be
> > > > used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> > > > of __builtin_constant_p().
> > > >
> > > > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > > > available in assembly") made the macros in linux/bits.h available in
> > > > assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> > > > compatible, disable the checks if the file is included in an asm file.
> > > >
> > > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > > ---
> > > > Joe Perches sent a series to fix the existing misuses of GENMASK() that
> > > > needs to be merged before this to avoid build failures. Currently, 7 of
> > > > the patches were not in Linus tree, and 2 were not in linux-next.
> > > >
> > > > Also, there's currently no asm users of bits.h, but since it was made
> > > > asm-compatible just two weeks ago it would be a shame to break it right
> > > > away...
> > > []
> > > > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > > []
> > > > @@ -18,12 +18,22 @@
> > > >   * position @h. For example
> > > >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > > >   */
> > > > +#ifndef __ASSEMBLY__
> > > > +#include <linux/build_bug.h>
> > > > +#define GENMASK_INPUT_CHECK(h, l)  BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > > > +             __is_constexpr(h) && __is_constexpr(l), (l) > (h), 0))
> > > > +#else
> > > > +#define GENMASK_INPUT_CHECK(h, l) 0
> > >
> > > A few things:
> > >
> > > o Reading the final code is a bit confusing.
> > >   Perhaps add a comment description saying it's not checked
> > >   in asm .h uses.
> > >
> > > o Maybe use:
> > >   #define GENMASK_INPUT_CHECK(h, l) UL(0)
> >
> > Why?
>
> Consistency with the uses in what's now called __GENMASK

Inconsistent with __GENMASK_ULL.



-- 
Best Regards
Masahiro Yamada
