Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CFAC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9836F21E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VLvFt6S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfHGO4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:56:18 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:43980 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbfHGO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:56:17 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x77EuBhY021136
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 23:56:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x77EuBhY021136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565189771;
        bh=OAO7XGlQdmEIgpn78eW2L2ZXYXkQrL3lABQNvOER8oU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VLvFt6S/I43TB+5ltV5z9dro2bM6nhwXidEu0BPBdGKajiKSTcZwbD0RGnPPhqnft
         /mMTw1BfoqPeN8S6lE5X7wTJyEbdPbGKEwhkBW/1t9RhwmAyXYXc+f54mTnNhNckpb
         wOQmT/2unaSifpeamaZS00so7/hpEivheLJNheRyhLdl3CgqA6pwaJ8jR/Sh0uAqkU
         ypLaIQExZaFsLFVsj7Mfnil4erpWMEO/xB/lbQoq+cPAtE9Sm4Zqr1dZ3CH68ljCZj
         r+JTSvXUkD8vHwGDhdBo7tcgQ8//l8NXDLGixIKVJi6+Iaa8GVm1kx85Y1ou+X1aw+
         hTSlYn6li1fbQ==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id v129so60844449vsb.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:56:11 -0700 (PDT)
X-Gm-Message-State: APjAAAU2eIzDvu1YazDvLDgKiVKyfkJS+6E0BjNulTm314jbmOkszx8b
        /iQBgAJgPcM8CoermwOjNLSbmmvWYcyHMvc7Ogk=
X-Google-Smtp-Source: APXvYqxcTU3HgFnWXtYedYJqFKQRBtWDWaMULS4dNjaFXj17+vON0Z92k0/VOYCtWad6HRH6isIAhdbZ0kfHeew7duo=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr6182973vsd.215.1565189770430;
 Wed, 07 Aug 2019 07:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-1-rikard.falkeborn@gmail.com> <20190801230358.4193-2-rikard.falkeborn@gmail.com>
 <20190807142728.GA16360@roeck-us.net>
In-Reply-To: <20190807142728.GA16360@roeck-us.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 7 Aug 2019 23:55:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
Message-ID: <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 11:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Aug 02, 2019 at 01:03:58AM +0200, Rikard Falkeborn wrote:
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
> > Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
> > used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
> > of __builtin_constant_p().
> >
> > If successful, BUILD_BUG_OR_ZERO() returns 0 of type size_t. To avoid
> > problems with implicit conversions, cast the result of BUILD_BUG_OR_ZERO
> > to unsigned long.
> >
> > Since both BUILD_BUG_ON_ZERO() and __is_constexpr() only uses sizeof()
> > on the arguments passed to them, neither of them evaluate the expression
> > unless it is a VLA. Therefore, GENMASK(1, x++) still behaves as
> > expected.
> >
> > Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
> > available in assembly") made the macros in linux/bits.h available in
> > assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
> > compatible, disable the checks if the file is included in an asm file.
> >
>
> Who is going to fix the fallout ? For example, arm64:defconfig no longer
> compiles with this patch applied.
>
> It seems to me that the benefit of catching misuses of GENMASK is much
> less than the fallout from no longer compiling kernels, since those
> kernels won't get any test coverage at all anymore.


We cannot apply this until we fix all errors.

I do not understand why Andrew picked up this so soon.

-- 
Best Regards
Masahiro Yamada
