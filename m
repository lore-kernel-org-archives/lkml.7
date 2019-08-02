Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E962C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D66F2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbfHBPXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfHBPXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:23:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 924342087C;
        Fri,  2 Aug 2019 15:23:01 +0000 (UTC)
Date:   Fri, 2 Aug 2019 11:22:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiping Ma <jiping.ma2@windriver.com>
Cc:     <mingo@redhat.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch
 in arm64
Message-ID: <20190802112259.0530a648@gandalf.local.home>
In-Reply-To: <20190802094103.163576-1-jiping.ma2@windriver.com>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 17:41:03 +0800
Jiping Ma <jiping.ma2@windriver.com> wrote:

First of all, this patch will not be accepted. I will not allow arch
specific defines in generic code like this. That said, there are better
solutions.


> There is not PC in ARM64 stack, LR is used to for walk_stackframe in
> ARM64. Tere is no the issue in ARM32 because there is PC in ARM32 stack.
> PC is used to calculate the stack size in trace_stack.c, so the
> function name and its stack size appear to be off-by-one.
> ARM64 stack layout:
> 	LR
>         FP
>         ......
>         LR
>         FP
>         ......

I think you are not explaining the issue correctly. From looking at the
document, I think what you want to say is that the LR is saved *after*
the data for the function. Is that correct? If so, then yes, it would
cause the stack tracing algorithm to be incorrect.

Most archs do this:

On entry to a function:

	save return address
 	reserve local variables and such for current function

I think you are saying that arm64 does this backwards.

	reserve local variables and such for current function
	save return address (LR)


For normal archs, we usually have something like this:

sys_call_entry:
   [save regs and crap on stack ]
   bl sys_finit_module
 sys_call_entry+x:
   [ here's the address put into the lr regsister ]

sys_finit_module:
   save lr on stack [syscall_entry+x]
   save more stuff on stack
   [..]
   bl load_module
  sys_finit_module+y:

load_module:
  save lr on stack [sys_finit_module+y]
  save more stuff on stack
  [..]
  bl do_init_module
 load_module+z:

do_init_module:
  save lr on stack [load_module+z]
  [ let's say we do the stack trace here! ]

On the stack we have:

  data for kernel entry
  sys_call_entry+x [ lr saved in sys_finit_module ]
  data for sys_finit_module
  sys_finit_module+y [ lr saved in load_module ]
  data for load_module
  load_module+z [ lr saved in do_init_module

When we call stack_trace_save() we get:

  sys_call_entry+x
  sys_finit_module+y
  load_module+z

We then find those locations on the stack. Let's add some numbers here:

0:   top of stack
     data for kernel entry
504: sys_call_entry+x
     data for sys_finit_module
856: sys_finit_module+y
     data for sys_load_module
904: load_module+z
1048: BOTTOM OF STACK HERE

To do the work, we start from the bottom of the stack, looking for what
was returned from the stack_trace_save

start = 1048
 *p == load_module+z
  stack size = 1048 - 904

Then we say load_module stack size is 144.

What you are describing doesn't make any sense. Yes, we all add LR to
the stack, not the PC! But if the issue is that the LR is saved *after*
the function data, then that *will* make a difference. We then have:


sys_call_entry:
   [save regs and crap on stack ]
   bl sys_finit_module
 sys_call_entry+x:
   [ here's the address put into the lr regsister ]

sys_finit_module:
   save sys_finit_module stuff on stack
   save lr on stack [syscall_entry+x]  <-- reversed order from before!
   [..]
   bl load_module
  sys_finit_module+y:

load_module:
  save load_module stuff on stack
  save lr on stack [sys_finit_module+y]
  [..]
  bl do_init_module
 load_module+z:

do_init_module:
  [ let's say we do the stack trace here! ]

On the stack we have:

  data for sys_call_entry
  data for sys_finit_module
  sys_call_entry+x [ lr saved in sys_finit_module ]
  data for load_module
  sys_finit_module+y [ lr saved in load_module ]
  data for do_init_module
  load_module+z [ lr saved in do_init_module

This also brings up the question of when the mcount is called?

We get the same data from stack_trace_save():

  sys_call_entry+x
  sys_finit_module+y
  load_module+z

But this time, the stack is different!

0:   top of stack
     data from kernel entry
     data for sys_call_entry
     data for sys_finit_module
504: sys_call_entry+x
     data for sys_finit_module
856: sys_finit_module+y
     data for load_module
904: load_module+z
     data for do_init_module?
1048: BOTTOM OF STACK HERE

So yes, the same algorithm is will come up with the wrong result,
because...

start = 1048
 *p == load_module+z
  stack size = 1048 - 904

We just calculated the size of data for do_init_module, and not for
load_module!

Can someone confirm that this is the real issue?

-- Steve


> 
> Wrong info:
> Depth Size Location (16 entries)
> ----- ---- --------
> 0) 5400 16 __update_load_avg_se.isra.2+0x28/0x220
> 1) 5384 96 put_prev_entity+0x250/0x338
> 2) 5288 80 pick_next_task_fair+0x4c4/0x508
> 3) 5208 72 __schedule+0x100/0x600
> 4) 5136 184 preempt_schedule_common+0x28/0x48
> 5) 4952 32 preempt_schedule+0x28/0x30
> 6) 4920 16 vprintk_emit+0x170/0x1f8
> 7) 4904 128 vprintk_default+0x48/0x58
> 8) 4776 64 vprintk_func+0xf8/0x1c8
> 9) 4712 112 printk+0x70/0x90
> 10) 4600 176 occupy_stack_init+0x64/0xc0 [kernel_stack]
> 11) 4424 3376 do_one_initcall+0x68/0x248
> 12) 1048 144 do_init_module+0x60/0x1f0
> 13) 904 48 load_module+0x1d50/0x2340
> 14) 856 352 sys_finit_module+0xd0/0xe8
> 15) 504 504 el0_svc_naked+0x30/0x34
> 
> Correct info:
> Depth Size Location (18 entries)
> ----- ---- --------
> 0) 5464 48 cgroup_rstat_updated+0x20/0x100
> 1) 5416 32 cgroup_base_stat_cputime_account_end.isra.0+0x30/0x60
> 2) 5384 32 __cgroup_account_cputime+0x3c/0x48
> 3) 5352 64 update_curr+0xc4/0x1d0
> 4) 5288 72 pick_next_task_fair+0x444/0x508
> 5) 5216 184 __schedule+0x100/0x600
> 6) 5032 32 preempt_schedule_common+0x28/0x48
> 7) 5000 16 preempt_schedule+0x28/0x30
> 8) 4984 128 vprintk_emit+0x170/0x1f8
> 9) 4856 64 vprintk_default+0x48/0x58
> 10) 4792 112 vprintk_func+0xf8/0x1c8
> 11) 4680 176 printk+0x70/0x90
> 12) 4504 80 func_test+0x7c/0xb8 [kernel_stack]
> 13) 4424 3376 occupy_stack_init+0x7c/0xc0 [kernel_stack]
> 14) 1048 144 do_one_initcall+0x68/0x248
> 15) 904 48 do_init_module+0x60/0x1f0
> 16) 856 352 load_module+0x1d50/0x2340
> 17) 504 504 sys_finit_module+0xd0/0xe8
> 
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
