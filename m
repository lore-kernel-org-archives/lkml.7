Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA120C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B166820661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfCGCE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:04:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:40332 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbfCGCEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:04:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 18:04:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,450,1544515200"; 
   d="scan'208";a="132216934"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2019 18:04:51 -0800
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH 3/3] arch/x86/acrn: add hypercall for acrn_hypervisor
Date:   Thu,  7 Mar 2019 10:04:11 +0800
Message-Id: <1551924251-19466-4-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
References: <1551924251-19466-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acrn_hypervisor is detected, the other module may communicate with
the hypervisor to query/config some settings. For example: it can be used
to query the resources in hypervisor and manage the CPU/memory/device/
interrupt for Guest system.

So the hypercall is added so that the kernel can communicate with the
low-level acrn-hypervisor. On x86 it is implemented by using vmacll when
the acrn hypervisor is enabled.

Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 arch/x86/include/asm/acrn_hypercall.h | 85 +++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 arch/x86/include/asm/acrn_hypercall.h

diff --git a/arch/x86/include/asm/acrn_hypercall.h b/arch/x86/include/asm/acrn_hypercall.h
new file mode 100644
index 0000000..7ffa759
--- /dev/null
+++ b/arch/x86/include/asm/acrn_hypercall.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * acrn_hypercall.h : acrn hypervisor call API
+ */
+
+#ifndef __ACRN_HYPERCALL_H__
+#define __ACRN_HYPERCALL_H__
+
+#include <linux/errno.h>
+
+#ifdef CONFIG_ACRN
+
+static inline long acrn_hypercall0(unsigned long hcall_id)
+{
+
+	/* x86-64 System V ABI register usage */
+	register signed long    result asm("rax");
+	register unsigned long  r8 asm("r8")  = hcall_id;
+
+	/* Execute vmcall */
+	asm volatile(".byte 0x0F,0x01,0xC1\n"
+			: "=r"(result)
+			:  "r"(r8));
+
+	/* Return result to caller */
+	return result;
+}
+
+static inline long acrn_hypercall1(unsigned long hcall_id,
+				   unsigned long param1)
+{
+
+	/* x86-64 System V ABI register usage */
+	register signed long    result asm("rax");
+	register unsigned long  r8 asm("r8")  = hcall_id;
+
+	/* Execute vmcall */
+	asm volatile(".byte 0x0F,0x01,0xC1\n"
+			: "=r"(result)
+			: "D"(param1), "r"(r8));
+
+	/* Return result to caller */
+	return result;
+}
+
+static inline long acrn_hypercall2(unsigned long hcall_id,
+				   unsigned long param1,
+				   unsigned long param2)
+{
+
+	/* x86-64 System V ABI register usage */
+	register signed long    result asm("rax");
+	register unsigned long  r8 asm("r8")  = hcall_id;
+
+	/* Execute vmcall */
+	asm volatile(".byte 0x0F,0x01,0xC1\n"
+			: "=r"(result)
+			: "D"(param1), "S"(param2), "r"(r8));
+
+	/* Return result to caller */
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

