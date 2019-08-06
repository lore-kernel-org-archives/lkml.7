Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3B5C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A742208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfHFQe7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfHFQe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:34:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40590208C3;
        Tue,  6 Aug 2019 16:34:57 +0000 (UTC)
Date:   Tue, 6 Aug 2019 12:34:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch
 in arm64
Message-ID: <20190806123455.487ac02b@gandalf.local.home>
In-Reply-To: <20190806154811.GB39951@google.com>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
        <20190802112259.0530a648@gandalf.local.home>
        <20190802120920.3b1f4351@gandalf.local.home>
        <20190802121124.6b41f26a@gandalf.local.home>
        <20190806154811.GB39951@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 11:48:11 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:


> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index 5ab5200b2bdc..13a4832cfb00 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -13,6 +13,7 @@
> >  #define HAVE_FUNCTION_GRAPH_FP_TEST
> >  #define MCOUNT_ADDR		((unsigned long)_mcount)
> >  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> > +#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1
> >  
> >  #ifndef __ASSEMBLY__
> >  #include <linux/compat.h>
> > diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> > index 5d16f73898db..050c6bd9beac 100644
> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -158,6 +158,18 @@ static void check_stack(unsigned long ip, unsigned long *stack)
> >  			i++;
> >  	}
> >  
> > +#ifdef ARCH_RET_ADDR_AFTER_LOCAL_VARS
> > +	/*
> > +	 * Most archs store the return address before storing the
> > +	 * function's local variables. But some archs do this backwards.
> > +	 */
> > +	if (x > 1) {
> > +		memmove(&stack_trace_index[0], &stack_trace_index[1],
> > +			sizeof(stack_trace_index[0]) * (x - 1));
> > +		x--;
> > +	}
> > +#endif
> > +
> >  	stack_trace_nr_entries = x;
> >  
> >  	if (task_stack_end_corrupted(current)) {  
> 
> 
> I am not fully understanding the fix :(. If the positions of the data and
> FP/LR are swapped, then there should be a loop of some sort where the FP/LR
> are copied repeatedly to undo the mess we are discussing. But in this patch
> I see only one copy happening. May be I just don't understand this code well
> enough. Are there any more clues for helping understand the fix?

Here's the best way to explain this. The code is using the stack trace
to figure out which function is the stack hog. Or perhaps a serious of
stack hogs. On x86, a call stores the return address as it calls the
next function. Then that function allocates its stack frame for its
local variables and saving of registers.

on x86:

[ top of stack ]
 0: sys call entry frame
10: return addr to entry code
11: start of sys_foo frame
20: return addr to sys_foo
21: start of kernel_func_bar frame
30: return addr to kernel_func_bar
31: [ do trace stack here ]


Then we do a save_stack_trace which returns the addresses of the
functions it finds. Which would be (from the bottom of the stack to the
top)

  return addr to kernel_func_bar
  return addr to sys_foo
  return addr to entry code

What we do here is try to figure out how much stack each of theses
functions have. So we loop through the stack looking for the addresses
returned by the save_stack trace, and see where on the stack this is.
This gives us:

  return addr to kernel_func_bar [ 30 ]
  return addr to sys_foo         [ 20 ]
  return addr to entry frame     [ 10 ]

From this, we can conclude (on x86) that the size of the stack used for
kernel_func_bar is 30 - 20 = 10. Because on the stack we have:

20: return addr to sys_foo
21: start of kernel_func_bar frame  <<-- kernel_func_bar stack frame
30: return addr to kernel_func_bar


Now, what Jiping reported, is that on arm64, it saves the link register
(the return address) when it is needed to, which is after the stack
frame for the current function has been saved. That means we have
something that looks like this:

on arm64:

[ top of stack ]
 0: sys call entry frame
10: start of sys_foo_frame
19: return addr to entry code << lr saved before calling kern_func_bar
20: start of kernel_func_bar frame
29: return addr to sys_foo_frame << lr saved before calling next function
30: [ do trace stack here ]

Now, I have a question. To call the mcount code (ftrace and the stack
tracing), you need to save the return address of kern_func_bar
somewhere, otherwise the call to mcount will overwrite the lr. But
let's say it does and then forgets it, so we have:

30: return addr of kernel_func_bar frame
31: [ do trace stack here ]

Now save_stack_trace gives us the same result:

 return addr to kernel_func bar
 return addr to sys_foo
 return addr to entry frame

But we get a different result when finding them in the location of the
stack.

 return addr to kernel_func_bar [ 30 ]
 return addr to sys foo         [ 29 ]
 return addr to entry frame     [ 19 ]

The simple subtractions will be off:

kernel_func_bar stack size = 30 - 29 = 1
Or even, sys_foo 29 - 19 = 10, but if we look at the stack:

10: start of sys_foo_frame
19: return addr to entry_code
20: start of kernel_func_bar frame
29: return addr to sys_foo

We are measuring the kernel_func_bar frame for sys_foo!

We are off by one here.

stack_trace_index[] is an array of the offsets mapping to the function
return addresses found. If we shift it by one, then we then sync the
functions found with their frames:

stack_trace_index[0] = 30
stack_trace_index[1] = 29
stack_trace_index[2] = 19

		memmove((&stack_trace_index[0], &stack_trace_index[1],
			sizeof(stack_trace_index[0]) * (x - 1));

Makes that:

stack_trace_index[0] = 29
stack_trace_index[1] = 19

And we do x-- to lose the last frame.

With the stack_dump_trace being:

stack_dump_trace[0] = return addr kernel_func_bar
stack_dump_trace[1] = return addr sys_foo

we then match which frame size belongs to which function better.


> 
> Also, this stack trace loop (original code) is a bit hairy :) It appears
> there is a call to stack_trace_save() followed by another loop that goes
> through the returned entries from there and tries to generate a set of
> indexes. Isn't the real issue that the entries returned by stack_trace_save()
> are a out of whack? I am curious also if other users of stack_trace_save()
> will suffer from the same issue.

No, the order is fine. The issue is that we are using the location of
the return address in the stack to find out what function has the
biggest stack usage, and our assumption for arm64 is incorrect in that
location.

-- Steve
