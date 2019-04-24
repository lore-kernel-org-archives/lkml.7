Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C2BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4523218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dfrpAScN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfDXGiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:38:09 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:21898 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDXGiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:38:09 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x3O6bksK031930;
        Wed, 24 Apr 2019 15:37:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x3O6bksK031930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556087867;
        bh=WnyTu3J5NAIj1IpFkhgPC1wY3fyU4SaEQPnxyOQqVRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dfrpAScNw0WY+ko66o0foQkhFhpUUUQJnlOaYvpuERRiOHMM1imN2K7QODJoyHDsZ
         N6x/ua9FC2PHYG5s+QYEIwucmJxW4mlYk0HofN4Y9Dyt8hK4LRqHUCqFyqOqlp91BG
         yD70Zq1Yj7ZV+2uWi47/Yud/qgE1Qh5BgFuCeKq2agq9tTYc/FTV1ndRJHqcOeyl5e
         y+JN35P7j/rcqrsi6FYmEdaRbkGwzfSkFnlFaL7aT13zhzoDlu+ACPjuN6k6qg9wC4
         h/12xnNAjpks6i+i4YdHYicm3YVcqaT/6uzsGNg0vjGlm99/5y2qCUSpvPVlqsZ4CL
         EKX7sAnsmbFmQ==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id h127so3769230vkd.12;
        Tue, 23 Apr 2019 23:37:46 -0700 (PDT)
X-Gm-Message-State: APjAAAUfC7/Xn0kdpBw8YXmUTiCY/bDNIUpVSqEs4Cf6ibi5nG6YZAYW
        CPbauWzZ38yAqh4a4U7MHZAwBjlMu0hO4xmiosU=
X-Google-Smtp-Source: APXvYqxQj6VuyACgko7vNqr4tJsVAqJrH/UipMI6Pr95+3voAQy4eQcSUeg0ykiSyf2GfjkRAL2jjVKKmd2k7Aykl8E=
X-Received: by 2002:a1f:5343:: with SMTP id h64mr3027965vkb.34.1556087865539;
 Tue, 23 Apr 2019 23:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190423202907.234180-1-ndesaulniers@google.com> <CAMuHMdX9hKQHitf3b8861dnTt+aJOaOiytxqBzgprBdCPnL18Q@mail.gmail.com>
In-Reply-To: <CAMuHMdX9hKQHitf3b8861dnTt+aJOaOiytxqBzgprBdCPnL18Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Apr 2019 15:37:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNATChymboE805YWiVxiT==P0arGXVutxi_h2+b4P=_oTPg@mail.gmail.com>
Message-ID: <CAK7LNATChymboE805YWiVxiT==P0arGXVutxi_h2+b4P=_oTPg@mail.gmail.com>
Subject: Re: [PATCH] sh: require --Wl,--hash-style=sysv
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirsky <luto@kernel.org>,
        clang-built-linux@googlegroups.com,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 3:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Nick,
>
> On Tue, Apr 23, 2019 at 10:31 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > Towards the goal of removing cc-ldoption, prefer ld-option, or better
> > yet, require --Wl,--hash-style=sysv since the selftest for vdso's
> > requires DT_HASH.
> >
> > Cc: Andy Lutomirsky <luto@kernel.org>
> > Cc: clang-built-linux@googlegroups.com
> > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Thanks for your patch!
>
> > --- a/arch/sh/kernel/vsyscall/Makefile
> > +++ b/arch/sh/kernel/vsyscall/Makefile
> > @@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
> >
> >  export CPPFLAGS_vsyscall.lds += -P -C -Ush
> >
> > -vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
> > -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
> >
> >  SYSCFLAGS_vsyscall-trapa.so    = $(vsyscall-flags)
>
> What impact does this have on the minimum binutils version needed to
> compile the kernel?
>


See his ia64 variant:
https://lore.kernel.org/patchwork/patch/1065347/


He commented a stronger reason
"it seems that --hash-style= was added to binutils 2.17.50.0.2 in 2006.
The minimal required version of binutils for the kernel according to
Documentation/process/changes.rst is 2.20"


Nick,
Why don't you rephrase the commit log like your ia64 one?
It will clarify this change has no impact.


BTW, I think the subject should be
"-Wl,--hash-style=sysv" instead of
"--Wl,--hash-style=sysv"

(single hash before "Wl")




--
Best Regards
Masahiro Yamada
