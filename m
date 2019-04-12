Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61C4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB4720652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCsP3gQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDLRYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:24:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44046 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:24:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so5496965pgj.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDBd90xKsrcm6fQT2OHL92uvFvh0KfrpQFA/w2s8GW8=;
        b=rCsP3gQlEL9RVkXn83BZq26uvx4aZ49c7YuqCfSlzqAcMcjnqcn4pq9aZVed751EPf
         22HqJNOyg86LWZZgr8EfXeXqJAPw2xGVhRidruPUeGNG8mZ+eJjG4kuB3uIFkcO1S4Yz
         KbW4r087BoVjzMOsPOOXmrHFzl5ITzfjj5dNa3fmkrb8dKI9JBibQip7gNQk6SFmp1GG
         Ig9dqwnS4tmJRijynefL+Q3m/wwYW7FUCqSA7wxAFJBirHTmM1n1DpPX7FMG/dkioFwm
         fnIwqDocTCQv14Vu30+sdKU9D9llw1fPGSw9DZHvcThuN3sk1QeuNdMrkbA1szhWX86S
         drQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDBd90xKsrcm6fQT2OHL92uvFvh0KfrpQFA/w2s8GW8=;
        b=ttSB3xTP+zUjpEPeo8Wv2FOcHqgVKGDuyvw3GltpqtgBSw4IipRGa2mtGNWmz3qAuo
         PF/BkpUN8kfnIixCF9CWPQhq26g9gKKc1y3hehdPn0/xFvmaZY4dQ65xj2GZtQT722IQ
         dfXNHfBPsvYQAar8E7E9zZcSWqX1t3Am/oPSaSmO3af7+dTNPth+kzD6vRZGn2yVa7KR
         WaPE1NvkUBrC/9ykTL6ojoatj6r7cMQaqPBLrWUyOmbHnVVitR7zCKD1egWx0RFMkO/c
         vSmvB+jMcdxxdkx1AM3TT6nQS9IXUParKYEzj4uE5tJFyni/vMmRYdg/nnYMPTJVXvTe
         Lk4Q==
X-Gm-Message-State: APjAAAVbGjALuLQvrWZ+jqxi2QNKB4esWfcYlZEKJN1IbFGbXzMa7wVQ
        XCG/oXbVjyRR/bOHV+JlRFp8DsD1mfDCHmDQrNL8P+0Ky34=
X-Google-Smtp-Source: APXvYqyOKTtylgCWfXbb+31mjRhXy50uTucTm/GvRL2l5irsvyAFYZsDTMgWB2DtoNDwcRb7/OhPPH4LTDSVT0tMEAQ=
X-Received: by 2002:a62:4558:: with SMTP id s85mr58166070pfa.171.1555089860942;
 Fri, 12 Apr 2019 10:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190411093015.6529-1-yamada.masahiro@socionext.com>
 <CAKwvOd=es2zG74T+BGbt_T8cHCPNATkmHBA4Hboyy_7=9Bgipg@mail.gmail.com>
 <CAK7LNAT3=tbf+1KZ+VQRdiBKk9p90EqXL9D8Hk6Ucbv92CRyNQ@mail.gmail.com> <20190412085013.GA11629@fuggles.cambridge.arm.com>
In-Reply-To: <20190412085013.GA11629@fuggles.cambridge.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Apr 2019 10:24:09 -0700
Message-ID: <CAKwvOdmdzK7N1nPNc5KTM1-7U=dYyDn74BdgDGRocDxv7v8foQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: vdso: use $(LD) instead of $(CC) to link VDSO
To:     Will Deacon <will.deacon@arm.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Fri, Apr 12, 2019 at 1:50 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi all,
>
> On Fri, Apr 12, 2019 at 10:21:38AM +0900, Masahiro Yamada wrote:
> > On Fri, Apr 12, 2019 at 3:20 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > On Thu, Apr 11, 2019 at 2:30 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > >
> > > > We use $(LD) to link vmlinux, modules, decompressors, etc.
> > > >
> > > > VDSO is the only exceptional case where $(CC) is used as the linker
> > > > driver, but I do not know why we need to do so. VDSO uses a special
> > > > linker script, and does not link standard libraries at all.
> > > >
> > > > I changed the Makefile to use $(LD) rather than $(CC). I tested this,
> > > > and VDSO worked for me.
> > > >
> > > > Users will be able to use their favorite linker (e.g. lld instead of
> > > > of bfd) by passing LD= from the command line.
> > > >
> > > > My plan is to rewrite all VDSO Makefiles to use $(LD), then delete
> > > > cc-ldoption.
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > ---
> > > >
> > > >  arch/arm64/kernel/vdso/Makefile | 13 +++----------
> > > >  1 file changed, 3 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > > > index a0af6bf6c11b..744b9dbaba03 100644
> > > > --- a/arch/arm64/kernel/vdso/Makefile
> > > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > > @@ -12,17 +12,12 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
> > > >  targets := $(obj-vdso) vdso.so vdso.so.dbg
> > > >  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
> > > >
> > > > -ccflags-y := -shared -fno-common -fno-builtin
> > >
> > > Thanks for the patch; in general LGTM. Just some small questions:
> > >
> > > Looks like -shared and -fno-common are linker flags forwarded along,
> > > but -fno-builtin is meant for the compiler, right?
> >
> > Definitely, -shared must be passed to the linker
> > to create a shared object.
> > It is listed in the linker option list:
> > https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/Link-Options.html#Link-Options
> >
> >
> >
> > I think -fno-common is a compiler flag instead of a linker one
> > as far as I understand this:
> > https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/Code-Gen-Options.html#Code-Gen-Options
> >
> >
> > -fno-builtin is a compiler flag:
> > https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/C-Dialect-Options.html#C-Dialect-Options
> >
> >
> >
> > > Do we want to keep
> > > that in ccflags?
> >
> > All source files in arch/arm64/kernel/vdso/
> > are written in assembly (gettimeofday.S note.S sigreturn.S).
> >
> > So, -fno-common -fno-builtin for ccflags-y
> > are not used.
> >
> > That's why I dropped them.
> >
> > If we want to keep them just in case,
> > it is fine with me too.
>
> I think dropping this is fine for now, but be aware that there is ongoing
> work to rewrite the vdso in C, in which case we may want that back. Much
> of the Makefile will probably get reworked when that happens anyway, so
> no need to worry.
>
> > >  I'm not sure why it would have been added
> > > intentionally; maybe Will knows?  Maybe it's ok to drop.
> >
> > They have been here since the initial VDSO support
> > by commit 9031fefde6f2a.
> >
> > Will, do you remember why you added these flags?
>
> Shamelessly lifted from ppc :)
>
> > > > -ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
> > > > -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > > > +ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> > > > +               $(call ld-option, --hash-style=sysv) -n -T
> > >
> > > Forgive my ignorance, but the man page for ld makes it looks like the
> > > -T argument requires a subsequent argument `scriptfile`.  Is that what
> > > `$(real-prereqs)` was doing below? If so, is dropping it in this patch
> > > intentional?
> >
> > I just re-used cmd_ld in scripts/Makefile.lib
> >
> >
> > It will be expanded like follows:
> >
> > cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@
> >
> >  ->
> >
> >  $(LD) $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F)) $(real-prereqs) -o $@
> >
> >  ->
> >
> > $(LD) -shared -nostdlib -soname=linux-vdso.so.1 \
> >      --hash-style=sysv -n -T \
> >     $(obj)/vdso.lds $(obj-vdso) -o $(obj)/vdso.so.dbg
>
> Yeah, this still works, but boy is it ugly to have that dangling -T and
> then grabbing the linker script from extra-y! That's also my fault though,
> so I think your patch is ok.
>
> Will

Will, thanks for the additional context.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
