Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D412FC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A633C20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dyamLpzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfF0HQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:16:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Adl0vr62TYYsl73Le7yrJGhjQV3e374BPJaykChMxu0=; b=dyamLpzz1keSN5aTYUNqAD0Ow
        e4n10Dl2RmO0cDmpL1WgzWoDtGx9fZhVhp/VE4pB4+KyLm6GSLi6nKfDvMq+KX/o9SDT+xTKkUOR0
        FC9Ck/Kek6z8lCc2ynD3HiGrvJkRj/D0tFQcFkx5Mw03Tq4cUiAEZouTLb81eWltIK5Z49HxIsO+y
        cwm38yVJiS+vV21yzwhH7BxXe39IjDTFICXvLCJrQqJ6ttUwYhNAwxoGdfHwRcYrJm7xCA9OWwiYP
        GUErFHTQpq1Ajn8UWwwgiGJFQsulyi1lQs6l7jB7tRV/2Noj7ZIozHA1o//vwbEMC5i29hKMDuPz+
        MTRj9QCZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgOdd-0007RE-UE; Thu, 27 Jun 2019 07:16:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2CFF20A714BA; Thu, 27 Jun 2019 09:16:08 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:16:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190627071608.GA3402@hirez.programming.kicks-ass.net>
References: <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626092432.GJ3419@hirez.programming.kicks-ass.net>
 <CAKwvOdm3qvaFH47MxJ9PWMbhYumt9V7gTASO5-ZAzwTVBUQqyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm3qvaFH47MxJ9PWMbhYumt9V7gTASO5-ZAzwTVBUQqyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:15:38PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 26, 2019 at 2:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 11:47:06PM +0200, Thomas Gleixner wrote:
> > > > On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
> >
> > > > > but it also makes objtool unhappy:
> > > > >
> > > > >  arch/x86/events/intel/core.o: warning: objtool: intel_pmu_nhm_workaround()+0xb3: unreachable instruction
> > > > >  kernel/fork.o: warning: objtool: free_thread_stack()+0x126: unreachable instruction
> > > > >  mm/workingset.o: warning: objtool: count_shadow_nodes()+0x11f: unreachable instruction
> > > > >  arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable instruction
> > > > >  arch/x86/kernel/platform-quirks.o: warning: objtool: x86_early_init_platform_quirks()+0x84: unreachable instruction
> > > > >  drivers/iommu/irq_remapping.o: warning: objtool: irq_remap_enable_fault_handling()+0x1d: unreachable instruction
> >
> > > I just checked two of them in the disassembly. In both cases it's jump
> > > label related. Here is one:
> > >
> > >       asm volatile("1: rdmsr\n"
> > >  410:   b9 59 02 00 00          mov    $0x259,%ecx
> > >  415:   0f 32                   rdmsr
> > >  417:   49 89 c6                mov    %rax,%r14
> > >  41a:   48 89 d3                mov    %rdx,%rbx
> > >       return EAX_EDX_VAL(val, low, high);
> > >  41d:   48 c1 e3 20             shl    $0x20,%rbx
> > >  421:   48 09 c3                or     %rax,%rbx
> > >  424:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> > >  429:   eb 0f                   jmp    43a <get_fixed_ranges+0xaa>
> > >       do_trace_read_msr(msr, val, 0);
> > >  42b:   bf 59 02 00 00          mov    $0x259,%edi   <------- "unreachable"
> > >  430:   48 89 de                mov    %rbx,%rsi
> > >  433:   31 d2                   xor    %edx,%edx
> > >  435:   e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
> > >  43a:   44 89 35 00 00 00 00    mov    %r14d,0x0(%rip)        # 441 <get_fixed_ranges+0xb1>
> > >
> > > Interestingly enough there are some more hunks of the same pattern in that
> > > function which look all the same. Those are not upsetting objtool. Josh
> > > might give an hint where to stare at.
> >
> > That's pretty atrocious code-gen :/ Does LLVM support things like label
> > attributes? Back when we did jump labels GCC didn't, or rather, it
> > ignored it completely when combined with asm goto (and it might still).
> >
> > That is, would something like this:
> >
> > diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> > index 06c3cc22a058..1761b1e76ddc 100644
> > --- a/arch/x86/include/asm/jump_label.h
> > +++ b/arch/x86/include/asm/jump_label.h
> > @@ -32,7 +32,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
> >                 : :  "i" (key), "i" (branch) : : l_yes);
> >
> >         return false;
> > -l_yes:
> > +l_yes: __attribute__((cold));
> >         return true;
> >  }
> >
> > @@ -49,7 +49,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
> >                 : :  "i" (key), "i" (branch) : : l_yes);
> >
> >         return false;
> > -l_yes:
> > +l_yes: __attribute__((hot));
> >         return true;
> >  }
> >
> > Help LLVM?

As I wrote later; the above suggestion is actually wrong :/

> So Clang definitely complains about putting attribute hot/cold on
> labels: https://godbolt.org/z/N-Z33Q
> In my test case I wasn't able to influence code gen with them though
> in GCC at -O2 or -O0.  Maybe GCC has a test case that shows how they
> should work?

As I wrote in that same later email; the way we influence the actual
code-layout is with the __builtin_expect() thing. Let me expand on that
in another email.

Sadly, I've no clue what so ever about compiler internals, be it GCC or
LLVM.
