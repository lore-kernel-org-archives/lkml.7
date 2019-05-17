Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA6AC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E0A206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfEQIop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:44:45 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60795 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfEQIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:44:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436283|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.692448-0.0313479-0.276204;FP=0|0|0|0|0|-1|-1|-1;HT=e01l01425;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.EZL5.tj_1558082676;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EZL5.tj_1558082676)
          by smtp.aliyun-inc.com(10.147.41.137);
          Fri, 17 May 2019 16:44:36 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V3 1/3] riscv: Add perf callchain support
Date:   Fri, 17 May 2019 16:43:02 +0800
Message-Id: <58bdfc163926422b6abe7f18a5a995dbc39aaaab.1558081981.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1558081981.git.han_mao@c-sky.com>
References: <cover.1558081981.git.han_mao@c-sky.com>
In-Reply-To: <cover.1558081981.git.han_mao@c-sky.com>
References: <cover.1558081981.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for perf callchain sampling on riscv platform.
The return address of leaf function is retrieved from pt_regs as
it is not saved in the outmost frame.

Signed-off-by: Mao Han <han_mao@c-sky.com>
CC: Palmer Dabbelt <palmer@sifive.com>
CC: linux-riscv <linux-riscv@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>
CC: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Makefile                |   3 +
 arch/riscv/kernel/Makefile         |   3 +-
 arch/riscv/kernel/perf_callchain.c | 113 +++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/perf_callchain.c

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index c6342e6..4396abc 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -59,6 +59,9 @@ endif
 ifeq ($(CONFIG_MODULE_SECTIONS),y)
 	KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/riscv/kernel/module.lds
 endif
+ifeq ($(CONFIG_PERF_EVENTS),y)
+        KBUILD_CFLAGS += -fno-omit-frame-pointer
+endif
 
 KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 5985681..dd2ba44 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
-obj-$(CONFIG_PERF_EVENTS)      += perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 
 clean:
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
new file mode 100644
index 0000000..8b57903
--- /dev/null
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
+
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+
+/* Kernel callchain */
+struct stackframe {
+	unsigned long fp;
+	unsigned long ra;
+};
+
+static int unwind_frame_kernel(struct stackframe *frame)
+{
+	if (kstack_end((void *)frame->fp))
+		return -EPERM;
+	if (frame->fp & 0x3 || frame->fp < TASK_SIZE)
+		return -EPERM;
+
+	*frame = *((struct stackframe *)frame->fp - 1);
+	if (__kernel_text_address(frame->ra)) {
+		int graph = 0;
+
+		frame->ra = ftrace_graph_ret_addr(NULL, &graph, frame->ra,
+				NULL);
+	}
+	return 0;
+}
+
+static void notrace walk_stackframe(struct stackframe *fr,
+			struct perf_callchain_entry_ctx *entry)
+{
+	do {
+		perf_callchain_store(entry, fr->ra);
+	} while (unwind_frame_kernel(fr) >= 0);
+}
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
+			unsigned long fp, unsigned long reg_ra)
+{
+	struct stackframe buftail;
+	unsigned long ra = 0;
+	unsigned long *user_frame_tail =
+			(unsigned long *)(fp - sizeof(struct stackframe));
+
+	/* Check accessibility of one struct frame_tail beyond */
+	if (!access_ok(user_frame_tail, sizeof(buftail)))
+		return 0;
+	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
+				      sizeof(buftail)))
+		return 0;
+
+	if (reg_ra != 0)
+		ra = reg_ra;
+	else
+		ra = buftail.ra;
+
+	fp = buftail.fp;
+	perf_callchain_store(entry, ra);
+
+	return fp;
+}
+
+/*
+ * This will be called when the target is in user mode
+ * This function will only be called when we use
+ * "PERF_SAMPLE_CALLCHAIN" in
+ * kernel/events/core.c:perf_prepare_sample()
+ *
+ * How to trigger perf_callchain_[user/kernel] :
+ * $ perf record -e cpu-clock --call-graph fp ./program
+ * $ perf report --call-graph
+ *
+ * On RISC-V platform, the program being sampled and the C library
+ * need to be compiled with -fno-omit-frame-pointer, otherwise
+ * the user stack will not contain function frame.
+ */
+void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+			 struct pt_regs *regs)
+{
+	unsigned long fp = 0;
+
+	/* RISC-V does not support virtualization. */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
+		return;
+
+	fp = regs->s0;
+	perf_callchain_store(entry, regs->sepc);
+
+	fp = user_backtrace(entry, fp, regs->ra);
+	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
+		fp = user_backtrace(entry, fp, 0);
+}
+
+void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
+			   struct pt_regs *regs)
+{
+	struct stackframe fr;
+
+	/* RISC-V does not support virtualization. */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		pr_warn("RISC-V does not support perf in guest mode!");
+		return;
+	}
+
+	fr.fp = regs->s0;
+	fr.ra = regs->ra;
+	walk_stackframe(&fr, entry);
+}
-- 
2.7.4

