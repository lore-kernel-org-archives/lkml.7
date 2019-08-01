Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42787C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 02:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E569206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 02:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfHAC5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 22:57:52 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:59120 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726626AbfHAC5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 22:57:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0E0C3181D3377;
        Thu,  1 Aug 2019 02:57:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hot98_2748f26d67433
X-Filterd-Recvd-Size: 4139
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 02:57:49 +0000 (UTC)
Message-ID: <d18482fae2c6ca7cdb955aff4c724b007ef45aba.camel@perches.com>
Subject: Re: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK
 inputs
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Jul 2019 19:57:48 -0700
In-Reply-To: <CAK7LNAT2r8J+4C8bAPDZ1R4Xk7Psr+fAS9wcs_c+JhuUqj-uAw@mail.gmail.com>
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
         <20190731190309.19909-1-rikard.falkeborn@gmail.com>
         <CAK7LNAT2r8J+4C8bAPDZ1R4Xk7Psr+fAS9wcs_c+JhuUqj-uAw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 11:50 +0900, Masahiro Yamada wrote:
> On Thu, Aug 1, 2019 at 4:04 AM Rikard Falkeborn
> <rikard.falkeborn@gmail.com> wrote:
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
[]
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
[]
> >  #define GENMASK(h, l) \
> > +       (GENMASK_INPUT_CHECK(h, l) + \
> >         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> > -        (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > +        (~UL(0) >> (BITS_PER_LONG - 1 - (h)))))
> > 
> >  #define GENMASK_ULL(h, l) \
> > +       (GENMASK_INPUT_CHECK(h, l) + \
> >         (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> > -        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> > +        (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h)))))
> 
> This is getting cluttered with so many parentheses.
> 
> One way of clean-up is to rename the current macros as follows:
> 
>    GENMASK()    ->  __GENMASK()
>    GENMASK_UL() ->  __GENMASK_ULL()
> 
> Then,
> 
> #define GENMASK(h, l)       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> #define GENMASK_ULL(h, l)   (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))

Much nicer.  It may be better still to use avoid
multiple dereferences of each argument.

Also it'd be useful to rename h and l to something like
high_bit and low_bit or high and low.


