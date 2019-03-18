Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F00EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE985213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfCSIMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:12:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:44015 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbfCSIMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:12:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 01:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="308418017"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2019 01:12:06 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH v4 2/8] KVM:CPUID: Add CET CPUID support for Guest
Date:   Mon, 18 Mar 2019 23:03:45 +0800
Message-Id: <20190318150351.15550-3-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318150351.15550-1-weijiang.yang@intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CET SHSTK and IBT capability are reported via
CPUID.(EAX=7, ECX=0):ECX[bit 7] and EDX[bit 20] respectively.
CR4.CET[bit 23] is CET master enable bit, it controls CET feature
enabling. CET user mode and supervisor mode xsaves component size
is reported via CPUID.(EAX=0xD, ECX=1):ECX[bit 11] and ECX[bit 12]
respectively.

Note: Although SHSTK or IBT can be enabled independently,
      both of them are controlled by CR4.CET.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  4 +++-
 arch/x86/kvm/cpuid.c            | 41 ++++++++++++++++++++++-----------
 arch/x86/kvm/vmx.c              |  6 +++++
 arch/x86/kvm/x86.h              |  4 ++++
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55e51ff7e421..fc038bf1924a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -90,7 +90,8 @@
 			  | X86_CR4_PGE | X86_CR4_PCE | X86_CR4_OSFXSR | X86_CR4_PCIDE \
 			  | X86_CR4_OSXSAVE | X86_CR4_SMEP | X86_CR4_FSGSBASE \
 			  | X86_CR4_OSXMMEXCPT | X86_CR4_LA57 | X86_CR4_VMXE \
-			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP))
+			  | X86_CR4_SMAP | X86_CR4_PKE | X86_CR4_UMIP \
+			  | X86_CR4_CET))
 
 #define CR8_RESERVED_BITS (~(unsigned long)X86_CR8_TPR)
 
@@ -1185,6 +1186,7 @@ struct kvm_x86_ops {
 
 	int (*nested_enable_evmcs)(struct kvm_vcpu *vcpu,
 				   uint16_t *vmcs_version);
+	u64 (*vmx_supported_xss)(void);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7bcfa61375c0..53abd6019c68 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -65,6 +65,11 @@ u64 kvm_supported_xcr0(void)
 	return xcr0;
 }
 
+u64 kvm_supported_xss(void)
+{
+	return KVM_SUPPORTED_XSS & kvm_x86_ops->vmx_supported_xss();
+}
+
 #define F(x) bit(X86_FEATURE_##x)
 
 /* For scattered features from cpufeatures.h; we currently expose none */
@@ -406,12 +411,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 		F(AVX512VBMI) | F(LA57) | F(PKU) | 0 /*OSPKE*/ |
 		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
 		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
-		F(CLDEMOTE);
+		F(CLDEMOTE) | F(SHSTK);
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
 		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
-		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
+		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(IBT);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
@@ -564,14 +569,16 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	}
 	case 0xd: {
 		int idx, i;
-		u64 supported = kvm_supported_xcr0();
+		u64 u_supported = kvm_supported_xcr0();
+		u64 s_supported = kvm_supported_xss();
+		u64 supported;
 
-		entry->eax &= supported;
-		entry->ebx = xstate_required_size(supported, false);
+		entry->eax &= u_supported;
+		entry->ebx = xstate_required_size(u_supported, false);
 		entry->ecx = entry->ebx;
-		entry->edx &= supported >> 32;
+		entry->edx &= u_supported >> 32;
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-		if (!supported)
+		if (!u_supported && !s_supported)
 			break;
 
 		for (idx = 1, i = 1; idx < 64; ++idx) {
@@ -583,19 +590,25 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			if (idx == 1) {
 				entry[i].eax &= kvm_cpuid_D_1_eax_x86_features;
 				cpuid_mask(&entry[i].eax, CPUID_D_1_EAX);
+				supported = u_supported | s_supported;
 				entry[i].ebx = 0;
-				if (entry[i].eax & (F(XSAVES)|F(XSAVEC)))
+				entry[i].edx = 0;
+				entry[i].ecx &= s_supported;
+				if (entry[i].eax & (F(XSAVES) | F(XSAVEC))) {
 					entry[i].ebx =
-						xstate_required_size(supported,
-								     true);
+					xstate_required_size(supported,
+							     true);
+				}
 			} else {
+				supported = (entry[i].ecx & 1) ? s_supported :
+								 u_supported;
 				if (entry[i].eax == 0 || !(supported & mask))
 					continue;
-				if (WARN_ON_ONCE(entry[i].ecx & 1))
-					continue;
+				entry[i].ecx &= 1;
+				entry[i].edx = 0;
+				if (entry[i].ecx)
+					entry[i].ebx = 0;
 			}
-			entry[i].ecx = 0;
-			entry[i].edx = 0;
 			entry[i].flags |=
 			       KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
 			++*nent;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 7bbb8b26e901..53cef5a3db96 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4169,6 +4169,11 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
+static __always_inline u64 vmx_supported_xss(void)
+{
+	return host_xss;
+}
+
 static void vmx_leave_nested(struct kvm_vcpu *vcpu);
 
 /*
@@ -15107,6 +15112,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 	.enable_smi_window = enable_smi_window,
 
 	.nested_enable_evmcs = nested_enable_evmcs,
+	.vmx_supported_xss = vmx_supported_xss,
 };
 
 static void vmx_cleanup_l1d_flush(void)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 224cd0a47568..c61da41c3c5c 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -283,6 +283,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, unsigned long cr2,
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
 				| XFEATURE_MASK_PKRU)
+
+#define KVM_SUPPORTED_XSS	(XFEATURE_MASK_SHSTK_USER \
+				| XFEATURE_MASK_SHSTK_KERNEL)
+
 extern u64 host_xcr0;
 
 extern u64 kvm_supported_xcr0(void);
-- 
2.17.1

