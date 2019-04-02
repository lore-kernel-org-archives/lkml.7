Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE317C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867E920882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfDBGko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:40:44 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59715 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728768AbfDBGko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:40:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743722|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.375491-0.016038-0.608471;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.EFvbW3d_1554187239;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EFvbW3d_1554187239)
          by smtp.aliyun-inc.com(10.147.40.26);
          Tue, 02 Apr 2019 14:40:39 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 1/2] csky: Add support for perf registers sampling
Date:   Tue,  2 Apr 2019 14:35:41 +0800
Message-Id: <20c1eb16f0a4fa59ea8479cc5bff54871413ac86.1554186270.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1554186270.git.han_mao@c-sky.com>
References: <cover.1554186270.git.han_mao@c-sky.com>
In-Reply-To: <cover.1554186270.git.han_mao@c-sky.com>
References: <cover.1554186270.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the perf registers sampling and validation API
for csky arch. The valid registers and their register ID are defined in
perf_regs.h. Perf tool can backtrace in userspace with unwind library
and the registers/user stack dump support.

CC: Guo Ren <guoren@kernel.org>

Signed-off-by: Mao Han <han_mao@c-sky.com>
---
 arch/csky/Kconfig                      |  2 ++
 arch/csky/include/uapi/asm/perf_regs.h | 48 ++++++++++++++++++++++++++++++++++
 arch/csky/kernel/Makefile              |  1 +
 arch/csky/kernel/perf_regs.c           | 40 ++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 arch/csky/kernel/perf_regs.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index c4974cf..8e45c7a 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -38,6 +38,8 @@ config CSKY
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/csky/include/uapi/asm/perf_regs.h b/arch/csky/include/uapi/asm/perf_regs.h
new file mode 100644
index 0000000..337d8fa
--- /dev/null
+++ b/arch/csky/include/uapi/asm/perf_regs.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef _ASM_CSKY_PERF_REGS_H
+#define _ASM_CSKY_PERF_REGS_H
+
+enum perf_event_csky_regs {
+	PERF_REG_CSKY_TLS,
+	PERF_REG_CSKY_LR,
+	PERF_REG_CSKY_PC,
+	PERF_REG_CSKY_SR,
+	PERF_REG_CSKY_SP,
+	PERF_REG_CSKY_ORIG_A0,
+	PERF_REG_CSKY_R0,
+	PERF_REG_CSKY_R1,
+	PERF_REG_CSKY_R2,
+	PERF_REG_CSKY_R3,
+	PERF_REG_CSKY_R4,
+	PERF_REG_CSKY_R5,
+	PERF_REG_CSKY_R6,
+	PERF_REG_CSKY_R7,
+	PERF_REG_CSKY_R8,
+	PERF_REG_CSKY_R9,
+	PERF_REG_CSKY_R10,
+	PERF_REG_CSKY_R11,
+	PERF_REG_CSKY_R12,
+	PERF_REG_CSKY_R13,
+	PERF_REG_CSKY_R16,
+	PERF_REG_CSKY_R17,
+	PERF_REG_CSKY_R18,
+	PERF_REG_CSKY_R19,
+	PERF_REG_CSKY_R20,
+	PERF_REG_CSKY_R21,
+	PERF_REG_CSKY_R22,
+	PERF_REG_CSKY_R23,
+	PERF_REG_CSKY_R24,
+	PERF_REG_CSKY_R25,
+	PERF_REG_CSKY_R26,
+	PERF_REG_CSKY_R27,
+	PERF_REG_CSKY_R28,
+	PERF_REG_CSKY_R29,
+	PERF_REG_CSKY_R30,
+	PERF_REG_CSKY_HI,
+	PERF_REG_CSKY_LO,
+	PERF_REG_CSKY_DCSR,
+	PERF_REG_CSKY_MAX,
+};
+#endif /* _ASM_CSKY_PERF_REGS_H */
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 4c462f5..1624b04 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o
 obj-$(CONFIG_STACKTRACE)		+= stacktrace.o
 obj-$(CONFIG_CSKY_PMU_V1)		+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_callchain.o
+obj-$(CONFIG_HAVE_PERF_REGS)            += perf_regs.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
new file mode 100644
index 0000000..153c8f6
--- /dev/null
+++ b/arch/csky/kernel/perf_regs.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/bug.h>
+#include <asm/perf_regs.h>
+#include <asm/ptrace.h>
+
+u64 perf_reg_value(struct pt_regs *regs, int idx)
+{
+	if (WARN_ON_ONCE((u32)idx >= PERF_REG_CSKY_MAX))
+		return 0;
+
+	return ((long *)regs)[idx];
+}
+
+#define REG_RESERVED (~((1ULL << PERF_REG_CSKY_MAX) - 1))
+
+int perf_reg_validate(u64 mask)
+{
+	if (!mask || mask & REG_RESERVED)
+		return -EINVAL;
+
+	return 0;
+}
+
+u64 perf_reg_abi(struct task_struct *task)
+{
+	return PERF_SAMPLE_REGS_ABI_32;
+}
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs,
+			struct pt_regs *regs_user_copy)
+{
+	regs_user->regs = task_pt_regs(current);
+	regs_user->abi = perf_reg_abi(current);
+}
-- 
2.7.4

