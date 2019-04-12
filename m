Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699DBC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3962077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDLROk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:14:40 -0400
Received: from foss.arm.com ([217.140.101.70]:37092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfDLROi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:14:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9B5815AD;
        Fri, 12 Apr 2019 10:14:37 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 802533F718;
        Fri, 12 Apr 2019 10:14:35 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        ard.biesheuvel@linaro.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v2 3/3] arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state
Date:   Fri, 12 Apr 2019 18:14:20 +0100
Message-Id: <20190412171420.29065-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190412171420.29065-1-julien.grall@arm.com>
References: <20190412171420.29065-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
the kernel may be able to use FPSIMD/SVE. This is for instance the case
for crypto code.

Any use of FPSIMD/SVE in the kernel are clearly marked by using the
function kernel_neon_{begin, end}. Furthermore, this can only be used
when may_use_simd() returns true.

The current implementation of may_use_simd() allows softirq to use
FPSIMD/SVE unless it is currently in used (i.e kernel_neon_busy is true).
When in used, softirqs usually fallback to a software method.

At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
when touching the FPSIMD/SVE context. This has the drawback to disable
all softirqs even if they are not using FPSIMD/SVE.

As a softirq should not rely on been able to use simd at a given time,
there are limited reason to keep softirq disabled when touching the
FPSIMD/SVE context. Instead, we can only disable preemption and tell
the NEON unit is currently in use.

This patch introduces two new helpers {get, put}_cpu_fpsimd_context to
mark the area using FPSIMD/SVE context and use them in replacement of
local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
also re-implemented to use the new helpers.

Additionally, this patch introduced a double-underscored version of each
helper that can be used when preemption is disabled. This avoid to
disable/enable preemption for again and helps documenting places where
context can only be used by one instance.

This patch has been benchmarked on Linux 5.1-rc4 with defconfig.

On Juno2:
    * hackbench 100 process 1000 (10 times)
    * .7% quicker

On ThunderX 2:
    * hackbench 1000 process 1000 (20 times)
    * 3.4% quicker

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Remove spurious call to kernel_neon_enable in kernel_neon_begin.
        - Rename kernel_neon_{enable, disable} to {get, put}_cpu_fpsimd_context
        - Introduce a double-underscore version of the helpers for case
        where preemption is already disabled
        - Introduce have_cpu_fpsimd_context() and use it in WARN_ON(...)
        - Surround more places in the code with the new helpers
        - Rework the comments
        - Update the commit message with the benchmark result
---
 arch/arm64/include/asm/simd.h |   4 +-
 arch/arm64/kernel/fpsimd.c    | 133 ++++++++++++++++++++++++++++++------------
 2 files changed, 97 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 6495cc51246f..94c0dac508aa 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -15,10 +15,10 @@
 #include <linux/preempt.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_KERNEL_MODE_NEON
-
 DECLARE_PER_CPU(bool, kernel_neon_busy);
 
+#ifdef CONFIG_KERNEL_MODE_NEON
+
 /*
  * may_use_simd - whether it is allowable at this time to issue SIMD
  *                instructions or access the SIMD register file
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9e4e4b6acd93..761d848fb26d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -92,7 +92,8 @@
  * To prevent this from racing with the manipulation of the task's FPSIMD state
  * from task context and thereby corrupting the state, it is necessary to
  * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
- * flag with local_bh_disable() unless softirqs are already masked.
+ * flag with kernel_neon_{disable, enable}. This will still allow softirqs to
+ * run but prevent them to use FPSIMD.
  *
  * For a certain task, the sequence may look something like this:
  * - the task gets scheduled in; if both the task's fpsimd_cpu field
@@ -150,6 +151,58 @@ extern void __percpu *efi_sve_state;
 
 #endif /* ! CONFIG_ARM64_SVE */
 
+DEFINE_PER_CPU(bool, kernel_neon_busy);
+EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
+
+/*
+ * Obtain the CPU FPSIMD context for use by the calling context.
+ *
+ * The caller may freely modify FPSIMD context until *put_cpu_fpsimd_context()
+ * is called.
+ *
+ * The double-underscore version must only be called if you know the task
+ * can't be preempted.
+ *
+ * __get_cpu_fpsimd_context() *must* be in pair with __put_cpu_fpsimd_context()
+ * get_cpu_fpsimd_context() *must* be in pair with put_cpu_fpsimd_context()
+ */
+static void __get_cpu_fpsimd_context(void)
+{
+	bool busy = __this_cpu_xchg(kernel_neon_busy, true);
+
+	WARN_ON(busy);
+}
+
+static void get_cpu_fpsimd_context(void)
+{
+	preempt_disable();
+	__get_cpu_fpsimd_context();
+}
+
+/*
+ * Release the CPU FPSIMD context.
+ *
+ * Must be called from a context in which *get_cpu_fpsimd_context() was
+ * previously called, with no call to *put_cpu_fpsimd_context() in the
+ * meantime.
+ */
+static void __put_cpu_fpsimd_context(void)
+{
+	bool busy = __this_cpu_xchg(kernel_neon_busy, false);
+	WARN_ON(!busy); /* No matching get_cpu_fpsimd_context()? */
+}
+
+static void put_cpu_fpsimd_context(void)
+{
+	__put_cpu_fpsimd_context();
+	preempt_enable();
+}
+
+static bool have_cpu_fpsimd_context(void)
+{
+	return (!preemptible() && __this_cpu_read(kernel_neon_busy));
+}
+
 /*
  * Call __sve_free() directly only if you know task can't be scheduled
  * or preempted.
@@ -221,11 +274,12 @@ static void sve_free(struct task_struct *task)
  * thread_struct is known to be up to date, when preparing to enter
  * userspace.
  *
- * Softirqs (and preemption) must be disabled.
+ * The FPSIMD context must be acquired with get_cpu_fpsimd_context()
+ * before calling this function.
  */
 static void task_fpsimd_load(void)
 {
-	WARN_ON(!in_softirq() && !irqs_disabled());
+	WARN_ON(!have_cpu_fpsimd_context());
 
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
 		sve_load_state(sve_pffr(&current->thread),
@@ -239,15 +293,22 @@ static void task_fpsimd_load(void)
  * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
  * date with respect to the CPU registers.
  *
- * Softirqs (and preemption) must be disabled.
+ * The FPSIMD context must be acquired with get_cpu_fpsimd_context()
+ * before calling this function.
  */
 static void fpsimd_save(void)
 {
 	struct fpsimd_last_state_struct const *last =
 		this_cpu_ptr(&fpsimd_last_state);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
+	WARN_ON(!have_cpu_fpsimd_context());
 
-	WARN_ON(!in_softirq() && !irqs_disabled());
+	if ( !have_cpu_fpsimd_context() )
+	{
+		printk("preemptible() = %u kernel_neon_busy = %u\n",
+		       preemptible(), __this_cpu_read(kernel_neon_busy));
+		while (1);
+	}
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
@@ -352,7 +413,8 @@ static int __init sve_sysctl_init(void) { return 0; }
  * task->thread.sve_state.
  *
  * Task can be a non-runnable task, or current.  In the latter case,
- * softirqs (and preemption) must be disabled.
+ * the FPSIMD context must be acquired with get_fpu_fpsimd_context()
+ * before calling this function.
  * task->thread.sve_state must point to at least sve_state_size(task)
  * bytes of allocated kernel memory.
  * task->thread.uw.fpsimd_state must be up to date before calling this
@@ -379,7 +441,8 @@ static void fpsimd_to_sve(struct task_struct *task)
  * task->thread.uw.fpsimd_state.
  *
  * Task can be a non-runnable task, or current.  In the latter case,
- * softirqs (and preemption) must be disabled.
+ * the FPSIMD context must be acquired with get_fpu_fpsimd_context()
+ * before calling this function.
  * task->thread.sve_state must point to at least sve_state_size(task)
  * bytes of allocated kernel memory.
  * task->thread.sve_state must be up to date before calling this function.
@@ -539,7 +602,7 @@ int sve_set_vector_length(struct task_struct *task,
 	 * non-SVE thread.
 	 */
 	if (task == current) {
-		local_bh_disable();
+		get_cpu_fpsimd_context();
 
 		fpsimd_save();
 	}
@@ -549,7 +612,7 @@ int sve_set_vector_length(struct task_struct *task,
 		sve_to_fpsimd(task);
 
 	if (task == current)
-		local_bh_enable();
+		put_cpu_fpsimd_context();
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -862,7 +925,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 
 	sve_alloc(current);
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 
 	fpsimd_save();
 
@@ -873,7 +936,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -917,6 +980,8 @@ void fpsimd_thread_switch(struct task_struct *next)
 	if (!system_supports_fpsimd())
 		return;
 
+	__get_cpu_fpsimd_context();
+
 	/* Save unsaved fpsimd state, if any: */
 	fpsimd_save();
 
@@ -931,6 +996,8 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 	update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
 			       wrong_task || wrong_cpu);
+
+	__put_cpu_fpsimd_context();
 }
 
 void fpsimd_flush_thread(void)
@@ -940,7 +1007,7 @@ void fpsimd_flush_thread(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 
 	fpsimd_flush_task_state(current);
 	memset(&current->thread.uw.fpsimd_state, 0,
@@ -981,7 +1048,7 @@ void fpsimd_flush_thread(void)
 			current->thread.sve_vl_onexec = 0;
 	}
 
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -993,9 +1060,9 @@ void fpsimd_preserve_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 	fpsimd_save();
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -1012,7 +1079,8 @@ void fpsimd_signal_preserve_current_state(void)
 
 /*
  * Associate current's FPSIMD context with this cpu
- * Preemption must be disabled when calling this function.
+ * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
+ * before calling this function.
  */
 void fpsimd_bind_task_to_cpu(void)
 {
@@ -1058,14 +1126,14 @@ void fpsimd_restore_current_state(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
 		fpsimd_bind_task_to_cpu();
 	}
 
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -1078,7 +1146,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	get_cpu_fpsimd_context();
 
 	current->thread.uw.fpsimd_state = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
@@ -1089,7 +1157,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 
 	clear_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_bh_enable();
+	put_cpu_fpsimd_context();
 }
 
 /*
@@ -1115,7 +1183,8 @@ void fpsimd_flush_task_state(struct task_struct *t)
 
 /*
  * Invalidate any task's FPSIMD state that is present on this cpu.
- * This function must be called with softirqs disabled.
+ * The FPSIMD context should be acquired with get_cpu_fpsimd_context()
+ * before calling this function.
  */
 static void fpsimd_flush_cpu_state(void)
 {
@@ -1125,19 +1194,18 @@ static void fpsimd_flush_cpu_state(void)
 
 /*
  * Save the FPSIMD state to memory and invalidate cpu view.
- * This function must be called with softirqs (and preemption) disabled.
+ * This function must be called with preemption disabled.
  */
 void fpsimd_save_and_flush_cpu_state(void)
 {
+	__get_cpu_fpsimd_context();
 	fpsimd_save();
 	fpsimd_flush_cpu_state();
+	__put_cpu_fpsimd_context();
 }
 
 #ifdef CONFIG_KERNEL_MODE_NEON
 
-DEFINE_PER_CPU(bool, kernel_neon_busy);
-EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
-
 /*
  * Kernel-side NEON support functions
  */
@@ -1162,19 +1230,13 @@ void kernel_neon_begin(void)
 
 	BUG_ON(!may_use_simd());
 
-	local_bh_disable();
-
-	__this_cpu_write(kernel_neon_busy, true);
+	get_cpu_fpsimd_context();
 
 	/* Save unsaved fpsimd state, if any: */
 	fpsimd_save();
 
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
-
-	preempt_disable();
-
-	local_bh_enable();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
@@ -1189,15 +1251,10 @@ EXPORT_SYMBOL(kernel_neon_begin);
  */
 void kernel_neon_end(void)
 {
-	bool busy;
-
 	if (!system_supports_fpsimd())
 		return;
 
-	busy = __this_cpu_xchg(kernel_neon_busy, false);
-	WARN_ON(!busy);	/* No matching kernel_neon_begin()? */
-
-	preempt_enable();
+	put_cpu_fpsimd_context();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
-- 
2.11.0

