Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD6DC606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAD1216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfGHWir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:38:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfGHWiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:38:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FB51356EC;
        Mon,  8 Jul 2019 22:38:46 +0000 (UTC)
Received: from treble (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CD5D1001B2B;
        Mon,  8 Jul 2019 22:38:37 +0000 (UTC)
Date:   Mon, 8 Jul 2019 17:38:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kairui Song <kasong@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
Message-ID: <20190708223834.zx7u45a4uuu2yyol@treble>
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
 <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com>
 <20190707013206.don22x3tfldec4zm@treble>
 <20190707055209.xqyopsnxfurhrkxw@treble>
 <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 08 Jul 2019 22:38:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 03:15:37PM -0700, Alexei Starovoitov wrote:
> > 2)
> >
> >   After doing the first optimization, GCC then does another one which is
> >   a little trickier.  It replaces:
> >
> >         select_insn:
> >                 jmp *jumptable(, %rax, 8)
> >                 ...
> >         ALU64_ADD_X:
> >                 ...
> >                 jmp *jumptable(, %rax, 8)
> >         ALU_ADD_X:
> >                 ...
> >                 jmp *jumptable(, %rax, 8)
> >
> >   with
> >
> >         select_insn:
> >                 mov jumptable, %r12
> >                 jmp *(%r12, %rax, 8)
> >                 ...
> >         ALU64_ADD_X:
> >                 ...
> >                 jmp *(%r12, %rax, 8)
> >         ALU_ADD_X:
> >                 ...
> >                 jmp *(%r12, %rax, 8)
> >
> >   The problem is that it only moves the jumptable address into %r12
> >   once, for the entire function, then it goes through multiple recursive
> >   indirect jumps which rely on that %r12 value.  But objtool isn't yet
> >   smart enough to be able to track the value across multiple recursive
> >   indirect jumps through the jump table.
> >
> >   After some digging I found that the quick and easy fix is to disable
> >   -fgcse.  In fact, this seems to be recommended by the GCC manual, for
> >   code like this:
> >
> >     -fgcse
> >         Perform a global common subexpression elimination pass.  This
> >         pass also performs global constant and copy propagation.
> >
> >         Note: When compiling a program using computed gotos, a GCC
> >         extension, you may get better run-time performance if you
> >         disable the global common subexpression elimination pass by
> >         adding -fno-gcse to the command line.
> >
> >         Enabled at levels -O2, -O3, -Os.
> >
> >   This code indeed relies extensively on computed gotos.  I don't know
> >   *why* disabling this optimization would improve performance.  In fact
> >   I really don't see how it could make much of a difference either way.
> >
> >   Anyway, using -fno-gcse makes optimization #2 go away and makes
> >   objtool happy, with only a fix for #1 needed.
> >
> >   If -fno-gcse isn't an option, we might be able to fix objtool by using
> >   the "first_jump_src" thing which Peter added, improving it such that
> >   it also takes table jumps into account.
> 
> Sorry for delay. I'm mostly offgrid until next week.
> As far as -fno-gcse.. I don't mind as long as it doesn't hurt performance.
> Which I suspect it will :(
> All these indirect gotos are there for performance.
> Single indirect goto and a bunch of jmp select_insn
> are way slower, since there is only one instruction
> for cpu branch predictor to work with.
> When every insn is followed by "jmp *jumptable"
> there is more room for cpu to speculate.
> It's been long time, but when I wrote it the difference
> between all indirect goto vs single indirect goto was almost 2x.

Just to clarify, -fno-gcse doesn't get rid of any of the indirect jumps.
It still has 166 indirect jumps.  It just gets rid of the second
optimization, where the jumptable address is placed in a register.

If you have a benchmark which is relatively easy to use, I could try to
run some tests.

-- 
Josh
