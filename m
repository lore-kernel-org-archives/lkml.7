Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C015AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E90218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfCOXTA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:19:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50009 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfCOXS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:18:59 -0400
Received: from [IPv6:2601:646:8680:2bb1:c81e:e06a:248a:3adc] ([IPv6:2601:646:8680:2bb1:c81e:e06a:248a:3adc])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2FNIdg71774044
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 15 Mar 2019 16:18:41 -0700
Date:   Fri, 15 Mar 2019 16:18:31 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190315222906.GC112750@google.com>
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com> <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com> <20190315222906.GC112750@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
To:     Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   hpa@zytor.com
Message-ID: <33DE9AEF-C51C-4021-97FD-BEE2C5D98DBE@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 15, 2019 3:29:06 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
>Hi Nick,
>
>On Fri, Mar 15, 2019 at 02:31:09PM -0700, 'Nick Desaulniers' via Clang
>Built Linux wrote:
>> On Fri, Mar 15, 2019 at 12:54 PM Matthias Kaehlcke <mka@chromium.org>
>wrote:
>> >
>> > Building the 32-bit vDSO with a recent clang version fails due
>> > to undefined symbols:
>> >
>> > arch/x86/entry/vdso/vdso32.so.dbg: undefined symbols found
>> >
>> > The undefined symbol in this case is __lshrdi3, which is part of
>> > the compiler runtime library, however the vDSO isn't linked against
>> > this library.
>> >
>> > Include the kernel version of __lshrdi3 in the 32-bit vDSO build.
>> 
>> __lshrdi3 is used for "logical shift right double-word by int" (best
>> guess), so anywhere there's a right shift of a u64.  Looks like
>> there's a few of these in arch/x86/entry/vdso/, so it's legal for the
>> compiler to emit this libcall.  Do you know which function
>> specifically in the .so has a relocation referencing __lshrdi3
>> specifically?
>
>It's the right shifts in do_realtime() and do_monotonic().
>
>> Is there a config I can set to reproduce this, in order to help
>> test?
>
>I encountered it with a Chrome OS specific configuration, but a
>defconfig should do. Note that you probably need a development version
>of clang to reproduce this.
>
>> >
>> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> > ---
>> >  arch/x86/entry/vdso/Makefile | 7 ++++++-
>> >  lib/lshrdi3.c                | 4 +++-
>> >  2 files changed, 9 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/x86/entry/vdso/Makefile
>b/arch/x86/entry/vdso/Makefile
>> > index 5bfe2243a08f..7517cd87e10b 100644
>> > --- a/arch/x86/entry/vdso/Makefile
>> > +++ b/arch/x86/entry/vdso/Makefile
>> > @@ -144,6 +144,7 @@ KBUILD_CFLAGS_32 += $(call cc-option,
>-fno-stack-protector)
>> >  KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
>> >  KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
>> >  KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
>> > +KBUILD_CFLAGS_32 += -DBUILD_VDSO
>> >
>> >  ifdef CONFIG_RETPOLINE
>> >  ifneq ($(RETPOLINE_VDSO_CFLAGS),)
>> > @@ -153,12 +154,16 @@ endif
>> >
>> >  $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
>> >
>> > +$(obj)/vdso32/lshrdi3.o: $(srctree)/lib/lshrdi3.c FORCE
>> > +       $(call if_changed_rule,cc_o_c)
>> 
>> + Masahiro to help look at this part (I don't understand this part
>> of kbuild).
>
>I bluntly stole that from arch/x86/purgatory/Makefile , which does
>something similar.
>
>> 
>> > +
>> >  $(obj)/vdso32.so.dbg: FORCE \
>> >                       $(obj)/vdso32/vdso32.lds \
>> >                       $(obj)/vdso32/vclock_gettime.o \
>> >                       $(obj)/vdso32/note.o \
>> >                       $(obj)/vdso32/system_call.o \
>> > -                     $(obj)/vdso32/sigreturn.o
>> > +                     $(obj)/vdso32/sigreturn.o \
>> > +                     $(obj)/vdso32/lshrdi3.o
>> >         $(call if_changed,vdso)
>> >
>> >  #
>> > diff --git a/lib/lshrdi3.c b/lib/lshrdi3.c
>> > index 99cfa5721f2d..8a4fc6bcf3a4 100644
>> > --- a/lib/lshrdi3.c
>> > +++ b/lib/lshrdi3.c
>> > @@ -16,7 +16,7 @@
>> >   * to the Free Software Foundation, Inc.
>> >   */
>> >
>> > -#include <linux/module.h>
>> > +#include <linux/export.h>
>> 
>> Is this a simple cleanup, or?
>
>The vDSO build is unhappy when modules.h draws in a whole bunch of
>other kernel headers and export.h is all that's need. It seemed
>reasonable to do the 'cleanup' in this patch since we touch it anyway
>to place EXPORT_SYMBOL within an #ifdef.
>
>> >  #include <linux/libgcc.h>
>> >
>> >  long long notrace __lshrdi3(long long u, word_type b)
>> > @@ -42,4 +42,6 @@ long long notrace __lshrdi3(long long u,
>word_type b)
>> >
>> >         return w.ll;
>> >  }
>> > +#ifndef BUILD_VDSO
>> >  EXPORT_SYMBOL(__lshrdi3);
>> > +#endif
>> 
>> Compilers (GCC and Clang) will always assume their runtime has these
>> helper functions; whether or not they emit libcalls vs inline
>routines
>> is implementation defined.  So I agree with this patch; I just would
>> like to help confirm/test it.
>
>Thanks for your help!
>
>Matthias

Note: it is also probably no reason to use -Os/-Oz for the vdso.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
