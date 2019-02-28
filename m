Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A0AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1182F21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbfB1K5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:57:52 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:56692 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbfB1K5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:57:51 -0500
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id x1SAVeLV086903
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 18:31:40 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x1SAVDs7086841;
        Thu, 28 Feb 2019 18:31:13 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 28 Feb 2019
 18:31:47 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <ebiederm@xmission.com>, <jimw@sifive.com>, <arnd@arndb.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH 3/3] riscv: Make WARN() related functions able to trigger a trap exception
Date:   Thu, 28 Feb 2019 18:31:31 +0800
Message-ID: <1551349891-22683-4-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551349891-22683-1-git-send-email-vincentc@andestech.com>
References: <1551349891-22683-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x1SAVDs7086841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can help developers to analyze the cause of WARN() because the
control will be transferred to debugging environment if the debugger is
connected.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/include/asm/bug.h |   27 ++++++++++++++++++---------
 arch/riscv/kernel/traps.c    |   19 ++++++++++++++++---
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1cab7f4..b2aa88f 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -43,38 +43,47 @@
 #define __BUG_ENTRY			\
 	__BUG_ENTRY_ADDR "\n\t"		\
 	__BUG_ENTRY_FILE "\n\t"		\
-	RISCV_SHORT " %1"
+	RISCV_SHORT " %1  \n\t"		\
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
+#define __BUG_FLAGS(flags)					\
 do {								\
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
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index dee0e5e..023208b 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -118,6 +118,17 @@ asmlinkage void name(struct pt_regs *regs)				\
 DO_ERROR_INFO(do_trap_ecall_m,
 	SIGILL, ILL_ILLTRP, "environment call from M-mode");
 
+#ifdef CONFIG_GENERIC_BUG
+static inline unsigned long get_break_insn_length(unsigned long pc)
+{
+	bug_insn_t insn;
+
+	if (probe_kernel_address((bug_insn_t *)pc, insn))
+		return 0;
+	return ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ? 4UL : 2UL;
+}
+#endif /* CONFIG_GENERIC_BUG */
+
 asmlinkage void do_trap_break(struct pt_regs *regs)
 {
 #ifdef CONFIG_GENERIC_BUG
@@ -129,7 +140,8 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 		case BUG_TRAP_TYPE_NONE:
 			break;
 		case BUG_TRAP_TYPE_WARN:
-			die(regs, "Kernel BUG. Kernel got an unexpected WARN trapped by ebreak");
+			regs->sepc += get_break_insn_length(regs->sepc);
+			break;
 		case BUG_TRAP_TYPE_BUG:
 			die(regs, "Kernel BUG");
 		}
@@ -149,12 +161,13 @@ int is_valid_bugaddr(unsigned long pc)
 	if (probe_kernel_address((bug_insn_t *)pc, insn))
 		return 0;
 	if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
-		return insn == __BUG_INSN_32;
+		return (insn == __BUG_INSN_32);
 	else
-		return (insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16;
+		return ((insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16);
 }
 #endif /* CONFIG_GENERIC_BUG */
 
+
 void __init trap_init(void)
 {
 	/*
-- 
1.7.1

