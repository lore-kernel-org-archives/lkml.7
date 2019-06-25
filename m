Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2216CC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B562063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfFYTxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:53:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfFYTxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:53:52 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfrV9-0007Zz-1y; Tue, 25 Jun 2019 21:53:11 +0200
Date:   Tue, 25 Jun 2019 21:53:09 +0200 (CEST)
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
        Shawn Landden <shawn@git.icu>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
In-Reply-To: <20190625180525.GA119831@archlinux-epyc>
Message-ID: <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
References: <20190624161913.GA32270@embeddedor> <20190624193123.GI3436@hirez.programming.kicks-ass.net> <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com> <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com> <20190625071846.GN3436@hirez.programming.kicks-ass.net> <201906251009.BCB7438@keescook> <20190625180525.GA119831@archlinux-epyc>
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

On Tue, 25 Jun 2019, Nathan Chancellor wrote:
> On Tue, Jun 25, 2019 at 10:12:42AM -0700, Kees Cook wrote:
> > On Tue, Jun 25, 2019 at 09:18:46AM +0200, Peter Zijlstra wrote:
> > > Can it build a kernel without patches yet? That is, why should I care
> > > what LLVM does?
> > 
> > Yes. LLVM trunk builds and boots x86 now. As for distro availability,
> > AIUI, the asm-goto feature missed the 9.0 LLVM branch point, so it'll
> > appear in the following release.
> > 
> > -- 
> > Kees Cook
> 
> I don't think that's right. LLVM 9 hasn't been branched yet so it should
> make it in.
> 
> http://lists.llvm.org/pipermail/llvm-dev/2019-June/133155.html
> 
> If anyone wants to play around with it before then, we wrote a
> self-contained script that will build an LLVM toolchain suitable for
> kernel development:
> 
> https://github.com/ClangBuiltLinux/tc-build

Useful!

But can the script please check for a minimal clang version required to
build that thing.

The default clang-3.8 which is installed on Debian stretch explodes. The
6.0 variant from backports works as advertised.

Kernel builds with the new shiny compiler. Jump labels seem to be enabled.

It complains about a few type conversions:

 arch/x86/kvm/mmu.c:4596:39: warning: implicit conversion from 'int' to 'u8' (aka 'unsigned char') changes value from -205 to 51 [-Wconstant-conversion]
                u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
                   ~~                               ^~

but it also makes objtool unhappy:

 arch/x86/events/intel/core.o: warning: objtool: intel_pmu_nhm_workaround()+0xb3: unreachable instruction
 kernel/fork.o: warning: objtool: free_thread_stack()+0x126: unreachable instruction
 mm/workingset.o: warning: objtool: count_shadow_nodes()+0x11f: unreachable instruction
 arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable instruction
 arch/x86/kernel/platform-quirks.o: warning: objtool: x86_early_init_platform_quirks()+0x84: unreachable instruction
 drivers/iommu/irq_remapping.o: warning: objtool: irq_remap_enable_fault_handling()+0x1d: unreachable instruction

Kernel boots. As I'm currently benchmarking VDSO performance, this was
obviosly my first test. Compared to the same kernel built with gcc6.3 the
performance of the VDSO drops slightly.

It's below 1%. Though I need to run the same tests on 4 other uarchs to get
the full picture. This stuff is randomly changing behaviour accross uarchs
depending on how the c source is arranged. So nothing to worry about (yet).

Thanks,

	tglx

