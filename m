Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED740C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C243120830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfCYIHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:07:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:50930 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfCYIHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:07:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 01:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134474072"
Received: from lxy-server.sh.intel.com ([10.239.48.11])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 01:07:19 -0700
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
Subject: [PATCH v3 2/2] x86/vmx: optimize MSR_MISC_FEATURES_ENABLES switch
Date:   Mon, 25 Mar 2019 16:06:50 +0800
Message-Id: <20190325080650.19896-3-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190325080650.19896-1-xiaoyao.li@linux.intel.com>
References: <20190325080650.19896-1-xiaoyao.li@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM needs to switch MSR_MISC_FEATURES_ENABLES between host and guest in
every pcpu/vcpu context switch. Since WRMSR is expensive, this patch tries
to save cycles by avoiding WRMSR MSR_MISC_FEATURES_ENABLES whenever possible.

If host's value is zero, nothing needs to be done, since guest can use
kvm emulated cpuid faulting.

If host's value is non-zero, it need not clear MSR_MISC_FEATURES_ENABLES
unconditionally. We can use hardware cpuid faulting if guest's
value is equal to host'value, thus avoid WRMSR
MSR_MISC_FEATURES_ENABLES.

Since hardware cpuid faulting takes higher priority than CPUID vm exit,
it should be updated to hardware while guest wrmsr and hardware cpuid
faulting is used for guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 13 ++++++++++---
 arch/x86/kvm/x86.c              | 15 ++++++++++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2c53df4a5a2a..9bcb444b903d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1343,6 +1343,8 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 void kvm_get_cs_db_l_bits(struct kvm_vcpu *vcpu, int *db, int *l);
 int kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
 
+int kvm_supported_msr_misc_features_enables(struct kvm_vcpu *vcpu, u64 data);
+
 int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 65aa947947ba..73bb11f74b36 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1035,10 +1035,10 @@ static void vmx_prepare_guest_misc_features_enables(struct vcpu_vmx *vmx)
 {
 	u64 msrval = this_cpu_read(msr_misc_features_shadow);
 
-	if (!msrval)
+	if (!msrval || msrval == vmx->vcpu.arch.msr_misc_features_enables)
 		return;
 
-	wrmsrl(MSR_MISC_FEATURES_ENABLES, 0ULL);
+	wrmsrl(MSR_MISC_FEATURES_ENABLES, vmx->vcpu.arch.msr_misc_features_enables);
 }
 
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
@@ -1136,7 +1136,7 @@ static void vmx_load_host_misc_features_enables(struct vcpu_vmx *vmx)
 {
 	u64 msrval = this_cpu_read(msr_misc_features_shadow);
 
-	if (!msrval)
+	if (!msrval || msrval == vmx->vcpu.arch.msr_misc_features_enables)
 		return;
 
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
@@ -2043,6 +2043,13 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		else
 			vmx->pt_desc.guest.addr_a[index / 2] = data;
 		break;
+	case MSR_MISC_FEATURES_ENABLES:
+		if (!kvm_supported_msr_misc_features_enables(vcpu, data))
+			return 1;
+		if (this_cpu_read(msr_misc_features_shadow) && vmx->loaded_cpu_state)
+			wrmsrl(MSR_MISC_FEATURES_ENABLES, data);
+		vcpu->arch.msr_misc_features_enables = data;
+		break;
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ad1df965574e..d2af90422a51 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2449,6 +2449,17 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		&vcpu->arch.st.steal, sizeof(struct kvm_steal_time));
 }
 
+int kvm_supported_msr_misc_features_enables(struct kvm_vcpu *vcpu, u64 data)
+{
+	if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
+	    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
+	     !supports_cpuid_fault(vcpu)))
+		return 0;
+	else
+		return 1;
+}
+EXPORT_SYMBOL_GPL(kvm_supported_msr_misc_features_enables);
+
 int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	bool pr = false;
@@ -2669,9 +2680,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vcpu->arch.msr_platform_info = data;
 		break;
 	case MSR_MISC_FEATURES_ENABLES:
-		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
-		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-		     !supports_cpuid_fault(vcpu)))
+		if (!kvm_supported_msr_misc_features_enables(vcpu, data))
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
-- 
2.19.1

