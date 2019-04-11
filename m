Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D97C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFD72184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDKIwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:52:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36141 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfDKIwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:52:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so6195922qtn.3;
        Thu, 11 Apr 2019 01:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zy5eU/X8uvoizIixQhEjfBDwS0KODN980Otb5tvnTB8=;
        b=LzZdlU29O1VSiwgoVEi3jetHYh+a6ghndQ2U0exx01dIBMZMo7gTPUBQCE7sd76Sx/
         2d1jKD67Lwu6CKfJui+qhO4ZBqZMtvaiyb3cJNSYrmmnP3zs9d21WfRRkR8S6Gjq0Cwk
         ceuzGWmwkqSqwXTyrwCpvMlVR339SGhDEhOC9L6JALeMiiRjLB8Lpx9/KGczy74+sXIm
         3LQU3BrW0hkQk5XwZ3R1zLB39xlT5upO3BOUawYoPA+oqnmtBUSRbCMW1q/8SJprRmBh
         bvPWXn9LBRYmBAsRziYPgFmL74GqppWD66E/vXShiQa1/sD6h18RcT55EZqp/RZ3dw+S
         KZ+g==
X-Gm-Message-State: APjAAAX1HRlLkkehPBF+3aC7ULOd5sG4O2THPTs+DtWzDmy/uco04Ppa
        TLkYeCd4iefaI7Ror6A3qhah4D6mIzBfJdTUVYk=
X-Google-Smtp-Source: APXvYqwJoZVV1mebIzfAeQabt4hOsUc56+8AT7clKkoNQp48IGLslRYLfw8NmpVZk4urczYAHfNrbk/q+ogwTghrAcY=
X-Received: by 2002:ac8:8b9:: with SMTP id v54mr41886760qth.64.1554972741726;
 Thu, 11 Apr 2019 01:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de> <20190410201300.3528984-2-arnd@arndb.de>
 <CAKwvOdk-tfsZRVaOr8Suv5C146F-w3jUA-Rx0n2OxkVy+L8tCg@mail.gmail.com>
In-Reply-To: <CAKwvOdk-tfsZRVaOr8Suv5C146F-w3jUA-Rx0n2OxkVy+L8tCg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Apr 2019 10:52:05 +0200
Message-ID: <CAK8P3a0cdvxkoRPOF7moxZ1W2059OEJeOGAFPfSemMH1_g=YPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390: boot, purgatory: pass $(CLANG_FLAGS) where needed
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:14 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The purgatory and boot Makefiles do not inherit the original cflags,
> > so clang falls back to the default target architecture when building it,
> > typically this would be x86 when cross-compiling.
> >
> > Add $(CLANG_FLAGS) everywhere so we pass the correct --target=s390x-linux
> > option when cross-compiling.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/s390/Makefile           | 5 +++--
> >  arch/s390/purgatory/Makefile | 1 +
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> > index 9c079a506325..443990791099 100644
> > --- a/arch/s390/Makefile
> > +++ b/arch/s390/Makefile
> > @@ -17,12 +17,13 @@ KBUILD_CFLAGS_MODULE += -fPIC
> >  KBUILD_AFLAGS  += -m64
> >  KBUILD_CFLAGS  += -m64
> >  aflags_dwarf   := -Wa,-gdwarf-2
> > -KBUILD_AFLAGS_DECOMPRESSOR := -m64 -D__ASSEMBLY__
> > +KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
> >  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> > -KBUILD_CFLAGS_DECOMPRESSOR := -m64 -O2
> > +KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
> >  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
> >  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
> >  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
>
> Thanks for the respin with Nathan's suggestion.
>
> > +KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning,pointer-sign)
>
> What's up with this ^ ?  Seems like the top level sets it (without
> cc-disable-warning :( ), but then KBUILD_CFLAGS_DECOMPRESSOR discards
> it.  Does Clang actually flag code in this arch (that GCC doesn't)?

Oops, that should have been a separate patch.

I think what happens is that clang warns more aggressively about pointer sign
bugs than gcc in some cases, and some of those cases happen in s390
header files that are included by both the kernel and the decompressor.

The full warning log without this change is rather long, see
https://pastebin.com/KG9xaTNB

I also tried patching the code to avoid the warnings, but I'm not entirely
happy with that result either, see
https://pastebin.com/pSMz5eZA

     Arnd
