Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E61C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A1C21773
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHPCdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:33:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:24671 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfHPCdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:33:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 19:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="194894481"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 19:33:02 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH 03/15] x86/acrn: Add hypercall for ACRN guest
Date:   Fri, 16 Aug 2019 10:25:44 +0800
Message-Id: <1565922356-4488-4-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ACRN hypervisor is detected, the hypercall is needed so that the
ACRN guest can query/config some settings. For example: it can be used
to query the resources in hypervisor and manage the CPU/memory/device/
interrupt for guest operating system.

On x86 it is implemented with the VMCALL instruction.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/include/asm/acrn.h | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index 857e6244..ab97c3d 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -11,4 +11,58 @@ extern void acrn_hv_vector_handler(struct pt_regs *regs);
 
 extern void acrn_setup_intr_irq(void (*handler)(void));
 extern void acrn_remove_intr_irq(void);
+
+/*
+ * Hypercalls for ACRN guest
+ *
+ * Hypercall number is passed in R8 register.
+ * Up to 2 arguments are passed in RDI, RSI.
+ * Return value will be placed in RAX.
+ */
+static inline long acrn_hypercall0(unsigned long hcall_id)
+{
+	long result;
+
+	/* the hypercall is implemented with the VMCALL instruction.
+	 * volatile qualifier is added to avoid that it is dropped
+	 * because of compiler optimization.
+	 */
+	asm volatile("movq %[hcall_id], %%r8\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : [hcall_id] "g" (hcall_id)
+		     : "r8");
+
+	return result;
+}
+
+static inline long acrn_hypercall1(unsigned long hcall_id,
+				   unsigned long param1)
+{
+	long result;
+
+	asm volatile("movq %[hcall_id], %%r8\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : [hcall_id] "g" (hcall_id), "D" (param1)
+		     : "r8");
+
+	return result;
+}
+
+static inline long acrn_hypercall2(unsigned long hcall_id,
+				   unsigned long param1,
+				   unsigned long param2)
+{
+	long result;
+
+	asm volatile("movq %[hcall_id], %%r8\n\t"
+		     "vmcall\n\t"
+		     : "=a" (result)
+		     : [hcall_id] "g" (hcall_id), "D" (param1), "S" (param2)
+		     : "r8");
+
+	return result;
+}
+
 #endif /* _ASM_X86_ACRN_H */
-- 
2.7.4

