Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF6ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F78E20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394191AbfJQQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:09:28 -0400
Received: from [217.140.110.172] ([217.140.110.172]:40546 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2390563AbfJQQJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:09:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DC93329;
        Thu, 17 Oct 2019 09:09:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9527A3F6C4;
        Thu, 17 Oct 2019 09:09:05 -0700 (PDT)
Date:   Thu, 17 Oct 2019 17:09:03 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] arm64: nofpsmid: Clear TIF_FOREIGN_FPSTATE flag for
 early tasks
Message-ID: <20191017160901.GB27757@arm.com>
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
 <20191010171517.28782-3-suzuki.poulose@arm.com>
 <20191011112642.GF27757@arm.com>
 <1688a2b2-080c-40cc-ab41-df234aa447c0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688a2b2-080c-40cc-ab41-df234aa447c0@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 01:42:37PM +0100, Suzuki K Poulose wrote:
> Hi Dave
> 
> Thanks for the comments.
> 
> On 11/10/2019 12:26, Dave Martin wrote:
> >On Thu, Oct 10, 2019 at 06:15:16PM +0100, Suzuki K Poulose wrote:
> >>We detect the absence of FP/SIMD after we boot the SMP CPUs, and by then
> >>we have kernel threads running already with TIF_FOREIGN_FPSTATE set which
> >>could be inherited by early userspace applications (e.g, modprobe triggered
> >>from initramfs). This could end up in the applications stuck in
> >>do_nofity_resume() as we never clear the TIF flag, once we now know that
> >>we don't support FP.
> >>
> >>Fix this by making sure that we clear the TIF_FOREIGN_FPSTATE flag
> >>for tasks which may have them set, as we would have done in the normal
> >>case, but avoiding touching the hardware state (since we don't support any).
> >>
> >>Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
> >>Cc: Will Deacon <will@kernel.org>
> >>Cc: Mark Rutland <mark.rutland@arm.com>
> >>Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>---
> >>  arch/arm64/kernel/fpsimd.c | 26 ++++++++++++++++----------
> >>  1 file changed, 16 insertions(+), 10 deletions(-)
> >>
> >>diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> >>index 37d3912cfe06..dfcdd077aeca 100644
> >>--- a/arch/arm64/kernel/fpsimd.c
> >>+++ b/arch/arm64/kernel/fpsimd.c
> >>@@ -1128,12 +1128,19 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
> >>   */
> >>  void fpsimd_restore_current_state(void)
> >>  {
> >>-	if (!system_supports_fpsimd())
> >>-		return;
> >>-
> >>  	get_cpu_fpsimd_context();
> >>-
> >>-	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >>+	/*
> >>+	 * For the tasks that were created before we detected the absence of
> >>+	 * FP/SIMD, the TIF_FOREIGN_FPSTATE could be set via fpsimd_thread_switch()
> >>+	 * and/or could be inherited from the parent(init_task has this set). Even
> >>+	 * though userspace has not run yet, this could be inherited by the
> >>+	 * processes forked from one of those tasks (e.g, modprobe from initramfs).
> >>+	 * If the system doesn't support FP/SIMD, we must clear the flag for the
> >>+	 * tasks mentioned above, to indicate that the FPSTATE is clean (as we
> >>+	 * can't have one) to avoid looping for ever to clear the flag.
> >>+	 */
> >>+	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE) &&
> >>+	    system_supports_fpsimd()) {
> >
> >I'm not too keen on this approach: elsewhere we just stub out all the
> >FPSIMD handling logic if !system_supports_fpsimd() -- I think we should
> >be using this test everywhere rather than relying on TIF_FOREIGN_FPSTATE.
> 
> We used to do this. But the flag is not cleared anymore once we detect
> the absence of FP/SIMD.
> 
> >Rather, I feel that TIF_FOREIGN_FPSTATE means "if this is a user task
> >and this task is current() and the system supports FPSIMD at all, this
> >task's FPSIMD state is not loaded in the cpu".
> 
> Yes, that is  correct. However, we ran some tasks, even before we detected
> that the FPSIMD is missing. So, we need to clear the flag for those tasks
> to make sure the flag state is consistent, as explained in the comment.

I think there's a misunderstanding here somewhere.

What I'm saying it that we shouldn't even look at TIF_FOREIGN_FPSTATE if
!system_supports_fpsimd() -- i.e., when checking whether there is
any FPSIMD context handling work to do, !system_supports_fpsimd()
should take precedence.

Firstly, this replaces the runtime TIF_FOREIGN_FPSTATE check with a
static key check in the !system_supprts_fpsimd() case, and second, the
"work to do" condition is never wrong, even temporarily.

The "work to do" condition is now

	system_supports_fpsimd() && test_thread_flag(TIF_FOREIGN_FPSTATE)

instead of

	test_thread_flag(TIF_FOREIGN_FPSTATE).

Code that _only writes_ the TIF_FORGIEN_FPSTATE flag can continue to do
so harmlessly if we do things this way.

In do_notify_resume() this doesn't quite work, but it's acceptable to
fall spuriously into fpsimd_restore_current_state() provided that we
check for !system_supports_fpsimd() in there.  Which we already do.
In this one case, we should clear TIF_FOREIGN_FPSTATE so this backwards
checking doesn't send do_notify_resume() into a spin waiting for the
flag to go clear.

Another option is to clear TIF_FOREIGN_FPSTATE from _TIF_WORK_MASK
when checking for pending work in do_notify_resume(), so that we
effectively ignore TIF_FOREIGN_FPSTATE here too.  This would be a static
key based check again, so should be fast.

I think this is a cleaner approach than trying to clean up
TIF_FOREIGN_FPSTATE for each task lazily in some random places --
otherwise we may need to do the cleanup anywhere that the flag is
accessed, and that happens all over the place.

Does that make sense?  More below.


> Another option is to clear this flag in fpsimd_thread_switch(), something like,
> rather than sprinkling the "flag fixup" everywhere:
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index dfcdd077aeca..2d8091b6ebfb 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -982,9 +982,14 @@ void fpsimd_thread_switch(struct task_struct *next)
>  {
>         bool wrong_task, wrong_cpu;
> 
> -       if (!system_supports_fpsimd())
> +       if (!system_supports_fpsimd()) {
> +               /*
> +                * Clear any TIF flags which may have been set, before we
> +                * detected the absense of FPSIMD.
> +                */
> +               clear_task_thread_flag(next, TIF_FOREIGN_FPSTATE);
>                 return;
> -
> +       }
>         __get_cpu_fpsimd_context();
> 
> 
> And also at :
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index a47462def04b..cd8e94d5dc8d 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -374,7 +374,10 @@ int copy_thread(unsigned long clone_flags, unsigned
> long stack_start,
>          * Otherwise we could erroneously skip reloading the FPSIMD
>          * registers for p.
>          */
> -       fpsimd_flush_task_state(p);
> +       if (system_supports_fpsimd())
> +               fpsimd_flush_task_state(p);
> +       else
> +               clear_tsk_thread_flag(p, TIF_FOREIGN_FPSTATE);
> 
>         if (likely(!(p->flags & PF_KTHREAD))) {
>                 *childregs = *current_pt_regs();
> 
> 
> That way we make sure the flag doesn't violate our assumption and we can
> bail out calling into the stubs with the existing checks.

But we may still go wrong where this flag is checked in signal handling /
ptrace / KVM, no?

> >I think we should ensure that any check on TIF_FOREIGN_FPSTATE is
> >shadowed by a check on system_supports_fpsimd() somewhere.  This already
> >exists in many places -- we just need to fill in the missing ones.
> >
> >fpsimd_save() is a backend function that should only be called if
> >system_supports_fpsimd(), so that should not need any check internally,
> >but we should make sure that calls to this function are appropriately
> >protected with in if (system_supports_fpsimd()).
> 
> Agree.
> 
> >
> >For other maintenance functions intended for outside callers:
> >
> >  * fpsimd_bind_task_to_cpu()
> This was/is called from fpsimd_{update,restore}_current_state()
> which are protected with system_supports_fpsimd() check already.
> 
> >  * fpsimd_bind_state_to_cpu()
> 
> This is only used by the KVM code and will only be used after we
> have finalized the capabilities and thus we are covered by the
> system_supports_fpsimd() check in __hyp_handle_fpsimd() which
> sets the FP_ENABLED flag.
> 
> >  * fpsimd_flush_task_state()
> 
> This seemed rather innocent, but looking at the callers, I realise
> that we need the check in fpr_{get/set} for NT_REGS and return errors
> if we are asked to deal with FP regs.
> 
> >  * fpsimd_save_and_flush_cpu_state()
> 
> This must not be called and is only triggered from KVM (covered) and
> the PM notifier (which is not registered if fp/simd is missing).
> 
> >
> >the situation is less clear.  Does is make sense to call these at all
> >if !system_supports_fpsimd()?  I'm not currently sure.  We could at
> >least drop some WARN_ON() into these to check, after revieweing their
> >callsites.
> 
> Sure, I agree.

My point is that we shouldn't knowingly introduce fragility, because this
code is hard enough to understand already -- I've spent literally months
of my life fighting it ;)

Hacking TIF_FOREIGN_FPSTATE at a few random sites feels inherently
more fragile than simply ignoring the flag when
!system_supports_fpsimd().

If there's a simple approach that can never go wrong, we should go for
that unless it introduces unacceptable overheads.

[...]

Cheers
---Dave
