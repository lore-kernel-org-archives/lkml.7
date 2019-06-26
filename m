Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C04C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA2216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLa+k3Dg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfFZWPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:15:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44788 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZWPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:15:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so131130pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcR+OhoZvK/rtRwZF0U9HfgerZx9aU/OIPtD1HeI1sk=;
        b=QLa+k3DgmzA3uFZuxJn0/YfcQZhoYugh5PCgCCiiPqktDF35A8rnRQ/00VcW7c7L/K
         MmV/o6HI1B7+dviaEN82hfXtJJ61WQQ8NVu2R++VYhc+89sJp9Uh4Oln0kkvMa5lrGHx
         I+wEfvvp+C9xjx//RKjWJSXplRJ63FPXUPDUP3h4UJzaNeqHumk/9F9P/Xd8pDh2SJYv
         B6DTR5WwQhh+aThE0wEsJlbC3kCgUk+DTKHwu6GwM3+BfcSR6fCzoNS4k1tLiMQlONPI
         N3Rbi1OvBNHdvZUP/7SbcHR0JF5RQq8u/s/mhV3N5cWFXwQYZg3f24ldbUGJOJ/QT+TW
         0Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcR+OhoZvK/rtRwZF0U9HfgerZx9aU/OIPtD1HeI1sk=;
        b=U3AdjemesrgtZKZCp88iIw3ZscBqR4SpBKqUl6rplqANgyD4yZGjrqCCagDJVk9ItB
         /pb90tTmNHQ8liUeS6ryae2182JCK45/HqKLuf/7bWkrtmQHYgkZcku1iz+asRzuk7Ds
         YYMe2ABhk5OkbzimPezAItgHbI2iV6iDsDG87m3Qawd69AU42ZjRHZ0hdQNZ6PSOq97P
         T50owo3rfrLKj3021i0xcSXIDVdbSY4+ehDXKNqr1uZuu5QyU90Hn7pSPXr376DgLZnI
         6IsDlnht8Z/q6NYnyyNro6M7SwGc4K1WYJAuAJ7R5jxLu+5aW+Z/DLJhqNh1YzPBw+nK
         pbMA==
X-Gm-Message-State: APjAAAU5x3ZEuVut9qJYeQU4b+LQtrvE1ECXJb7DbriQnzd+NQvHvVOn
        QWqabUADnKgFrKHRKIPS+0sbTN6mELCR7IHr9f+Yhw==
X-Google-Smtp-Source: APXvYqzv4aUDf3pH+e1PaW2H6k0H/gY8j3eUsOg53jWXmrm7BFYO6L7d8sFqNaMGGWr5H4nYD2CnMfG38ms/zRzft2s=
X-Received: by 2002:a63:10a:: with SMTP id 10mr237268pgb.263.1561587349200;
 Wed, 26 Jun 2019 15:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc> <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc> <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626092432.GJ3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190626092432.GJ3419@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Jun 2019 15:15:38 -0700
Message-ID: <CAKwvOdm3qvaFH47MxJ9PWMbhYumt9V7gTASO5-ZAzwTVBUQqyA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 2:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 25, 2019 at 11:47:06PM +0200, Thomas Gleixner wrote:
> > > On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
>
> > > > but it also makes objtool unhappy:
> > > >
> > > >  arch/x86/events/intel/core.o: warning: objtool: intel_pmu_nhm_workaround()+0xb3: unreachable instruction
> > > >  kernel/fork.o: warning: objtool: free_thread_stack()+0x126: unreachable instruction
> > > >  mm/workingset.o: warning: objtool: count_shadow_nodes()+0x11f: unreachable instruction
> > > >  arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable instruction
> > > >  arch/x86/kernel/platform-quirks.o: warning: objtool: x86_early_init_platform_quirks()+0x84: unreachable instruction
> > > >  drivers/iommu/irq_remapping.o: warning: objtool: irq_remap_enable_fault_handling()+0x1d: unreachable instruction
>
> > I just checked two of them in the disassembly. In both cases it's jump
> > label related. Here is one:
> >
> >       asm volatile("1: rdmsr\n"
> >  410:   b9 59 02 00 00          mov    $0x259,%ecx
> >  415:   0f 32                   rdmsr
> >  417:   49 89 c6                mov    %rax,%r14
> >  41a:   48 89 d3                mov    %rdx,%rbx
> >       return EAX_EDX_VAL(val, low, high);
> >  41d:   48 c1 e3 20             shl    $0x20,%rbx
> >  421:   48 09 c3                or     %rax,%rbx
> >  424:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> >  429:   eb 0f                   jmp    43a <get_fixed_ranges+0xaa>
> >       do_trace_read_msr(msr, val, 0);
> >  42b:   bf 59 02 00 00          mov    $0x259,%edi   <------- "unreachable"
> >  430:   48 89 de                mov    %rbx,%rsi
> >  433:   31 d2                   xor    %edx,%edx
> >  435:   e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
> >  43a:   44 89 35 00 00 00 00    mov    %r14d,0x0(%rip)        # 441 <get_fixed_ranges+0xb1>
> >
> > Interestingly enough there are some more hunks of the same pattern in that
> > function which look all the same. Those are not upsetting objtool. Josh
> > might give an hint where to stare at.
>
> That's pretty atrocious code-gen :/ Does LLVM support things like label
> attributes? Back when we did jump labels GCC didn't, or rather, it
> ignored it completely when combined with asm goto (and it might still).
>
> That is, would something like this:
>
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 06c3cc22a058..1761b1e76ddc 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -32,7 +32,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>                 : :  "i" (key), "i" (branch) : : l_yes);
>
>         return false;
> -l_yes:
> +l_yes: __attribute__((cold));
>         return true;
>  }
>
> @@ -49,7 +49,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
>                 : :  "i" (key), "i" (branch) : : l_yes);
>
>         return false;
> -l_yes:
> +l_yes: __attribute__((hot));
>         return true;
>  }
>
> Help LLVM?

So Clang definitely complains about putting attribute hot/cold on
labels: https://godbolt.org/z/N-Z33Q
In my test case I wasn't able to influence code gen with them though
in GCC at -O2 or -O0.  Maybe GCC has a test case that shows how they
should work?
-- 
Thanks,
~Nick Desaulniers
