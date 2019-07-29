Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84784C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8F92073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564434915;
	bh=iTB9j7eXG+vtEE4H+3GwpI3RPSotB3lUtoqZSCUiTZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfJY/KGTopmHlpGD0FaAU4Z7qc96PiD1DlPSI9hlQOlXLk0pOHh57u5/FsiinEFSp
	 qEDqpgKZ+PV32Nj4a3sjGtmBa1YBV3x1ItVTAyTWCzjDldPBLTFDbrBwnd2FnK507W
	 nBN1CobP/xKAvXotDdrZiLwefbahFRHJKj0biuU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbfG2VPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388589AbfG2VPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:15:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C451921655;
        Mon, 29 Jul 2019 21:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564434912;
        bh=iTB9j7eXG+vtEE4H+3GwpI3RPSotB3lUtoqZSCUiTZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pfnoccYwMiLSelnH4XiJNgbMmoP++S+wfjbIwygB6L04v1BPsALlm845LpwUTeqG+
         0ZAd7VRENWxQJw7DBSAzf4jWlNh8WIAOSlThhfxHyQy3JZboz7s3bqXgYSK/Tv2O9F
         pptb52/20gCsCRMdGWdbFhy+gkhZQeTQpqTv5U1U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Eric Hankland <ehankland@google.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 02/12] tools headers UAPI: Update tools's copy of kvm.h headers
Date:   Mon, 29 Jul 2019 18:14:49 -0300
Message-Id: <20190729211456.6380-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking the changes from:

  66bb8a065f5a ("KVM: x86: PMU Event Filter")
  f087a02941fe ("KVM: nVMX: Stash L1's CR3 in vmcs01.GUEST_CR3 on nested entry w/o EPT")
  99adb567632b ("KVM: arm/arm64: Add save/restore support for firmware workaround state")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/arm/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm/include/uapi/asm/kvm.h arch/arm/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/vmx.h' differs from latest version at 'arch/x86/include/uapi/asm/vmx.h'
  diff -u tools/arch/x86/include/uapi/asm/vmx.h arch/x86/include/uapi/asm/vmx.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Now 'perf trace' and other code that might use the tools/perf/trace/beauty autogenerated
tables will be able to translate this new ioctl code into a string:

  $ tools/perf/trace/beauty/kvm_ioctl.sh > before
  $
  $ cp include/uapi/linux/kvm.h tools/include/uapi/linux/kvm.h
  $ tools/perf/trace/beauty/kvm_ioctl.sh > after
  $ diff -u before after
  --- before 2019-07-26 12:32:47.959220236 -0300
  +++ after 2019-07-26 12:33:05.766464871 -0300
  @@ -79,6 +79,7 @@
        [0xac] = "SET_ONE_REG",
        [0xad] = "KVMCLOCK_CTRL",
        [0xb0] = "GET_REG_LIST",
  +     [0xb2] = "SET_PMU_EVENT_FILTER",
        [0xb7] = "SMI",
        [0xba] = "MEMORY_ENCRYPT_OP",
        [0xbb] = "MEMORY_ENCRYPT_REG_REGION",
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Eric Hankland <ehankland@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Link: https://lkml.kernel.org/n/tip-py1gcmt6rboehlwg6zvagfg2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm/include/uapi/asm/kvm.h   | 12 ++++++++++++
 tools/arch/arm64/include/uapi/asm/kvm.h | 10 ++++++++++
 tools/arch/x86/include/uapi/asm/kvm.h   | 22 ++++++++++++++++++----
 tools/arch/x86/include/uapi/asm/vmx.h   |  1 -
 tools/include/uapi/linux/kvm.h          |  3 +++
 5 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/tools/arch/arm/include/uapi/asm/kvm.h b/tools/arch/arm/include/uapi/asm/kvm.h
index 4602464ebdfb..a4217c1a5d01 100644
--- a/tools/arch/arm/include/uapi/asm/kvm.h
+++ b/tools/arch/arm/include/uapi/asm/kvm.h
@@ -214,6 +214,18 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
+	/* Higher values mean better protection. */
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
+	/* Higher values mean better protection. */
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL		2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	(1U << 4)
 
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index d819a3e8b552..9a507716ae2f 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -229,6 +229,16 @@ struct kvm_vcpu_events {
 #define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
 					 KVM_REG_ARM_FW | ((r) & 0xffff))
 #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL		2
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
+#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED     	(1U << 4)
 
 /* SVE registers */
 #define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index d6ab5b4d15e5..503d3f42da16 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -378,10 +378,11 @@ struct kvm_sync_regs {
 	struct kvm_vcpu_events events;
 };
 
-#define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
-#define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
-#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
-#define KVM_X86_QUIRK_OUT_7E_INC_RIP	(1 << 3)
+#define KVM_X86_QUIRK_LINT0_REENABLED	   (1 << 0)
+#define KVM_X86_QUIRK_CD_NW_CLEARED	   (1 << 1)
+#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	   (1 << 2)
+#define KVM_X86_QUIRK_OUT_7E_INC_RIP	   (1 << 3)
+#define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT (1 << 4)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1	/* unused */
@@ -432,4 +433,17 @@ struct kvm_nested_state {
 	} data;
 };
 
+/* for KVM_CAP_PMU_EVENT_FILTER */
+struct kvm_pmu_event_filter {
+	__u32 action;
+	__u32 nevents;
+	__u32 fixed_counter_bitmap;
+	__u32 flags;
+	__u32 pad[4];
+	__u64 events[0];
+};
+
+#define KVM_PMU_EVENT_ALLOW 0
+#define KVM_PMU_EVENT_DENY 1
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/tools/arch/x86/include/uapi/asm/vmx.h b/tools/arch/x86/include/uapi/asm/vmx.h
index d213ec5c3766..f0b0c90dd398 100644
--- a/tools/arch/x86/include/uapi/asm/vmx.h
+++ b/tools/arch/x86/include/uapi/asm/vmx.h
@@ -146,7 +146,6 @@
 
 #define VMX_ABORT_SAVE_GUEST_MSR_FAIL        1
 #define VMX_ABORT_LOAD_HOST_PDPTE_FAIL       2
-#define VMX_ABORT_VMCS_CORRUPTED             3
 #define VMX_ABORT_LOAD_HOST_MSR_FAIL         4
 
 #endif /* _UAPIVMX_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index c2152f3dd02d..a7c19540ce21 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -995,6 +995,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_SVE 170
 #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
+#define KVM_CAP_PMU_EVENT_FILTER 173
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1329,6 +1330,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_info)
 /* Available with KVM_CAP_PPC_GET_CPU_CHAR */
 #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_char)
+/* Available with KVM_CAP_PMU_EVENT_FILTER */
+#define KVM_SET_PMU_EVENT_FILTER  _IOW(KVMIO,  0xb2, struct kvm_pmu_event_filter)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.21.0

