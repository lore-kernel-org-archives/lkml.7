Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F40BC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604E2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFYVra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:47:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44512 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFYVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:47:29 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hftHP-00013C-Sg; Tue, 25 Jun 2019 23:47:08 +0200
Date:   Tue, 25 Jun 2019 23:47:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     Kees Cook <keescook@chromium.org>,
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
In-Reply-To: <20190625202746.GA83499@archlinux-epyc>
Message-ID: <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
References: <20190624161913.GA32270@embeddedor> <20190624193123.GI3436@hirez.programming.kicks-ass.net> <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com> <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com> <20190625071846.GN3436@hirez.programming.kicks-ass.net> <201906251009.BCB7438@keescook> <20190625180525.GA119831@archlinux-epyc> <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan,

On Tue, 25 Jun 2019, Nathan Chancellor wrote:
> On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
> > 
> > But can the script please check for a minimal clang version required to
> > build that thing.
> > 
> > The default clang-3.8 which is installed on Debian stretch explodes. The
> > 6.0 variant from backports works as advertised.
> > 
> 
> Hmmm interesting, I test a lot of different distros using Docker
> containers to make sure the script works universally and that includes
> Debian stretch, which is the stress tester because all of the packages
> are older. I install the following packages then run the following
> command and it works fine for me (just tested):
> 
> $ apt update && apt install -y --no-install-recommends ca-certificates \
> ccache clang cmake curl file gcc g++ git make ninja-build python3 \
> texinfo zlib1g-dev
> $ ./build-llvm.py
> 
> If you could give me a build log, I'd be happy to look into it and see
> what I can do.

I can produce one tomorrow.
 
> > Kernel builds with the new shiny compiler. Jump labels seem to be enabled.
> > 
> > It complains about a few type conversions:
> > 
> >  arch/x86/kvm/mmu.c:4596:39: warning: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -205 to 51 [-Wconstant-conversion]
> >                 u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> >                    ~~                               ^~
> > 
> 
> Yes, there was a patch sent to try and fix this but it was rejected by
> the maintainers:
> 
> https://github.com/ClangBuiltLinux/linux/issues/95
> 
> https://lore.kernel.org/lkml/20180619192504.180479-1-mka@chromium.org/

Just looked through it. I don't think it's an outright reject. Paolo was
not totally against it and then the whole discussion degraded into bikeshed
painting and bitching about compiler error messaged. Try again or should I?

> > but it also makes objtool unhappy:
> > 
> >  arch/x86/events/intel/core.o: warning: objtool: intel_pmu_nhm_workaround()+0xb3: unreachable
instruction
> >  kernel/fork.o: warning: objtool: free_thread_stack()+0x126: unreachable instruction
> >  mm/workingset.o: warning: objtool: count_shadow_nodes()+0x11f: unreachable instruction
> >  arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable
instruction
> >  arch/x86/kernel/platform-quirks.o: warning: objtool: x86_early_init_platform_quirks()+0x84:
unreachable instruction
> >  drivers/iommu/irq_remapping.o: warning: objtool: irq_remap_enable_fault_handling()+0x1d:
unreachable instruction

> Unfortunately, we have quite a few of those outstanding, it's probably
> time to start really taking a look at them:
> 
> https://github.com/ClangBuiltLinux/linux/labels/objtool

I just checked two of them in the disassembly. In both cases it's jump
label related. Here is one:

      asm volatile("1: rdmsr\n"
 410:   b9 59 02 00 00          mov    $0x259,%ecx
 415:   0f 32                   rdmsr
 417:   49 89 c6                mov    %rax,%r14
 41a:   48 89 d3                mov    %rdx,%rbx
      return EAX_EDX_VAL(val, low, high);
 41d:   48 c1 e3 20             shl    $0x20,%rbx
 421:   48 09 c3                or     %rax,%rbx
 424:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
 429:   eb 0f                   jmp    43a <get_fixed_ranges+0xaa>
      do_trace_read_msr(msr, val, 0);
 42b:   bf 59 02 00 00          mov    $0x259,%edi   <------- "unreachable"
 430:   48 89 de                mov    %rbx,%rsi
 433:   31 d2                   xor    %edx,%edx
 435:   e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
 43a:   44 89 35 00 00 00 00    mov    %r14d,0x0(%rip)        # 441 <get_fixed_ranges+0xb1>

Interestingly enough there are some more hunks of the same pattern in that
function which look all the same. Those are not upsetting objtool. Josh
might give an hint where to stare at.

Just for the fun of it I looked at the GCC output of the same file. It
takes a different apporach:

      asm volatile("1: rdmsr\n"
 c70:   b9 59 02 00 00          mov    $0x259,%ecx
 c75:   0f 32                   rdmsr
      return EAX_EDX_VAL(val, low, high);
 c77:   48 c1 e2 20             shl    $0x20,%rdx
 c7b:   48 89 d3                mov    %rdx,%rbx
 c7e:   48 09 c3                or     %rax,%rbx
 c81:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
 c86:   48 89 1d 00 00 00 00    mov    %rbx,0x0(%rip)        # c8d <get_fixed_ranges.constprop.5+0x7d>

and the tracing code is completely out of line:

      do_trace_read_msr(msr, val, 0);
 ce2:   31 d2                   xor    %edx,%edx
 ce4:   48 89 de                mov    %rbx,%rsi
 ce7:   bf 59 02 00 00          mov    $0x259,%edi
 cec:   e8 00 00 00 00          callq  cf1 <get_fixed_ranges.constprop.5+0xe1>
 cf1:   eb 93                   jmp    c86 <get_fixed_ranges.constprop.5+0x76>

which makes a lot of sense as the normal path (tracepoint disabled) just
runs through linearly while in the clang version it has to jump around the
tracepoint code.

The jump itself is not a problem, but what matters is the $I cache
footprint. The GCC version hotpath fits in 3 cache lines while the Clang
version unconditionally eats 4.2 of them. That's a huge difference.

> Thanks for trying it out and letting us know. Please keep us in the loop
> if you happen to find anything amiss.

Will do.

Thanks,

	tglx
