Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF866C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC48218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfDXMf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDXMf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:35:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1062020811;
        Wed, 24 Apr 2019 12:35:26 +0000 (UTC)
Date:   Wed, 24 Apr 2019 08:35:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 1/1] x86/ftrace: make ftrace_int3_handler() not to
 skip fops invocation
Message-ID: <20190424083525.1cf8d990@gandalf.local.home>
In-Reply-To: <87bm0vexgj.fsf@suse.de>
References: <20180726104029.7736-1-nstange@suse.de>
        <20180726104029.7736-2-nstange@suse.de>
        <20190419160513.1faa01d2@gandalf.local.home>
        <87ef5sfuzu.fsf@suse.de>
        <20190423195023.425902dc@gandalf.local.home>
        <87bm0vexgj.fsf@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 08:20:12 +0200
Nicolai Stange <nstange@suse.de> wrote:

> Alright, if there's a use case beyond live patching, I can try to handle
> 32 bits alongside, of course.
> 
> However, some care will be needed when determining the actual context
> from ftrace_int3_handler(): tracing anything before the addition or
> after the subtraction of HARDIRQ_OFFSET to/from preempt_count in
> irq_enter() resp. irq_exit() could otherwise clobber the "normal" state
> in thread_info, correct?
> 
> How about having a fixed size stack with three entries shared between
> "normal", "irq" and "softirq" in thread_info, as well as a dedicated
> slot for nmi context? (The stack would be modified/consumed only with
> irqs disabled).
> 
> Which makes me wonder:
> - if we disabled preemption from ftrace_int3_handler() and reenabled it
>   again from the *_int3_tramp*s, these stacks could be made per-CPU,
>   AFAICS,

Heh, here you go again, having some of the ideas I came up with as well.

I thought about this use per-cpu variables and this preempt disable
hack as well. But thinking more on it, it goes into the "too crazy, and
too fragile" category. It breaks a lot of norms (but I do that a lot
anyway ;) and decided that it would probably not be accepted by others.

I much rather use the above thread info solution. As for the
irq_enter/exit() issue, instead of using the preempt_count context, we
could just have a counter in the thread info as well:

	depth = local_add_return(thread_info->ftrace_int_depth);
	thread_info->slot[depth] = *(pt_regs->sp);

Where thread_info->slot is an array of 4 long words.

And then in the trampoline: (pseudo code)

	push	%rax	// just a place holder
	push	%rax
	push	%rdx
	mov	thread->depth, %rax
	mov	thread->slot(%rax), %rdx
	mov	%rdx, 16(%rsp)
	add	-1,%rax
	mov	%rax, thread->depth
	pop	%rdx
	pop	%rax
	jmp	ftrace_caller
	
If an interrupt were to come in at any time, it would just increment
the depth, use the next slot, and then decrement it back to what the
depth was when it interrupted the code.

-- Steve

> - and why not use this strategy on x86_64, too? The advantages would be
>   a common implemention between 32 and 64 bit and more importantly, not
>   relying on that %r11 hack. When doing the initial RFC patch, it
>   wasn't clear to me that at most one stack slot per context would be
>   needed, i.e. only four in total...

