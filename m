Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409FEC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18918218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfDXA5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:57:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:21810 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfDXA44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:56:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 17:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; 
   d="scan'208";a="340195457"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2019 17:56:55 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de,
        Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
Date:   Wed, 24 Apr 2019 08:54:20 +0800
Message-Id: <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ACRN hypervisor is detected, the hypercall is needed so that the
ACRN guest can query/config some settings. For example: it can be used
to query the resources in hypervisor and manage the CPU/memory/device/
interrupt for the guest operating system.

So add the hypercall so that ACRN guest can communicate with the
low-level ACRN hypervisor. It is implemented with the VMCALL instruction.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
V1->V2: Refine the comments for the function of acrn_hypercall0/1/2
v2->v3: Use the "vmcall" mnemonic to replace hard-code byte definition
v4->v5: Use _ASM_X86_ACRN_HYPERCALL_H instead of _ASM_X86_ACRNHYPERCALL_H to
align the header file of acrn_hypercall.h
        Use the "VMCALL" mnemonic in comment/commit log.
        Uppercase r8/rdi/rsi/rax for hypercall parameter registers in comment.
---
 arch/x86/include/asm/acrn_hypercall.h | 82 +++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 arch/x86/include/asm/acrn_hypercall.h

diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
new file mode 100644
index 0000000..3594436
--- /dev/null
+++ b/arch/x86/include/asm/acrn_hypercall.h
@@ -0,0 +1,82 @@
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
+	register unsigned long r8 asm("r8") = hcall_id;
+	register long result asm("rax");
+
+	/* the hypercall is implemented with the VMCALL instruction.
+	 * asm indicates that inline assembler instruction is used.
+	 * volatile qualifier is added to avoid that it is dropped
+	 * because of compiler optimization.
+	 */
+	asm volatile("vmcall"
+			: "=r"(result)
+			: "r"(r8));
+
+	return result;
+}
+
+static inline long acrn_hypercall1(unsigned long hcall_id,
+				   unsigned long param1)
+{
+	register unsigned long r8 asm("r8") = hcall_id;
+	register long result asm("rax");
+
+	asm volatile("vmcall"
+			: "=r"(result)
+			: "D"(param1), "r"(r8));
+
+	return result;
+}
+
+static inline long acrn_hypercall2(unsigned long hcall_id,
+				   unsigned long param1,
+				   unsigned long param2)
+{
+	register unsigned long r8 asm("r8") = hcall_id;
+	register long result asm("rax");
+
+	asm volatile("vmcall"
+			: "=r"(result)
+			: "D"(param1), "S"(param2), "r"(r8));
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

