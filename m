Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8879C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A3A20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfCEDYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:24:10 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:31392 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726852AbfCEDYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:24:07 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x253Mmx5044059;
        Tue, 5 Mar 2019 11:22:48 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 5 Mar 2019
 11:23:48 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <ebiederm@xmission.com>, <jimw@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH v2 1/3] riscv: support trap-based WARN()
Date:   Tue, 5 Mar 2019 11:23:33 +0800
Message-ID: <1551756215-22299-2-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551756215-22299-1-git-send-email-vincentc@andestech.com>
References: <1551756215-22299-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x253Mmx5044059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WARN() related function will trigger a debug exception. This can help
developers to analyze the cause of WARN() because if the debugger is
connected, the control flow will be transferred to debugging
environment.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/include/asm/bug.h |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index bfc7f09..4d906d8 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -38,38 +38,46 @@
 #define __BUG_ENTRY			\
 	__BUG_ENTRY_ADDR "\n\t"		\
 	__BUG_ENTRY_FILE "\n\t"		\
-	RISCV_SHORT " %1"
+	RISCV_SHORT " %1\n\t"		\
+	RISCV_SHORT " %2"
 #else
 #define __BUG_ENTRY			\
-	__BUG_ENTRY_ADDR
+	__BUG_ENTRY_ADDR "\n\t"		\
+	RISCV_SHORT " %2"
 #endif
 
-#define BUG()							\
+#define __BUG_FLAGS(flags)					\
 do {								\
 	__asm__ __volatile__ (					\
 		"1:\n\t"					\
 			"ebreak\n"				\
-			".pushsection __bug_table,\"a\"\n\t"	\
+			".pushsection __bug_table,\"aw\"\n\t"	\
 		"2:\n\t"					\
 			__BUG_ENTRY "\n\t"			\
-			".org 2b + %2\n\t"			\
+			".org 2b + %3\n\t"                      \
 			".popsection"				\
 		:						\
 		: "i" (__FILE__), "i" (__LINE__),		\
-		  "i" (sizeof(struct bug_entry)));		\
-	unreachable();						\
+		  "i" (flags),					\
+		  "i" (sizeof(struct bug_entry)));              \
 } while (0)
+
 #endif /* !__ASSEMBLY__ */
 #else /* CONFIG_GENERIC_BUG */
 #ifndef __ASSEMBLY__
-#define BUG()							\
-do {								\
+#define __BUG_FLAGS(flags) do {					\
 	__asm__ __volatile__ ("ebreak\n");			\
-	unreachable();						\
 } while (0)
 #endif /* !__ASSEMBLY__ */
 #endif /* CONFIG_GENERIC_BUG */
 
+#define BUG() do {						\
+	__BUG_FLAGS(0);						\
+	unreachable();						\
+} while (0)
+
+#define __WARN_FLAGS(flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
+
 #define HAVE_ARCH_BUG
 
 #include <asm-generic/bug.h>
-- 
1.7.1

