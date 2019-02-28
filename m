Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CFAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE492218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfB1K5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:57:37 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:29645 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727810AbfB1K5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:57:34 -0500
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id x1SAVb88086883
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 18:31:37 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x1SAV3WW086808;
        Thu, 28 Feb 2019 18:31:03 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 28 Feb 2019
 18:31:37 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <ebiederm@xmission.com>, <jimw@sifive.com>, <arnd@arndb.de>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <deanbo422@gmail.com>, <vincentc@andestech.com>
Subject: [PATCH 1/3] riscv: Add the support for c.ebreak check in is_valid_bugaddr()
Date:   Thu, 28 Feb 2019 18:31:29 +0800
Message-ID: <1551349891-22683-2-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551349891-22683-1-git-send-email-vincentc@andestech.com>
References: <1551349891-22683-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x1SAV3WW086808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_valid_bugaddr() function compares the instruction pointed to by
$sepc with macro __BUG_INSN to check whether the current trap exception
is caused by an "ebreak" instruction. Hence the macro __BUG_INSN is
defined as "ebreak". However, this check flow is possibly erroneous
because the expected trap instruction possibly be translated to "c.ebreak"
by assembler if C extension is supported. Therefore, it requires
a mechanism to distinguish the length of the instruction in $spec and
compare it to the correct __BUG_INSN.

By the way, I make the kernel go to die() like BUG() when the trap
type is BUG_TRAP_TYPE_WARN because currently the WARN() does not trigger
any trap exception.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/include/asm/bug.h |    7 ++++++-
 arch/riscv/kernel/traps.c    |    8 +++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index bfc7f09..1cab7f4 100644
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
index 24a9333..deae0e5 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -129,8 +129,7 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 		case BUG_TRAP_TYPE_NONE:
 			break;
 		case BUG_TRAP_TYPE_WARN:
-			regs->sepc += sizeof(bug_insn_t);
-			return;
+			die(regs, "Kernel BUG. Kernel got an unexpected WARN trapped by ebreak");
 		case BUG_TRAP_TYPE_BUG:
 			die(regs, "Kernel BUG");
 		}
@@ -149,7 +148,10 @@ int is_valid_bugaddr(unsigned long pc)
 		return 0;
 	if (probe_kernel_address((bug_insn_t *)pc, insn))
 		return 0;
-	return (insn == __BUG_INSN);
+	if ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32)
+		return insn == __BUG_INSN_32;
+	else
+		return (insn & __COMPRESSED_INSN_MASK) == __BUG_INSN_16;
 }
 #endif /* CONFIG_GENERIC_BUG */
 
-- 
1.7.1

