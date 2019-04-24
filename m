Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33C8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67728218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KfpSG7ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfDXGkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:40:23 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:35988 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDXGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:40:22 -0400
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x3O6e7Tm001458;
        Wed, 24 Apr 2019 15:40:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x3O6e7Tm001458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556088008;
        bh=oDafs3VZXSSu5xoDlOXLdYOrCRqoXXFkxL0xgFY1HzY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KfpSG7ts6U5ZM2c+qxbNC9Et/GPrP4zZ5z+uZVVj6GOLhS5N96H5RcyCEFKkXUeMJ
         JSXwDwM72wBOhYEMOlwDw3ViDXhMFY+hrmARSdb1l/dj7R49pPDkuKdZaOiGMXWfuq
         McZDjcbqkvZyS+M29JcypOHd98wfJcZQ+Lnh8VxOOniPPH9sfq9NxFryp6d2uCwkFl
         IO/rQYt/h3sofiuCMoyXlewmcOMPGzyRMAg1q0l2vzSj0WHLG4cO5vkI95kkZxP75F
         L/HtlpDChBsQTBH1fixjxCL8C/QHYlxkTGSLMrPynEu3AtixOcq4w6ovVSeBB0KX2I
         3eFwnk9U6LvoQ==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id s80so3782567vke.6;
        Tue, 23 Apr 2019 23:40:08 -0700 (PDT)
X-Gm-Message-State: APjAAAU+UdAIJk79KM6AV2HGRLwitjiXRRRzRMNz+e2WNqW4HX92vAVk
        r+de94n455/PVQD04QYS9h2e8hRAEXAC2U0VbDo=
X-Google-Smtp-Source: APXvYqzzeHmkcjCVzVtl6anD3lUWFGcz2Ee8P4hkZvdt1+3ufFAowJ/EtMOMBP2ilvpOxullCcKu4HdEEg24okgRlsE=
X-Received: by 2002:a1f:2fc7:: with SMTP id v190mr15649968vkv.84.1556088007056;
 Tue, 23 Apr 2019 23:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190423202907.234180-1-ndesaulniers@google.com>
 <CAMuHMdX9hKQHitf3b8861dnTt+aJOaOiytxqBzgprBdCPnL18Q@mail.gmail.com> <CAK7LNATChymboE805YWiVxiT==P0arGXVutxi_h2+b4P=_oTPg@mail.gmail.com>
In-Reply-To: <CAK7LNATChymboE805YWiVxiT==P0arGXVutxi_h2+b4P=_oTPg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Apr 2019 15:39:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
Message-ID: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
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

On Wed, Apr 24, 2019 at 3:37 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Wed, Apr 24, 2019 at 3:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Nick,
> >
> > On Tue, Apr 23, 2019 at 10:31 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > Towards the goal of removing cc-ldoption, prefer ld-option, or better
> > > yet, require --Wl,--hash-style=sysv since the selftest for vdso's
> > > requires DT_HASH.
> > >
> > > Cc: Andy Lutomirsky <luto@kernel.org>
> > > Cc: clang-built-linux@googlegroups.com
> > > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Thanks for your patch!
> >
> > > --- a/arch/sh/kernel/vsyscall/Makefile
> > > +++ b/arch/sh/kernel/vsyscall/Makefile
> > > @@ -15,8 +15,7 @@ quiet_cmd_syscall = SYSCALL $@
> > >
> > >  export CPPFLAGS_vsyscall.lds += -P -C -Ush
> > >
> > > -vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 \
> > > -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > > +vsyscall-flags = -shared -s -Wl,-soname=linux-gate.so.1 -Wl,--hash-style=sysv
> > >
> > >  SYSCFLAGS_vsyscall-trapa.so    = $(vsyscall-flags)
> >
> > What impact does this have on the minimum binutils version needed to
> > compile the kernel?
> >
>
>
> See his ia64 variant:
> https://lore.kernel.org/patchwork/patch/1065347/
>
>
> He commented a stronger reason
> "it seems that --hash-style= was added to binutils 2.17.50.0.2 in 2006.
> The minimal required version of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20"
>
>
> Nick,
> Why don't you rephrase the commit log like your ia64 one?
> It will clarify this change has no impact.
>
>
> BTW, I think the subject should be
> "-Wl,--hash-style=sysv" instead of
> "--Wl,--hash-style=sysv"
>
> (single hash before "Wl")

I mean "single dash"
just in case.  :)




-- 
Best Regards
Masahiro Yamada
