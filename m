Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C512C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E95218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PY2OTJMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfCOW3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:29:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34624 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfCOW3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:29:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so7413845pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tEqipMkmPrwuZy0D121gbGL9+fu8h62ZcrJU46Deif8=;
        b=PY2OTJMWhe8nWOnu9fcoaSh5m3Mlvj+LorPk2yvi51QDH/RN46ZtAG8eThQI8Bu+j9
         VufniDVkgiw8kIvmbziNZ809AxO1c9hhIVWANljmS+MQ0CwnxsYrHcvWvK26wFvfOwJl
         V3x3cOCqkqs6YBavygTSPJ4mXdiek1o+gLR1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tEqipMkmPrwuZy0D121gbGL9+fu8h62ZcrJU46Deif8=;
        b=aOXMWe5gnHWIlBxbKFTi9UXsrtk5Dm6xJ8V0KC/A6TviWazXTMK7cJBWKTyjV6nITC
         J1VqFjsTbe0RM8jzipoV2MbbY5VsK8xEo5bf6bL9kqDiV2zucFw6uBlAVSWmH/IfWA44
         mxrzDmUx0j136+1uPhqHR2b3QLeLO7evNPbcgueOMcBwUQPgmRjyzimmSsoc9aUlZHfU
         pCL4u6I36oNxN0wIWapsi6TfsSlpK+hyBXH07tLF32/lPMYBvhWNki8bWmEe7R34FXmt
         oWwZcA3vPo0ifpfK2c6e+mYpX4mI8TeMw0g+DnKJDw7vdN8+YTxEmj5TkIRayllHdGLa
         J3bQ==
X-Gm-Message-State: APjAAAXe4u4Q21FcXoa063z0vz+TT8ntiWebUkSrANnFkSyc70nDEmkm
        uN2WXM5nSxJNaliFZ87DmH4+nw==
X-Google-Smtp-Source: APXvYqy7LihTpgqltqd3Xx8vrQhv2VU8eTShuiqSUb8qBJxo2Sw5oMFIle9mV9a0SpqwfVxE4mIdkg==
X-Received: by 2002:a63:6f46:: with SMTP id k67mr5633363pgc.174.1552688947866;
        Fri, 15 Mar 2019 15:29:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j4sm4252130pfn.132.2019.03.15.15.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 15:29:07 -0700 (PDT)
Date:   Fri, 15 Mar 2019 15:29:06 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
Message-ID: <20190315222906.GC112750@google.com>
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
 <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, Mar 15, 2019 at 02:31:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Fri, Mar 15, 2019 at 12:54 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Building the 32-bit vDSO with a recent clang version fails due
> > to undefined symbols:
> >
> > arch/x86/entry/vdso/vdso32.so.dbg: undefined symbols found
> >
> > The undefined symbol in this case is __lshrdi3, which is part of
> > the compiler runtime library, however the vDSO isn't linked against
> > this library.
> >
> > Include the kernel version of __lshrdi3 in the 32-bit vDSO build.
> 
> __lshrdi3 is used for "logical shift right double-word by int" (best
> guess), so anywhere there's a right shift of a u64.  Looks like
> there's a few of these in arch/x86/entry/vdso/, so it's legal for the
> compiler to emit this libcall.  Do you know which function
> specifically in the .so has a relocation referencing __lshrdi3
> specifically?

It's the right shifts in do_realtime() and do_monotonic().

> Is there a config I can set to reproduce this, in order to help
> test?

I encountered it with a Chrome OS specific configuration, but a
defconfig should do. Note that you probably need a development version
of clang to reproduce this.

> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/x86/entry/vdso/Makefile | 7 ++++++-
> >  lib/lshrdi3.c                | 4 +++-
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> > index 5bfe2243a08f..7517cd87e10b 100644
> > --- a/arch/x86/entry/vdso/Makefile
> > +++ b/arch/x86/entry/vdso/Makefile
> > @@ -144,6 +144,7 @@ KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
> >  KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
> >  KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
> >  KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
> > +KBUILD_CFLAGS_32 += -DBUILD_VDSO
> >
> >  ifdef CONFIG_RETPOLINE
> >  ifneq ($(RETPOLINE_VDSO_CFLAGS),)
> > @@ -153,12 +154,16 @@ endif
> >
> >  $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
> >
> > +$(obj)/vdso32/lshrdi3.o: $(srctree)/lib/lshrdi3.c FORCE
> > +       $(call if_changed_rule,cc_o_c)
> 
> + Masahiro to help look at this part (I don't understand this part
> of kbuild).

I bluntly stole that from arch/x86/purgatory/Makefile , which does
something similar.

> 
> > +
> >  $(obj)/vdso32.so.dbg: FORCE \
> >                       $(obj)/vdso32/vdso32.lds \
> >                       $(obj)/vdso32/vclock_gettime.o \
> >                       $(obj)/vdso32/note.o \
> >                       $(obj)/vdso32/system_call.o \
> > -                     $(obj)/vdso32/sigreturn.o
> > +                     $(obj)/vdso32/sigreturn.o \
> > +                     $(obj)/vdso32/lshrdi3.o
> >         $(call if_changed,vdso)
> >
> >  #
> > diff --git a/lib/lshrdi3.c b/lib/lshrdi3.c
> > index 99cfa5721f2d..8a4fc6bcf3a4 100644
> > --- a/lib/lshrdi3.c
> > +++ b/lib/lshrdi3.c
> > @@ -16,7 +16,7 @@
> >   * to the Free Software Foundation, Inc.
> >   */
> >
> > -#include <linux/module.h>
> > +#include <linux/export.h>
> 
> Is this a simple cleanup, or?

The vDSO build is unhappy when modules.h draws in a whole bunch of
other kernel headers and export.h is all that's need. It seemed
reasonable to do the 'cleanup' in this patch since we touch it anyway
to place EXPORT_SYMBOL within an #ifdef.

> >  #include <linux/libgcc.h>
> >
> >  long long notrace __lshrdi3(long long u, word_type b)
> > @@ -42,4 +42,6 @@ long long notrace __lshrdi3(long long u, word_type b)
> >
> >         return w.ll;
> >  }
> > +#ifndef BUILD_VDSO
> >  EXPORT_SYMBOL(__lshrdi3);
> > +#endif
> 
> Compilers (GCC and Clang) will always assume their runtime has these
> helper functions; whether or not they emit libcalls vs inline routines
> is implementation defined.  So I agree with this patch; I just would
> like to help confirm/test it.

Thanks for your help!

Matthias
