Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D671C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E9F20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ulyr0khH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbfJAOpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:45:52 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:18710 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388953AbfJAOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:45:52 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x91Ejjxr024273
        for <linux-kernel@vger.kernel.org>; Tue, 1 Oct 2019 23:45:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x91Ejjxr024273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569941145;
        bh=7Bvi5CB0Y/ucWirAJcxGpfKhycv9MrI86dSeJ1hyRV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ulyr0khHHe36KPGJCJrnxu8e9T8xzFpB1O00oAj36lfn4CUt3QcjhRrB9O/quF70h
         GU0U2qYbhlR9QGlWcmSbd3SyDCJYHJuLbHmNQCSfTqU5Tr4YqL+ZMpurdarZI46wk9
         tt3AeCrLDrLqQB+A6JEYHFOCn9sbXfuthFGALkFXKprHA2hTTzrTjKst8wCODA/nMl
         B64fmZtzxuOm+pPgQon20stGHrbGKj89oMRaVeeVJRnxG3uO6lML3eZz/Xqj9uboHQ
         OoMTUyMW3LsOC3M8CBdhlnx7C4b+GHYf6gtnu1XA61YAP7VHFFupW+OLofSCD6XkSS
         4HZ+2v6rfisCg==
X-Nifty-SrcIP: [209.85.222.174]
Received: by mail-qk1-f174.google.com with SMTP id y189so11485832qkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:45:45 -0700 (PDT)
X-Gm-Message-State: APjAAAWzHEBDSZh69LKo/Kue13FUZlnqUcy4mAiDt2ryutux77jZSrzM
        2CmDDurMezuCMh/SghDd75pkLmiJXPphiVL2JKo=
X-Google-Smtp-Source: APXvYqw0Ehg1E2Ssjw+hMDuLH3p9aLYQPiEv56ONeJimQdzQeXmDt6AGsA2prDioWim1q9bSODZXnTNt61n5WoZxtlA=
X-Received: by 2002:a05:620a:6b6:: with SMTP id i22mr6449417qkh.477.1569941144328;
 Tue, 01 Oct 2019 07:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191001121724.23886-1-yamada.masahiro@socionext.com> <CAMuHMdUFMC0hbv68Ggsu4q2A+OyHwS1kMsgjjRvxZ7qnqqov7A@mail.gmail.com>
In-Reply-To: <CAMuHMdUFMC0hbv68Ggsu4q2A+OyHwS1kMsgjjRvxZ7qnqqov7A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 1 Oct 2019 23:45:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRAOk4YxFxdCvjF_eQd84nted1rhsqGhX5-UK5WKaDvA@mail.gmail.com>
Message-ID: <CAK7LNARRAOk4YxFxdCvjF_eQd84nted1rhsqGhX5-UK5WKaDvA@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: clear local varaible to make it
 work for sh
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Oct 1, 2019 at 10:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Yamada-san,
>
> s/varaible/variable/ in subject.
>
> On Tue, Oct 1, 2019 at 2:17 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > Geert Uytterhoeven reports a strange side-effect of commit 858805b336be
> > ("kbuild: add $(BASH) to run scripts with bash-extension"), which
> > inserts the contents of a localversion file in the build directory twice.
> >
> > [Steps to Reproduce]
> >   $ echo bar > localversion
> >   $ mkdir build
> >   $ cd build/
> >   $ echo foo > localversion
> >   $ make -s -f ../Makefile defconfig include/config/kernel.release
> >   $ cat include/config/kernel.release
> >   5.4.0-rc1foofoobar
> >
> > This comes down to the behavior change of 'local' variables.
> >
> > The 'man sh' on my Ubuntu machine, where sh is an alias to dash,
> > explains as follows:
> >   When a variable is made local, it inherits the initial value and
> >   exported and readonly flags from the variable with the same name
> >   in the surrounding scope, if there is one. Otherwise, the variable
> >   is initially unset.
> >
> > [Test Code]
> >
> >   foo ()
> >   {
> >           local res
> >           echo "res: $res"
> >   }
> >
> >   res=1
> >   foo
> >
> > [Result]
> >
> >   $ sh test.sh
> >   res: 1
> >   $ bash test.sh
> >   res:
> >
> > So, scripts/setlocalversion correctly works only for bash in spite of
> > its hashbang being #!/bin/sh. Nobody had noticed it before because
> > CONFIG_SHELL was previously set to sh only when bash is missing, which
> > is very unlikely to happen.
> >
> > The benefit of commit 858805b336be is to make people write portable and
> > correct code. I gave it the Fixes tag since it uncovered the issue for
> > most of people.
> >
> > Clear the variable 'res' in collect_files() to make it work for sh
> > (and it also works on distributions where sh is an alias to bash).
> >
> > Fixes: commit 858805b336be ("kbuild: add $(BASH) to run scripts with bash-extension")
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Can you please use
>
>     Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> instead?

OK, I will.

Thanks.



> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Thanks, that fixes the issue for me!
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
