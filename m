Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD81ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DCC214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 02:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfJKC5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 22:57:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41694 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbfJKC5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 22:57:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07448077|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.335335-0.0158047-0.64886;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03291;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.FjD-bDi_1570762619;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FjD-bDi_1570762619)
          by smtp.aliyun-inc.com(10.147.41.138);
          Fri, 11 Oct 2019 10:56:59 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH] csky: Initial stack protector support
Date:   Fri, 11 Oct 2019 10:56:55 +0800
Message-Id: <1570762615-4256-1-git-send-email-han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a basic -fstack-protector support without per-task canary
switching. The protector will report something like when stack
corruption is detected:

stack-protector: Kernel stack is corrupted in: sys_kill+0x23c/0x23c

Tested with a local array overflow in kill system call.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <guoren@kernel.org>
---
 arch/csky/Kconfig                      |  1 +
 arch/csky/include/asm/stackprotector.h | 29 +++++++++++++++++++++++++++++
 arch/csky/kernel/process.c             |  6 ++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/csky/include/asm/stackprotector.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3973847..2852343 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
+	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
diff --git a/arch/csky/include/asm/stackprotector.h b/arch/csky/include/asm/stackprotector.h
new file mode 100644
index 0000000..d7cd4e5
--- /dev/null
+++ b/arch/csky/include/asm/stackprotector.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H 1
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif /* __ASM_SH_STACKPROTECTOR_H */
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f320d92..5349cd8 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -16,6 +16,12 @@
 
 struct cpuinfo_csky cpu_data[NR_CPUS];
 
+#ifdef CONFIG_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
-- 
2.7.4

