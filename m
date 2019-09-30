Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86617C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5904C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 08:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UMLkZkxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfI3I1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 04:27:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:41038 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfI3I1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:27:35 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x8U8R4vs026947
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 17:27:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x8U8R4vs026947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569832025;
        bh=S3XJDoeipww5RQbEvSMupd7ozkKy8JwBydWHSl7iEd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UMLkZkxecf6GdVqFNZtK3I5UzfFgRPItb95ROKa80T/3sa/9Eiehes5+KNghNotEA
         EbgDc04gztLox5jrIiJb0xhh3XcQuNj2v2wueRxKc0vYzuEgwRO1fVwianL73Yc8mG
         mx17qPyFl4wPz8U0ssJUkboAE/+Z000MpXUOwO3yzN48jY3V/1UcmaxUoJZ9GCOSPV
         gocNk+Rs8IU5bi9t0clQ0Ac8DCi0W0UdN6kIaI+nci9GIbK+S2fsYZvaWzwABsnX6F
         fgWOaKo41QeSGMN9AdX2jaGBcZd9QCqmVEQNzDr/x1EJv+j7F4q7jZzN0OMiw5tawy
         wFP1flpOBSYxA==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id d204so6143592vsc.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 01:27:04 -0700 (PDT)
X-Gm-Message-State: APjAAAU6RPI5e0awEHW2/0ivvBkxzcgv2PpJrvVKkLTITq1gFIlzBu1L
        YuZeKJe632pE5cgCWViDeq//7QE0vaXPvTemtOA=
X-Google-Smtp-Source: APXvYqyu9o2T0h0WNByn2XriMLNL31isIe26D8AZTWUv/uJaOHyQY1+TN/o45LxvFGamYDgXuIeEO1go3fL594zyVNk=
X-Received: by 2002:a67:1e87:: with SMTP id e129mr9358134vse.179.1569832023746;
 Mon, 30 Sep 2019 01:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190930055925.25842-1-yamada.masahiro@socionext.com> <CAK8P3a24P7v41TZszjKzoJmhcss5WK-e9fHwUqEqre6FBPJWvw@mail.gmail.com>
In-Reply-To: <CAK8P3a24P7v41TZszjKzoJmhcss5WK-e9fHwUqEqre6FBPJWvw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 30 Sep 2019 17:26:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_gbz2Qc8MgXiKRRSSgKse3J-dJ98c4qViuvnyxdAD+Q@mail.gmail.com>
Message-ID: <CAK7LNAS_gbz2Qc8MgXiKRRSSgKse3J-dJ98c4qViuvnyxdAD+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix __get_user_check() in case uaccess_* calls are
 not inlined
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Sep 30, 2019 at 4:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Sep 30, 2019 at 8:01 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > KernelCI reports that bcm2835_defconfig is no longer booting since
> > commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> > forcibly"):
> >
> >   https://lkml.org/lkml/2019/9/26/825
> >
> > I also received a regression report from Nicolas Saenz Julienne:
> >
> >   https://lkml.org/lkml/2019/9/27/263
> >
> > This problem has cropped up on arch/arm/config/bcm2835_defconfig
> > because it enables CONFIG_CC_OPTIMIZE_FOR_SIZE. The compiler tends
> > to prefer not inlining functions with -Os. I was able to reproduce
> > it with other boards and defconfig files by manually enabling
> > CONFIG_CC_OPTIMIZE_FOR_SIZE.
> >
> > The __get_user_check() specifically uses r0, r1, r2 registers.
> > So, uaccess_save_and_enable() and uaccess_restore() must be inlined
> > in order to avoid those registers being overwritten in the callees.
> >
> > Prior to commit 9012d011660e ("compiler: allow all arches to enable
> > CONFIG_OPTIMIZE_INLINING"), the 'inline' marker was always enough for
> > inlining functions, except on x86.
> >
> > Since that commit, all architectures can enable CONFIG_OPTIMIZE_INLINING.
> > So, __always_inline is now the only guaranteed way of forcible inlining.
> >
> > I want to keep as much compiler's freedom as possible about the inlining
> > decision. So, I changed the function call order instead of adding
> > __always_inline around.
> >
> > Call uaccess_save_and_enable() before assigning the __p ("r0"), and
> > uaccess_restore() after evacuating the __e ("r0").
> >
> > Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> The patch looks reasonable to me, but I think we should also revert
> commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly") in mainline for now, as it caused this to happen all the time rather
> than only for users that expliticly select CONFIG_OPTIMIZE_INLINING.
>
> We have had other bug reports starting with that commit that run into
> similar issues, and I'm sure there are more of them. I don't mind having it
> in linux-next for a while long, but I think it was premature to have it merged
> into mainline.
>
>         Arnd


Hmm, I know you are testing randconfig build tests,
but how many people are testing the kernel boot in linux-next?

People and kernelci started to report the issue immediately
after it landed in the mainline...


-- 
Best Regards
Masahiro Yamada
