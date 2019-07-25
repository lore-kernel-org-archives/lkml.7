Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81048C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6166722BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbfGYDLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:11:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:24587 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389783AbfGYDL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:11:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 20:11:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,305,1559545200"; 
   d="scan'208";a="321537743"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2019 20:11:24 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, pbonzini@redhat.com
Cc:     mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v6 4/8] KVM: VMX: Pass through CET related MSRs to Guest
Date:   Thu, 25 Jul 2019 11:12:42 +0800
Message-Id: <20190725031246.8296-5-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190725031246.8296-1-weijiang.yang@intel.com>
References: <20190725031246.8296-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CET MSRs pass through Guest directly to enhance performance.
CET runtime control settings are stored in MSR_IA32_{U,S}_CET,
Shadow Stack Pointer(SSP) are stored in MSR_IA32_PL{0,1,2,3}_SSP,
SSP table base address is stored in MSR_IA32_INT_SSP_TAB,
these MSRs are defined in kernel and re-used here.

MSR_IA32_U_CET and MSR_IA32_PL3_SSP are used for user mode protection,
the contents could differ from process to process, therefore,
kernel needs to save/restore them during context switch, it makes
sense to pass through them so that the guest kernel can
use xsaves/xrstors to operate them efficiently. Other MSRs are used
for non-user mode protection. See CET spec for detailed info.

The difference between CET VMCS state fields and xsave components is that,
the former used for CET state storage during VMEnter/VMExit,
whereas the latter used for state retention between Guest task/process
switch.

Co-developed-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ce1d6fe21780..ce5d1e45b7a5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6952,6 +6952,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long *msr_bitmap;
 
 	if (cpu_has_secondary_exec_ctrls()) {
 		vmx_compute_secondary_exec_control(vmx);
@@ -6973,6 +6974,19 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 	if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
 			guest_cpuid_has(vcpu, X86_FEATURE_INTEL_PT))
 		update_intel_pt_cfg(vcpu);
+
+	msr_bitmap = vmx->vmcs01.msr_bitmap;
+
+	if (guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) ||
+	    guest_cpuid_has(vcpu, X86_FEATURE_IBT)) {
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_U_CET, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_S_CET, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL0_SSP, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL1_SSP, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL2_SSP, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL3_SSP, MSR_TYPE_RW);
+	}
 }
 
 static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
-- 
2.17.2

