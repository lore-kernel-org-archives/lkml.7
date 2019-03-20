Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBDEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8BA2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RnueoKjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCTOHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:07:06 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:50348 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:07:06 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2KE6v9Z008986
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 23:06:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2KE6v9Z008986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553090817;
        bh=ZpljRSfbGyTC2cPvq+XXud3imeukOcnalEgs+TCdt60=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RnueoKjwW5zEWXGUBWDDVvFrIK4vXQrVwc7sdqlOyrROLJyiA7ydZqCb5eZ0pf2Gk
         SFYy+jBwplUlSk3vIsO6fsLw3hTZ/6UNzB+P0BDZtq9Ll9l2ETKbzF/TgDVC6mdz+P
         H39MUJQ/JCyYlhyVG/L9jcdfqOS+EcToIQmwytPreT6DhnNJAQYJAtOk43Uok91agS
         tEhiP8AITTuX0iCC+if9QKaeQOMVZs1qN3rXPgKaJrP++tl82HdWcHqSPenlILFXAb
         ALqB6iVnHJrsU4rDbNQ53w16P8KS44PKuUougWNFR6aELwlkM0qYvlI/SoQL9u2XCv
         cUoT1HVcy72Mg==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id z6so1566528vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:06:57 -0700 (PDT)
X-Gm-Message-State: APjAAAUWRxeTM0zgrsI1o+04WAmuRboV2vh5nCUxDKE6mSmXTAkZRd5A
        bQiQ1bDoKWgKEgDG7a326s7jTywN/+B8WAI8FL8=
X-Google-Smtp-Source: APXvYqzASh0y6AZUStVgn2eYWJv9AZ+tFjhN2rpvg6IW7tLrTPQ9OMX1sDfcF7RrS8LEaI7UKwNTEoHdmnklUjGyEVE=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr4999206vsc.155.1553090816117;
 Wed, 20 Mar 2019 07:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
 <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
In-Reply-To: <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Mar 2019 23:06:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT5JkoONtDzrG6Ft6xxdYUcc5-H2CSGO_9zGsbykbE7Eg@mail.gmail.com>
Message-ID: <CAK7LNAT5JkoONtDzrG6Ft6xxdYUcc5-H2CSGO_9zGsbykbE7Eg@mail.gmail.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 6:32 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
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
>
> Is there a config I can set to reproduce this, in order to help test?
>
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
> + Masahiro to help look at this part (I don't understand this part of kbuild).


This is a copy from scripts/Makefile.build,
which is globally used to compile %.c -> %.o



--
Best Regards
Masahiro Yamada
