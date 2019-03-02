Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D6EC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5FC21473
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 02:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfCBCwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 21:52:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:49778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfCBCwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 21:52:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 18:52:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,430,1544515200"; 
   d="scan'208";a="148572637"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2019 18:52:29 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, kvm@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 17/17] kvm: vmx: Emulate TEST_CTL MSR
Date:   Fri,  1 Mar 2019 18:45:11 -0800
Message-Id: <1551494711-213533-18-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyao Li <xiaoyao.li@linux.intel.com>

A control bit (bit 29) in TEST_CTL MSR 0x33 will be introduced in
future x86 processors. When bit 29 is set, the processor causes #AC
exception for split locked accesses at all CPL.

Please check the latest Intel Software Developer's Manual
for more detailed information on the MSR and the split lock bit.

1. Since the kernel chooses to enable AC split lock by default, which
means if we don't emulate TEST_CTL MSR for guest, guest will run with
this feature enable while does not known it. Thus existing guests with
buggy firmware (like OVMF) and old kernels having the cross cache line
issues will fail the boot due to #AC.

So we should emulate TEST_CTL MSR, and set it zero to disable AC split
lock by default. Whether and when to enable it is left to guest firmware
and guest kernel.

2. Host and guest can enable AC split lock independently, so using
msr autoload to switch it during VM entry/exit.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 35 +++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3e03c6e1e558..c0c5e8621afa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1659,6 +1659,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u32 index;
 
 	switch (msr_info->index) {
+	case MSR_TEST_CTL:
+		if (!msr_info->host_initiated &&
+		    !(vmx->core_capability & CORE_CAP_SPLIT_LOCK_DETECT))
+			return 1;
+		msr_info->data = vmx->msr_test_ctl;
+		break;
 #ifdef CONFIG_X86_64
 	case MSR_FS_BASE:
 		msr_info->data = vmcs_readl(GUEST_FS_BASE);
@@ -1805,6 +1811,14 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u32 index;
 
 	switch (msr_index) {
+	case MSR_TEST_CTL:
+		if (!(vmx->core_capability & CORE_CAP_SPLIT_LOCK_DETECT))
+			return 1;
+
+		if (data & ~TEST_CTL_ENABLE_SPLIT_LOCK_DETECT)
+			return 1;
+		vmx->msr_test_ctl = data;
+		break;
 	case MSR_EFER:
 		ret = kvm_set_msr_common(vcpu, msr_info);
 		break;
@@ -4108,6 +4122,9 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 
 	vmx->arch_capabilities = kvm_get_arch_capabilities();
 
+	/* disable AC split lock by default */
+	vmx->msr_test_ctl = 0;
+
 	vm_exit_controls_init(vmx, vmx_vmexit_ctrl());
 
 	/* 22.2.1, 20.8.1 */
@@ -4145,6 +4162,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	vmx->rmode.vm86_active = 0;
 	vmx->spec_ctrl = 0;
+	vmx->msr_test_ctl = 0;
 
 	vcpu->arch.microcode_version = 0x100000000ULL;
 	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
@@ -6344,6 +6362,21 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
 					msrs[i].host, false);
 }
 
+static void atomic_switch_msr_test_ctl(struct vcpu_vmx *vmx)
+{
+	u64 host_msr_test_ctl;
+
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
+		return;
+
+	rdmsrl(MSR_TEST_CTL, host_msr_test_ctl);
+	if (host_msr_test_ctl == vmx->msr_test_ctl)
+		clear_atomic_switch_msr(vmx, MSR_TEST_CTL);
+	else
+		add_atomic_switch_msr(vmx, MSR_TEST_CTL, vmx->msr_test_ctl,
+				      host_msr_test_ctl, false);
+}
+
 static void vmx_arm_hv_timer(struct vcpu_vmx *vmx, u32 val)
 {
 	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, val);
@@ -6585,6 +6618,8 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
 	atomic_switch_perf_msrs(vmx);
 
+	atomic_switch_msr_test_ctl(vmx);
+
 	vmx_update_hv_timer(vcpu);
 
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index cc22379991f3..e8831609c6c3 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -191,6 +191,7 @@ struct vcpu_vmx {
 	u64		      msr_guest_kernel_gs_base;
 #endif
 
+	u64		      msr_test_ctl;
 	u64		      core_capability;
 	u64		      arch_capabilities;
 	u64		      spec_ctrl;
-- 
2.7.4

