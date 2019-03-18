Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746B120850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCSIMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:12:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:44015 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727625AbfCSIMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:12:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 01:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="308418055"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2019 01:12:12 -0700
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH v4 5/8] KVM:VMX: Load Guest CET via VMCS when CET is enabled in Guest
Date:   Mon, 18 Mar 2019 23:03:48 +0800
Message-Id: <20190318150351.15550-6-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318150351.15550-1-weijiang.yang@intel.com>
References: <20190318150351.15550-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Load Guest CET state" bit controls whether guest CET states
will be loaded at Guest entry. Before doing that, KVM needs
to check if CPU CET feature is available.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/vmx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 28b8ac027bd7..246467c12930 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -55,6 +55,7 @@
 #include <asm/mmu_context.h>
 #include <asm/spec-ctrl.h>
 #include <asm/mshyperv.h>
+#include <asm/cet.h>
 
 #include "trace.h"
 #include "pmu.h"
@@ -5414,6 +5415,23 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	}
 
+	/*
+	 * To enable Guest CET, check whether CPU CET feature is
+	 * available, if it's there, set Guest CET state loading bit
+	 * per CR4.CET status, otherwise, return a fault to Guest.
+	 */
+	if (guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) ||
+	    guest_cpuid_has(vcpu, X86_FEATURE_IBT)) {
+		if (cr4 & X86_CR4_CET)
+			vmcs_set_bits(VM_ENTRY_CONTROLS,
+				      VM_ENTRY_LOAD_GUEST_CET_STATE);
+		else
+			vmcs_clear_bits(VM_ENTRY_CONTROLS,
+					VM_ENTRY_LOAD_GUEST_CET_STATE);
+	} else if (cr4 & X86_CR4_CET) {
+		return 1;
+	}
+
 	if (to_vmx(vcpu)->nested.vmxon && !nested_cr4_valid(vcpu, cr4))
 		return 1;
 
-- 
2.17.1

