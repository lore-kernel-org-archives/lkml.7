Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D498C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAC2217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 19:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cohyz/FM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfJHTGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 15:06:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38554 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 15:06:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so12796388lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+4dahDwqppQ/lGt5CT5AlzyDGG98Y1WJrrGLrGCAME=;
        b=cohyz/FMoizyhRX+jNQrtjCTaU9Ha549yFcT8pF3P+2xlpWgskYa+iHI1zP+Z/1Gy5
         Xsf/gs9te34tcTs1E4pwr+0RGUfAxZvWgiTFqGh8BG8g3/lJ3WM3A4PqxDbTGynigpur
         lL0hlwgyvPDmK6QA4onTCgCvBMqrJoYoh/Ha9IqS5NOM0iWIFZfS2Z6pkjVAnXi2qQwg
         mR27eia5y4X76QAWfZVD/QjlcNomH7Mk9xffWfmw2/6eB4a6iY4HalsfjumcP5GULi2g
         Zenl/v+KMfFcEaWjSc2ScW8B5RpM4QpcFa4J1Nrbx3lU8jeNjGzQkyBAAyavgK4fqa/w
         1jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+4dahDwqppQ/lGt5CT5AlzyDGG98Y1WJrrGLrGCAME=;
        b=k1ZM4UK7ktXM5fDeIr29YL0qQWCamJbfu85J9YLwckrGeqwP9CDSCnRGIM9oQUijmJ
         2KHPdL1zXhs6sSWULmT8oSGyxuRe9lBTM5gI//GsGlQIZwTwxPFvr0eKg4Funze4G6QR
         f+kYsMvMWi0D8cpECMyc5oCQu4Nh8iInMky1/dPszuztW8p6IQF+vT+SdJKBK85ILlfj
         3yXItmduoVYNictoiFaM+0vwmjbQY/RspIL2S70eodkNktyczWhkp9MT+pq+dAIduA7h
         Y3Rq+DpTZUw8VH7q6abEmoA81VF6COtJqx+9t40Z8dK4TX7QfZsYHdIy3wFi2hrLOrH9
         BdQg==
X-Gm-Message-State: APjAAAVV5gyXVk/dJxjCb2lJ8HK2YAeaLbbyldmtFvmBa6GUEq+/1OTM
        kw1ferzLk55S7xK1rTIhPzVWFwj+VsI=
X-Google-Smtp-Source: APXvYqxIRolJdXo4fSn2XjXjAxaVvBO1lggMrO4nPY2h4nN+zA0Voc6mDUgXCFHPKuSP1Xt5uWM8Zw==
X-Received: by 2002:a19:381a:: with SMTP id f26mr5999973lfa.168.1570561579798;
        Tue, 08 Oct 2019 12:06:19 -0700 (PDT)
Received: from rikard (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id m15sm4180044ljh.50.2019.10.08.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 12:06:18 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 8 Oct 2019 21:06:13 +0200
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haren Myneni <haren@us.ibm.com>
Subject: Re: [PATCH v3 3/3] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
Message-ID: <20191008190613.GA860@rikard>
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-4-rikard.falkeborn@gmail.com>
 <CAMuHMdUkM98oiz-v8X-1QMAM25_d_=Gnxtud+gVQyZNb4nJDMA@mail.gmail.com>
 <CAK7LNARAC=ATn67PHMBiO2b7ZM-GzmKNSv0o6_yi2qSg9Dyq-w@mail.gmail.com>
 <CAK7LNARt3Ag0B2H=vgYG2j+nGGCZXv_CGVNFgnmHNT1Udz+s=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARt3Ag0B2H=vgYG2j+nGGCZXv_CGVNFgnmHNT1Udz+s=Q@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:52:17PM +0900, Masahiro Yamada wrote:
> On Tue, Oct 8, 2019 at 4:44 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Geert,
> >
> > On Tue, Oct 8, 2019 at 4:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Rikard,
> > >
> > > On Sun, Aug 11, 2019 at 8:52 PM Rikard Falkeborn
> > > <rikard.falkeborn@gmail.com> wrote:
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
> > > > checking to the arguments of GENMASK() and GENMASK_ULL(). If both
> > > > arguments are known at compile time, and the low bit is higher than the
> > > > high bit, break the build to detect the mistake immediately.
> > > >
> > > > Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> > > > used instead of BUILD_BUG_ON().
> > > >
> > > > __builtin_constant_p does not evaluate is argument, it only checks if it
> > > > is a constant or not at compile time, and __builtin_choose_expr does not
> > > > evaluate the expression that is not chosen. Therefore, GENMASK(x++, 0)
> > > > does only evaluate x++ once.
> > > >
> > > > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > > > available in assembly") made the macros in linux/bits.h available in
> > > > assembly. Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
> > > > checks if the file is included in an asm file.
> > > >
> > > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > > ---
> > > > Changes in v3:
> > > >   - Changed back to shorter macro argument names
> > > >   - Remove casts and use 0 instead of UL(0) in GENMASK_INPUT_CHECK(),
> > > >     since all results in GENMASK_INPUT_CHECK() are now ints. Update
> > > >     commit message to reflect that.
> > > >
> > > > Changes in v2:
> > > >   - Add comment about why inputs are not checked when used in asm file
> > > >   - Use UL(0) instead of 0
> > > >   - Extract mask creation in a separate macro to improve readability
> > > >   - Use high and low instead of h and l (part of this was extracted to a
> > > >     separate patch)
> > > >   - Updated commit message
> > > >
> > > > Joe Perches sent a series to fix the existing misuses of GENMASK() that
> > > > needs to be merged before this to avoid build failures. Currently, 5 of
> > > > the patches are not in Linus tree, and 2 are not in linux-next. There is
> > > > also a patch pending by Nathan Chancellor that also needs to be merged
> > > > before this patch is merged to avoid build failures.
> > > >
> > > >  include/linux/bits.h | 21 +++++++++++++++++++--
> > > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/bits.h b/include/linux/bits.h
> > > > index 669d69441a62..4ba0fb609239 100644
> > > > --- a/include/linux/bits.h
> > > > +++ b/include/linux/bits.h
> > > > @@ -18,12 +18,29 @@
> > > >   * position @h. For example
> > > >   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
> > > >   */
> > > > -#define GENMASK(h, l) \
> > > > +#ifndef __ASSEMBLY__
> > > > +#include <linux/build_bug.h>
> > > > +#define GENMASK_INPUT_CHECK(h, l) \
> > > > +       (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> > > > +               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> > > > +#else
> > > > +/*
> > > > + * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
> > > > + * disable the input check if that is the case.
> > > > + */
> > > > +#define GENMASK_INPUT_CHECK(h, l) 0
> > > > +#endif
> > > > +
> > > > +#define __GENMASK(h, l) \
> > > >         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> > > >          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > > > +#define GENMASK(h, l) \
> > > > +       (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > > >
> > > > -#define GENMASK_ULL(h, l) \
> > > > +#define __GENMASK_ULL(h, l) \
> > > >         (((~ULL(0)) - (ULL(1) << (l)) + 1) & \
> > > >          (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> > > > +#define GENMASK_ULL(h, l) \
> > > > +       (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
> > > >
> > > >  #endif /* __LINUX_BITS_H */
> > >
> > > This is now commit 0fd35cd30a2fece1 ("linux/bits.h: add compile time sanity
> > > check of GENMASK inputs") in next-20191008.
> > >
> > > <noreply@ellerman.id.au> reported the following failure in sun3_defconfig,
> > > which I managed to reproduce with gcc-4.6.3:
> >
> > Oh dear.
> >
> > I was able to reproduce this for gcc 4.7 or 4.8,
> > but I did not see any problem for gcc 4.9+
> >
> > Perhaps, is this due to broken __builtin_choose_expr or __builtin_constant_p
> > for old compilers?
> >
> >
> >
> >
> >
> >
> >
> > >
> > >     lib/842/842_compress.c: In function '__split_add_bits':
> > >     lib/842/842_compress.c:164:25: error: first argument to
> > > '__builtin_choose_expr' not a constant
> > >     lib/842/842_compress.c:164:25: error: bit-field '<anonymous>'
> > > width not an integer constant
> > >     scripts/Makefile.build:265: recipe for target
> > > 'lib/842/842_compress.o' failed
> > >
> > > __split_add_bits() calls GENMASK_ULL() with a non-constant.
> > > However __split_add_bits() itself is called with constants only.
> > > Apparently gcc fails to inline __split_add_bits().
> > > Adding inline or always_inline doesn't help.
> > >
> 
> 
> If this is broken for GCC < 4.9,
> we might be able to workaround it as follows:
> 
> 
> 
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 4ba0fb609239..f00417baf545 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -18,7 +18,7 @@
>   * position @h. For example
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
> -#ifndef __ASSEMBLY__
> +#if !defined(__ASSEMBLY__) && (!defined(CONFIG_CC_IS_GCC) ||
> CONFIG_GCC_VERSION >= 49000)
>  #include <linux/build_bug.h>
>  #define GENMASK_INPUT_CHECK(h, l) \
>         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

Hi Masahiro, Geert,

It seems it is broken for GCC < 4.9, see [1]. I'll try disabling it for
too old compilers and resend.

In the meantime, I guess it should be dropped from linux-next?

Rikard

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449
