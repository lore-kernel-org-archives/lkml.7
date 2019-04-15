Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921BBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 02:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B85821473
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 02:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDOCDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:03:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:30382 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfDOCDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 22:03:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2019 19:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,351,1549958400"; 
   d="scan'208";a="149422513"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Apr 2019 19:03:07 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, tglx@linutronix.de,
        Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH v4 4/4] x86/acrn: Add hypercall for ACRN guest
Date:   Mon, 15 Apr 2019 10:00:57 +0800
Message-Id: <1555293657-32233-5-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555293657-32233-1-git-send-email-yakui.zhao@intel.com>
References: <1555293657-32233-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ACRN hypervisor is detected, the hypercall is needed so that the
ACRN guest can query/config some settings. For example: it can be used
to query the resources in hypervisor and manage the CPU/memory/device/
interrupt for guest operating system.

Add the hypercall so that the kernel can communicate with the low-level
ACRN hypervisor. It is implemented with vmacll instruction.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
V1->V2: Refine the comments for the function of acrn_hypercall0/1/2
v2->v3: Use the "vmcall" mnemonic to replace hard-code byte definition
v3->v4: refine the commit log(minor change)
---
 arch/x86/include/asm/acrn_hypercall.h | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 arch/x86/include/asm/acrn_hypercall.h

diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
new file mode 100644
index 0000000..30e256e
--- /dev/null
+++ b/arch/x86/include/asm/acrn_hypercall.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_ACRNHYPERCALL_H
+#define _ASM_X86_ACRNHYPERCALL_H
+
+#include <linux/errno.h>
+
+#ifdef CONFIG_ACRN_GUEST
+
+/*
+ * Hypercalls for ACRN Guest
+ *
+ * Hypercall number is passed in r8 register.
+ * Return value will be placed in rax.
+ * Up to 2 arguments are passed in rdi, rsi.
+ */
+
+static inline long acrn_hypercall0(unsigned long hcall_id)
+{
+	register unsigned long r8 asm("r8") = hcall_id;
+	register long result asm("rax");
+
+	/* the hypercall is implemented with vmcall instruction.
+	 * asm volatile is used to avoid that it is dropped because of
+	 * compiler optimization.
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
+#endif /* _ASM_X86_ACRNHYPERCALL_H */
-- 
2.7.4

