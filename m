Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EAFC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767F220693
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfD1Rid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfD1Ric (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:38:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1265520675;
        Sun, 28 Apr 2019 17:38:28 +0000 (UTC)
Date:   Sun, 28 Apr 2019 13:38:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
Message-ID: <20190428133826.3e142cfd@oasis.local.home>
In-Reply-To: <20190427102657.GF2623@hirez.programming.kicks-ass.net>
References: <20190427100639.15074-1-nstange@suse.de>
        <20190427100639.15074-4-nstange@suse.de>
        <20190427102657.GF2623@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Added Linus ]

On Sat, 27 Apr 2019 12:26:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Apr 27, 2019 at 12:06:38PM +0200, Nicolai Stange wrote:
> > ftrace_int3_handler()'s context is different from the interrupted call
> > instruction's one, obviously. In order to be able to emulate the call
> > within the original context, make ftrace_int3_handler() set its iret
> > frame's ->ip to some helper stub. Upon return from the trap, this stub will
> > then mimic the call by pushing the the return address onto the stack and
> > issuing a jmp to the target address. As describe above, the jmp target
> > will be either of ftrace_ops_list_func() or ftrace_regs_caller(). Provide
> > one such stub implementation for each of the two cases.  
> 
> Yuck; I'd much rather we get that static_call() stuff sorted such that
> text_poke() and poke_int3_handler() can do CALL emulation.
> 
> Given all the back and forth, I think the solution where we shift
> pt_regs a bit to allow the emulated PUSH is a viable solution; eg. I
> think we collectively hated it least.

Note, this use case is slightly different than the static calls but has
the same issue.  That issue is that we need a way to simulate a "call"
function from int3, and there's no good way to handle that case right
now.

The static call needs to modify the call sight but make the call still
work from int3 context.

This use case is similar, but the issue is with a "bug" in the function
tracing implementation, that has become an issue with live kernel
patching which is built on top of it.

The issue is this:

For optimization reasons, if there's only a single user of a function
it gets its own trampoline that sets up the call to its callback and
calls that callback directly:


<function being traced>
  call custom trampoline


<custom trampoline>
   save regs to call C code
   call custom_callback
   restore regs
   ret

If more than one callback is attached to that function, then we need to
call the iterator that loops through all registered callbacks of the
function tracer and checks their hashes to see if they want to trace
this function or not.

<function being traced>
  call iterator_trampoline

<iterator_trampoline>
  save regs to call C code
  call iterator
  restore regs
  ret

What happens in that transition? We add an "int3" at the function being
traced, and change:

  call custom_trampoline

to

  call iterator_trampoline

But if the function being traced is executed during this transition,
the int3 just makes it act like a nop and returns pass the call.

For tracing this is a bug because we just missed a function that should
be traced. For live kernel patching, this could be more devastating
because the original "buggy" patched function is called, and this could
cause subtle problems.

If we can add a slot to the int3 handler, that we can use to emulate a
call, (perhaps add another slot to pt_regs structure, call it link
register)

It would make it easier to solve both this and the static call problems.

-- Steve
