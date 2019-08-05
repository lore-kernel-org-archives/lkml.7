Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3381AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EF420856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565004333;
	bh=TmtelhoJN4rVcHfXDz3RKpzTznoS0df18x7lkJ3wjmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GKndY1VKOsdqlnewF1wgSEn0Ko3AGNPvyWO0t6JzF1k4YcnxDs83Y3cyJhWFHKZo/
	 /6pnxQK187Evhq+nvJTqH5nDLnfDhZozacjrZ8NYljyJgwu+1FdLTrbDYatIQdawh8
	 1f9/L3lY5vvxQGoc8a5/1V8TPpJVbKhcQSPrDqs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfHELZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbfHELZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:25:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D74D20679;
        Mon,  5 Aug 2019 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565004330;
        bh=TmtelhoJN4rVcHfXDz3RKpzTznoS0df18x7lkJ3wjmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwjTiTqtOTSLR90R4HPaTwUMIIgulnB4VUo/wk1H6p7yMjy+aF/IYLLLinWo+SB47
         bkxr6dYdste7KqIDRbvhsyLEL3KE86XeJqb/HAeGUYWh8naQwbn53CzRXiEEESs4M0
         hLM7B37NItieTBAYI3lMC6BK7tO3D1lNcCubqDiU=
Date:   Mon, 5 Aug 2019 12:25:25 +0100
From:   Will Deacon <will@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jiping Ma <jiping.ma2@windriver.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, takahiro.akashi@linaro.org
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch in
 arm64
Message-ID: <20190805112524.ajlmouutqckwpqyd@willie-the-truck>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
 <20190802112259.0530a648@gandalf.local.home>
 <20190803082642.GA224541@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803082642.GA224541@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Akashi, since he may remember more of the gory details here]

On Sat, Aug 03, 2019 at 04:26:42AM -0400, Joel Fernandes wrote:
> On Fri, Aug 02, 2019 at 11:22:59AM -0400, Steven Rostedt wrote:
> [snip]
> > > There is not PC in ARM64 stack, LR is used to for walk_stackframe in
> > > ARM64. Tere is no the issue in ARM32 because there is PC in ARM32 stack.
> > > PC is used to calculate the stack size in trace_stack.c, so the
> > > function name and its stack size appear to be off-by-one.
> > > ARM64 stack layout:
> > > 	LR
> > >         FP
> > >         ......
> > >         LR
> > >         FP
> > >         ......
> > 
> > I think you are not explaining the issue correctly. From looking at the
> > document, I think what you want to say is that the LR is saved *after*
> > the data for the function. Is that correct? If so, then yes, it would
> > cause the stack tracing algorithm to be incorrect.
> > 
> > Most archs do this:
> > 
> > On entry to a function:
> > 
> > 	save return address
> >  	reserve local variables and such for current function
> > 
> > I think you are saying that arm64 does this backwards.
> > 
> > 	reserve local variables and such for current function
> > 	save return address (LR)
> 
> Actually for arm64 it is like what you said about 'Most archs'. It saves FP
> and LR first onto the current stack frame, then assigns the top of the stack
> to FP (marking the new frame). Then executes branch-link, and then allocates
> space to variables on stack in the callee.
> 
> Disassembly of prog:
> 
> int foo(int x, int y) {
> 	int a[32];
>         return (x + y + a[31]);
> }
> 
> int bar(void) {
>         foo(1, 2);
> }
> 
> confirms it:
> 
> 000000000000073c <bar>:
>  73c:   a9bf7bfd        stp     x29, x30, [sp, #-16]! <-- save FP and LR
>  740:   910003fd        mov     x29, sp		      <-- create new FP 
>  744:   52800041        mov     w1, #0x2              <-- pass arguments
>  748:   52800020        mov     w0, #0x1 
>  74c:   97fffff4        bl      71c <foo>             <-- branch (sets LR)
>  750:   d503201f        nop
>  754:   a8c17bfd        ldp     x29, x30, [sp], #16   <-- restore FP, LR
>  758:   d65f03c0        ret
> 
> 000000000000071c <foo>:
>  71c:   d10243ff        sub     sp, sp, #0x90        <-- space for local var
>  720:   b9000fe0        str     w0, [sp, #12]
>  724:   b9000be1        str     w1, [sp, #8]
>  728:   b9400fe1        ldr     w1, [sp, #12]
>  72c:   b9400be0        ldr     w0, [sp, #8]
>  730:   0b000021        add     w1, w1, w0
>  734:   b9408fe0        ldr     w0, [sp, #140]
>  738:   0b000020        add     w0, w1, w0
>  73c:   910243ff        add     sp, sp, #0x90      <-- restore sp before ret
>  740:   d65f03c0        ret

I think we need to untangle things a bit here.

The arm64 PCS makes no guarantee about the position of the frame record with
respect to stack allocations, so relying on this is fragile at best. This is
partly why the ftrace-with-regs work currently relies on
-fpatchable-function-entry, since that allows the very beginning of the
function to be intercepted which I don't think is necessarily the case with
-pg/_mcount.

For the snippet above, foo is a leaf function and does not have a frame record
placed on the stack. If we instead look at something like:

__attribute__((noinline)) int baz(int x)
{
	return x;
}

__attribute__((noinline)) int bar(int x)
{
	int a[32];
	return baz(x * a[0]);
}

int foo(int x)
{
	return bar(x);
}

then the first instruction of bar() allocates stack space and pushes
the frame record at the same time:

	stp	x29, x30, [sp, -144]!

This can be read as "subtract 144 bytes (32*4 + 16) from the stack pointer,
write the frame record there and then update the stack pointer to point at the
bottom of the newly allocated stack", which means that the array 'a[32]' sits
directly /above/ the frame record on the stack. However, this is just what my
GCC happened to do today. When we looked at this back in 2015, there were other
cases we ended up having to identify with heuristics based on what had been
observed under various compilers:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393721.html

This was deemed to be far too fragile, so we didn't merge it in the end.

If this is to work reliably, then we need support from the tools. This was
raised when we first merged support for ftrace, but I'm not sure it went
anywhere:

https://gcc.gnu.org/ml/gcc/2016-01/msg00035.html

So, I completely agree with Steve that we shouldn't be littering the core code
with #ifdef CONFIG_ARM64, but we probably do need something in the arch backend
if we're going to do this properly, and that in turn is likely to need a very
different algorithm from the one currently in use.

Will
