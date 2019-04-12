Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187B2C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2B20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfDLIuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:50:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55560 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfDLIuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:50:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49CAC374;
        Fri, 12 Apr 2019 01:50:21 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFBDA3F59C;
        Fri, 12 Apr 2019 01:50:19 -0700 (PDT)
Date:   Fri, 12 Apr 2019 09:50:13 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: vdso: use $(LD) instead of $(CC) to link VDSO
Message-ID: <20190412085013.GA11629@fuggles.cambridge.arm.com>
References: <20190411093015.6529-1-yamada.masahiro@socionext.com>
 <CAKwvOd=es2zG74T+BGbt_T8cHCPNATkmHBA4Hboyy_7=9Bgipg@mail.gmail.com>
 <CAK7LNAT3=tbf+1KZ+VQRdiBKk9p90EqXL9D8Hk6Ucbv92CRyNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT3=tbf+1KZ+VQRdiBKk9p90EqXL9D8Hk6Ucbv92CRyNQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Apr 12, 2019 at 10:21:38AM +0900, Masahiro Yamada wrote:
> On Fri, Apr 12, 2019 at 3:20 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > On Thu, Apr 11, 2019 at 2:30 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > We use $(LD) to link vmlinux, modules, decompressors, etc.
> > >
> > > VDSO is the only exceptional case where $(CC) is used as the linker
> > > driver, but I do not know why we need to do so. VDSO uses a special
> > > linker script, and does not link standard libraries at all.
> > >
> > > I changed the Makefile to use $(LD) rather than $(CC). I tested this,
> > > and VDSO worked for me.
> > >
> > > Users will be able to use their favorite linker (e.g. lld instead of
> > > of bfd) by passing LD= from the command line.
> > >
> > > My plan is to rewrite all VDSO Makefiles to use $(LD), then delete
> > > cc-ldoption.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > ---
> > >
> > >  arch/arm64/kernel/vdso/Makefile | 13 +++----------
> > >  1 file changed, 3 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > > index a0af6bf6c11b..744b9dbaba03 100644
> > > --- a/arch/arm64/kernel/vdso/Makefile
> > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > @@ -12,17 +12,12 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
> > >  targets := $(obj-vdso) vdso.so vdso.so.dbg
> > >  obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
> > >
> > > -ccflags-y := -shared -fno-common -fno-builtin
> >
> > Thanks for the patch; in general LGTM. Just some small questions:
> >
> > Looks like -shared and -fno-common are linker flags forwarded along,
> > but -fno-builtin is meant for the compiler, right?
> 
> Definitely, -shared must be passed to the linker
> to create a shared object.
> It is listed in the linker option list:
> https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/Link-Options.html#Link-Options
> 
> 
> 
> I think -fno-common is a compiler flag instead of a linker one
> as far as I understand this:
> https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/Code-Gen-Options.html#Code-Gen-Options
> 
> 
> -fno-builtin is a compiler flag:
> https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/C-Dialect-Options.html#C-Dialect-Options
> 
> 
> 
> > Do we want to keep
> > that in ccflags?
> 
> All source files in arch/arm64/kernel/vdso/
> are written in assembly (gettimeofday.S note.S sigreturn.S).
> 
> So, -fno-common -fno-builtin for ccflags-y
> are not used.
> 
> That's why I dropped them.
> 
> If we want to keep them just in case,
> it is fine with me too.

I think dropping this is fine for now, but be aware that there is ongoing
work to rewrite the vdso in C, in which case we may want that back. Much
of the Makefile will probably get reworked when that happens anyway, so
no need to worry.

> >  I'm not sure why it would have been added
> > intentionally; maybe Will knows?  Maybe it's ok to drop.
> 
> They have been here since the initial VDSO support
> by commit 9031fefde6f2a.
> 
> Will, do you remember why you added these flags?

Shamelessly lifted from ppc :)

> > > -ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
> > > -               $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> > > +ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
> > > +               $(call ld-option, --hash-style=sysv) -n -T
> >
> > Forgive my ignorance, but the man page for ld makes it looks like the
> > -T argument requires a subsequent argument `scriptfile`.  Is that what
> > `$(real-prereqs)` was doing below? If so, is dropping it in this patch
> > intentional?
> 
> I just re-used cmd_ld in scripts/Makefile.lib
> 
> 
> It will be expanded like follows:
> 
> cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@
> 
>  ->
> 
>  $(LD) $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F)) $(real-prereqs) -o $@
> 
>  ->
> 
> $(LD) -shared -nostdlib -soname=linux-vdso.so.1 \
>      --hash-style=sysv -n -T \
>     $(obj)/vdso.lds $(obj-vdso) -o $(obj)/vdso.so.dbg

Yeah, this still works, but boy is it ugly to have that dangling -T and
then grabbing the linker script from extra-y! That's also my fault though,
so I think your patch is ok.

Will
