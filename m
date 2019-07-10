Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196EBC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D643220665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIfExlZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfGJXm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:42:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35476 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfGJXm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:42:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so1833933pfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8wra02GeEP0SVg5sdKoUvO7OcYTQnTWkeSeWCcrhT0=;
        b=oIfExlZfIRhZ7FVUoexMOfO3VzFoeSLUjFHiaCi687FqmnIAHRxj5m5nV1R7MqGbzW
         Gd+wzR3f4AhjQJji14ivA5zoW6MrZTP6ZBk1+uasXwmBAcrW0/rXkD7MJAkr+WEZq/pa
         drBy+kVqVv9Iqxufv/pap5vDKWplfS15m1hBM+PSp7QdaniIesWMfm79UTPrPu685bNa
         U8E9a0NRTIUFvzpOUd5KqugCTzWhKHuSAnHKZaT5SmRnFnSuH/94N5SoyEdYbxaDJiqv
         vMPE2VaOYA90T3iAR+fpuI/ScZHT7ZLvU+FbY6d7gz+vpbYDRh96LvGKE3euIvko5q23
         2UaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8wra02GeEP0SVg5sdKoUvO7OcYTQnTWkeSeWCcrhT0=;
        b=B+TePBcsfwG9IgXrxbeD17w0C76bdiI04uAA6E4Cm3oP/Mx3ggRhPloQPRzo07/cH2
         nOTTdsPwS5NI8TQ2pcg7OOMDMpkkZ0BPc8wLDeKeFNTuOsXkfN7BTkuNFNrCoRDhHfTo
         ct9riI8vwnsn5hEV/AfdWBKSpULydH4BTOEiKNxMEDW0QP3XRch1VQQGfoCSTb0FF2QB
         qhS7EiggLlUGuRuEwKDIbv7Y7z6+/xuo3R2PFH6Ljm12+q1IrxMmReMwzdF03VJ7tg3C
         I1QEkB+ejKJXuDE2jbU2tns5QcFxxVOxSWsJwmec9gr2rKCbMm/QC8nd43fyFSYEDjbX
         s9gA==
X-Gm-Message-State: APjAAAVLL9Uj7cGl8kTyhBVu4LFX056IuhmbV+xxTt1a80opAU/2idbw
        T0Y2hrAcdEriglLFGhH1hflXMoFhFDg2nABZm76tvA==
X-Google-Smtp-Source: APXvYqxppDsOItDIT2YaELr43k74ClVedLV7sA/RnILraBhZZyo5avdE5zTyXJhFMqrri9Sx4SWOX07jkPYf4o/PBwM=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr1070268pje.123.1562802174886;
 Wed, 10 Jul 2019 16:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
 <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
 <20190706155001.yrfxqj7c2bmqtbid@treble> <20190710232244.to73phlufdetf5os@treble>
In-Reply-To: <20190710232244.to73phlufdetf5os@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Jul 2019 16:42:43 -0700
Message-ID: <CAKwvOdmSQUjDUeL-rG5q=EyfhWstHeCVDn+=9spEQmw5BJGaaA@mail.gmail.com>
Subject: Re: objtool warnings in prerelease clang-9
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 4:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sat, Jul 06, 2019 at 10:50:01AM -0500, Josh Poimboeuf wrote:
> > On Tue, Jul 02, 2019 at 11:58:27PM +0200, Thomas Gleixner wrote:
> > > platform-quirks.o:
> > >
> > >         if (x86_platform.set_legacy_features)
> > >   74:   4c 8b 1d 00 00 00 00    mov    0x0(%rip),%r11        # 7b <x86_early_init_platform_quirks+0x7b>
> > >   7b:   4d 85 db                test   %r11,%r11
> > >   7e:   0f 85 00 00 00 00       jne    84 <x86_early_init_platform_quirks+0x84>
> > >                 x86_platform.set_legacy_features();
> > > }
> > >   84:   c3                      retq
> > >
> > > That jne jumps to __x86_indirect_thunk_r11, aka. ratpoutine.
> > >
> > > No idea why objtool thinks that the instruction at 0x84 is not
> > > reachable. Josh?
> >
> > That's a conditional tail call, which is something GCC never does.
> > Objtool doesn't understand that, so we'll need to fix it.
>
> Can somebody test this patch to see if it fixes the platform-quirks.o
> warning?

$ make CC=clang -j71 2>&1 | grep platform-quirks
  CC      arch/x86/kernel/platform-quirks.o
arch/x86/kernel/platform-quirks.o: warning: objtool:
x86_early_init_platform_quirks()+0x84: unreachable instruction
$ git am /tmp/objtool.patch
$ make CC=clang -j71 clean
$ make CC=clang -j71 2>&1 | grep platform-quirks
  CC      arch/x86/kernel/platform-quirks.o
arch/x86/kernel/platform-quirks.o: warning: objtool:
x86_early_init_platform_quirks()+0x84: unreachable instruction

:(

$ llvm-objdump -dr arch/x86/kernel/platform-quirks.o

arch/x86/kernel/platform-quirks.o: file format ELF64-x86-64


Disassembly of section .init.text:

0000000000000000 x86_early_init_platform_quirks:
       0: 48 b8 02 00 00 00 01 00 00 00 movabsq $4294967298, %rax
       a: 48 89 05 00 00 00 00          movq %rax, (%rip)
000000000000000d:  R_X86_64_PC32 x86_platform+84
      11: c7 05 00 00 00 00 01 00 00 00 movl $1, (%rip)
0000000000000013:  R_X86_64_PC32 x86_platform+88
      1b: 48 b8 00 00 00 00 01 00 00 00 movabsq $4294967296, %rax
      25: 48 89 05 00 00 00 00          movq %rax, (%rip)
0000000000000028:  R_X86_64_PC32 x86_platform+100
      2c: 8b 05 00 00 00 00            movl (%rip), %eax
000000000000002e:  R_X86_64_PC32 boot_params+568
      32: 8d 48 fd                      leal -3(%rax), %ecx
      35: 83 f9 02                      cmpl $2, %ecx
      38: 72 15                        jb 21
<x86_early_init_platform_quirks+0x4f>
      3a: 83 f8 02                      cmpl $2, %eax
      3d: 74 27                        je 39
<x86_early_init_platform_quirks+0x66>
      3f: 85 c0                        testl %eax, %eax
      41: 75 31                        jne 49
<x86_early_init_platform_quirks+0x74>
      43: c7 05 00 00 00 00 01 00 00 00 movl $1, (%rip)
0000000000000045:  R_X86_64_PC32 x86_platform+96
      4d: eb 25                        jmp 37
<x86_early_init_platform_quirks+0x74>
      4f: c7 05 00 00 00 00 00 00 00 00 movl $0, (%rip)
0000000000000051:  R_X86_64_PC32 x86_platform+100
      59: 48 c7 05 00 00 00 00 00 00 00 00      movq $0, (%rip)
000000000000005c:  R_X86_64_PC32 x86_platform+80
      64: eb 0e                        jmp 14
<x86_early_init_platform_quirks+0x74>
      66: 31 c0                        xorl %eax, %eax
      68: 89 05 00 00 00 00            movl %eax, (%rip)
000000000000006a:  R_X86_64_PC32 x86_platform+104
      6e: 89 05 00 00 00 00            movl %eax, (%rip)
0000000000000070:  R_X86_64_PC32 x86_platform+88
      74: 4c 8b 1d 00 00 00 00          movq (%rip), %r11
0000000000000077:  R_X86_64_PC32 x86_platform+108
      7b: 4d 85 db                      testq %r11, %r11
      7e: 0f 85 00 00 00 00            jne 0
<x86_early_init_platform_quirks+0x84>
0000000000000080:  R_X86_64_PC32 __x86_indirect_thunk_r11-4
      84: c3                            retq

I've sent you the .o file off thread as well.  Thanks for taking a
look into this. :D
-- 
Thanks,
~Nick Desaulniers
