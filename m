Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB61C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1A1206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfHBDN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:13:58 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:35957 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbfHBDN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:13:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 99FA518224D6C;
        Fri,  2 Aug 2019 03:13:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tent09_5c08077be4850
X-Filterd-Recvd-Size: 4014
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Aug 2019 03:13:52 +0000 (UTC)
Message-ID: <2b782cf609330f53b6ecc5b75a8a4b49898483eb.camel@perches.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Aug 2019 20:13:51 -0700
In-Reply-To: <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
         <20190731190309.19909-1-rikard.falkeborn@gmail.com>
         <47d29791addc075431737aff4b64531a668d4c1b.camel@perches.com>
         <CAK7LNAQdgUOsjWtWFnXm66DPnYFRp=i69DMyr+q4+NT+SPCQxA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 10:40 +0900, Masahiro Yamada wrote:
> On Thu, Aug 1, 2019 at 4:27 AM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2019-07-31 at 21:03 +0200, Rikard Falkeborn wrote:
> > > GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
> > > as the first argument and the low bit as the second argument. Mixing
> > > them will return a mask with zero bits set.
> > > 
> > > Recent commits show getting this wrong is not uncommon, see e.g.
> > > commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
> > > commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
> > > macro").
> > > 
> > > To prevent such mistakes from appearing again, add compile time sanity
> > > checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
> > > arguments are known at compile time, and the low bit is higher than the
> > > high bit, break the build to detect the mistake immediately.
> > > 
> > > Since GENMASK() is used in declarations, BUILD_BUG_OR_ZERO() must be
> > > used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> > > of __builtin_constant_p().
> > > 
> > > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > > available in assembly") made the macros in linux/bits.h available in
> > > assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> > > compatible, disable the checks if the file is included in an asm file.
> > > 
> > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > ---
> > > Joe Perches sent a series to fix the existing misuses of GENMASK() that
> > > needs to be merged before this to avoid build failures. Currently, 7 of
> > > the patches were not in Linus tree, and 2 were not in linux-next.
> > > 
> > > Also, there's currently no asm users of bits.h, but since it was made
> > > asm-compatible just two weeks ago it would be a shame to break it right
> > > away...
> > []
> > > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > []
> > > @@ -18,12 +18,22 @@
> > >   * position @h. For example
> > >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > >   */
> > > +#ifndef __ASSEMBLY__
> > > +#include <linux/build_bug.h>
> > > +#define GENMASK_INPUT_CHECK(h, l)  BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > > +             __is_constexpr(h) && __is_constexpr(l), (l) > (h), 0))
> > > +#else
> > > +#define GENMASK_INPUT_CHECK(h, l) 0
> > 
> > A few things:
> > 
> > o Reading the final code is a bit confusing.
> >   Perhaps add a comment description saying it's not checked
> >   in asm .h uses.
> > 
> > o Maybe use:
> >   #define GENMASK_INPUT_CHECK(h, l) UL(0)
> 
> Why?

Consistency with the uses in what's now called __GENMASK


