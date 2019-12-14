Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB287C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B049124656
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576313838;
	bh=BjG/oVtzeeahvdcQp4K1ArNubJsdgpHPe5hF7oGpaDo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bt/hMY63ZmNAGhYQAqTLMdWAceTSx7N8lOU070E7B/6fdmI2U91u+F5qWamCU2gRw
	 GexbjgQuHjueutwGwdv/b3NQBtBfNj24HwNP7GUtWqSHi2CfW3cko1tzIf8jK4xp9U
	 vrVu3chff81lyd060EVIizIVpvLtBsmjc2c1FjW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfLNI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 03:57:16 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50607 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfLNI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 03:57:16 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xBE8vB0O008300
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 17:57:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xBE8vB0O008300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576313832;
        bh=tOG6kTlp8s2Wa7TA90vKI50NyHvG0cGEmJq+pmXM+IE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mTlnWukxuu2SqbGLPkUDKfpYQ/ZAn+86k4XT14LRN8XsN1ra0P5s6SjxJmYGqpVzp
         sE6uE+roNh0mO1+KEXOeZNGFb66vk4aUcGe1yGHru2Q1EWh0OhHyZSzAw+m6gPoruD
         18ZGdRsRVwQ8saau56I6EYetCreURZbpAyJHoRLm+OlYsrO4Lur/bWPr4okL1bEKcF
         mrdTmKzaeVJT8k7PsGkm3NPKuKQVxVpArWDJ0MBAWjD0DMKpKR3Ah9DWEkgxTvKFiO
         6oF/500SRoyjV7eKhN9E+xDVoLocHvjJv3ElLGX+Wbj5JJkFAwVyPKGWyDyLTsyPZX
         4rPcT/r9ajPQg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id i31so458793uae.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 00:57:11 -0800 (PST)
X-Gm-Message-State: APjAAAWtctYWMBF0vvbfINb6IvDETGZyhtMTsyn1ape2f2qOec2B25xI
        ZvA4z6sm1uaDOdIbTMRRJ4U2cZO8Su+cR0cWqXM=
X-Google-Smtp-Source: APXvYqwmYrpSUuPxlEvWVvOsd7YEYsu2OUZUKhh6HhH9l2daQiTwE8jfI3K3o+1Jd09Fb5ZcIFx0iW/FrDCBUOBdsbM=
X-Received: by 2002:ab0:2814:: with SMTP id w20mr15685601uap.95.1576313830670;
 Sat, 14 Dec 2019 00:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20191211133951.401933-1-arnd@arndb.de> <CAK7LNASeyPxgQczSvEN4S3Ae7fRtYyynhU9kJ=96VX34S4TECA@mail.gmail.com>
 <CAK8P3a1dH+msCgxU-=w4gp30Bw+x3=6Cj473DuFzxun+3dfOcA@mail.gmail.com> <201912120943.486E507@keescook>
In-Reply-To: <201912120943.486E507@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Dec 2019 17:56:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKuyyC-bjSZ=8bhkd1PHjRa-LDEsZra_tFdYbL7X-Azw@mail.gmail.com>
Message-ID: <CAK7LNAQKuyyC-bjSZ=8bhkd1PHjRa-LDEsZra_tFdYbL7X-Azw@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: make it possible to disable
 CONFIG_GCC_PLUGINS again
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Emese Revfy <re.emese@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 2:44 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Dec 12, 2019 at 10:59:40AM +0100, Arnd Bergmann wrote:
> > On Thu, Dec 12, 2019 at 5:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Wed, Dec 11, 2019 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > I noticed that randconfig builds with gcc no longer produce a lot of
> > > > ccache hits, unlike with clang, and traced this back to plugins
> > > > now being enabled unconditionally if they are supported.
> > > >
> > > > I am now working around this by adding
> > > >
> > > >    export CCACHE_COMPILERCHECK=/usr/bin/size -A %compiler%
> > > >
> > > > to my top-level Makefile. This changes the heuristic that ccache uses
> > > > to determine whether the plugins are the same after a 'make clean'.
> > > >
> > > > However, it also seems that being able to just turn off the plugins is
> > > > generally useful, at least for build testing it adds noticeable overhead
> > > > but does not find a lot of bugs additional bugs, and may be easier for
> > > > ccache users than my workaround.
> > > >
> > > > Fixes: 9f671e58159a ("security: Create "kernel hardening" config area")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > On Wed, Dec 11, 2019 at 2:59 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Thanks! Who would be the best person to pick up the patch?
> > Should I send it to Andrew?
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> I can take it in my tree, or I'm happy to have Masahiro take it.
>
> --
> Kees Cook

Kees,
Please apply it to your tree.

Thanks.


-- 
Best Regards
Masahiro Yamada
