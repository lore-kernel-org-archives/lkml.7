Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FA9C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfLQSea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:34:30 -0500
Received: from foss.arm.com ([217.140.110.172]:44820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbfLQSe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:34:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0DB331B;
        Tue, 17 Dec 2019 10:34:27 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 875223F67D;
        Tue, 17 Dec 2019 10:34:26 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, dave.martin@arm.com, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, christoffer.dall@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 7/7] arm64: nofpsmid: Handle TIF_FOREIGN_FPSTATE flag cleanly
Date:   Tue, 17 Dec 2019 18:34:02 +0000
Message-Id: <20191217183402.2259904-8-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217183402.2259904-1-suzuki.poulose@arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We detect the absence of FP/SIMD after an incapable CPU is brought up,
and by then we have kernel threads running already with TIF_FOREIGN_FPSTATE set
which could be set for early userspace applications (e.g, modprobe triggered
from initramfs) and init. This could cause the applications to loop forever in
do_nofity_resume() as we never clear the TIF flag, once we now know that
we don't support FP.

Fix this by making sure that we clear the TIF_FOREIGN_FPSTATE flag
for tasks which may have them set, as we would have done in the normal
case, but avoiding touching the hardware state (since we don't support any).

Also to make sure we handle the cases seemlessly we categorise the
helper functions to two :
 1) Helpers for common core code, which calls into take appropriate
    actions without knowing the current FPSIMD state of the CPU/task.

    e.g fpsimd_restore_current_state(), fpsimd_flush_task_state(),
        fpsimd_save_and_flush_cpu_state().

    We bail out early for these functions, taking any appropriate actions
    (e.g, clearing the TIF flag) where necessary to hide the handling
    from core code.

 2) Helpers used when the presence of FP/SIMD is apparent.
    i.e, save/restore the FP/SIMD register state, modify the CPU/task
    FP/SIMD state.
    e.g,

    fpsimd_save(), task_fpsimd_load() - save/restore task FP/SIMD registers

    fpsimd_bind_task_to_cpu()  \
                                - Update the "state" metadata for CPU/task.
    fpsimd_bind_state_to_cpu() /

    fpsimd_update_current_state() - Update the fp/simd state for the current
                                    task from memory.

    These must not be called in the absence of FP/SIMD. Put in a WARNING
    to make sure they are not invoked in the absence of FP/SIMD.

KVM also uses the TIF_FOREIGN_FPSTATE flag to manage the FP/SIMD state
on the CPU. However, without FP/SIMD support we trap all accesses and
inject undefined instruction. Thus we should never "load" guest state.
Add a sanity check to make sure this is valid.

Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/fpsimd.c  | 31 +++++++++++++++++++++++++++----
 arch/arm64/kvm/hyp/switch.c |  9 +++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 3eb338f14386..240c52b71cda 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -269,7 +269,7 @@ static void sve_free(struct task_struct *task)
  */
 static void task_fpsimd_load(void)
 {
-	WARN_ON(!have_cpu_fpsimd_context());
+	WARN_ON(!system_supports_fpsimd() || !have_cpu_fpsimd_context());
 
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
 		sve_load_state(sve_pffr(&current->thread),
@@ -289,6 +289,7 @@ static void fpsimd_save(void)
 		this_cpu_ptr(&fpsimd_last_state);
 	/* set by fpsimd_bind_task_to_cpu() or fpsimd_bind_state_to_cpu() */
 
+	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
@@ -1092,6 +1093,7 @@ void fpsimd_bind_task_to_cpu(void)
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
 
+	WARN_ON(!system_supports_fpsimd());
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_state = current->thread.sve_state;
 	last->sve_vl = current->thread.sve_vl;
@@ -1114,6 +1116,7 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
 
+	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!in_softirq() && !irqs_disabled());
 
 	last->st = st;
@@ -1128,8 +1131,19 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st, void *sve_state,
  */
 void fpsimd_restore_current_state(void)
 {
-	if (!system_supports_fpsimd())
+	/*
+	 * For the tasks that were created before we detected the absence of
+	 * FP/SIMD, the TIF_FOREIGN_FPSTATE could be set via fpsimd_thread_switch(),
+	 * e.g, init. This could be then inherited by the children processes.
+	 * If we later detect that the system doesn't support FP/SIMD,
+	 * we must clear the flag for  all the tasks to indicate that the
+	 * FPSTATE is clean (as we can't have one) to avoid looping for ever in
+	 * do_notify_resume().
+	 */
+	if (!system_supports_fpsimd()) {
+		clear_thread_flag(TIF_FOREIGN_FPSTATE);
 		return;
+	}
 
 	get_cpu_fpsimd_context();
 
@@ -1148,7 +1162,7 @@ void fpsimd_restore_current_state(void)
  */
 void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 {
-	if (!system_supports_fpsimd())
+	if (WARN_ON(!system_supports_fpsimd()))
 		return;
 
 	get_cpu_fpsimd_context();
@@ -1179,7 +1193,13 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 void fpsimd_flush_task_state(struct task_struct *t)
 {
 	t->thread.fpsimd_cpu = NR_CPUS;
-
+	/*
+	 * If we don't support fpsimd, bail out after we have
+	 * reset the fpsimd_cpu for this task and clear the
+	 * FPSTATE.
+	 */
+	if (!system_supports_fpsimd())
+		return;
 	barrier();
 	set_tsk_thread_flag(t, TIF_FOREIGN_FPSTATE);
 
@@ -1193,6 +1213,7 @@ void fpsimd_flush_task_state(struct task_struct *t)
  */
 static void fpsimd_flush_cpu_state(void)
 {
+	WARN_ON(!system_supports_fpsimd());
 	__this_cpu_write(fpsimd_last_state.st, NULL);
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
@@ -1203,6 +1224,8 @@ static void fpsimd_flush_cpu_state(void)
  */
 void fpsimd_save_and_flush_cpu_state(void)
 {
+	if (!system_supports_fpsimd())
+		return;
 	WARN_ON(preemptible());
 	__get_cpu_fpsimd_context();
 	fpsimd_save();
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 72fbbd86eb5e..9696ebb5c13a 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -28,10 +28,19 @@
 /* Check whether the FP regs were dirtied while in the host-side run loop: */
 static bool __hyp_text update_fp_enabled(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * When the system doesn't support FP/SIMD, we cannot rely on
+	 * the state of _TIF_FOREIGN_FPSTATE. However, we will never
+	 * set the KVM_ARM64_FP_ENABLED, as the FP/SIMD accesses always
+	 * inject an abort into the guest. Thus we always trap the
+	 * accesses.
+	 */
 	if (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE)
 		vcpu->arch.flags &= ~(KVM_ARM64_FP_ENABLED |
 				      KVM_ARM64_FP_HOST);
 
+	WARN_ON(!system_supports_fpsimd() &&
+		(vcpu->arch.flags & KVM_ARM64_FP_ENABLED));
 	return !!(vcpu->arch.flags & KVM_ARM64_FP_ENABLED);
 }
 
-- 
2.23.0

