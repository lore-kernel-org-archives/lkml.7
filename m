Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A5520854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfCSIM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:12:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:44031 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbfCSIMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:12:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 01:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="308418083"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2019 01:12:19 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>
Subject: [RFC PATCH v4 8/8] KVM:x86: Add user-space read/write interface for CET MSRs
Date:   Mon, 18 Mar 2019 23:03:51 +0800
Message-Id: <20190318150351.15550-9-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318150351.15550-1-weijiang.yang@intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VMExit occurs, the Guest CET MSRs are stored in two different
places, U_CET/PL0_SSP/PL1_SSP/PL2_SSP/PL3_SSP are stored in fpu
xsave area, they are operated by XSAVES/XRSTORS, so before access
these MSRs, kvm_load_guest_fpu is required to restore them to Host MSRs.
After finish operation, need to restore Host MSRs by kvm_put_guest_fpu,
these two functions are call in __msr_io(). S_CET and INTR_SSP_TABLE
are stored in VMCS fields, so they can be access via vmcs_read/vmcs_write
directly.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/include/asm/msr-index.h |  2 ++
 arch/x86/kvm/vmx.c               | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 298721ff00f4..cc94ab14a946 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -782,6 +782,8 @@
 #define MSR_IA32_U_CET		0x6a0 /* user mode cet setting */
 #define MSR_IA32_S_CET		0x6a2 /* kernel mode cet setting */
 #define MSR_IA32_PL0_SSP	0x6a4 /* kernel shstk pointer */
+#define MSR_IA32_PL1_SSP	0x6a5 /* ring 1 shstk pointer */
+#define MSR_IA32_PL2_SSP	0x6a6 /* ring 2 shstk pointer */
 #define MSR_IA32_PL3_SSP	0x6a7 /* user shstk pointer */
 #define MSR_IA32_INT_SSP_TAB	0x6a8 /* exception shstk table */
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 816e11a66557..5923b89fe120 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4153,6 +4153,27 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		msr_info->data = vcpu->arch.ia32_xss;
 		break;
+	case MSR_IA32_S_CET:
+		msr_info->data = vmcs_readl(GUEST_S_CET);
+		break;
+	case MSR_IA32_U_CET:
+		rdmsrl(MSR_IA32_U_CET, msr_info->data);
+		break;
+	case MSR_IA32_INT_SSP_TAB:
+		msr_info->data = vmcs_readl(GUEST_INTR_SSP_TABLE);
+		break;
+	case MSR_IA32_PL0_SSP:
+		rdmsrl(MSR_IA32_PL0_SSP, msr_info->data);
+		break;
+	case MSR_IA32_PL1_SSP:
+		rdmsrl(MSR_IA32_PL1_SSP, msr_info->data);
+		break;
+	case MSR_IA32_PL2_SSP:
+		rdmsrl(MSR_IA32_PL2_SSP, msr_info->data);
+		break;
+	case MSR_IA32_PL3_SSP:
+		rdmsrl(MSR_IA32_PL3_SSP, msr_info->data);
+		break;
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
@@ -4337,6 +4358,27 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		else
 			clear_atomic_switch_msr(vmx, MSR_IA32_XSS);
 		break;
+	case MSR_IA32_S_CET:
+		vmcs_writel(GUEST_S_CET, data);
+		break;
+	case MSR_IA32_U_CET:
+		wrmsrl(MSR_IA32_U_CET, data);
+		break;
+	case MSR_IA32_INT_SSP_TAB:
+		vmcs_writel(GUEST_INTR_SSP_TABLE, data);
+		break;
+	case MSR_IA32_PL0_SSP:
+		wrmsrl(MSR_IA32_PL0_SSP, data);
+		break;
+	case MSR_IA32_PL1_SSP:
+		wrmsrl(MSR_IA32_PL1_SSP, data);
+		break;
+	case MSR_IA32_PL2_SSP:
+		wrmsrl(MSR_IA32_PL2_SSP, data);
+		break;
+	case MSR_IA32_PL3_SSP:
+		wrmsrl(MSR_IA32_PL3_SSP, data);
+		break;
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
-- 
2.17.1

