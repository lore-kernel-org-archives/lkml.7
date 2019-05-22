Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47305C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2605920863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfEVHCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:02:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:31984 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfEVHCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:02:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 00:02:06 -0700
X-ExtLoop1: 1
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 22 May 2019 00:02:04 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, sean.j.christopherson@intel.com,
        mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        yu-cheng.yu@intel.com
Cc:     weijiang.yang@intel.com
Subject: [PATCH v5 7/8] KVM: x86: Load Guest fpu state when accessing MSRs managed by XSAVES
Date:   Wed, 22 May 2019 15:01:00 +0800
Message-Id: <20190522070101.7636-8-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190522070101.7636-1-weijiang.yang@intel.com>
References: <20190522070101.7636-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

A handful of CET MSRs are not context switched through "traditional"
methods, e.g. VMCS or manual switching, but rather are passed through
to the guest and are saved and restored by XSAVES/XRSTORS, i.e. the
guest's FPU state.

Load the guest's FPU state if userspace is accessing MSRs whose values
are managed by XSAVES so that the MSR helper, e.g. vmx_{get,set}_msr(),
can simply do {RD,WR}MSR to access the guest's value.

Note that guest_cpuid_has() is not queried as host userspace is allowed
to access MSRs that have not been exposed to the guest, e.g. it might do
KVM_SET_MSRS prior to KVM_SET_CPUID2.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/x86.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c3fb4f6b678d..8f1bc65495a9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -105,6 +105,8 @@ static void enter_smm(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
+static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
+static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
 
 struct kvm_x86_ops *kvm_x86_ops __read_mostly;
 EXPORT_SYMBOL_GPL(kvm_x86_ops);
@@ -2901,6 +2903,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 }
 EXPORT_SYMBOL_GPL(kvm_get_msr_common);
 
+static bool is_xsaves_msr(u32 index)
+{
+	return index == MSR_IA32_U_CET ||
+	       (index >= MSR_IA32_PL0_SSP && index <= MSR_IA32_PL3_SSP);
+}
+
 /*
  * Read or write a bunch of msrs. All parameters are kernel addresses.
  *
@@ -2911,11 +2919,30 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
 		    int (*do_msr)(struct kvm_vcpu *vcpu,
 				  unsigned index, u64 *data))
 {
+	bool fpu_loaded = false;
 	int i;
+	u64 cet_bits = XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL;
+	u64 host_xss = 0;
+
+	for (i = 0; i < msrs->nmsrs; ++i) {
+		if (!fpu_loaded && is_xsaves_msr(entries[i].index)) {
+			if (!kvm_x86_ops->xsaves_supported() ||
+			    !kvm_x86_ops->supported_xss())
+				continue;
+
+			host_xss = kvm_x86_ops->supported_xss();
 
-	for (i = 0; i < msrs->nmsrs; ++i)
+			if ((host_xss & cet_bits) != cet_bits)
+				continue;
+
+			kvm_load_guest_fpu(vcpu);
+			fpu_loaded = true;
+		}
 		if (do_msr(vcpu, entries[i].index, &entries[i].data))
 			break;
+	}
+	if (fpu_loaded)
+		kvm_put_guest_fpu(vcpu);
 
 	return i;
 }
-- 
2.17.2

