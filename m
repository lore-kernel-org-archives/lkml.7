Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B5520828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 04:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfCZEzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 00:55:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:55875 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbfCZEzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 00:55:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 21:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="143826864"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2019 21:55:05 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH v2 3/3] arch/x86/acrn: add hypercall for acrn_guest
Date:   Tue, 26 Mar 2019 12:53:43 +0800
Message-Id: <1553576023-6434-4-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553576023-6434-1-git-send-email-yakui.zhao@intel.com>
References: <1553576023-6434-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acrn_hypervisor is detected, the hypercall is needed so that the
acrn guest can query/config some settings. For example: it can be used
to query the resources in hypervisor and manage the CPU/memory/device/
interrupt for Guest system.

So the hypercall is added so that the kernel can communicate with the
low-level acrn-hypervisor. On x86 it is implemented by using vmacll when
the acrn hypervisor is enabled.

V1->V2: Refine the comments for the function of acrn_hypercall0/1/2

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/include/asm/acrn_hypercall.h | 84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 arch/x86/include/asm/acrn_hypercall.h

diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
new file mode 100644
index 0000000..3262935
--- /dev/null
+++ b/arch/x86/include/asm/acrn_hypercall.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * acrn_hypercall.h : acrn hypervisor call API
+ */
+
+#ifndef __ACRN_HYPERCALL_H__
+#define __ACRN_HYPERCALL_H__
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
+
+	register long result asm("rax");
+	register unsigned long r8 asm("r8") = hcall_id;
+
+	asm volatile(".byte 0x0F,0x01,0xC1\n"
+			: "=r"(result)
+			:  "r"(r8));
+
+	return result;
+}
+
+static inline long acrn_hypercall1(unsigned long hcall_id,
+				   unsigned long param1)
+{
+
+	register long result asm("rax");
+	register unsigned long r8 asm("r8") = hcall_id;
+
+	asm volatile(".byte 0x0F,0x01,0xC1\n"
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
+
+	register long result asm("rax");
+	register unsigned long r8 asm("r8") = hcall_id;
+
+	asm volatile(".byte 0x0F,0x01,0xC1\n"
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
+#endif
+
+#endif /* __ACRN_HYPERCALL_H__ */
-- 
2.7.4

