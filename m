Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FC7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890B62080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 03:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfD3Ds2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 23:48:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:54863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbfD3DsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:48:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 20:48:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,412,1549958400"; 
   d="scan'208";a="138598254"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2019 20:48:22 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de,
        Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [PATCH v6 4/4] x86/acrn: Add hypercall for ACRN guest
Date:   Tue, 30 Apr 2019 11:45:26 +0800
Message-Id: <1556595926-17910-5-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
References: <1556595926-17910-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ACRN hypervisor is detected, the hypercall is needed so that the
ACRN guest can query/config some settings. For example: it can be used
to query the resources in hypervisor and manage the CPU/memory/device/
interrupt for guest operating system.

Add the hypercall so that the ACRN guest can communicate with the
low-level ACRN hypervisor. On x86 it is implemented with the VMCALL
instruction.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
V1->V2: Refine the comments for the function of acrn_hypercall0/1/2
v2->v3: Use the "vmcall" mnemonic to replace hard-code byte definition
v4->v5: Use _ASM_X86_ACRN_HYPERCALL_H instead of _ASM_X86_ACRNHYPERCALL_H.
        Use the "VMCALL" mnemonic in comment/commit log.
        Uppercase r8/rdi/rsi/rax for hypercall parameter register in comment.
v5->v6: Remove explicit local register variable for inline assembly
---
 arch/x86/include/asm/acrn_hypercall.h | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 arch/x86/include/asm/acrn_hypercall.h

diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
new file mode 100644
index 0000000..5cb438e
--- /dev/null
+++ b/arch/x86/include/asm/acrn_hypercall.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_ACRN_HYPERCALL_H
+#define _ASM_X86_ACRN_HYPERCALL_H
+
+#include <linux/errno.h>
+
+#ifdef CONFIG_ACRN_GUEST
+
+/*
+ * Hypercalls for ACRN guest
+ *
+ * Hypercall number is passed in R8 register.
+ * Up to 2 arguments are passed in RDI, RSI.
+ * Return value will be placed in RAX.
+ */
+
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
+#else
+
+static inline long acrn_hypercall0(unsigned long hcall_id)
+{
+	return -ENOTSUPP;
+}
+
+static inline long acrn_hypercall1(unsigned long hcall_id,
+				   unsigned long param1)
+{
+	return -ENOTSUPP;
+}
+
+static inline long acrn_hypercall2(unsigned long hcall_id,
+				   unsigned long param1,
+				   unsigned long param2)
+{
+	return -ENOTSUPP;
+}
+#endif /* CONFIG_ACRN_GUEST */
+#endif /* _ASM_X86_ACRN_HYPERCALL_H */
-- 
2.7.4

