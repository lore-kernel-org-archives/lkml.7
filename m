Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FA8C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955C1206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfDQOBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:01:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45194 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbfDQOBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:01:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35ED6374;
        Wed, 17 Apr 2019 07:01:05 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4550C3F557;
        Wed, 17 Apr 2019 07:01:03 -0700 (PDT)
Date:   Wed, 17 Apr 2019 15:01:00 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     julien.thierry@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
Message-ID: <20190417140058.GZ3567@e103592.cambridge.arm.com>
References: <20190412171420.29065-1-julien.grall@arm.com>
 <20190412171420.29065-4-julien.grall@arm.com>
 <20190416123033.GM3567@e103592.cambridge.arm.com>
 <901b1c73-4f96-b493-cdc7-bc2f6bd2d7ca@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901b1c73-4f96-b493-cdc7-bc2f6bd2d7ca@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:37:57PM +0100, Julien Grall wrote:
> Hi Dave,
> 
> On 16/04/2019 13:30, Dave Martin wrote:
> >On Fri, Apr 12, 2019 at 06:14:20PM +0100, Julien Grall wrote:

[...]

> >>+
> >>+/*
> >>+ * Obtain the CPU FPSIMD context for use by the calling context.

If we say something like "Claim ownership of the CPU FPSIMD context for
use by the calling context", this may be easier to reference elsewhere
(see below).

> >>+ *
> >>+ * The caller may freely modify FPSIMD context until *put_cpu_fpsimd_context()
> >
> >Nit: Why *?  This makes it look a bit like get_cpu_fpsimd_context()
> >returns a pointer and you're saying something about dereferencing that
> >pointer here.
> 
> I tend to use * for wildcard. In this context it used to refers to both the
> double-underscored version and the one without.

Ah, right.  * makes sense in general, but here it confused me.

> I can use {,__}put_cpu_fpsimd_context() instead.

Maybe, but the caller is not supposed to pair get_cpu_fpsimd_context()
with __put_cpu_fpsimd_context().

What if we just comment the non-underscore versions.  The purpose of
the __ versions is then relatively obvious without additional commenting.

> 
> >
> >>+ * is called.
> >>+ *
> >>+ * The double-underscore version must only be called if you know the task
> >>+ * can't be preempted.
> >>+ *
> >>+ * __get_cpu_fpsimd_context() *must* be in pair with __put_cpu_fpsimd_context()
> >>+ * get_cpu_fpsimd_context() *must* be in pair with put_cpu_fpsimd_context()
> >
> >"in pair" -> "paired with"?
> 
> Sure.
> 
> >
> >I'd move each of these comments to be next to the function it applies
> >to.
> 
> Do you mean on top of {,__}put_cpu_ or {,__}get_cpu?

It doesn't matter.  It's the statement about get_cpu_fpsimd_context()
next to the definition of __get_cpu_fpsimd_context() that I find a bit
weird.

Arguably we could solve this by just having less commenting: the
expectation that a "get" should be paired with a subsequent matching
"put" is a common pattern (which was the reason for suggesting those
names).

> >>+ */
> >>+static void __get_cpu_fpsimd_context(void)
> >>+{
> >>+	bool busy = __this_cpu_xchg(kernel_neon_busy, true);
> >>+
> >
> >I don't mind whether there is a blank line here or not, but please make
> >it consistent with __put_cpu_fpsimd_context().
> 
> I will modify __put_cpu_fpsimd_context() to add a newline.
> 
> >
> >>+	WARN_ON(busy);
> >>+}
> >>+
> >>+static void get_cpu_fpsimd_context(void)
> >>+{
> >>+	preempt_disable();
> >>+	__get_cpu_fpsimd_context();
> >>+}
> >>+
> >>+/*
> >>+ * Release the CPU FPSIMD context.
> >>+ *
> >>+ * Must be called from a context in which *get_cpu_fpsimd_context() was
> >
> >Nit: Why *?
> 
> Same as above, I can update to use {,__} instead of *.
> 
> >
> >>+ * previously called, with no call to *put_cpu_fpsimd_context() in the
> >>+ * meantime.
> >>+ */
> >>+static void __put_cpu_fpsimd_context(void)
> >>+{
> >>+	bool busy = __this_cpu_xchg(kernel_neon_busy, false);
> >>+	WARN_ON(!busy); /* No matching get_cpu_fpsimd_context()? */
> >>+}
> >>+
> >>+static void put_cpu_fpsimd_context(void)
> >>+{
> >>+	__put_cpu_fpsimd_context();
> >>+	preempt_enable();
> >>+}
> >>+
> >>+static bool have_cpu_fpsimd_context(void)
> >>+{
> >>+	return (!preemptible() && __this_cpu_read(kernel_neon_busy));
> >
> >Nit: Redundant ()
> >
> >>+}
> >>+
> >>  /*
> >>   * Call __sve_free() directly only if you know task can't be scheduled
> >>   * or preempted.
> >>@@ -221,11 +274,12 @@ static void sve_free(struct task_struct *task)
> >>   * thread_struct is known to be up to date, when preparing to enter
> >>   * userspace.
> >>   *
> >>- * Softirqs (and preemption) must be disabled.
> >>+ * The FPSIMD context must be acquired with get_cpu_fpsimd_context()
> >
> >or __get_cpu_fpsimd_context()?  Since this is effectively documented by
> >the WARN_ON() and this is a local function anyway, maybe it would be
> >simpler just to drop this comment here?
> 
> I am fine with that.
> 
> >
> >>+ * before calling this function.
> >>   */
> >>  static void task_fpsimd_load(void)
> >>  {
> >>-	WARN_ON(!in_softirq() && !irqs_disabled());
> >>+	WARN_ON(!have_cpu_fpsimd_context());
> >>  	if (system_supports_sve() && test_thread_flag(TIF_SVE))
> >>  		sve_load_state(sve_pffr(&current->thread),
> >>@@ -239,15 +293,22 @@ static void task_fpsimd_load(void)
> >>   * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
> >>   * date with respect to the CPU registers.
> >>   *
> >>- * Softirqs (and preemption) must be disabled.
> >>+ * The FPSIMD context must be acquired with get_cpu_fpsimd_context()
> >
> >Likewise.
> 
> Ditto.
> 
> >
> >>+ * before calling this function.
> >>   */
> >>  static void fpsimd_save(void)
> >>  {
> >>  	struct fpsimd_last_state_struct const *last =
> >>  		this_cpu_ptr(&fpsimd_last_state);
> >>  	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
> >>+	WARN_ON(!have_cpu_fpsimd_context());
> >>-	WARN_ON(!in_softirq() && !irqs_disabled());
> >>+	if ( !have_cpu_fpsimd_context() )
> >
> >Nit: Redundant whitespace around expression.
> 
> This hunk should actually be dropped. I was using for debugging and forgot
> to remove it before sending the series :/.

Ah, right.  I didn't spot it -- yes, please remove.

> >
> >>+	{
> >>+		printk("preemptible() = %u kernel_neon_busy = %u\n",
> >>+		       preemptible(), __this_cpu_read(kernel_neon_busy));
> >>+		while (1);
> >>+	}
> >>  	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
> >>  		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
> >>@@ -352,7 +413,8 @@ static int __init sve_sysctl_init(void) { return 0; }
> >>   * task->thread.sve_state.
> >>   *
> >>   * Task can be a non-runnable task, or current.  In the latter case,
> >>- * softirqs (and preemption) must be disabled.
> >>+ * the FPSIMD context must be acquired with get_fpu_fpsimd_context()
> >>+ * before calling this function.
> 
> I noticed you didn't comment about the usage of get_cpu_fpsimd_context here.
> Do you want to add a WARN(..) in the function, or just using {,___} here?

Partly because of things getting repetitive.

WARN() is not free, so I suggest we don't add any new ones for now.

From a comment point of view, if we just say something "the caller must
have ownership of the cpu FPSIMD context" to refer back to the
commenting for get_cpu_fpsimd_context(), that should cover the general
case.
> 
> >>   * task->thread.sve_state must point to at least sve_state_size(task)
> >>   * bytes of allocated kernel memory.
> >>   * task->thread.uw.fpsimd_state must be up to date before calling this
> >>@@ -379,7 +441,8 @@ static void fpsimd_to_sve(struct task_struct *task)
> >>   * task->thread.uw.fpsimd_state.
> >>   *
> >>   * Task can be a non-runnable task, or current.  In the latter case,
> >>- * softirqs (and preemption) must be disabled.
> >>+ * the FPSIMD context must be acquired with get_fpu_fpsimd_context()
> >>+ * before calling this function.
> 
> Same question here.
> 
> [...]
> 
> >>@@ -1012,7 +1079,8 @@ void fpsimd_signal_preserve_current_state(void)
> >>  /*
> >>   * Associate current's FPSIMD context with this cpu
> >>- * Preemption must be disabled when calling this function.
> >>+ * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
> >>+ * before calling this function.
> 
> Same question here.

Same for these.

> >>  /*
> >>   * Invalidate any task's FPSIMD state that is present on this cpu.
> >>- * This function must be called with softirqs disabled.
> >>+ * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
> >>+ * before calling this function.
> >>   */
> >>  static void fpsimd_flush_cpu_state(void)
> >>  {
> >>@@ -1125,19 +1194,18 @@ static void fpsimd_flush_cpu_state(void)
> >>  /*
> >>   * Save the FPSIMD state to memory and invalidate cpu view.
> >>- * This function must be called with softirqs (and preemption) disabled.
> >>+ * This function must be called with preemption disabled.
> >>   */
> >>  void fpsimd_save_and_flush_cpu_state(void)
> >>  {
> >>+	__get_cpu_fpsimd_context();
> >>  	fpsimd_save();
> >>  	fpsimd_flush_cpu_state();
> >>+	__put_cpu_fpsimd_context();
> >
> >It may be cleaner to avoid the assumption about preemption already being
> >disabled here.  fpsimd_thread_switch() is rather a special case, but for
> >this one is this really used on a hot path that justifies the assumption?
> 
> It is currently only called with preemption disabled. So I thought it would
> be better to avoid disabling preemption again. But I am happy to use the
> non-__ version if you think it is better.

Hmmm, this works either way.  Since this is not fast-path and has an
external caller, it might be worth adding a WARN_ON(preemptible()) here
if you want to stick with the __ functions.

Otherwise, I don't have a strong opinion.

Cheers
---Dave
