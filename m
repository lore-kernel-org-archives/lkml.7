Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F6BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F08206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfDZKtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:49:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38504 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfDZKtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:49:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7091780D;
        Fri, 26 Apr 2019 03:49:02 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BDB53F5AF;
        Fri, 26 Apr 2019 03:49:00 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:48:57 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Subject: Re: [PATCH v3 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190426104856.GJ3567@e103592.cambridge.arm.com>
References: <20190423135719.11306-1-julien.grall@arm.com>
 <20190423135719.11306-4-julien.grall@arm.com>
 <20190424131734.GT3567@e103592.cambridge.arm.com>
 <ab9294b0-a360-df28-ca5c-ba4974f6c5a5@arm.com>
 <20190425163937.GI3567@e103592.cambridge.arm.com>
 <971994b0-052e-6a93-3949-0b05d2b558e5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971994b0-052e-6a93-3949-0b05d2b558e5@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 06:12:59PM +0100, Julien Grall wrote:
> Hi Dave,
> 
> On 25/04/2019 17:39, Dave Martin wrote:
> >On Thu, Apr 25, 2019 at 04:57:26PM +0100, Julien Grall wrote:
> >>Hi Dave,
> >>
> >>On 24/04/2019 14:17, Dave Martin wrote:
> >>>On Tue, Apr 23, 2019 at 02:57:19PM +0100, Julien Grall wrote:

[...]

> >>>(For that you also need fpsimd_save_and_flush_cpu_state(), or just use
> >>>kernel_neon_begin() instead.)
> >>>
> >>>[...]
> >>>
> >>>>@@ -922,6 +971,8 @@ void fpsimd_thread_switch(struct task_struct *next)
> >>>>  	if (!system_supports_fpsimd())
> >>>>  		return;
> >>>>+	__get_cpu_fpsimd_context();
> >>>>+
> >>>>  	/* Save unsaved fpsimd state, if any: */
> >>>>  	fpsimd_save();
> >>>>@@ -936,6 +987,8 @@ void fpsimd_thread_switch(struct task_struct *next)
> >>>>  	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
> >>>>  			       wrong_task || wrong_cpu);
> >>>>+
> >>>>+	__put_cpu_fpsimd_context();
> >>>
> >>>There should be a note in the commit message explaining why these are
> >>>here.
> >>>
> >>>Are they actually needed, other than to keep
> >>>WARN_ON(have_cpu_fpsimd_context()) happy elsewhere?
> >>
> >>It depends on how fpsimd_thread_switch() is called. I will answer more below.
> >>
> >>>
> >>>Does PREEMPT_RT allow non-threaded softirqs to execute while we're in
> >>>this code?
> >>
> >>This has nothing to do with PREEMPT_RT. Softirqs might be executed after
> >>handling interrupt (see irq_exit()).
> >>
> >>A call to preempt_disable() will not be enough to prevent softirqs, you
> >>actually need to either mask interrupts or have BH disabled.
> >>
> >>fpsimd_thread_switch() seems to be only called from the context switch code.
> >>AFAICT, interrupt will be masked. Therefore, holding the FPSIMD CPU is not
> >>necessary. However...
> >>
> >>>
> >>>
> >>>OTOH, if the overall effect on performance remains positive, we can
> >>>probably argue that these operations make the code more self-describing
> >>>and help guard against mistakes during future maintanence, even if
> >>>they're not strictly needed today.
> >>
> >>.... I think it would help guard against mistakes. The more I haven't seen
> >>any performance impact in the benchmark.
> >
> >Which generally seems a good thing.  The commit message should explain
> >that these are being added for hygiene rather than necessity here,
> >though.
> 
> I will update the commit message.

Thanks

[...]

> >>>>-/*
> >>>>- * Save the FPSIMD state to memory and invalidate cpu view.
> >>>>- * This function must be called with softirqs (and preemption) disabled.
> >>>>- */
> >>>>+/* Save the FPSIMD state to memory and invalidate cpu view. */
> >>>>  void fpsimd_save_and_flush_cpu_state(void)
> >>>>  {
> >>>>+	get_cpu_fpsimd_context();
> >>>>  	fpsimd_save();
> >>>>  	fpsimd_flush_cpu_state();
> >>>>+	put_cpu_fpsimd_context();
> >>>>  }
> >>>
> >>>Again, are these added just to keep WARN_ON()s happy?
> >>
> >>!preemptible() is not sufficient to prevent softirq running. You also need
> >>to have either interrupt masked or BH disabled.
> >
> >So, why was the code safe before this series?  (In fact, _was_ it safe?)
> >
> >AFAICT, we have local_irq_disable() around context switch, which covers
> >preempt notifiers (where kvm_arch_vcpu_put_fp() gets called) and
> >fpsimd_thread_switch(): this is what prevents softirqs from firing.
> 
> That's correct, both callers of the function will have IRQs masked. Also,
> the function fpsimd_save() contained:
>     WARN_ON(!in_softirq() && !irqs_disabled());
> 
> So we were covered in case of misuse.

OK -- my main worry here was that there might be a bug in mainline.

Adding protection where none existed previously raises the question of
whether we're papering over an existing bug, so it's good to mention in
the commit message if this is not the case.

> >So, while it's clean to have get/put here, I still don't see why they're
> >required.
> >
> >I think the arguments are basically similar to fpsimd_thread_switch().
> >Since fpsimd_save_and_flush_cpu_state() and fpsimd_thread_switch() are
> >called from similar contexts, is makes sense to keep them aligned.
> 
> Yes, this is for hygiene rather than a real bug (thought the WARN_ON() in
> fpsimd_save() would fire). I will update the message accordingly.

OK, thanks
---Dave
