Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95959C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354A921924
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RInnKvJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfJHHpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:45:06 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:35946 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfJHHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:45:06 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x987ixw7010587
        for <linux-kernel@vger.kernel.org>; Tue, 8 Oct 2019 16:45:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x987ixw7010587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570520701;
        bh=5vdyLTpEpqPrxGKiHV1GQDqsAbuwLe1TeFdRcUBrweM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RInnKvJ9611O6MJB6/m/3g9rYpMP2U/Uj3bFYIHKAOdXfTK+Cqhi0PNebaCSbuxiV
         ZMlZHPcurK7t4rsQNhSH5fncQAVVE8WmkMy6ozrCSezns+A6UMXKfpTampNuG/7PKY
         +giS4mAvJLtJA5KgVVvbsQdElzGwKdCm4th1cXb/IWqhPTNLH5qqC9fVSVK4Abl88h
         xLWZIe3bgH4goKQvKaoKAhePA1maQ/K56VuR2luqG0a4ws6KemKH34piyHlKb6fV6y
         JSCCOUejK+FGpMssH+8tf8wE9aVoBFp+ed+GpF1Uc4BjB5mosdVSe/t3LfH2GLTB/t
         BFWv015/p358w==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id r25so4887660uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:45:00 -0700 (PDT)
X-Gm-Message-State: APjAAAW0mcq5B2gax2si1rLPd4nAuM0BVVXIcztBSFfvOyAdMn4B3tlx
        k6LMcU6z6wO8YuVb84H8WfTOEqjqMjLHOrTfSxQ=
X-Google-Smtp-Source: APXvYqy6lP0GYJAxHitYgDFRxHYa2MX52vBA0gcbcApI2yNBhKsuR8rMg+UwE01vmVZNoTqdjbaL6JS3kYi86HEKnZ0=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr4841683uad.25.1570520699005;
 Tue, 08 Oct 2019 00:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com> <20190811184938.1796-4-rikard.falkeborn@gmail.com>
 <CAMuHMdUkM98oiz-v8X-1QMAM25_d_=Gnxtud+gVQyZNb4nJDMA@mail.gmail.com>
In-Reply-To: <CAMuHMdUkM98oiz-v8X-1QMAM25_d_=Gnxtud+gVQyZNb4nJDMA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 8 Oct 2019 16:44:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAC=ATn67PHMBiO2b7ZM-GzmKNSv0o6_yi2qSg9Dyq-w@mail.gmail.com>
Message-ID: <CAK7LNARAC=ATn67PHMBiO2b7ZM-GzmKNSv0o6_yi2qSg9Dyq-w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haren Myneni <haren@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Oct 8, 2019 at 4:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rikard,
>
> On Sun, Aug 11, 2019 at 8:52 PM Rikard Falkeborn
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
> > checking to the arguments of GENMASK() and GENMASK_ULL(). If both
> > arguments are known at compile time, and the low bit is higher than the
> > high bit, break the build to detect the mistake immediately.
> >
> > Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> > used instead of BUILD_BUG_ON().
> >
> > __builtin_constant_p does not evaluate is argument, it only checks if it
> > is a constant or not at compile time, and __builtin_choose_expr does not
> > evaluate the expression that is not chosen. Therefore, GENMASK(x++, 0)
> > does only evaluate x++ once.
> >
> > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > available in assembly") made the macros in linux/bits.h available in
> > assembly. Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
> > checks if the file is included in an asm file.
> >
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> > Changes in v3:
> >   - Changed back to shorter macro argument names
> >   - Remove casts and use 0 instead of UL(0) in GENMASK_INPUT_CHECK(),
> >     since all results in GENMASK_INPUT_CHECK() are now ints. Update
> >     commit message to reflect that.
> >
> > Changes in v2:
> >   - Add comment about why inputs are not checked when used in asm file
> >   - Use UL(0) instead of 0
> >   - Extract mask creation in a separate macro to improve readability
> >   - Use high and low instead of h and l (part of this was extracted to a
> >     separate patch)
> >   - Updated commit message
> >
> > Joe Perches sent a series to fix the existing misuses of GENMASK() that
> > needs to be merged before this to avoid build failures. Currently, 5 of
> > the patches are not in Linus tree, and 2 are not in linux-next. There is
> > also a patch pending by Nathan Chancellor that also needs to be merged
> > before this patch is merged to avoid build failures.
> >
> >  include/linux/bits.h | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > index 669d69441a62..4ba0fb609239 100644
> > --- a/include/linux/bits.h
> > +++ b/include/linux/bits.h
> > @@ -18,12 +18,29 @@
> >   * position @h. For example
> >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> >   */
> > -#define GENMASK(h, l) \
> > +#ifndef __ASSEMBLY__
> > +#include <linux/build_bug.h>
> > +#define GENMASK_INPUT_CHECK(h, l) \
> > +       (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > +               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > +#else
> > +/*
> > + * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > + * disable the input check if that is the case.
> > + */
> > +#define GENMASK_INPUT_CHECK(h, l) 0
> > +#endif
> > +
> > +#define __GENMASK(h, l) \
> >         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> >          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > +#define GENMASK(h, l) \
> > +       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> >
> > -#define GENMASK_ULL(h, l) \
> > +#define __GENMASK_ULL(h, l) \
> >         (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> >          (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> > +#define GENMASK_ULL(h, l) \
> > +       (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> >
> >  #endif /* __LINUX_BITS_H */
>
> This is now commit 0fd35cd30a2fece1 ("linux/bits.h: add compile time sanity
> check of GENMASK inputs") in next-20191008.
>
> <noreply@ellerman.id.au> reported the following failure in sun3_defconfig,
> which I managed to reproduce with gcc-4.6.3:

Oh dear.

I was able to reproduce this for gcc 4.7 or 4.8,
but I did not see any problem for gcc 4.9+

Perhaps, is this due to broken __builtin_choose_expr or __builtin_constant_p
for old compilers?







>
>     lib/842/842_compress.c: In function '__split_add_bits':
>     lib/842/842_compress.c:164:25: error: first argument to
> '__builtin_choose_expr' not a constant
>     lib/842/842_compress.c:164:25: error: bit-field '<anonymous>'
> width not an integer constant
>     scripts/Makefile.build:265: recipe for target
> 'lib/842/842_compress.o' failed
>
> __split_add_bits() calls GENMASK_ULL() with a non-constant.
> However __split_add_bits() itself is called with constants only.
> Apparently gcc fails to inline __split_add_bits().
> Adding inline or always_inline doesn't help.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Best Regards
Masahiro Yamada
