Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCC220651
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfC2Ny6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:54:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:44836 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbfC2Ny4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:54:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 06:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="138342106"
Received: from lxy-server.sh.intel.com ([10.239.48.11])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2019 06:54:53 -0700
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        chao.gao@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v4 2/2] x86/vmx: optimize MSR_MISC_FEATURES_ENABLES switch
Date:   Fri, 29 Mar 2019 21:54:22 +0800
Message-Id: <20190329135422.15046-3-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190329135422.15046-1-xiaoyao.li@linux.intel.com>
References: <20190329135422.15046-1-xiaoyao.li@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM needs to switch MSR_MISC_FEATURES_ENABLES between host and guest in
every pcpu/vcpu context switch. Since WRMSR is expensive, this patch tries
to save cycles by avoiding WRMSR MSR_MISC_FEATURES_ENABLES whenever possible.

If host's value is zero, nothing needs to do, since guest can use kvm
emulated cpuid faulting.

If host's value is non-zero, it need not clear MSR_MISC_FEATURES_ENABLES
unconditionally. We can use hardware cpuid faulting if guest's
value is equal to host'value, thus avoid WRMSR
MSR_MISC_FEATURES_ENABLES.

Since hardware cpuid faulting takes higher priority than CPUID vm exit,
it should be updated to hardware while guest wrmsr and hardware cpuid
faulting is used for guest.

Note that MSR_MISC_FEATURES_ENABLES only exists in Intel CPU, only
applying this optimization to vmx.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 15 ++++++++++++---
 arch/x86/kvm/x86.c              | 11 ++++++++---
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2c53df4a5a2a..105691e069d9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1343,6 +1343,8 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 void kvm_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
 int kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
 
+bool kvm_misc_features_enables_msr_invalid(struct kvm_vcpu *vcpu, u64 data);
+
 int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cb0f63879a25..07a598663ace 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1041,6 +1041,7 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	unsigned long fs_base, gs_base;
 	u16 fs_sel, gs_sel;
 	int i;
+	u64 msrval;
 
 	vmx->req_immediate_exit = false;
 
@@ -1064,8 +1065,9 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	vmx->loaded_cpu_state = vmx->loaded_vmcs;
 	host_state = &vmx->loaded_cpu_state->host_state;
 
-	if (this_cpu_read(msr_misc_features_shadow))
-		wrmsrl(MSR_MISC_FEATURES_ENABLES, 0ULL);
+	msrval = this_cpu_read(msr_misc_features_shadow);
+	if (msrval && msrval != vcpu->arch.msr_misc_features_enables)
+		wrmsrl(MSR_MISC_FEATURES_ENABLES, vcpu->arch.msr_misc_features_enables);
 
 	/*
 	 * Set host fs and gs selectors.  Unfortunately, 22.2.3 does not
@@ -1138,7 +1140,7 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 	vmx->loaded_cpu_state = NULL;
 
 	msrval = this_cpu_read(msr_misc_features_shadow);
-	if (msrval)
+	if (msrval && msrval != vmx->vcpu.arch.msr_misc_features_enables)
 		wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
 
 #ifdef CONFIG_X86_64
@@ -2027,6 +2029,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		else
 			vmx->pt_desc.guest.addr_a[index / 2] = data;
 		break;
+	case MSR_MISC_FEATURES_ENABLES:
+		if (kvm_misc_features_enables_msr_invalid(vcpu, data))
+			return 1;
+		if (vmx->loaded_cpu_state && this_cpu_read(msr_misc_features_shadow))
+			wrmsrl(MSR_MISC_FEATURES_ENABLES, data);
+		vcpu->arch.msr_misc_features_enables = data;
+		break;
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ad1df965574e..749aa4c9437a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2449,6 +2449,13 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
 }
 
+bool kvm_misc_features_enables_msr_invalid(struct kvm_vcpu *vcpu, u64 data)
+{
+	return (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT) ||
+	       (data && !supports_cpuid_fault(vcpu));
+}
+EXPORT_SYMBOL_GPL(kvm_misc_features_enables_msr_invalid);
+
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	bool pr = false;
@@ -2669,9 +2676,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.msr_platform_info = data;
 		break;
 	case MSR_MISC_FEATURES_ENABLES:
-		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
-		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-		     !supports_cpuid_fault(vcpu)))
+		if (kvm_misc_features_enables_msr_invalid(vcpu, data))
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
-- 
2.19.1

