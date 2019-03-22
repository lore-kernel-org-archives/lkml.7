Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47302192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255876;
	bh=g7oFL/89GSKst66ICKCnXWdHOieVyOY/LBZLa02Kq2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pH/fCiifB77iYDse8wKR9MzAgmb5i0c6M0kzrHGMjsTzAEh16EalLtiqWM0l1F+/Z
	 alipCbjYIbZFDv6Y+Os+QZEg0+XlnIDtS1/NzuvHGC8QU4N6nIXINNEks79MEt65vW
	 IKJ54lEcylT93ukfizfguakOsaCk5lreQWn+nYMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfCVL5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387726AbfCVL5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05CC20850;
        Fri, 22 Mar 2019 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255868;
        bh=g7oFL/89GSKst66ICKCnXWdHOieVyOY/LBZLa02Kq2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEwpecIyO+6zfFqBKoqeBk3zxuua1leBDsyYEQPvilLfe894IXAaTutvq02mq2pPl
         wTxdlSbuVbPHKNaDieM11l+7gO6ne/qvgFbvRh4MTSXnl8UOIlMrNvrxsg/GVe8BPm
         dIJruGiwebRyqRywcs9Lz+V56E+F3gUwRfe3w7t4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/280] arm/arm64: KVM: Allow a VCPU to fully reset itself
Date:   Fri, 22 Mar 2019 12:13:12 +0100
Message-Id: <20190322111308.518599085@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 358b28f09f0ab074d781df72b8a671edb1547789 ]

The current kvm_psci_vcpu_on implementation will directly try to
manipulate the state of the VCPU to reset it.  However, since this is
not done on the thread that runs the VCPU, we can end up in a strangely
corrupted state when the source and target VCPUs are running at the same
time.

Fix this by factoring out all reset logic from the PSCI implementation
and forwarding the required information along with a request to the
target VCPU.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/kvm_host.h   | 10 +++++++++
 arch/arm/kvm/reset.c              | 24 +++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h | 11 ++++++++++
 arch/arm64/kvm/reset.c            | 24 +++++++++++++++++++++
 virt/kvm/arm/arm.c                | 10 +++++++++
 virt/kvm/arm/psci.c               | 36 ++++++++++++++-----------------
 6 files changed, 95 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 3ad482d2f1eb..d0d0227fc70d 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -48,6 +48,7 @@
 #define KVM_REQ_SLEEP \
 	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
+#define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
@@ -147,6 +148,13 @@ struct kvm_cpu_context {
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
 
+struct vcpu_reset_state {
+	unsigned long	pc;
+	unsigned long	r0;
+	bool		be;
+	bool		reset;
+};
+
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
@@ -186,6 +194,8 @@ struct kvm_vcpu_arch {
 	/* Cache some mmu pages needed inside spinlock regions */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
+	struct vcpu_reset_state reset_state;
+
 	/* Detect first run of a vcpu */
 	bool has_run_once;
 };
diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index 5ed0c3ee33d6..e53327912adc 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -26,6 +26,7 @@
 #include <asm/cputype.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_emulate.h>
 
 #include <kvm/arm_arch_timer.h>
 
@@ -69,6 +70,29 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset CP15 registers */
 	kvm_reset_coprocs(vcpu);
 
+	/*
+	 * Additional reset state handling that PSCI may have imposed on us.
+	 * Must be done after all the sys_reg reset.
+	 */
+	if (READ_ONCE(vcpu->arch.reset_state.reset)) {
+		unsigned long target_pc = vcpu->arch.reset_state.pc;
+
+		/* Gracefully handle Thumb2 entry point */
+		if (target_pc & 1) {
+			target_pc &= ~1UL;
+			vcpu_set_thumb(vcpu);
+		}
+
+		/* Propagate caller endianness */
+		if (vcpu->arch.reset_state.be)
+			kvm_vcpu_set_be(vcpu);
+
+		*vcpu_pc(vcpu) = target_pc;
+		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
+
+		vcpu->arch.reset_state.reset = false;
+	}
+
 	/* Reset arch_timer context */
 	return kvm_timer_vcpu_reset(vcpu);
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3d6d7336f871..6abe4002945f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -48,6 +48,7 @@
 #define KVM_REQ_SLEEP \
 	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_IRQ_PENDING	KVM_ARCH_REQ(1)
+#define KVM_REQ_VCPU_RESET	KVM_ARCH_REQ(2)
 
 DECLARE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
@@ -206,6 +207,13 @@ struct kvm_cpu_context {
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
 
+struct vcpu_reset_state {
+	unsigned long	pc;
+	unsigned long	r0;
+	bool		be;
+	bool		reset;
+};
+
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
@@ -295,6 +303,9 @@ struct kvm_vcpu_arch {
 	/* Virtual SError ESR to restore when HCR_EL2.VSE is set */
 	u64 vsesr_el2;
 
+	/* Additional reset state */
+	struct vcpu_reset_state	reset_state;
+
 	/* True when deferrable sysregs are loaded on the physical CPU,
 	 * see kvm_vcpu_load_sysregs and kvm_vcpu_put_sysregs. */
 	bool sysregs_loaded_on_cpu;
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 644dd0050766..18b9a522a2b3 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -31,6 +31,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 
 /*
@@ -140,6 +141,29 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
 
+	/*
+	 * Additional reset state handling that PSCI may have imposed on us.
+	 * Must be done after all the sys_reg reset.
+	 */
+	if (vcpu->arch.reset_state.reset) {
+		unsigned long target_pc = vcpu->arch.reset_state.pc;
+
+		/* Gracefully handle Thumb2 entry point */
+		if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
+			target_pc &= ~1UL;
+			vcpu_set_thumb(vcpu);
+		}
+
+		/* Propagate caller endianness */
+		if (vcpu->arch.reset_state.be)
+			kvm_vcpu_set_be(vcpu);
+
+		*vcpu_pc(vcpu) = target_pc;
+		vcpu_set_reg(vcpu, 0, vcpu->arch.reset_state.r0);
+
+		vcpu->arch.reset_state.reset = false;
+	}
+
 	/* Reset PMU */
 	kvm_pmu_vcpu_reset(vcpu);
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 91495045ad5a..1415e36fed3d 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -624,6 +624,13 @@ static void vcpu_req_sleep(struct kvm_vcpu *vcpu)
 		/* Awaken to handle a signal, request we sleep again later. */
 		kvm_make_request(KVM_REQ_SLEEP, vcpu);
 	}
+
+	/*
+	 * Make sure we will observe a potential reset request if we've
+	 * observed a change to the power state. Pairs with the smp_wmb() in
+	 * kvm_psci_vcpu_on().
+	 */
+	smp_rmb();
 }
 
 static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
@@ -637,6 +644,9 @@ static void check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
 			vcpu_req_sleep(vcpu);
 
+		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
+			kvm_reset_vcpu(vcpu);
+
 		/*
 		 * Clear IRQ_PENDING requests that were made to guarantee
 		 * that a VCPU sees new virtual interrupts.
diff --git a/virt/kvm/arm/psci.c b/virt/kvm/arm/psci.c
index 9b73d3ad918a..34d08ee63747 100644
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -104,12 +104,10 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 
 static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 {
+	struct vcpu_reset_state *reset_state;
 	struct kvm *kvm = source_vcpu->kvm;
 	struct kvm_vcpu *vcpu = NULL;
-	struct swait_queue_head *wq;
 	unsigned long cpu_id;
-	unsigned long context_id;
-	phys_addr_t target_pc;
 
 	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
 	if (vcpu_mode_is_32bit(source_vcpu))
@@ -130,32 +128,30 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
 			return PSCI_RET_INVALID_PARAMS;
 	}
 
-	target_pc = smccc_get_arg2(source_vcpu);
-	context_id = smccc_get_arg3(source_vcpu);
+	reset_state = &vcpu->arch.reset_state;
 
-	kvm_reset_vcpu(vcpu);
-
-	/* Gracefully handle Thumb2 entry point */
-	if (vcpu_mode_is_32bit(vcpu) && (target_pc & 1)) {
-		target_pc &= ~((phys_addr_t) 1);
-		vcpu_set_thumb(vcpu);
-	}
+	reset_state->pc = smccc_get_arg2(source_vcpu);
 
 	/* Propagate caller endianness */
-	if (kvm_vcpu_is_be(source_vcpu))
-		kvm_vcpu_set_be(vcpu);
+	reset_state->be = kvm_vcpu_is_be(source_vcpu);
 
-	*vcpu_pc(vcpu) = target_pc;
 	/*
 	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
 	 * the general puspose registers are undefined upon CPU_ON.
 	 */
-	smccc_set_retval(vcpu, context_id, 0, 0, 0);
-	vcpu->arch.power_off = false;
-	smp_mb();		/* Make sure the above is visible */
+	reset_state->r0 = smccc_get_arg3(source_vcpu);
+
+	WRITE_ONCE(reset_state->reset, true);
+	kvm_make_request(KVM_REQ_VCPU_RESET, vcpu);
 
-	wq = kvm_arch_vcpu_wq(vcpu);
-	swake_up_one(wq);
+	/*
+	 * Make sure the reset request is observed if the change to
+	 * power_state is observed.
+	 */
+	smp_wmb();
+
+	vcpu->arch.power_off = false;
+	kvm_vcpu_wake_up(vcpu);
 
 	return PSCI_RET_SUCCESS;
 }
-- 
2.19.1



