Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0352C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C488C222BD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKKOM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:12:26 -0500
Received: from foss.arm.com ([217.140.110.172]:45782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKKOMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:12:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5997D328;
        Mon, 11 Nov 2019 06:12:24 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04CFC3F534;
        Mon, 11 Nov 2019 06:12:22 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH 1/2] arm64: Rename WORKAROUND_1165522 to SPECULATIVE_AT
Date:   Mon, 11 Nov 2019 14:11:56 +0000
Message-Id: <20191111141157.55062-2-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111141157.55062-1-steven.price@arm.com>
References: <20191111141157.55062-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cortex-A55 is affected by a similar erratum, so rename the existing
workaround for errarum 1165522 so it can be used for both errata.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/Kconfig                |  4 ++++
 arch/arm64/include/asm/cpucaps.h  |  2 +-
 arch/arm64/include/asm/kvm_host.h |  2 +-
 arch/arm64/include/asm/kvm_hyp.h  |  3 +--
 arch/arm64/kernel/cpu_errata.c    | 17 +++++++++++++----
 arch/arm64/kvm/hyp/switch.c       |  2 +-
 arch/arm64/kvm/hyp/tlb.c          |  4 ++--
 7 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3f047afb982c..6cb4eff602c6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -510,9 +510,13 @@ config ARM64_ERRATUM_1418040
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_SPECULATIVE_AT
+	bool
+
 config ARM64_ERRATUM_1165522
 	bool "Cortex-A76: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
 	default y
+	select ARM64_WORKAROUND_SPECULATIVE_AT
 	help
 	  This option adds a workaround for ARM Cortex-A76 erratum 1165522.
 
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index ac1dbca3d0cd..33c9545fe08a 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -44,7 +44,7 @@
 #define ARM64_SSBS				34
 #define ARM64_WORKAROUND_1418040		35
 #define ARM64_HAS_SB				36
-#define ARM64_WORKAROUND_1165522		37
+#define ARM64_WORKAROUND_SPECULATIVE_AT		37
 #define ARM64_HAS_ADDRESS_AUTH_ARCH		38
 #define ARM64_HAS_ADDRESS_AUTH_IMP_DEF		39
 #define ARM64_HAS_GENERIC_AUTH_ARCH		40
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f656169db8c3..d9f35ef1675e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -534,7 +534,7 @@ static inline bool kvm_arch_requires_vhe(void)
 		return true;
 
 	/* Some implementations have defects that confine them to VHE */
-	if (cpus_have_cap(ARM64_WORKAROUND_1165522))
+	if (cpus_have_cap(ARM64_WORKAROUND_SPECULATIVE_AT))
 		return true;
 
 	return false;
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 97f21cc66657..43d6c30b1bcc 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -95,8 +95,7 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
 	 * before we can switch to the EL1/EL0 translation regime used by
 	 * the guest.
 	 */
-	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
-}
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT)); }
 
 #endif /* __ARM64_KVM_HYP_H__ */
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 93f34b4eca25..a9ea19fdaf03 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -772,6 +772,16 @@ static const struct arm64_cpu_capabilities erratum_843419_list[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT
+static const struct midr_range erratum_speculative_at_list[] = {
+#ifdef CONFIG_ARM64_ERRATUM_1165522
+	/* Cortex A76 r0p0 to r2p0 */
+	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+#endif
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -898,12 +908,11 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_RANGE_LIST(erratum_1418040_list),
 	},
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_1165522
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT
 	{
-		/* Cortex-A76 r0p0 to r2p0 */
 		.desc = "ARM erratum 1165522",
-		.capability = ARM64_WORKAROUND_1165522,
-		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+		.capability = ARM64_WORKAROUND_SPECULATIVE_AT,
+		ERRATA_MIDR_RANGE_LIST(erratum_speculative_at_list),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1463225
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 799e84a40335..9b88627f9da9 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -148,7 +148,7 @@ static void deactivate_traps_vhe(void)
 	 * before we can switch to the EL2/EL0 translation regime used by
 	 * the host.
 	 */
-	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_1165522));
+	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index eb0efc5557f3..97e4b21367f1 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -23,7 +23,7 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 
 	local_irq_save(cxt->flags);
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		/*
 		 * For CPUs that are affected by ARM erratum 1165522, we
 		 * cannot trust stage-1 to be in a correct state at that
@@ -87,7 +87,7 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 	isb();
 
-	if (cpus_have_const_cap(ARM64_WORKAROUND_1165522)) {
+	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
 		/* Restore the registers to what they were */
 		write_sysreg_el1(cxt->tcr, SYS_TCR);
 		write_sysreg_el1(cxt->sctlr, SYS_SCTLR);
-- 
2.20.1

