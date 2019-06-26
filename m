Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC7AC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB221738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFZXLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:11:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFZXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:11:37 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgH4L-0001bg-AB; Thu, 27 Jun 2019 01:11:13 +0200
Date:   Thu, 27 Jun 2019 01:11:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Craig Topper <craig.topper@intel.com>,
        Chandler Carruth <chandlerc@google.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
In-Reply-To: <CAKwvOdnvKLs1oF0-G8iq2T4wqcVkBGRKiZjPbb+K0gDRh3Liww@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906270043480.32342@nanos.tec.linutronix.de>
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com> <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com> <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net> <201906251009.BCB7438@keescook> <20190625180525.GA119831@archlinux-epyc> <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de> <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de> <20190626163057.GN3419@hirez.programming.kicks-ass.net> <CAKwvOdnvKLs1oF0-G8iq2T4wqcVkBGRKiZjPbb+K0gDRh3Liww@mail.gmail.com>
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

On Wed, 26 Jun 2019, Nick Desaulniers wrote:
> On Wed, Jun 26, 2019 at 9:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Jun 25, 2019 at 11:47:06PM +0200, Thomas Gleixner wrote:
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
> 
> I assume if 0x42b is unreachable, that's bad as $0x259 is never stored
> in %edi before the call to get_fixed_ranges+0xaa...

Well no. The static key will never be enabled because it's not in the jump
table entries. And that's why objtool complains. That code path @42b will
never be reached even if the tracepoints are enabled because due to the
missing entry the kernel will not patch it.

> > So for some reason the .rela__jump_table are buggy on this clang build.
> 
> So that sounds like a correctness bug then. (I'd been doing testing
> with the STATIC_KEYS_SELFTEST, which I guess doesn't expose this).
> I'm kind of surprised we can boot and pass STATIC_KEYS_SELFTEST.  Any
> way you can help us pare down a test case?

Well, the test thing works as long as the entries which are used there are
correct. And looking at the output of that kernel build I did, I get 6
unreachable entries in 6 different files. That means that ~99% are
correct. So the chance that the self test fails is low.

Vs. test case. Just compile a kernel and pick the first file where objtool
complains. Look at the disassembly which will have the

	   nopl   0x0(%rax,%rax,1)

and that do_trace_read_msr() reference right at that failing offset (or
whatever other function is called in the file you pick).

From there you should be able to debug why the compiler is not emitting the
r.rela__jump_table entry for this particular instance.

I compiled arch/x86/kernel/cpu/mtrr/generic.o several times and the failure
is fully reproducible.

Kernel version is plain v5.2-rc6 and the config I used is here:

  https://tglx.de/~tglx/config-clang-repro

Make invocation is:

  make CC=clang HOST_CC=clang arch/x86/kernel/cpu/mtrr/generic.o

that builds only that single file and not the whole kernel Moloch.

Output:

  CC      arch/x86/kernel/cpu/mtrr/generic.o
arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable instruction

That's with the compiler I built a few hours ago with Nathans fixed
build-llvm.py script. Head commit of llvm-project is:

  master 600941e34fe: Print NULL as "(null)" in diagnostic message

Hope that helps.

Thanks,

	tglx
