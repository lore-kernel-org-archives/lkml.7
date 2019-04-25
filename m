Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16617C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731D1206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfDYQjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:39:43 -0400
Received: from foss.arm.com ([217.140.101.70]:48174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfDYQjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:39:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1B2F15A2;
        Thu, 25 Apr 2019 09:39:41 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBBF53F557;
        Thu, 25 Apr 2019 09:39:39 -0700 (PDT)
Date:   Thu, 25 Apr 2019 17:39:37 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     julien.thierry@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190425163937.GI3567@e103592.cambridge.arm.com>
References: <20190423135719.11306-1-julien.grall@arm.com>
 <20190423135719.11306-4-julien.grall@arm.com>
 <20190424131734.GT3567@e103592.cambridge.arm.com>
 <ab9294b0-a360-df28-ca5c-ba4974f6c5a5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9294b0-a360-df28-ca5c-ba4974f6c5a5@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 04:57:26PM +0100, Julien Grall wrote:
> Hi Dave,
> 
> On 24/04/2019 14:17, Dave Martin wrote:
> >On Tue, Apr 23, 2019 at 02:57:19PM +0100, Julien Grall wrote:
> >>diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> >>index 5313aa257be6..6168d06bbd20 100644
> >>--- a/arch/arm64/kernel/fpsimd.c
> >>+++ b/arch/arm64/kernel/fpsimd.c
> >>@@ -92,7 +92,8 @@
> >>   * To prevent this from racing with the manipulation of the task's FPSIMD state
> >>   * from task context and thereby corrupting the state, it is necessary to
> >>   * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
> >>- * flag with local_bh_disable() unless softirqs are already masked.
> >>+ * flag with {, __}get_cpu_fpsimd_context(). This will still allow softirqs to
> >>+ * run but prevent them to use FPSIMD.
> >>   *
> >>   * For a certain task, the sequence may look something like this:
> >>   * - the task gets scheduled in; if both the task's fpsimd_cpu field
> >>@@ -155,6 +156,56 @@ extern void __percpu *efi_sve_state;
> >>  #endif /* ! CONFIG_ARM64_SVE */
> >>+DEFINE_PER_CPU(bool, fpsimd_context_busy);
> >>+EXPORT_PER_CPU_SYMBOL(fpsimd_context_busy);
> >>+
> >>+static void __get_cpu_fpsimd_context(void)
> >>+{
> >>+	bool busy = __this_cpu_xchg(fpsimd_context_busy, true);
> >>+
> >>+	WARN_ON(busy);
> >>+}
> >>+
> >>+/*
> >>+ * Claim ownership of the CPU FPSIMD context for use by the calling context.
> >>+ *
> >>+ * The caller may freely modify FPSIMD context until *put_cpu_fpsimd_context()
> >>+ * is called.
> >
> >Nit: it may be better to say "freely manipulate the FPSIMD context
> >metadata".
> >
> >get_cpu_fpsimd_context() isn't enough to allow the FPSIMD regs to be
> >safely trashed, because they may still contain live data (or an up to
> >date copy) for some task.
> 
> Good point, I will update the comment.
> 
> >
> >(For that you also need fpsimd_save_and_flush_cpu_state(), or just use
> >kernel_neon_begin() instead.)
> >
> >[...]
> >
> >>@@ -922,6 +971,8 @@ void fpsimd_thread_switch(struct task_struct *next)
> >>  	if (!system_supports_fpsimd())
> >>  		return;
> >>+	__get_cpu_fpsimd_context();
> >>+
> >>  	/* Save unsaved fpsimd state, if any: */
> >>  	fpsimd_save();
> >>@@ -936,6 +987,8 @@ void fpsimd_thread_switch(struct task_struct *next)
> >>  	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
> >>  			       wrong_task || wrong_cpu);
> >>+
> >>+	__put_cpu_fpsimd_context();
> >
> >There should be a note in the commit message explaining why these are
> >here.
> >
> >Are they actually needed, other than to keep
> >WARN_ON(have_cpu_fpsimd_context()) happy elsewhere?
> 
> It depends on how fpsimd_thread_switch() is called. I will answer more below.
> 
> >
> >Does PREEMPT_RT allow non-threaded softirqs to execute while we're in
> >this code?
> 
> This has nothing to do with PREEMPT_RT. Softirqs might be executed after
> handling interrupt (see irq_exit()).
> 
> A call to preempt_disable() will not be enough to prevent softirqs, you
> actually need to either mask interrupts or have BH disabled.
> 
> fpsimd_thread_switch() seems to be only called from the context switch code.
> AFAICT, interrupt will be masked. Therefore, holding the FPSIMD CPU is not
> necessary. However...
> 
> >
> >
> >OTOH, if the overall effect on performance remains positive, we can
> >probably argue that these operations make the code more self-describing
> >and help guard against mistakes during future maintanence, even if
> >they're not strictly needed today.
> 
> .... I think it would help guard against mistakes. The more I haven't seen
> any performance impact in the benchmark.

Which generally seems a good thing.  The commit message should explain
that these are being added for hygiene rather than necessity here,
though.

> [...]
> 
> >>-/*
> >>- * Save the FPSIMD state to memory and invalidate cpu view.
> >>- * This function must be called with softirqs (and preemption) disabled.
> >>- */
> >>+/* Save the FPSIMD state to memory and invalidate cpu view. */
> >>  void fpsimd_save_and_flush_cpu_state(void)
> >>  {
> >>+	get_cpu_fpsimd_context();
> >>  	fpsimd_save();
> >>  	fpsimd_flush_cpu_state();
> >>+	put_cpu_fpsimd_context();
> >>  }
> >
> >Again, are these added just to keep WARN_ON()s happy?
> 
> !preemptible() is not sufficient to prevent softirq running. You also need
> to have either interrupt masked or BH disabled.

So, why was the code safe before this series?  (In fact, _was_ it safe?)

AFAICT, we have local_irq_disable() around context switch, which covers
preempt notifiers (where kvm_arch_vcpu_put_fp() gets called) and
fpsimd_thread_switch(): this is what prevents softirqs from firing.

So, while it's clean to have get/put here, I still don't see why they're
required.

I think the arguments are basically similar to fpsimd_thread_switch().
Since fpsimd_save_and_flush_cpu_state() and fpsimd_thread_switch() are
called from similar contexts, is makes sense to keep them aligned.

> >Now I look at the diff, I think after all that
> >
> >	WARN_ON(preemptible());
> >	__get_cpu_fpsimd_context();
> >
> >	...
> >
> >	__put_cpu_fpsimd_context();
> >
> >is preferable.  The purpose of this function is to free up the FPSIMD
> >regs for use by the kernel, so it makes no sense to call it with
> >preemption enabled: the regs could spontaneously become live again due
> >to a context switch.  So we shouldn't encourage misuse by making the
> >function "safe" to call with preemption enabled.
> 
> Ok, I will switch back to the underscore version and add a WARN_ON(...).

Thanks.

[...]

Cheers
---Dave
