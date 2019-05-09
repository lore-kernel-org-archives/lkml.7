Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EFC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A885E20863
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JCmHD6FJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfEIApO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 20:45:14 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:46571 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEIApN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 20:45:13 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x490infd010328;
        Thu, 9 May 2019 09:44:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x490infd010328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557362690;
        bh=0MJ5gBk9NRKE+Xi+tjUDFK3eCRm84EkfBQ9ymup5aDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JCmHD6FJ7iNgcYdHMB5zTIsTAP7bIjGlPPobtg1f2Q2FvhijqnOCXbOKna11KNeLQ
         WpMTsaOPSZQnUp5eopUmN8nRhBrSrw33r962kOmH/U5zm0+XCV34Nhj+vLd+iv7LWT
         0JS/gINTKHMBvZidFga5kouW0LBDrL9RaXG/IoGcBqrpVkV4yHqEuvApEwMTleFyk6
         5YDjjRh1aJ24jAOx9F8OWGS5s+dZUQe8O5ByYECWS6tvFRKln/LLLllRSIRDZikxPY
         7EC42+AlUaP+1POXNcl0TkcJq0Pwi2cJLTGk38Y7oyxttEHvA04tEwt0iV3eTabLE1
         L8yZFxsPVC81w==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id w13so318678vsc.4;
        Wed, 08 May 2019 17:44:50 -0700 (PDT)
X-Gm-Message-State: APjAAAWQnED/cgLloX4Wl10OdtYnTF/J24QxRMdZIG6xke6EBMbHdKrS
        nMTqnLH5bQzITOborouoMopiYaD/teW1pNTRHOU=
X-Google-Smtp-Source: APXvYqwujd8VQ7C7fjwmTWsVvb+gGV78HZwL+W/GhjjHb1n2rFF6hKbmLpl2sQdPvzBX0m4xAkUZgXoTgfMu6VgzPZE=
X-Received: by 2002:a67:fc4:: with SMTP id 187mr702130vsp.215.1557362689436;
 Wed, 08 May 2019 17:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASLBQ=w9YFBD80s7dit1bd_Tr+ggVyRNms0jf1pR9k=ZA@mail.gmail.com>
 <20190424180223.253025-1-ndesaulniers@google.com> <CAKwvOd=5SVBFsfEgYc9Dpgr--h+pQgCwOnpAjg9B4HG2VY6kFg@mail.gmail.com>
 <CAKwvOdkpjwgt3pP9rjZtm=rEK9MhEfQdc6PEr91Bnb9tMVDBEA@mail.gmail.com>
In-Reply-To: <CAKwvOdkpjwgt3pP9rjZtm=rEK9MhEfQdc6PEr91Bnb9tMVDBEA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 9 May 2019 09:44:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASL+oNNbZ4YaPtGnwka06sRr3Pz8HjjM7oxUC-JkvqF2Q@mail.gmail.com>
Message-ID: <CAK7LNASL+oNNbZ4YaPtGnwka06sRr3Pz8HjjM7oxUC-JkvqF2Q@mail.gmail.com>
Subject: Re: [PATCH v2] sh: vsyscall: drop unnecessary cc-ldoption
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Lutomirski <luto@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 5:13 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> bumping for review, as the merge window is now open.


sh is not very active these days.

I applied this to my kbuild tree.
I will send PR for this in the current MW.

Thanks.



> On Tue, Apr 30, 2019 at 1:26 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Apr 24, 2019 at 11:02 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > Towards the goal of removing cc-ldoption, it seems that --hash-style=
> > > was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> > > of binutils for the kernel according to
> > > Documentation/process/changes.rst is 2.20.
> > >
> > > Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> > > Cc: clang-built-linux@googlegroups.com
> > > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > > Changes V1 -> V2:
> > > * update commit subject and message as per Masahiro/Geert.
> > >
> > > To Geert's question about minimum binutils versions; no change needed to
> > > binutils.
> > >
> > >
> > >  arch/sh/kernel/vsyscall/Makefile | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
> > > index 5db6579bc44c..6e8664448048 100644
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
> > >
> > > --
> > > 2.21.0.593.g511ec345e18-goog
> > >
> >
> > bumping for review
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
