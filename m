Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D5C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 05:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887D22083B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 05:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGGFwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 01:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfGGFwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 01:52:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A0A1306041F;
        Sun,  7 Jul 2019 05:52:17 +0000 (UTC)
Received: from treble (ovpn-122-197.rdu2.redhat.com [10.10.122.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DCAC1001B30;
        Sun,  7 Jul 2019 05:52:11 +0000 (UTC)
Date:   Sun, 7 Jul 2019 00:52:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     bp@alien8.de, hpa@zytor.com, songliubraving@fb.com,
        tglx@linutronix.de, rostedt@goodmis.org, kasong@redhat.com,
        daniel@iogearbox.net, ast@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
Message-ID: <20190707055209.xqyopsnxfurhrkxw@treble>
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
 <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com>
 <20190707013206.don22x3tfldec4zm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190707013206.don22x3tfldec4zm@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 07 Jul 2019 05:52:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 08:32:06PM -0500, Josh Poimboeuf wrote:
> On Sat, Jul 06, 2019 at 10:29:42PM +0200, Ingo Molnar wrote:
> > Hm, I get this new build warning on x86-64 defconfig-ish kernels plus 
> > these enabled:
> > 
> >  CONFIG_BPF=y
> >  CONFIG_BPF_JIT=y
> > 
> > kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x8da: sibling call from callable instruction with modified stack frame
> 
> I assume you have CONFIG_RETPOLINE disabled?  For some reason that
> causes GCC to add 166 indirect jumps to that function, which is giving
> objtool trouble.  Looking into it.

Alexei, do you have any objections to setting -fno-gcse for
___bpf_prog_run()?  Either for the function or the file?  Doing so seems
to be recommended by the GCC manual for computed gotos.  It would also
"fix" one of the issues.  More details below.

Details:

With CONFIG_RETPOLINE=n, there are a couple of GCC optimizations in
___bpf_prog_run() which objtool is having trouble with.

1)

  The function has:

	select_insn:
		goto *jumptable[insn->code];

  And then a bunch of "goto select_insn" statements.

  GCC is basically replacing

	select_insn:
		jmp *jumptable(,%rax,8)
		...
	ALU64_ADD_X:
		...
		jmp select_insn
	ALU_ADD_X:
		...
		jmp select_insn

  with

	select_insn:
		jmp *jumptable(, %rax, 8)
		...
	ALU64_ADD_X:
		...
		jmp *jumptable(, %rax, 8)
	ALU_ADD_X:
		...
		jmp *jumptable(, %rax, 8)


  It does that 166 times.

  For some reason, it doesn't do the optimization with retpolines
  enabled.

  Objtool has never seen multiple indirect jump sites which use the same
  jump table.  This is relatively trivial to fix (I already have a
  working patch).

2)

  After doing the first optimization, GCC then does another one which is
  a little trickier.  It replaces:

	select_insn:
		jmp *jumptable(, %rax, 8)
		...
	ALU64_ADD_X:
		...
		jmp *jumptable(, %rax, 8)
	ALU_ADD_X:
		...
		jmp *jumptable(, %rax, 8)

  with

	select_insn:
		mov jumptable, %r12
		jmp *(%r12, %rax, 8)
		...
	ALU64_ADD_X:
		...
		jmp *(%r12, %rax, 8)
	ALU_ADD_X:
		...
		jmp *(%r12, %rax, 8)

  The problem is that it only moves the jumptable address into %r12
  once, for the entire function, then it goes through multiple recursive
  indirect jumps which rely on that %r12 value.  But objtool isn't yet
  smart enough to be able to track the value across multiple recursive
  indirect jumps through the jump table.

  After some digging I found that the quick and easy fix is to disable
  -fgcse.  In fact, this seems to be recommended by the GCC manual, for
  code like this:

    -fgcse
	Perform a global common subexpression elimination pass.  This
	pass also performs global constant and copy propagation.

	Note: When compiling a program using computed gotos, a GCC
	extension, you may get better run-time performance if you
	disable the global common subexpression elimination pass by
	adding -fno-gcse to the command line.

        Enabled at levels -O2, -O3, -Os.

  This code indeed relies extensively on computed gotos.  I don't know
  *why* disabling this optimization would improve performance.  In fact
  I really don't see how it could make much of a difference either way.

  Anyway, using -fno-gcse makes optimization #2 go away and makes
  objtool happy, with only a fix for #1 needed.

  If -fno-gcse isn't an option, we might be able to fix objtool by using
  the "first_jump_src" thing which Peter added, improving it such that
  it also takes table jumps into account.

-- 
Josh
