Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED58C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B4E2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DRppkKsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfE1Vbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:31:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfE1Vbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:31:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLV9Da2241105
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:31:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLV9Da2241105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559079070;
        bh=4uL5ZpaQDHVgeJEFnGeT44GJ3RDJWkXunVPIQVejTrg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=DRppkKsFq+6Ahf9yYc2ptjwLJViSTOzS2XaJm2cAD4xtI+85ar19ZE8HP1FwhdCmg
         0j/B/pNSVpMugX2utkWuIM5ejXCM9rA3P9ICM/NI11v2TJnGadt4GLMA5JO+bI99ux
         AlriJIxy55mGvIxgqlDTez+sjtkrA6VfjKvHNNKPMmXKWSffA+CXz+B/mCanqW0f+9
         IVrG8X8kB3RljpOkqPxdUoqwpoveSI05wb++BQla/w3sbVDZoav/31uRGy67978D6R
         cQ1C9ugwWrBGffK7CsyPK3SKtJUW/NpABKkyRKo7SYXvtwuXzOmVo+QpkCcCZffXCw
         i8aRRMfqqKDpg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLV9l02241102;
        Tue, 28 May 2019 14:31:09 -0700
Date:   Tue, 28 May 2019 14:31:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3msmqjenlmb7eygcdnmlqaq1@git.kernel.org>
Cc:     hpa@zytor.com, adrian.hunter@intel.com, namhyung@kernel.org,
        paulus@ozlabs.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        clg@kaod.org, pbonzini@redhat.com, brendan.d.gregg@gmail.com,
        Dave.Martin@arm.com, marc.zyngier@arm.com, lclaudio@redhat.com,
        borntraeger@de.ibm.com, amit.kachhap@arm.com, jolsa@kernel.org
Reply-To: brendan.d.gregg@gmail.com, Dave.Martin@arm.com,
          pbonzini@redhat.com, mingo@kernel.org, clg@kaod.org,
          acme@redhat.com, amit.kachhap@arm.com, lclaudio@redhat.com,
          borntraeger@de.ibm.com, jolsa@kernel.org, marc.zyngier@arm.com,
          adrian.hunter@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, peterx@redhat.com,
          tglx@linutronix.de, namhyung@kernel.org, paulus@ozlabs.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Sync kvm.h headers with the
 kernel sources
Git-Commit-ID: a7350998a25ac10cdca5b33dee1d343a74debbfe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a7350998a25ac10cdca5b33dee1d343a74debbfe
Gitweb:     https://git.kernel.org/tip/a7350998a25ac10cdca5b33dee1d343a74debbfe
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 24 May 2019 14:04:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:52:23 -0300

tools headers UAPI: Sync kvm.h headers with the kernel sources

  dd53f6102c30 ("Merge tag 'kvmarm-for-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD")
  59c5c58c5b93 ("Merge tag 'kvm-ppc-next-5.2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into HEAD")
  d7547c55cbe7 ("KVM: Introduce KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2")
  6520ca64cde7 ("KVM: PPC: Book3S HV: XIVE: Add a mapping for the source ESB pages")
  39e9af3de5ca ("KVM: PPC: Book3S HV: XIVE: Add a TIMA mapping")
  e4945b9da52b ("KVM: PPC: Book3S HV: XIVE: Add get/set accessors for the VP XIVE state")
  e6714bd1671d ("KVM: PPC: Book3S HV: XIVE: Add a control to dirty the XIVE EQ pages")
  7b46b6169ab8 ("KVM: PPC: Book3S HV: XIVE: Add a control to sync the sources")
  5ca806474859 ("KVM: PPC: Book3S HV: XIVE: Add a global reset control")
  13ce3297c576 ("KVM: PPC: Book3S HV: XIVE: Add controls for the EQ configuration")
  e8676ce50e22 ("KVM: PPC: Book3S HV: XIVE: Add a control to configure a source")
  4131f83c3d64 ("KVM: PPC: Book3S HV: XIVE: add a control to initialize a source")
  eacc56bb9de3 ("KVM: PPC: Book3S HV: XIVE: Introduce a new capability KVM_CAP_PPC_IRQ_XIVE")
  90c73795afa2 ("KVM: PPC: Book3S HV: Add a new KVM device for the XIVE native exploitation mode")
  4f45b90e1c03 ("KVM: s390: add deflate conversion facilty to cpu model")
  a243c16d18be ("KVM: arm64: Add capability to advertise ptrauth for guest")
  a22fa321d13b ("KVM: arm64: Add userspace flag to enable pointer authentication")
  4bd774e57b29 ("KVM: arm64/sve: Simplify KVM_REG_ARM64_SVE_VLS array sizing")
  8ae6efdde451 ("KVM: arm64/sve: Clean up UAPI register ID definitions")
  173aec2d5a9f ("KVM: s390: add enhanced sort facilty to cpu model")
  555f3d03e7fb ("KVM: arm64: Add a capability to advertise SVE support")
  9033bba4b535 ("KVM: arm64/sve: Add pseudo-register for the guest's vector lengths")
  7dd32a0d0103 ("KVM: arm/arm64: Add KVM_ARM_VCPU_FINALIZE ioctl")
  e1c9c98345b3 ("KVM: arm64/sve: Add SVE support to register access ioctl interface")
  2b953ea34812 ("KVM: Allow 2048-bit register access via ioctl interface")

None entails changes in tooling, the closest to that were some new arch
specific ioctls, that are still not handled by the tools/perf/trace/beauty/
library, that needs to create per-arch tables to convert ioctl cmd->string (and
back).

From a quick look the arch specific kvm-stat.c files at:

  $ ls -1 tools/perf/arch/*/util/kvm-stat.c
  tools/perf/arch/powerpc/util/kvm-stat.c
  tools/perf/arch/s390/util/kvm-stat.c
  tools/perf/arch/x86/util/kvm-stat.c
  $

Are not affected.

This silences these perf building warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/kvm.h' differs from latest version at 'arch/powerpc/include/uapi/asm/kvm.h'
  diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/kvm.h' differs from latest version at 'arch/s390/include/uapi/asm/kvm.h'
  diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Peter Xu <peterx@redhat.com>
Link: https://lkml.kernel.org/n/tip-3msmqjenlmb7eygcdnmlqaq1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h   | 43 +++++++++++++++++++++++++++++
 tools/arch/powerpc/include/uapi/asm/kvm.h | 46 +++++++++++++++++++++++++++++++
 tools/arch/s390/include/uapi/asm/kvm.h    |  4 ++-
 tools/include/uapi/linux/kvm.h            | 15 ++++++++--
 4 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 97c3478ee6e7..7b7ac0f6cec9 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -35,6 +35,7 @@
 #include <linux/psci.h>
 #include <linux/types.h>
 #include <asm/ptrace.h>
+#include <asm/sve_context.h>
 
 #define __KVM_HAVE_GUEST_DEBUG
 #define __KVM_HAVE_IRQ_LINE
@@ -102,6 +103,9 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_EL1_32BIT		1 /* CPU running a 32bit VM */
 #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
 #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
+#define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
+#define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
+#define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
 
 struct kvm_vcpu_init {
 	__u32 target;
@@ -226,6 +230,45 @@ struct kvm_vcpu_events {
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
 
+/* SVE registers */
+#define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
+
+/* Z- and P-regs occupy blocks at the following offsets within this range: */
+#define KVM_REG_ARM64_SVE_ZREG_BASE	0
+#define KVM_REG_ARM64_SVE_PREG_BASE	0x400
+#define KVM_REG_ARM64_SVE_FFR_BASE	0x600
+
+#define KVM_ARM64_SVE_NUM_ZREGS		__SVE_NUM_ZREGS
+#define KVM_ARM64_SVE_NUM_PREGS		__SVE_NUM_PREGS
+
+#define KVM_ARM64_SVE_MAX_SLICES	32
+
+#define KVM_REG_ARM64_SVE_ZREG(n, i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_ZREG_BASE | \
+	 KVM_REG_SIZE_U2048 |						\
+	 (((n) & (KVM_ARM64_SVE_NUM_ZREGS - 1)) << 5) |			\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_REG_ARM64_SVE_PREG(n, i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_PREG_BASE | \
+	 KVM_REG_SIZE_U256 |						\
+	 (((n) & (KVM_ARM64_SVE_NUM_PREGS - 1)) << 5) |			\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_REG_ARM64_SVE_FFR(i)					\
+	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | KVM_REG_ARM64_SVE_FFR_BASE | \
+	 KVM_REG_SIZE_U256 |						\
+	 ((i) & (KVM_ARM64_SVE_MAX_SLICES - 1)))
+
+#define KVM_ARM64_SVE_VQ_MIN __SVE_VQ_MIN
+#define KVM_ARM64_SVE_VQ_MAX __SVE_VQ_MAX
+
+/* Vector lengths pseudo-register: */
+#define KVM_REG_ARM64_SVE_VLS		(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
+					 KVM_REG_SIZE_U512 | 0xffff)
+#define KVM_ARM64_SVE_VLS_WORDS	\
+	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
diff --git a/tools/arch/powerpc/include/uapi/asm/kvm.h b/tools/arch/powerpc/include/uapi/asm/kvm.h
index 26ca425f4c2c..b0f72dea8b11 100644
--- a/tools/arch/powerpc/include/uapi/asm/kvm.h
+++ b/tools/arch/powerpc/include/uapi/asm/kvm.h
@@ -482,6 +482,8 @@ struct kvm_ppc_cpu_char {
 #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
 #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
 
+#define KVM_REG_PPC_VP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U128 | 0x8d)
+
 /* Device control API: PPC-specific devices */
 #define KVM_DEV_MPIC_GRP_MISC		1
 #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
@@ -677,4 +679,48 @@ struct kvm_ppc_cpu_char {
 #define  KVM_XICS_PRESENTED		(1ULL << 43)
 #define  KVM_XICS_QUEUED		(1ULL << 44)
 
+/* POWER9 XIVE Native Interrupt Controller */
+#define KVM_DEV_XIVE_GRP_CTRL		1
+#define   KVM_DEV_XIVE_RESET		1
+#define   KVM_DEV_XIVE_EQ_SYNC		2
+#define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
+#define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
+#define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
+#define KVM_DEV_XIVE_GRP_SOURCE_SYNC	5       /* 64-bit source identifier */
+
+/* Layout of 64-bit XIVE source attribute values */
+#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
+#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
+
+/* Layout of 64-bit XIVE source configuration attribute values */
+#define KVM_XIVE_SOURCE_PRIORITY_SHIFT	0
+#define KVM_XIVE_SOURCE_PRIORITY_MASK	0x7
+#define KVM_XIVE_SOURCE_SERVER_SHIFT	3
+#define KVM_XIVE_SOURCE_SERVER_MASK	0xfffffff8ULL
+#define KVM_XIVE_SOURCE_MASKED_SHIFT	32
+#define KVM_XIVE_SOURCE_MASKED_MASK	0x100000000ULL
+#define KVM_XIVE_SOURCE_EISN_SHIFT	33
+#define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
+
+/* Layout of 64-bit EQ identifier */
+#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
+#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
+#define KVM_XIVE_EQ_SERVER_SHIFT	3
+#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
+
+/* Layout of EQ configuration values (64 bytes) */
+struct kvm_ppc_xive_eq {
+	__u32 flags;
+	__u32 qshift;
+	__u64 qaddr;
+	__u32 qtoggle;
+	__u32 qindex;
+	__u8  pad[40];
+};
+
+#define KVM_XIVE_EQ_ALWAYS_NOTIFY	0x00000001
+
+#define KVM_XIVE_TIMA_PAGE_OFFSET	0
+#define KVM_XIVE_ESB_PAGE_OFFSET	4
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/tools/arch/s390/include/uapi/asm/kvm.h b/tools/arch/s390/include/uapi/asm/kvm.h
index 09652eabe769..47104e5b47fd 100644
--- a/tools/arch/s390/include/uapi/asm/kvm.h
+++ b/tools/arch/s390/include/uapi/asm/kvm.h
@@ -153,7 +153,9 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 ppno[16];		/* with MSA5 */
 	__u8 kma[16];		/* with MSA8 */
 	__u8 kdsa[16];		/* with MSA9 */
-	__u8 reserved[1792];
+	__u8 sortl[32];		/* with STFLE.150 */
+	__u8 dfltcc[32];	/* with STFLE.151 */
+	__u8 reserved[1728];
 };
 
 /* kvm attributes for crypto */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 6d4ea4b6c922..2fe12b40d503 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -986,8 +986,13 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_ENLIGHTENED_VMCS 163
 #define KVM_CAP_EXCEPTION_PAYLOAD 164
 #define KVM_CAP_ARM_VM_IPA_SIZE 165
-#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166 /* Obsolete */
 #define KVM_CAP_HYPERV_CPUID 167
+#define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 168
+#define KVM_CAP_PPC_IRQ_XIVE 169
+#define KVM_CAP_ARM_SVE 170
+#define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
+#define KVM_CAP_ARM_PTRAUTH_GENERIC 172
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1145,6 +1150,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_SIZE_U256	0x0050000000000000ULL
 #define KVM_REG_SIZE_U512	0x0060000000000000ULL
 #define KVM_REG_SIZE_U1024	0x0070000000000000ULL
+#define KVM_REG_SIZE_U2048	0x0080000000000000ULL
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
@@ -1211,6 +1217,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_ARM_VGIC_V3	KVM_DEV_TYPE_ARM_VGIC_V3
 	KVM_DEV_TYPE_ARM_VGIC_ITS,
 #define KVM_DEV_TYPE_ARM_VGIC_ITS	KVM_DEV_TYPE_ARM_VGIC_ITS
+	KVM_DEV_TYPE_XIVE,
+#define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
 	KVM_DEV_TYPE_MAX,
 };
 
@@ -1434,12 +1442,15 @@ struct kvm_enc_region {
 #define KVM_GET_NESTED_STATE         _IOWR(KVMIO, 0xbe, struct kvm_nested_state)
 #define KVM_SET_NESTED_STATE         _IOW(KVMIO,  0xbf, struct kvm_nested_state)
 
-/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT */
+/* Available with KVM_CAP_MANUAL_DIRTY_LOG_PROTECT_2 */
 #define KVM_CLEAR_DIRTY_LOG          _IOWR(KVMIO, 0xc0, struct kvm_clear_dirty_log)
 
 /* Available with KVM_CAP_HYPERV_CPUID */
 #define KVM_GET_SUPPORTED_HV_CPUID _IOWR(KVMIO, 0xc1, struct kvm_cpuid2)
 
+/* Available with KVM_CAP_ARM_SVE */
+#define KVM_ARM_VCPU_FINALIZE	  _IOW(KVMIO,  0xc2, int)
+
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
 	/* Guest initialization commands */
