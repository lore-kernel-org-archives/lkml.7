Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6985CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD3E2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKVSo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:44:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:58745 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfKVSo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:44:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 10:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="259793861"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2019 10:44:57 -0800
Date:   Fri, 22 Nov 2019 10:44:57 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122184457.GA31235@linux.intel.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122152715.GA1909@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 04:27:15PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 22, 2019 at 11:51:41AM +0100, Peter Zijlstra wrote:
> 
> > A non-lethal default enabled variant would be even better for them :-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index d779366ce3f8..d23638a0525e 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -92,6 +92,7 @@ struct thread_info {
>  #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
>  #define TIF_NOTSC		16	/* TSC is not accessible in userland */
>  #define TIF_IA32		17	/* IA32 compatibility process */
> +#define TIF_SLD			18	/* split_lock_detect */

Maybe use SLAC (Split-Lock AC) as the acronym?  I can't help but read
SLD as "split-lock disabled".  And name this TIF_NOSLAC (or TIF_NOSLD if
you don't like SLAC) since it's set when the task is running without #AC?

>  #define TIF_NOHZ		19	/* in adaptive nohz mode */
>  #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
>  #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
> @@ -122,6 +123,7 @@ struct thread_info {
>  #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
>  #define _TIF_NOTSC		(1 << TIF_NOTSC)
>  #define _TIF_IA32		(1 << TIF_IA32)
> +#define _TIF_SLD		(1 << TIF_SLD)
>  #define _TIF_NOHZ		(1 << TIF_NOHZ)
>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>  #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)

...

> +void handle_split_lock(void)
> +{
> +	return sld_state != sld_off;
> +}
> +
> +void handle_user_split_lock(struct pt_regs *regs, long error_code)
> +{
> +	if (sld_state == sld_fatal)
> +		return false;
> +
> +	pr_alert("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
> +		 current->comm, current->pid, regs->ip);
> +
> +	__sld_set_msr(false);
> +	set_tsk_thread_flag(current, TIF_CLD);
> +	return true;
> +}
> +
> +void switch_sld(struct task_struct *prev)
> +{
> +	__sld_set_msr(true);
> +	clear_tsk_thread_flag(current, TIF_CLD);
> +}

...

> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index bd2a11ca5dd6..c04476a1f970 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -654,6 +654,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  		/* Enforce MSR update to ensure consistent state */
>  		__speculation_ctrl_update(~tifn, tifn);
>  	}
> +
> +	if (tifp & _TIF_SLD)
> +		switch_sld(prev_p);
>  }

Re-enabling #AC when scheduling out the misbehaving task would also work
well for KVM, e.g. call a variant of handle_user_split_lock() on an
unhandled #AC in the guest.  We can also reuse KVM's existing code to
restore the MSR on return to userspace so that an #AC in the guest doesn't
disable detection in the userspace VMM.

Alternatively, KVM could manually do it's own thing and context switch
the MSR on VM-Enter/VM-Exit (after an unhandled #AC), but I'd rather keep
this out of the VM-Enter path and also avoid thrashing the MSR on an SMT
CPU.  The only downside is that KVM itself would occasionally run with #AC
disabled, but that doesn't seem like a big deal since split locks should
not be magically appearing in KVM.

Last thought, KVM should only expose split lock #AC to the guest if SMT=n
or the host is in "force" mode so that split lock #AC is always enabled
in hardware (for the guest) when then guest wants it enabled.  KVM would
obviously not actually disable #AC in hardware when running in force mode,
regardless of the guest's wishes.

>  /*
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 3451a004e162..3cba28c9c4d9 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -242,7 +242,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
>  {
>  	struct task_struct *tsk = current;
>  
> -
>  	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
>  		return;
>  
> @@ -288,9 +287,34 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
>  DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
>  DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
>  DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
> -DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
>  #undef IP
>  
> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> +{
> +	unsigned int trapnr = X86_TRAP_AC;
> +	char str[] = "alignment check";
> +	int signr = SIGBUS;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_STOP)
> +		return;
> +
> +	if (!handle_split_lock())

Pretty sure this should be omitted entirely.  For an #AC in the kernel,
simply restarting the instruction will fault indefinitely, e.g. dieing is
probably the best course of action if a (completely unexpteced) #AC occurs
in "off" mode.  Dropping this check also lets handle_user_split_lock() do
the right thing for #AC due to EFLAGS.AC=1 (pointed out by Tony).

> +		return;
> +
> +	if (!user_mode(regs))
> +		die("Split lock detected\n", regs, error_code);
> +
> +	cond_local_irq_enable(regs);
> +
> +	if (handle_user_split_lock(regs, error_code))
> +		return;
> +
> +	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
> +		error_code, BUS_ADRALN, NULL);
> +}
> +
>  #ifdef CONFIG_VMAP_STACK
>  __visible void __noreturn handle_stack_overflow(const char *message,
>  						struct pt_regs *regs,
