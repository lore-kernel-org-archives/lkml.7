Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB92C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D60C206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfLLJ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:59:59 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:39529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:59:58 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCKO4-1iW1bb104o-009Q8A for <linux-kernel@vger.kernel.org>; Thu, 12 Dec
 2019 10:59:57 +0100
Received: by mail-qk1-f178.google.com with SMTP id c16so1105160qko.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 01:59:57 -0800 (PST)
X-Gm-Message-State: APjAAAUGFLMuch5FtqIABl8SApGOUe234TkelxPQ5Ehpbc15lp/AER90
        61GZZkJat2QH8U6X0uamtETYIKDVhdBHuQvElt8=
X-Google-Smtp-Source: APXvYqxkULaZmjXZpjS5HEn1p1TLik8jAP/fqAKzJNUYyZjMz9AYttUv30jL0zE54EkdUAz9jbgN1/fDqh4J5Uq3tUk=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr7290911qka.286.1576144796165;
 Thu, 12 Dec 2019 01:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20191211133951.401933-1-arnd@arndb.de> <CAK7LNASeyPxgQczSvEN4S3Ae7fRtYyynhU9kJ=96VX34S4TECA@mail.gmail.com>
In-Reply-To: <CAK7LNASeyPxgQczSvEN4S3Ae7fRtYyynhU9kJ=96VX34S4TECA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 10:59:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1dH+msCgxU-=w4gp30Bw+x3=6Cj473DuFzxun+3dfOcA@mail.gmail.com>
Message-ID: <CAK8P3a1dH+msCgxU-=w4gp30Bw+x3=6Cj473DuFzxun+3dfOcA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: make it possible to disable
 CONFIG_GCC_PLUGINS again
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Qent4lNFQ6ARoh82HDB/40srRr3gEjckt6+ish88EHx6OMqzXDH
 YhYf1Ogb4CtGkHNSrYdsLgzuP8PTXPExliWxzTreJYccZ5240JYfLtwkyGrKaI1/agfDbvK
 Mo6RSI7RbdJ1qRTplIj2bj/6/1ShVkOyGf1H8XzWe/CyQMAdg2OZbW1jH2ubEHBSyAfqZR1
 7taNjil9kypTaaSnmkuBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wHuGgxaTWUQ=:AvhxGCQvFM/CbMwwOQ7qIX
 AWS7AXlABEJ6pqjgDnfbO/1ZuJhlXVPFs5w1D5ucxvxDfFn48hxx9HjFQCjI7FEJmgJvBdMS7
 ULgN6UL4ms54Fc/744Ry9J0sPWRCEHasgj3y5qQwykAvBCk/AXCTDBAgAN4rTu6GC+tSLOMBm
 N7WEmVjjHGqGBjYy15nfgEV7yYZkrqH8DvR0Mt7UXoTKM6EJyg1XScBi29umd7rhsiwjyA434
 uJD1BwqtmWQQ2701odULqzlU2IEpSdLQHKacuuvHX3ubn/jXSc5C6/mELt95dGd6dxOFyfdQj
 gZfb5hf/gHmQoZidCWd7C6T7N6PMpQKxTqOtCn7386dA0ndsJpI9xoLp4+gK1d4YNXpAgHxhb
 7CyuwKqK1yHnddYjMJZIu2vj60W/u/qDv0xr588PSDV87HVTo/ttsaIht7u2aMrxK5u9Cfczi
 iOZuDxmPBeY7uiDdWy3gHS9RaZKZGCrkyeowyRnZleB0hk060sFXVZ6HfgcLa6TGxUL/tvITc
 nzpHV7Z+6Kn1ZexiVLfnzwAnSwAjZPKA1T2bWlGfhqwEDhxObcPV46wTK9XXGUQgr1FOo5Hrl
 cexSwFO1vIQjaksj10+h2uF8W4FGUg0OmCupxyqFJp9T42PsXWyMu2shHjUADRiTSzb3iZLhB
 VbPgyc8nRTK4rLW/lebCjVxiEj0K+9mRkBOcwnALiaUK7hCWv+7Kttc4EaNbwJCSYTkbw172d
 B/qkvJS/QQmg3hXuOjtwKNcHRrkR0VOXALaYLzGl2sDSOoGRJFHvRMhB4za2j/3AKZI2wGftd
 /p2j+F3zN4hON7g/R2Oqx2wjgMhNoWLr/22uh0hLfBb62w6oEH7hlpPRrAC7ukj1hJWwOlJ9y
 AFWX5iAMJDjH4tqrzOOg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 5:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Dec 11, 2019 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I noticed that randconfig builds with gcc no longer produce a lot of
> > ccache hits, unlike with clang, and traced this back to plugins
> > now being enabled unconditionally if they are supported.
> >
> > I am now working around this by adding
> >
> >    export CCACHE_COMPILERCHECK=/usr/bin/size -A %compiler%
> >
> > to my top-level Makefile. This changes the heuristic that ccache uses
> > to determine whether the plugins are the same after a 'make clean'.
> >
> > However, it also seems that being able to just turn off the plugins is
> > generally useful, at least for build testing it adds noticeable overhead
> > but does not find a lot of bugs additional bugs, and may be easier for
> > ccache users than my workaround.
> >
> > Fixes: 9f671e58159a ("security: Create "kernel hardening" config area")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

On Wed, Dec 11, 2019 at 2:59 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks! Who would be the best person to pick up the patch?
Should I send it to Andrew?

    Arnd
