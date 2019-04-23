Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C27CC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F72183E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfDWSPy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbfDWSPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:15:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3044CAE8A;
        Tue, 23 Apr 2019 18:15:51 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicolai Stange <nstange@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 1/1] x86/ftrace: make ftrace_int3_handler() not to skip fops invocation
References: <20180726104029.7736-1-nstange@suse.de>
        <20180726104029.7736-2-nstange@suse.de>
        <20190419160513.1faa01d2@gandalf.local.home>
Date:   Tue, 23 Apr 2019 20:15:49 +0200
In-Reply-To: <20190419160513.1faa01d2@gandalf.local.home> (Steven Rostedt's
        message of "Fri, 19 Apr 2019 16:05:13 -0400")
Message-ID: <87ef5sfuzu.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

many thanks for having a look!

Steven Rostedt <rostedt@goodmis.org> writes:

> I just found this in my Inbox, and this looks to be a legit issue.
>
> On Thu, 26 Jul 2018 12:40:29 +0200
> Nicolai Stange <nstange@suse.de> wrote:
>
> You still working on this?

Yes, this still needs to get fixed somehow, preferably at the ftrace
layer.

>
>> With dynamic ftrace, ftrace patches call sites in a three steps:
>> 1. Put a breakpoint at the to be patched location,
>> 2. update call site and
>> 3. finally remove the breakpoint again.
>> 
>> Note that the breakpoint ftrace_int3_handler() simply makes execution
>> to skip over the to be patched function.
>> 
>> This patching happens in the following circumstances:
>> - the global ftrace_trace_function changes and the call sites at
>>   ftrace_call and ftrace_regs_call get patched,
>> - an ftrace_ops' ->func changes and the call site in its trampoline gets
>>   patched,
>> - graph tracing gets enabled/disabled and the jump site at
>>   ftrace_graph_call gets patched
>> - a mcount site gets converted from nop -> call, call -> nop
>>   or call -> call.
>> 
>> The latter case, i.e. a mcount call getting redirected, happens for example
>> in a transition from trampolined to not trampolined upon a user enabling
>> function tracing on a live patched function.
>> 
>> The ftrace_int3_handler() simply skipping over the mcount callsite is
>> problematic here, because it means that a live patched function gets
>> temporarily reverted to its unpatched original and this breaks live
>> patching consistency.
>> 
>> Make ftrace_int3_handler not to skip over the fops invocation, but modify
>> the interrupted control flow to issue a call as needed.
>> 
>> For determining what the proper action actually is, modify
>> update_ftrace_func() to take an extra argument, func, to be called if the
>> corresponding breakpoint gets hit. Introduce a new global variable,
>> trace_update_func_dest and let update_ftrace_func() set it. For the special
>> case of patching the jmp insn at ftrace_graph_call, set it to zero and make
>> ftrace_int3_handler() just skip over the insn in this case as before.
>> 
>> Because there's no space left above the int3 handler's iret frame to stash
>> an extra call's return address in, this can't be mimicked from the
>> ftrace_int3_handler() itself.
>> 
>> Instead, make ftrace_int3_handler() change the iret frame's %rip slot to
>> point to the new ftrace_int3_call_trampoline to be executed immediately
>> after iret.
>> 
>> The original %rip gets communicated to ftrace_int3_call_trampoline which
>> can then take proper action. Note that ftrace_int3_call_trampoline can
>> nest, because of NMIs, for example. In order to avoid introducing another
>> stack, abuse %r11 for passing the original %rip. This is safe, because the
>> interrupted context is always at a call insn and according to the x86_64
>> ELF ABI allows %r11 is callee-clobbered. According to the glibc sources,
>> this is also true for the somewhat special mcount/fentry ABI.
>> 
>> OTOH, a spare register doesn't exist on i686 and thus, this is approach is
>> limited to x86_64.
>> 
>> For determining the call target address, let ftrace_int3_call_trampoline
>> compare ftrace_update_func against the interrupted %rip.
>
> I don't think we need to do the compare.
>
>> If they match, an update_ftrace_func() is currently pending and the
>> call site is either of ftrace_call, ftrace_regs_call or the call insn
>> within a fops' trampoline. Jump to the ftrace_update_func_dest location as
>> set by update_ftrace_func().
>> 
>> If OTOH the interrupted %rip doesn't equal ftrace_update_func, then
>> it points to an mcount call site. In this case, redirect control flow to
>> the most generic handler, ftrace_regs_caller, which will then do the right
>> thing.
>> 
>> Finally, reading ftrace_update_func and ftrace_update_func_dest from
>> outside of the int3 handler requires some care: inbetween adding and
>> removing the breakpoints, ftrace invokes run_sync() which basically
>> issues a couple of IPIs. Because the int3 handler has interrupts disabled,
>> it orders with run_sync().
>> 
>> To extend that ordering to also include ftrace_int3_call_trampoline, make
>> ftrace_int3_handler() disable interrupts within the iret frame returning to
>> it.
>> 
>> Store the original EFLAGS.IF into %r11's MSB which, because it represents
>> a kernel address, is redundant. Make ftrace_int3_call_trampoline restore
>> it when done.
>
> This can be made much simpler by making a hardcoded ftrace_int3_tramp
> that does the following:
>
> ftrace_int3_tramp
> 	push	%r11
> 	jmp	ftrace_caller


But wouldn't this mean that ftrace_caller could nest if the breakpoint
in question happened to be placed at ftrace_call? Infinite recursion set
aside, the ip value determined from inner calls based on the on-stack
return address would be wrong, AFAICS. Or am I missing something here?


> The ftrace_caller will either call a single ftrace callback, if there's
> only a single ops registered, or it will call the loop function that
> iterates over all the ftrace_ops registered and will call each function
> that matches the ftrace_ops hashes.
>
> In either case, it's what we want.

Ok, under the assumption that my above point is valid, this patch could
still get simplified a lot by having two trampolines:

1.) Your ftrace_int3_tramp from above, to be used if the patched insn is
    some mcount call site. The live patching fops will need
    ftrace_regs_caller though. So,

	ftrace_int3_tramp_regs_caller:
		push %r11
                jmp ftrace_regs_caller

2.) Another one redirecting control flow to ftrace_ops_list_func(). It's
    going to be used when the int3 is found at ftrace_call or
    ftrace_regs_call resp. their counterparts in some ftrace_ops'
    trampoline.

	ftrace_int3_tramp_list_func:
		push %r11
                jmp ftrace_ops_list_func

ftrace_int3_handler() would then distinguish the following cases:
1.) ip == ftrace_graph_call => ignore, i.e. skip the insn
2.) is_ftrace_caller(ip) => ftrace_int3_tramp_list_func
3.) ftrace_location(ip) => ftrace_int3_tramp_regs_caller

ftrace_location() is getting invoked from ftrace_int3_handler() already,
so there wouldn't be any additional cost.

If that makes sense to you, I'd prepare a patch...


> The ftrace_int3_tramp will simply simulate the call ftrace_caller that
> would be there as the default caller if more than one function is set
> to it.
>
> For 32 bit, we could add 4 variables on the thread_info and make 4
> trampolines, one for each context (normal, softirq, irq and NMI), and
> have them use the variable stored in the thread_info for that location:
>
> ftrace_int3_tramp_normal
> 	push %eax # just for space
> 	push %eax
> 	mov whatever_to_get_thread_info, %eax
> 	mov normal(%eax), %eax
> 	mov %eax, 4(%esp)
> 	pop %eax
> 	jmp ftrace_caller
>
> ftrace_int3_tramp_softiqr
> 	push %eax # just for space
> 	push %eax
> 	mov whatever_to_get_thread_info, %eax
> 	mov softirq(%eax), %eax
> 	mov %eax, 4(%esp)
> 	pop %eax
> 	jmp ftrace_caller
>
> etc..
>
>
> A bit crazier for 32 bit but it can still be done. ;-)

Ok, but currently CONFIG_HAVE_LIVEPATCH=n for x86 && !x86_64,
so I'd rather not invest too much energy into screwing 32 bit up ;)

Thanks!

Nicolai


-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
