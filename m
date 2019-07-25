Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC80C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5BB22BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbfGYDLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:11:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:24599 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389806AbfGYDLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:11:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 20:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,305,1559545200"; 
   d="scan'208";a="321537769"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2019 20:11:31 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, pbonzini@redhat.com
Cc:     mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v6 8/8] KVM: x86: Add user-space access interface for CET MSRs
Date:   Thu, 25 Jul 2019 11:12:46 +0800
Message-Id: <20190725031246.8296-9-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190725031246.8296-1-weijiang.yang@intel.com>
References: <20190725031246.8296-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There're two different places storing Guest CET states, the states
managed with XSAVES/XRSTORS, as restored/saved
in previous patch, can be read/write directly from/to the MSRs.
For those stored in VMCS fields, they're access via vmcs_read/
vmcs_write.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 123285177c6b..e5eacd01e984 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1774,6 +1774,27 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		else
 			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
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
@@ -2007,6 +2028,28 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		else
 			vmx->pt_desc.guest.addr_a[index / 2] = data;
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
+
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
-- 
2.17.2

