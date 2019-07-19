Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7B1C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A1920693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfGSU2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:28:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:6702 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbfGSU2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:28:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2019 13:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,283,1559545200"; 
   d="scan'208";a="170998185"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.165])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2019 13:28:36 -0700
Date:   Fri, 19 Jul 2019 13:28:36 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eiichi Tsukata <devel@etsukata.com>, edwintorok@gmail.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] x86/stacktrace: Do not access user space memory
 unnecessarily
Message-ID: <20190719202836.GB13680@linux.intel.com>
References: <20190702053151.26922-1-devel@etsukata.com>
 <20190702072821.GX3419@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907021400350.1802@nanos.tec.linutronix.de>
 <20190702113355.5be9ebfe@gandalf.local.home>
 <20190702133905.1482b87e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702133905.1482b87e@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 01:39:05PM -0400, Steven Rostedt wrote:
> On Tue, 2 Jul 2019 11:33:55 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 2 Jul 2019 16:14:05 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > On Tue, 2 Jul 2019, Peter Zijlstra wrote:
> > >   
> > > > On Tue, Jul 02, 2019 at 02:31:51PM +0900, Eiichi Tsukata wrote:    
> > > > > Put the boundary check before it accesses user space to prevent unnecessary
> > > > > access which might crash the machine.
> > > > > 
> > > > > Especially, ftrace preemptirq/irq_disable event with user stack trace
> > > > > option can trigger SEGV in pid 1 which leads to panic.    
> > 
> > Note, I'm only able to trigger this crash with the irq_disable event.
> > The irq_enable and preempt_disable/enable events work just fine. This
> > leads me to believe that the TRACE_IRQS_OFF macro (which uses a thunk
> > trampoline) may have some issues and is probably the place to look at.
> 
> I figured it out.
> 
> It's another "corruption of the cr2" register issue. The following
> patch makes the issue go away. I'm not suggesting that we use this
> patch, but it shows where the bug lies.
> 
> IIRC, there was patches posted before that fixed this issue. I'll go
> look to see if I can dig them up. Was it Joel that sent them?
> 
> -- Steve
> 
> diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
> index be36bf4e0957..dd79256badb2 100644
> --- a/arch/x86/entry/thunk_64.S
> +++ b/arch/x86/entry/thunk_64.S
> @@ -40,7 +40,7 @@
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
> -	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
> +	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller_cr2,1
>  #endif
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 46df4c6aae46..b42ca3fc569d 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1555,3 +1555,13 @@ do_page_fault(struct pt_regs *regs, unsigned long error_code)
>  	exception_exit(prev_state);
>  }
>  NOKPROBE_SYMBOL(do_page_fault);
> +
> +void trace_hardirqs_off_caller(unsigned long addr);
> +
> +void notrace trace_hardirqs_off_caller_cr2(unsigned long addr)
> +{
> +	unsigned long address = read_cr2(); /* Get the faulting address */
> +
> +	trace_hardirqs_off_caller(addr);
> +	write_cr2(address);
> +}

I'm hitting a similar panic that bisects to commit

  a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption")

except I'm experiencing death immediately after starting init.

Through sheer dumb luck, I tracked (pun intended) this down to forcing
context tracking:

  CONFIG_CONTEXT_TRACKING=y
  CONFIG_CONTEXT_TRACKING_FORCE=y
  CONFIG_VIRT_CPU_ACCOUNTING_GEN=y

I haven't attempted to debug further and I'll be offline for most of the
next few days.  Hopefully this is enough to root cause the badness.

[    0.680477] Run /sbin/init as init process
[    0.682116] init[1]: segfault at 2926a7ef ip 00007f98a49d9c30 sp 00007fffd83e6af0 error 14 in ld-2.23.so[7f98a49d9000+26000]
[    0.683427] Code: Bad RIP value.
[    0.683844] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.684710] CPU: 0 PID: 1 Comm: init Not tainted 5.2.0+ #18
[    0.685352] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    0.686239] Call Trace:
[    0.686542]  dump_stack+0x46/0x5b
[    0.686915]  panic+0xf8/0x2d2
[    0.687252]  do_exit+0xb68/0xb70
[    0.687616]  do_group_exit+0x3a/0xa0
[    0.688088]  get_signal+0x184/0x880
[    0.688483]  do_signal+0x30/0x690
[    0.688857]  ? signal_wake_up_state+0x15/0x30
[    0.689433]  ? __send_signal+0x139/0x380
[    0.689908]  exit_to_usermode_loop+0x6a/0xc0
[    0.690397]  ? async_page_fault+0x8/0x40
[    0.690850]  prepare_exit_to_usermode+0x78/0xb0
[    0.691355]  retint_user+0x8/0x8
[    0.691722] RIP: 0033:0x7f98a49d9c30
[    0.692122] Code: Bad RIP value.
[    0.692484] RSP: 002b:00007fffd83e6af0 EFLAGS: 00010202
[    0.693060] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    0.693907] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.694739] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    0.695538] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    0.696322] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.697195] Kernel Offset: disabled
[    0.697600] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
