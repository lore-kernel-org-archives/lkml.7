Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71530C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C96D205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZC2TTtzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFZJzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:55:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fFjxZyqv/QkBSXuLuh37Zu3ki51Vyxrgqa7r261G24k=; b=ZC2TTtzLM8pd0XkdwwPvKtIOM
        oxdGHWJWGRUP8haVNBjOeqOi+GNeAD7uQvNM0Fd1RCxdN/Oaop42n8iGX3d2z9/Nd9h4SE0MfZyK/
        y2ejEmdoLDu5nu/dlVGt/mMWNMV4qQytcJY06TQJYuWQzg3aX262Tdj9k1txA5tDYRnL4ri1pZYeC
        p8zR3FXzC4IeLvWGRZFMeMJwlDEn2H4qC/lxfbvY3iyg2a2StWsbqkSR+TqAH17i43sEbaV3s/VLV
        2mC7pLNyq6pv1zJ01uTiRnMExgXZ5Ms7nlN6n9HrC9K3j9emPsHduvyMaOsW3PNga4YOEHsoRtKdf
        CI3ohl4XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg4eC-0001fs-H2; Wed, 26 Jun 2019 09:55:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2D4920A585AE; Wed, 26 Jun 2019 11:55:22 +0200 (CEST)
Date:   Wed, 26 Jun 2019 11:55:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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
        clang-built-linux@googlegroups.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626095522.GB3463@hirez.programming.kicks-ass.net>
References: <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626092432.GJ3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626092432.GJ3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:24:32AM +0200, Peter Zijlstra wrote:
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
> That's pretty atrocious code-gen :/ 

And I know nobody reads comments (I don't either), but I did write one
on this as it happens.

See include/linux/jump_label.h:399

/*
 * Combine the right initial value (type) with the right branch order
 * to generate the desired result.
 *
 *
 * type\branch|	likely (1)	      |	unlikely (0)
 * -----------+-----------------------+------------------
 *            |                       |
 *  true (1)  |	   ...		      |	   ...
 *            |    NOP		      |	   JMP L
 *            |    <br-stmts>	      |	1: ...
 *            |	L: ...		      |
 *            |			      |
 *            |			      |	L: <br-stmts>
 *            |			      |	   jmp 1b
 *            |                       |
 * -----------+-----------------------+------------------
 *            |                       |
 *  false (0) |	   ...		      |	   ...
 *            |    JMP L	      |	   NOP
 *            |    <br-stmts>	      |	1: ...
 *            |	L: ...		      |
 *            |			      |
 *            |			      |	L: <br-stmts>
 *            |			      |	   jmp 1b
 *            |                       |
 * -----------+-----------------------+------------------
 *
 * The initial value is encoded in the LSB of static_key::entries,
 * type: 0 = false, 1 = true.
 *
 * The branch type is encoded in the LSB of jump_entry::key,
 * branch: 0 = unlikely, 1 = likely.
 *
 * This gives the following logic table:
 *
 *	enabled	type	branch	  instuction
 * -----------------------------+-----------
 *	0	0	0	| NOP
 *	0	0	1	| JMP
 *	0	1	0	| NOP
 *	0	1	1	| JMP
 *
 *	1	0	0	| JMP
 *	1	0	1	| NOP
 *	1	1	0	| JMP
 *	1	1	1	| NOP
 *
 * Which gives the following functions:
 *
 *   dynamic: instruction = enabled ^ branch
 *   static:  instruction = type ^ branch
 *
 * See jump_label_type() / jump_label_init_type().
 */

The case here is false-unlikely, which *should* then result in the
branch statements going out-of-line.
