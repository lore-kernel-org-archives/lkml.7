Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A5C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC95120B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEKY8Rsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZFKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:10:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43845 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfFZFKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:10:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so1295504edr.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QJ/cbj94BxUhje6ss1rjJBjz5mHbDrI7tyvpFHn6cUc=;
        b=nEKY8RsxPiuAPfF+wawn7P6+b3n9yfdxTel6qIgH6pobPR7HYkaIgfa926d2RPKBo/
         GZvA3pLdBkp6DJ9JN0E3ip1EkE62HTk4Uj5tcJC0r72M76nyOYUnO/yL4lQo5jVXK7FJ
         gkFW3nY2SFzaVjKbOXKdRNldSoWpDMIVYPE+1eeZEVJFy8zrmcXfaCv/tu9EVCLuCVja
         FSDRaGYu7Nv4k5UkOWhQ0sTLu3ZZJ3YrTXJuVVvrB1ajQ5e46R/F8QwtVnuNhnNebxUG
         bdzo1vkhUBsg08POBbYv52KMNlJ2iwJU+l1Jt8+Ff8mgPHqQKwIKN2srXVWaVuejMBvt
         S7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJ/cbj94BxUhje6ss1rjJBjz5mHbDrI7tyvpFHn6cUc=;
        b=EUmbR83uIQFTKMOlWX8zaEYQTOwMZYN6kvgv+hIme3FZWj2j7T+AJARHoeRkx4hsBE
         RYfuJxmyaRh2gOWoZZM7rBg5fmjZEAuxzzF1Xet5Kf/nAh16d9gZN8u/ab3TR31++zkP
         bQ7atXZ3xBPokDlpcaptdrhytGMF8ynocveOc10vlsFAgNm1qgNSewW1ejhvrIu/QWxl
         IhJXpnJ6FHDgqZvtLumJE3s6FCWQWCj1mjc3N/ff9ZBlcqauEg0G8KpjXoqadn9LYFrl
         UICBWMgdDUXatQTeUCouS19rppZp5kSCRHTgy/KJ6ykLoSoZMqmikm0K8lCX5M/qMOOt
         UWNA==
X-Gm-Message-State: APjAAAWy6T3GI1mk01jWRo6SUtOAVabl1AchUFxEJtJnQqUydXLkAIZG
        F51HjxLWm74VdOR56STqH6w=
X-Google-Smtp-Source: APXvYqxVF7VLCD1s6ZA95VMlfxCRszxkN/CjjtiKMIWOb8Uuyj7qLtZzpLR1bcA/R8FD+WCMIS7JiA==
X-Received: by 2002:a50:f5f5:: with SMTP id x50mr2621321edm.89.1561525838866;
        Tue, 25 Jun 2019 22:10:38 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id b1sm2716421ejo.9.2019.06.25.22.10.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 22:10:37 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:10:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        clang-built-linux@googlegroups.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626051035.GA114229@archlinux-epyc>
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:47:06PM +0200, Thomas Gleixner wrote:
> On Tue, 25 Jun 2019, Nathan Chancellor wrote:
> > On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
> > > 
> > > But can the script please check for a minimal clang version required to
> > > build that thing.
> > > 
> > > The default clang-3.8 which is installed on Debian stretch explodes. The
> > > 6.0 variant from backports works as advertised.
> > > 
> > 
> > Hmmm interesting, I test a lot of different distros using Docker
> > containers to make sure the script works universally and that includes
> > Debian stretch, which is the stress tester because all of the packages
> > are older. I install the following packages then run the following
> > command and it works fine for me (just tested):
> > 
> > $ apt update && apt install -y --no-install-recommends ca-certificates \
> > ccache clang cmake curl file gcc g++ git make ninja-build python3 \
> > texinfo zlib1g-dev
> > $ ./build-llvm.py
> > 
> > If you could give me a build log, I'd be happy to look into it and see
> > what I can do.
> 
> I can produce one tomorrow.
>  

Great, thank you!

> > > Kernel builds with the new shiny compiler. Jump labels seem to be enabled.
> > > 
> > > It complains about a few type conversions:
> > > 
> > >  arch/x86/kvm/mmu.c:4596:39: warning: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -205 to 51 [-Wconstant-conversion]
> > >                 u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> > >                    ~~                               ^~
> > > 
> > 
> > Yes, there was a patch sent to try and fix this but it was rejected by
> > the maintainers:
> > 
> > https://github.com/ClangBuiltLinux/linux/issues/95
> > 
> > https://lore.kernel.org/lkml/20180619192504.180479-1-mka@chromium.org/
> 
> Just looked through it. I don't think it's an outright reject. Paolo was
> not totally against it and then the whole discussion degraded into bikeshed
> painting and bitching about compiler error messaged. Try again or should I?
> 

Might be worth having you chime in, given that is the only instance of
that type of warning that I see in my set of builds (I fixed the rest:
https://github.com/ClangBuiltLinux/linux/issues?q=label%3A-Wconstant-conversion)

> > > but it also makes objtool unhappy:
> > > 
> > >  arch/x86/events/intel/core.o: warning: objtool: intel_pmu_nhm_workaround()+0xb3: unreachable
> instruction
> > >  kernel/fork.o: warning: objtool: free_thread_stack()+0x126: unreachable instruction
> > >  mm/workingset.o: warning: objtool: count_shadow_nodes()+0x11f: unreachable instruction
> > >  arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable
> instruction
> > >  arch/x86/kernel/platform-quirks.o: warning: objtool: x86_early_init_platform_quirks()+0x84:
> unreachable instruction
> > >  drivers/iommu/irq_remapping.o: warning: objtool: irq_remap_enable_fault_handling()+0x1d:
> unreachable instruction
> 
> > Unfortunately, we have quite a few of those outstanding, it's probably
> > time to start really taking a look at them:
> > 
> > https://github.com/ClangBuiltLinux/linux/labels/objtool
> 
> I just checked two of them in the disassembly. In both cases it's jump
> label related. Here is one:
> 
>       asm volatile("1: rdmsr\n"
>  410:   b9 59 02 00 00          mov    $0x259,%ecx
>  415:   0f 32                   rdmsr
>  417:   49 89 c6                mov    %rax,%r14
>  41a:   48 89 d3                mov    %rdx,%rbx
>       return EAX_EDX_VAL(val, low, high);
>  41d:   48 c1 e3 20             shl    $0x20,%rbx
>  421:   48 09 c3                or     %rax,%rbx
>  424:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>  429:   eb 0f                   jmp    43a <get_fixed_ranges+0xaa>
>       do_trace_read_msr(msr, val, 0);
>  42b:   bf 59 02 00 00          mov    $0x259,%edi   <------- "unreachable"
>  430:   48 89 de                mov    %rbx,%rsi
>  433:   31 d2                   xor    %edx,%edx
>  435:   e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
>  43a:   44 89 35 00 00 00 00    mov    %r14d,0x0(%rip)        # 441 <get_fixed_ranges+0xb1>
> 
> Interestingly enough there are some more hunks of the same pattern in that
> function which look all the same. Those are not upsetting objtool. Josh
> might give an hint where to stare at.
> 
> Just for the fun of it I looked at the GCC output of the same file. It
> takes a different apporach:
> 
>       asm volatile("1: rdmsr\n"
>  c70:   b9 59 02 00 00          mov    $0x259,%ecx
>  c75:   0f 32                   rdmsr
>       return EAX_EDX_VAL(val, low, high);
>  c77:   48 c1 e2 20             shl    $0x20,%rdx
>  c7b:   48 89 d3                mov    %rdx,%rbx
>  c7e:   48 09 c3                or     %rax,%rbx
>  c81:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
>  c86:   48 89 1d 00 00 00 00    mov    %rbx,0x0(%rip)        # c8d <get_fixed_ranges.constprop.5+0x7d>
> 
> and the tracing code is completely out of line:
> 
>       do_trace_read_msr(msr, val, 0);
>  ce2:   31 d2                   xor    %edx,%edx
>  ce4:   48 89 de                mov    %rbx,%rsi
>  ce7:   bf 59 02 00 00          mov    $0x259,%edi
>  cec:   e8 00 00 00 00          callq  cf1 <get_fixed_ranges.constprop.5+0xe1>
>  cf1:   eb 93                   jmp    c86 <get_fixed_ranges.constprop.5+0x76>
> 
> which makes a lot of sense as the normal path (tracepoint disabled) just
> runs through linearly while in the clang version it has to jump around the
> tracepoint code.
> 
> The jump itself is not a problem, but what matters is the $I cache
> footprint. The GCC version hotpath fits in 3 cache lines while the Clang
> version unconditionally eats 4.2 of them. That's a huge difference.
> 
> > Thanks for trying it out and letting us know. Please keep us in the loop
> > if you happen to find anything amiss.
> 
> Will do.
> 
> Thanks,
> 
> 	tglx
