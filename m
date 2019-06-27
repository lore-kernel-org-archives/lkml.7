Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AFBC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2B20828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RXxATgC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfF0HLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:11:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Kcirxfxn0CosZPj8/LNtELfLIDtkRTCsrV2SNv65gM=; b=RXxATgC1YXBfw7xgnEsbRnahD
        AS+NZaACDh04Eg8KEsbE0iQ2GdnyfWyZ+TJmXiuwMQ+9CvCwOdPT6YYgPTWdWsd5iTu/lFcfAxtOm
        kH++2M/GHipzfXHqzJ2PIWMbsCt7MwOZN2VMPbtbye3z/fCh9vDYxwD5iWnty3+ILjKSDkhrxoecp
        5A3/01oPt6mRzrHUnq8vXsDKFckjQQAtAbBFQXmvipatUtC965xnwb8X/gZUu38NImhIhZAnKBTZ8
        I9wesb1PGoxy3yi7Dyu47CoIDd3S3r+M9MKQaFcCFcj3PEKfQgy6Jh++w2welJNmk5a2eaabiL7ud
        zVbIfpZRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgOYn-0002DJ-Sw; Thu, 27 Jun 2019 07:11:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABD8320A714B9; Thu, 27 Jun 2019 09:11:07 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:11:07 +0200
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Craig Topper <craig.topper@intel.com>,
        Chandler Carruth <chandlerc@google.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190627071107.GY3402@hirez.programming.kicks-ass.net>
References: <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626163057.GN3419@hirez.programming.kicks-ass.net>
 <CAKwvOdnvKLs1oF0-G8iq2T4wqcVkBGRKiZjPbb+K0gDRh3Liww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnvKLs1oF0-G8iq2T4wqcVkBGRKiZjPbb+K0gDRh3Liww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:33:36PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 26, 2019 at 9:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 11:47:06PM +0200, Thomas Gleixner wrote:
> > > > On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
> >
> > > > > but it also makes objtool unhappy:
> >
> > > > >  arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool: get_fixed_ranges()+0x9b: unreachable instruction
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
> 
> I assume if 0x42b is unreachable, that's bad as $0x259 is never stored
> in %edi before the call to get_fixed_ranges+0xaa...

So what happens is that the __jump_table entry for 424 is wrong. When we
enable that key (read msr tracepoint) the code will jump to another
instance of the read msr tracepoint and continue running from there.

So we'll jump from one inlined instance to another, with all the
ramifications thereof; the code-flow will be completely screwy.

> > >  430:   48 89 de                mov    %rbx,%rsi
> > >  433:   31 d2                   xor    %edx,%edx
> > >  435:   e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
> > >  43a:   44 89 35 00 00 00 00    mov    %r14d,0x0(%rip)        # 441 <get_fixed_ranges+0xb1>
> >
> > Thomas provided the actual .o file, and from that we find that the
> > .rela__jump_table entries look like:
> >
> > 000000000010  000100000002 R_X86_64_PC32     0000000000000000 .text + 3e9
> > 000000000014  000100000002 R_X86_64_PC32     0000000000000000 .text + 3f0
> > 000000000018  006100000018 R_X86_64_PC64     0000000000000000 __tracepoint_read_msr + 8
> 
> I assume these relocations come from arch_static_branch() (and thus
> appear in triples?)
> 
>  21 static __always_inline bool arch_static_branch(struct static_key
> *key, bool branch)
>  22 {
>  23   asm_volatile_goto("1:"
>  24     ".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"

>  25     ".pushsection __jump_table,  \"aw\" \n\t"
>  26     _ASM_ALIGN "\n\t"
>  27     ".long 1b - ., %l[l_yes] - . \n\t" // 1, 2
>  28     _ASM_PTR "%c0 + %c1 - .\n\t" // 3
>  29     ".popsection \n\t"

Yes, its lines 25-29 ^ that generate the jump_table entries. The first
entry is the code location, the second is the jump target and the third
is a pointer (and two LSB state bits) to the key this belongs to.

The compiler emits .rela objects for these and this is what we use with
objtool -- just like a linker would to resolve and create the actual
__jump_table section.

>  30     : :  "i" (key), "i" (branch) : : l_yes);
> 
> > 000000000020  000100000002 R_X86_64_PC32     0000000000000000 .text + 424
> > 000000000024  000100000002 R_X86_64_PC32     0000000000000000 .text + 3f0
> > 000000000028  006100000018 R_X86_64_PC64     0000000000000000 __tracepoint_read_msr + 8
> >
> > From this we find that the jump target that goes with the NOP at +424 is
> > +3f0, not +42b as one would expect.
> >
> > And as Josh noted, it is also 'weird' that this +3f0 is the very same as
> > the target for the previous entry.
> 
> (Ok, I think I did talk to Josh about this, and I think he did mention
> something about the jump targets, but I didn't really understand the
> issue well at the time).

So what we have here is two instances of the same read msr inline. They
have code in different offsets (+3e9 and +424 resp.) but somehow the
compiler messed up and collapsed their jump target (or didn't properly
de-duplicate -- I've no idea how inline instantiation actually works).

> >
> > When we compare the code at both sites, we find:
> >
> > 3f0:       bf 58 02 00 00          mov    $0x258,%edi
> > 3f5:       48 89 de                mov    %rbx,%rsi
> > 3f8:       31 d2                   xor    %edx,%edx
> > 3fa:       e8 00 00 00 00          callq  3ff <get_fixed_ranges+0x6f>
> >                 3fb: R_X86_64_PC32      do_trace_read_msr-0x4
> >
> > vs
> >
> > 42b:       bf 59 02 00 00          mov    $0x259,%edi
> > 430:       48 89 de                mov    %rbx,%rsi
> > 433:       31 d2                   xor    %edx,%edx
> > 435:       e8 00 00 00 00          callq  43a <get_fixed_ranges+0xaa>
> >                 436: R_X86_64_PC32      do_trace_read_msr-0x4
> >
> > Which is not in fact the same code.
> >
> > So for some reason the .rela__jump_table are buggy on this clang build.
> 
> So that sounds like a correctness bug then. 

Yes, this is very very very bad. Like I wrote above, this results in
code flow moving from one inline'd instance into another, it completely
wrecks code flow integrity.

> (I'd been doing testing
> with the STATIC_KEYS_SELFTEST, which I guess doesn't expose this).
> I'm kind of surprised we can boot and pass STATIC_KEYS_SELFTEST.  Any
> way you can help us pare down a test case?

It looks like an inlining bug, and I a rare one at that. The static key
self-tests simply don't trigger this for whatever reason. Like Thomas
wrote, of all the jump_labels in the kernel, only 6 go 'funny' for
whatever reason.
