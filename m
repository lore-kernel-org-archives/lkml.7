Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A9AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BFD20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfCMURu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:17:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37953 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMURu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:17:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id m1so2998631otf.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/mXpmakv6imNbTS8MmVhOFORBB0KE0VQhcEqeFl01w=;
        b=ZT4Za+xgwRR80v54ZQAnpmALmyoxfstweNJAUkbPMBdXXBVaPSG1wnpfDgXsIBt8aA
         AZxkPuAVU+GJmHFBYVMDo0TSiq2Yfor0j3aEdRvSb0XKdA3YjBZB7v22eiFvTtpxCS4E
         rzrupmookyRjDtDIgLmt4+G/cp0gF33yWpL12DY7+XiB/kisbWs4xyCII27BMAYwcYqG
         T4CW9VYEKQjIsEXkQoP9UOr5g/QhaDBdzqaRunfXVHPdChjz2GSLvkwoffxRCw1X4jGM
         hX8AUIGp4wZZauPIyH+6lMmm5lofYvn9nmtoeD5TdEVhZD5t9z76YehXx17iYUu2BkRd
         zEKQ==
X-Gm-Message-State: APjAAAUZWl0m1jkxCJ5NLpki6DkKp7hxkYPflze5iz6Fq11jrY8j1PSZ
        +rPqlVFQiXC0uaWmNeHC9tdCKq+rEAQvG3PVIqI=
X-Google-Smtp-Source: APXvYqx24alyJ3Yt4w8D8c4j43I99OkdaVG7ntyqaOkKqOAwOclQEbGJQ4yCCPfaIzDOm0+GQ5xFszCNoRUzg/XZ2pw=
X-Received: by 2002:a9d:7841:: with SMTP id c1mr29656545otm.354.1552508268714;
 Wed, 13 Mar 2019 13:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
 <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com> <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com>
In-Reply-To: <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 13 Mar 2019 21:17:37 +0100
Message-ID: <CA+7wUsxruu0GdyRGJ3vsjRvSBAptMn8_f5BmeMo=-E3zbhGGxQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 3:26 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Feb 16, 2019 at 1:11 AM Mathieu Malaterre <malat@debian.org> wrote:
> >
> > On Fri, Feb 15, 2019 at 10:41 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > I often test all Kconfig commands for all architectures. To ease my
> > > workflow, I want 'make defconfig' at least working without any cross
> > > compiler.
> > >
> > > Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
> > > default defconfig source.
> > >
> > > If CROSS_COMPILE is unset, it is likely to be the native build, so
> > > 'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
> > > the user is cross-building (i.e. 'uname -m' is probably x86_64), so
> > > it falls back to ppc64_defconfig. Yup, make sense.
> > >
> > > However, I want to run 'make ARCH=* defconfig' without setting
> > > CROSS_COMPILE for each architecture.
> > >
> > > My suggestion is to check $(origin ARCH).
> > >
> > > When you cross-compile the kernel, you need to set ARCH from your
> > > environment or from the command line.
> > >
> > > For the native build, you do not need to set ARCH. The default in
> > > the top Makefile is used:
> > >
> > >   ARCH            ?= $(SUBARCH)
> > >
> > > Hence, $(origin ARCH) returns 'file'.
> > >
> > > Before this commit, 'make ARCH=powerpc defconfig' failed:
> >
> > In case you have not seen it, please check:
> >
> > http://patchwork.ozlabs.org/patch/1037835/
>
>
> I did not know that because I do not subscribe to ppc ML.
>
>
> Michael's patch looks good to me.

OK

>
> If you mimic x86, the following will work:
>

Nice! Michael do you have a preference ?

>
>
> diff --git a/Makefile b/Makefile
> index 86cf35d..eb9552d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -356,6 +356,11 @@ ifeq ($(ARCH),sh64)
>         SRCARCH := sh
>  endif
>
> +# Additional ARCH settings for powerpc
> +ifneq ($(filter ppc%,$(ARCH)),)
> +       SRCARCH := powerpc
> +endif
> +
>  KCONFIG_CONFIG ?= .config
>  export KCONFIG_CONFIG
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 488c9ed..ff01fef 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -34,10 +34,10 @@ ifdef CONFIG_PPC_BOOK3S_32
>  KBUILD_CFLAGS          += -mcpu=powerpc
>  endif
>
> -ifeq ($(CROSS_COMPILE),)
> -KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
> -else
> +ifeq ($(ARCH),powerpc)
>  KBUILD_DEFCONFIG := ppc64_defconfig
> +else
> +KBUILD_DEFCONFIG := $(ARCH)_defconfig
>  endif
>
>  ifdef CONFIG_PPC64
> diff --git a/scripts/subarch.include b/scripts/subarch.include
> index 6506828..c98323f 100644
> --- a/scripts/subarch.include
> +++ b/scripts/subarch.include
> @@ -8,6 +8,6 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e
> s/x86_64/x86/ \
>                                   -e s/sun4u/sparc64/ \
>                                   -e s/arm.*/arm/ -e s/sa110/arm/ \
>                                   -e s/s390x/s390/ -e s/parisc64/parisc/ \
> -                                 -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
> +                                 -e s/mips.*/mips/ \
>                                   -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
>                                   -e s/riscv.*/riscv/)
>
>
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
