Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67600C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F00218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfDWXu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfDWXu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:50:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2766620B1F;
        Tue, 23 Apr 2019 23:50:25 +0000 (UTC)
Date:   Tue, 23 Apr 2019 19:50:23 -0400
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
Message-ID: <20190423195023.425902dc@gandalf.local.home>
In-Reply-To: <87ef5sfuzu.fsf@suse.de>
References: <20180726104029.7736-1-nstange@suse.de>
        <20180726104029.7736-2-nstange@suse.de>
        <20190419160513.1faa01d2@gandalf.local.home>
        <87ef5sfuzu.fsf@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 20:15:49 +0200
Nicolai Stange <nstange@suse.de> wrote:

> > This can be made much simpler by making a hardcoded ftrace_int3_tramp
> > that does the following:
> >
> > ftrace_int3_tramp
> > 	push	%r11
> > 	jmp	ftrace_caller  
> 
> 
> But wouldn't this mean that ftrace_caller could nest if the breakpoint
> in question happened to be placed at ftrace_call? Infinite recursion set
> aside, the ip value determined from inner calls based on the on-stack
> return address would be wrong, AFAICS. Or am I missing something here?

I had a reply here, but I think you explained what I just explained
(and then deleted) below ;-)

> 
> 
> > The ftrace_caller will either call a single ftrace callback, if there's
> > only a single ops registered, or it will call the loop function that
> > iterates over all the ftrace_ops registered and will call each function
> > that matches the ftrace_ops hashes.
> >
> > In either case, it's what we want.  
> 
> Ok, under the assumption that my above point is valid, this patch could
> still get simplified a lot by having two trampolines:
> 
> 1.) Your ftrace_int3_tramp from above, to be used if the patched insn is
>     some mcount call site. The live patching fops will need
>     ftrace_regs_caller though. So,
> 
> 	ftrace_int3_tramp_regs_caller:
> 		push %r11
>                 jmp ftrace_regs_caller
> 
> 2.) Another one redirecting control flow to ftrace_ops_list_func(). It's
>     going to be used when the int3 is found at ftrace_call or
>     ftrace_regs_call resp. their counterparts in some ftrace_ops'
>     trampoline.
> 
> 	ftrace_int3_tramp_list_func:
> 		push %r11
>                 jmp ftrace_ops_list_func

Yes, I wrote a reply basically stating something similar, but then
deleted it after reading what you wrote here!

> 
> ftrace_int3_handler() would then distinguish the following cases:
> 1.) ip == ftrace_graph_call => ignore, i.e. skip the insn

OK, because this transition would be from "call function graph" to
"nop" or the other way. Either case, one would always be a nop.

> 2.) is_ftrace_caller(ip) => ftrace_int3_tramp_list_func
> 3.) ftrace_location(ip) => ftrace_int3_tramp_regs_caller
> 
> ftrace_location() is getting invoked from ftrace_int3_handler() already,
> so there wouldn't be any additional cost.
> 
> If that makes sense to you, I'd prepare a patch...

Yes it does.

> 
> 
> > The ftrace_int3_tramp will simply simulate the call ftrace_caller that
> > would be there as the default caller if more than one function is set
> > to it.
> >
> > For 32 bit, we could add 4 variables on the thread_info and make 4
> > trampolines, one for each context (normal, softirq, irq and NMI), and
> > have them use the variable stored in the thread_info for that location:
> >
> > ftrace_int3_tramp_normal
> > 	push %eax # just for space
> > 	push %eax
> > 	mov whatever_to_get_thread_info, %eax
> > 	mov normal(%eax), %eax
> > 	mov %eax, 4(%esp)
> > 	pop %eax
> > 	jmp ftrace_caller
> >
> > ftrace_int3_tramp_softiqr
> > 	push %eax # just for space
> > 	push %eax
> > 	mov whatever_to_get_thread_info, %eax
> > 	mov softirq(%eax), %eax
> > 	mov %eax, 4(%esp)
> > 	pop %eax
> > 	jmp ftrace_caller
> >
> > etc..
> >
> >
> > A bit crazier for 32 bit but it can still be done. ;-)  
> 
> Ok, but currently CONFIG_HAVE_LIVEPATCH=n for x86 && !x86_64,
> so I'd rather not invest too much energy into screwing 32 bit up ;)
>

Probably not something you care about, but something that I do. Which
means it will have to go on my TODO list. I care about missed functions
being called. This means, if you have something tracing a function, and
then enable something else to trace that same function, you might miss
the first one.

-- Steve
