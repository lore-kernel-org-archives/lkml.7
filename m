Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B175C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE85A20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PvSL5zC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDLBWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:22:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:43188 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDLBWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:22:39 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3C1MF43025785
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:22:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3C1MF43025785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555032136;
        bh=5IpeB7GhZQnuq/2z4ByNOOwWab5dBJZ/HkI9MBONbZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PvSL5zC1tcQthsZZwoKoy3bY/lRX8srEGE/SgcdvmPULlCcNjwoCDCOsDOrKZ/9Hc
         saxhpRaTl9MgZsL9E9b6mhJVID5Cs3ALsNY+zDAcvDCu2f53AGpgUh/Vc+DQVbdGAO
         nSJPcP7DKunj9J2d8wKIl6hURXByZuB1K1UgSfT5nq8/42KuxcRUDBMDhP0hEUDplq
         3UnCspTUOBelCpnz/IEA+FYvOcdpkdUjWZNoWE2+0MunB2iB1/xnJ9ngbwkUeSQAn2
         kcpzCL9KQ86fM8DABDgaoxKXHrOzTeMaaddfDRwxClwQ/lFMrGOwcWYveDfNh2+GoU
         8xcqW/nDNr0cA==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id f22so4615264vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 18:22:15 -0700 (PDT)
X-Gm-Message-State: APjAAAURAJoSllTUgSvKRC0eAIoIwtlkEjYqIiqU5qj8bII3GRpUsC9L
        B+HJv59w6c4qerUN5W0vRJ+g9O2YJY0QPa7tM0A=
X-Google-Smtp-Source: APXvYqydNZqalNWOvRuN+Zm0XmTHx+7x4EnU3M/p3isrr66pohRhUkJCZNpL86T1K4Ub9HO/rgTmL5OzXFh1OlqHTRs=
X-Received: by 2002:a67:f714:: with SMTP id m20mr30767894vso.211.1555032134648;
 Thu, 11 Apr 2019 18:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190411093015.6529-1-yamada.masahiro@socionext.com> <CAKwvOd=es2zG74T+BGbt_T8cHCPNATkmHBA4Hboyy_7=9Bgipg@mail.gmail.com>
In-Reply-To: <CAKwvOd=es2zG74T+BGbt_T8cHCPNATkmHBA4Hboyy_7=9Bgipg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 12 Apr 2019 10:21:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3=tbf+1KZ+VQRdiBKk9p90EqXL9D8Hk6Ucbv92CRyNQ@mail.gmail.com>
Message-ID: <CAK7LNAT3=tbf+1KZ+VQRdiBKk9p90EqXL9D8Hk6Ucbv92CRyNQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: use $(LD) instead of $(CC) to link VDSO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, Apr 12, 2019 at 3:20 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Apr 11, 2019 at 2:30 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > We use $(LD) to link vmlinux, modules, decompressors, etc.
> >
> > VDSO is the only exceptional case where $(CC) is used as the linker
> > driver, but I do not know why we need to do so. VDSO uses a special
> > linker script, and does not link standard libraries at all.
> >
> > I changed the Makefile to use $(LD) rather than $(CC). I tested this,
> > and VDSO worked for me.
> >
> > Users will be able to use their favorite linker (e.g. lld instead of
> > of bfd) by passing LD= from the command line.
> >
> > My plan is to rewrite all VDSO Makefiles to use $(LD), then delete
> > cc-ldoption.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/arm64/kernel/vdso/Makefile | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > index a0af6bf6c11b..744b9dbaba03 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -12,17 +12,12 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
> >  targets := $(obj-vdso) vdso.so vdso.so.dbg
> >  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
> >
> > -ccflags-y := -shared -fno-common -fno-builtin
>
> Thanks for the patch; in general LGTM. Just some small questions:
>
> Looks like -shared and -fno-common are linker flags forwarded along,
> but -fno-builtin is meant for the compiler, right?

Definitely, -shared must be passed to the linker
to create a shared object.
It is listed in the linker option list:
https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/Link-Options.html#Link-Options



I think -fno-common is a compiler flag instead of a linker one
as far as I understand this:
https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/Code-Gen-Options.html#Code-Gen-Options


-fno-builtin is a compiler flag:
https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/C-Dialect-Options.html#C-Dialect-Options



> Do we want to keep
> that in ccflags?

All source files in arch/arm64/kernel/vdso/
are written in assembly (gettimeofday.S note.S sigreturn.S).

So, -fno-common -fno-builtin for ccflags-y
are not used.

That's why I dropped them.

If we want to keep them just in case,
it is fine with me too.


>  I'm not sure why it would have been added
> intentionally; maybe Will knows?  Maybe it's ok to drop.

They have been here since the initial VDSO support
by commit 9031fefde6f2a.

Will, do you remember why you added these flags?




> > -ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
> > -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > +ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> > +               $(call ld-option, --hash-style=sysv) -n -T
>
> Forgive my ignorance, but the man page for ld makes it looks like the
> -T argument requires a subsequent argument `scriptfile`.  Is that what
> `$(real-prereqs)` was doing below? If so, is dropping it in this patch
> intentional?

I just re-used cmd_ld in scripts/Makefile.lib


It will be expanded like follows:

cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@

 ->

 $(LD) $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F)) $(real-prereqs) -o $@

 ->

$(LD) -shared -nostdlib -soname=linux-vdso.so.1 \
     --hash-style=sysv -n -T \
    $(obj)/vdso.lds $(obj-vdso) -o $(obj)/vdso.so.dbg



-- 
Best Regards
Masahiro Yamada
