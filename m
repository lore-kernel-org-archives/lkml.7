Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CEBC00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3CD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfCEDYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:24:11 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:34555 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726996AbfCEDYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:24:10 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x253MrPA044079;
        Tue, 5 Mar 2019 11:22:53 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 5 Mar 2019
 11:23:53 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <ebiederm@xmission.com>, <jimw@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH v2 2/3] riscv: Add the support for c.ebreak check in is_valid_bugaddr()
Date:   Tue, 5 Mar 2019 11:23:34 +0800
Message-ID: <1551756215-22299-3-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551756215-22299-1-git-send-email-vincentc@andestech.com>
References: <1551756215-22299-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x253MrPA044079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro __BUG_INSN currently is defined as the "ebreak" opcode.
The is_valid_bugaddr() function compares the instruction pointed to by
$sepc with macro __BUG_INSN to check whether the current trap exception
is caused by an "ebreak" instruction. However, this check flow is possibly
erroneous because if C extension is supported, the expected trap
instruction "ebreak" is possibly translated to "c.ebreak" by the assembler.
Therefore, it requires a mechanism to distinguish the length of the
instruction in $spec and compare it to the correct trap instruction.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/include/asm/bug.h |    7 ++++++-
 arch/riscv/kernel/traps.c    |   20 +++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 4d906d8..52a1fbd 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -21,7 +21,12 @@
 #include <asm/asm.h>
 
 #ifdef CONFIG_GENERIC_BUG
-#define __BUG_INSN	_AC(0x00100073, UL) /* ebreak */
+#define __INSN_LENGTH_MASK  _UL(0x3)
+#define __INSN_LENGTH_32    _UL(0x3)
+#define __COMPRESSED_INSN_MASK	_UL(0xffff)
+
+#define __BUG_INSN_32	_UL(0x00100073) /* ebreak */
+#define __BUG_INSN_16	_UL(0x9002) /* c.ebreak */
 
 #ifndef __ASSEMBLY__
 typedef u32 bug_insn_t;
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 24a9333..6423e1a 100644
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
+	return (((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ? 4UL : 2UL);
+}
+#endif /* CONFIG_GENERIC_BUG */
+
 asmlinkage void do_trap_break(struct pt_regs *regs)
 {
 #ifdef CONFIG_GENERIC_BUG
@@ -129,8 +140,8 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 		case BUG_TRAP_TYPE_NONE:
 			break;
 		case BUG_TRAP_TYPE_WARN:
-			regs->sepc += sizeof(bug_insn_t);
-			return;
+			regs->sepc += get_break_insn_length(regs->sepc);
+			break;
 		case BUG_TRAP_TYPE_BUG:
 			die(regs, "Kernel BUG");
 		}
@@ -149,7 +160,10 @@ int is_valid_bugaddr(unsigned long pc)
 		return 0;
 	if (probe_kernel_address((bug_insn_t *)pc, insn))
 		return 0;
-	return (insn == __BUG_INSN);
+	if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
+		return (insn == __BUG_INSN_32);
+	else
+		return ((insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16);
 }
 #endif /* CONFIG_GENERIC_BUG */
 
-- 
1.7.1

