Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FE720675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfCGJmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:42:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:64690 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGJmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:42:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 01:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="150105090"
Received: from xy-skl-4s.sh.intel.com ([10.239.48.75])
  by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2019 01:42:47 -0800
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm/x86/vmx: Make the emulation of MSR_IA32_ARCH_CAPABILITIES only for vmx
Date:   Thu,  7 Mar 2019 17:31:43 +0800
Message-Id: <20190307093143.77182-1-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, we report F(ARCH_CAPABILITIES) for x86 arch(both vmx and svm)
unconditionally, but we only emulate this MSR in vmx. It will cause #GP
while guest kernel rdmsr(MSR_IA32_ARCH_CAPABILITIES) in an AMD host.

Since MSR IA32_ARCH_CAPABILITIES is an intel-specific MSR, it makes no
sense to emulate it in svm. Thus this patch chooses to only emulate it
for vmx, and moves the related handling to vmx related files.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/cpuid.c            |  8 +++++---
 arch/x86/kvm/vmx/vmx.c          | 26 +++++++++++++++++++++++++-
 arch/x86/kvm/x86.c              | 25 -------------------------
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 180373360e34..99ad4a1b5cf7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1526,7 +1526,6 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 		    unsigned long ipi_bitmap_high, u32 min,
 		    unsigned long icr, int op_64_bit);
 
-u64 kvm_get_arch_capabilities(void);
 void kvm_define_shared_msr(unsigned index, u32 msr);
 int kvm_set_shared_msr(unsigned index, u64 val, u64 mask);
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c07958b59f50..1c14eef59b54 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -501,10 +501,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
 			cpuid_mask(&entry->edx, CPUID_7_EDX);
 			/*
-			 * We emulate ARCH_CAPABILITIES in software even
-			 * if the host doesn't support it.
+			 * MSR IA32_ARCH_CAPABILITIES is intel-specific.
+			 * we emulate it in software even if the host doesn't
+			 * support it.
 			 */
-			entry->edx |= F(ARCH_CAPABILITIES);
+			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+				entry->edx |= F(ARCH_CAPABILITIES);
 		} else {
 			entry->ebx = 0;
 			entry->ecx = 0;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 30a6bcd735ec..0d4f4fe1bb12 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1633,6 +1633,27 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 	return !(val & ~valid_bits);
 }
 
+static u64 vmx_get_arch_capabilities(void)
+{
+	u64 data;
+
+	rdmsrl_safe(MSR_IA32_ARCH_CAPABILITIES, &data);
+
+	/*
+	 *If we're doing cache flushes (either "always" or "cond")
+	 * we will do one whenever the guest does a vmlaunch/vmresume.
+	 * If an outer hypervisor is doing the cache flush for us
+	 * (VMENTER_L1D_FLUSH_NESTED_VM), we can safely pass that
+	 * capability to the guest too, and if EPT is disabled we're not
+	 * vulnerable.  Overall, only VMENTER_L1D_FLUSH_NEVER will
+	 * require a nested hypervisor to do a flush of its own.
+	 */
+	if (l1tf_vmx_mitigation != VMENTER_L1D_FLUSH_NEVER)
+		data |= ARCH_CAP_SKIP_VMENTRY_L1DFLUSH;
+
+	return data;
+}
+
 static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
@@ -1640,6 +1661,9 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 		if (!nested)
 			return 1;
 		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
+	case MSR_IA32_ARCH_CAPABILITIES:
+		msr->data = vmx_get_arch_capabilities();
+		break;
 	default:
 		return 1;
 	}
@@ -4083,7 +4107,7 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		++vmx->nmsrs;
 	}
 
-	vmx->arch_capabilities = kvm_get_arch_capabilities();
+	vmx->arch_capabilities = vmx_get_arch_capabilities();
 
 	vm_exit_controls_init(vmx, vmx_vmexit_ctrl());
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 941f932373d0..b3ba336c4662 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1202,34 +1202,9 @@ static u32 msr_based_features[] = {
 
 static unsigned int num_msr_based_features;
 
-u64 kvm_get_arch_capabilities(void)
-{
-	u64 data;
-
-	rdmsrl_safe(MSR_IA32_ARCH_CAPABILITIES, &data);
-
-	/*
-	 * If we're doing cache flushes (either "always" or "cond")
-	 * we will do one whenever the guest does a vmlaunch/vmresume.
-	 * If an outer hypervisor is doing the cache flush for us
-	 * (VMENTER_L1D_FLUSH_NESTED_VM), we can safely pass that
-	 * capability to the guest too, and if EPT is disabled we're not
-	 * vulnerable.  Overall, only VMENTER_L1D_FLUSH_NEVER will
-	 * require a nested hypervisor to do a flush of its own.
-	 */
-	if (l1tf_vmx_mitigation != VMENTER_L1D_FLUSH_NEVER)
-		data |= ARCH_CAP_SKIP_VMENTRY_L1DFLUSH;
-
-	return data;
-}
-EXPORT_SYMBOL_GPL(kvm_get_arch_capabilities);
-
 static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
-	case MSR_IA32_ARCH_CAPABILITIES:
-		msr->data = kvm_get_arch_capabilities();
-		break;
 	case MSR_IA32_UCODE_REV:
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
-- 
2.19.1

