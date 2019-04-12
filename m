Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D4EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A786D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDLROj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:14:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37080 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLROf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:14:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46AF615AB;
        Fri, 12 Apr 2019 10:14:35 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E5EC3F718;
        Fri, 12 Apr 2019 10:14:33 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        ard.biesheuvel@linaro.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v2 2/3] arch/arm64: fpsimd: Introduce fpsimd_save_and_flush_cpu_state() and use it
Date:   Fri, 12 Apr 2019 18:14:19 +0100
Message-Id: <20190412171420.29065-3-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190412171420.29065-1-julien.grall@arm.com>
References: <20190412171420.29065-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only external user of fpsimd_save() and fpsimd_flush_cpu_state() is
the KVM FPSIMD code.

A follow-up patch will mandate hold of the FPSIMD context while
modifying it. Rather than having to export the new helpers to get/put
the context, we can just introduce a new function to combine
fpsimd_save() and fpsimd_flush_cpu_state().

This has also the advantage to remove any external call of fpsimd_save()
and fpsimd_flush_cpu_state(), so they can be turned static.

Lastly, the new function can also be used in the PM notifier.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Patch added
---
 arch/arm64/include/asm/fpsimd.h |  5 ++---
 arch/arm64/kernel/fpsimd.c      | 17 +++++++++++++----
 arch/arm64/kvm/fpsimd.c         |  3 +--
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 32abbfd852e8..88c223f6ded6 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -48,11 +48,11 @@ struct task_struct;
 extern void fpsimd_save_state(struct user_fpsimd_state *state);
 extern void fpsimd_load_state(struct user_fpsimd_state *state);
 
-extern void fpsimd_save(void);
-
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
 
+extern void fpsimd_save_and_flush_cpu_state(void);
+
 extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
@@ -63,7 +63,6 @@ extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
-extern void fpsimd_flush_cpu_state(void);
 
 /* Maximum VL that SVE VL-agnostic software can transparently support */
 #define SVE_VL_ARCH_MAX 0x100
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 577296bba730..9e4e4b6acd93 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -241,7 +241,7 @@ static void task_fpsimd_load(void)
  *
  * Softirqs (and preemption) must be disabled.
  */
-void fpsimd_save(void)
+static void fpsimd_save(void)
 {
 	struct fpsimd_last_state_struct const *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1117,12 +1117,22 @@ void fpsimd_flush_task_state(struct task_struct *t)
  * Invalidate any task's FPSIMD state that is present on this cpu.
  * This function must be called with softirqs disabled.
  */
-void fpsimd_flush_cpu_state(void)
+static void fpsimd_flush_cpu_state(void)
 {
 	__this_cpu_write(fpsimd_last_state.st, NULL);
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
+/*
+ * Save the FPSIMD state to memory and invalidate cpu view.
+ * This function must be called with softirqs (and preemption) disabled.
+ */
+void fpsimd_save_and_flush_cpu_state(void)
+{
+	fpsimd_save();
+	fpsimd_flush_cpu_state();
+}
+
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 DEFINE_PER_CPU(bool, kernel_neon_busy);
@@ -1279,8 +1289,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 {
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		fpsimd_save();
-		fpsimd_flush_cpu_state();
+		fpsimd_save_and_flush_cpu_state();
 		break;
 	case CPU_PM_EXIT:
 		break;
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 6e3c9c8b2df9..01bd2e862506 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -113,8 +113,7 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 		u64 *guest_zcr = &vcpu->arch.ctxt.sys_regs[ZCR_EL1];
 
 		/* Clean guest FP state to memory and invalidate cpu view */
-		fpsimd_save();
-		fpsimd_flush_cpu_state();
+		fpsimd_save_and_flush_cpu_state();
 
 		if (guest_has_sve)
 			*guest_zcr = read_sysreg_s(SYS_ZCR_EL12);
-- 
2.11.0

