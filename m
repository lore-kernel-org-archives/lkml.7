Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875AA20850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfDAFuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:50:37 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46341 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbfDAFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:50:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4208047|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.338085-0.0190379-0.642877;FP=0|0|0|0|0|0|0|0;HT=e01l07447;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.EFR7l41_1554097819;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EFR7l41_1554097819)
          by smtp.aliyun-inc.com(10.147.41.178);
          Mon, 01 Apr 2019 13:50:19 +0800
Date:   Mon, 1 Apr 2019 13:48:30 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     ren_guo@c-sky.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: csky: Add perf callchin support
Message-ID: <20190401054829.GA7489@vmh-VirtualBox>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
This patch set add perf callchain support for C-SKY. Including perf callchain
support using frame pointer, perf registers definition, registers initiation
for libdw unwinding and some build infrastructure.

Regards,
Mao Han

--opJtzjQTFsWo+cga
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-csky-Add-perf-callchin-support.patch"

From c538e33c6705c9284264a5035185edb55ace1786 Mon Sep 17 00:00:00 2001
Message-Id: <c538e33c6705c9284264a5035185edb55ace1786.1554094500.git.han_mao@c-sky.com>
From: Mao Han <han_mao@c-sky.com>
Date: Fri, 8 Mar 2019 13:21:33 +0800
Subject: [PATCH 1/3] csky: Add perf callchin support

This patch add support for perf callchain sampling on csky platform.
Both fp and dwarf unwinding are supported with this patch. When fp
is used to unwind the stack, the program being sampled and the
C library need to be compiled with -mbacktrace for user callchains,
kernel callchains require CONFIG_STACKTRACE = y. Unwinding with
dwarf requires compilation with -fexceptions, otherwise there will
be not debug information inside the excutable file.

Signed-off-by: Mao Han <han_mao@c-sky.com>
---
 arch/csky/Kconfig                      |   2 +
 arch/csky/include/uapi/asm/perf_regs.h |  48 ++++++++++++
 arch/csky/kernel/Makefile              |   2 +
 arch/csky/kernel/perf_callchain.c      | 133 +++++++++++++++++++++++++++++++++
 arch/csky/kernel/perf_regs.c           |  41 ++++++++++
 5 files changed, 226 insertions(+)
 create mode 100644 arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 arch/csky/kernel/perf_callchain.c
 create mode 100644 arch/csky/kernel/perf_regs.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c..93b535d 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -35,6 +35,8 @@ config CSKY
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
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
index 484e6d3..3549d0d 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -9,6 +9,8 @@ obj-$(CONFIG_SMP)			+= smp.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o
 obj-$(CONFIG_STACKTRACE)		+= stacktrace.o
 obj-$(CONFIG_CSKY_PMU_V1)		+= perf_event.o
+obj-$(CONFIG_PERF_EVENTS)               += perf_callchain.o
+obj-$(CONFIG_HAVE_PERF_REGS)            += perf_regs.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/csky/kernel/perf_callchain.c b/arch/csky/kernel/perf_callchain.c
new file mode 100644
index 0000000..0ed8279
--- /dev/null
+++ b/arch/csky/kernel/perf_callchain.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+
+/* Kernel callchain */
+struct stackframe {
+	unsigned long fp;
+	unsigned long lr;
+};
+
+static int
+unwind_frame_kernel(struct stackframe *frame)
+{
+	int graph = 0;
+
+	/* 0x3 means misalignment */
+	if (!kstack_end((void *)frame->fp) &&
+	    !((unsigned long)frame->fp & 0x3) &&
+	    ((unsigned long)frame->fp >= TASK_SIZE)) {
+		frame->lr = ((struct stackframe *)frame->fp)->lr;
+		frame->fp = ((struct stackframe *)frame->fp)->fp;
+		/* make sure CONFIG_FUNCTION_GRAPH_TRACER is turned on */
+		if (__kernel_text_address(frame->lr))
+			frame->lr = ftrace_graph_ret_addr
+						(NULL, &graph, frame->lr, NULL);
+		return 0;
+	} else {
+		return -EPERM;
+	}
+}
+
+static void notrace
+walk_stackframe(struct stackframe *fr,
+		struct perf_callchain_entry_ctx *entry)
+{
+	while (1) {
+		int ret;
+
+		perf_callchain_store(entry, fr->lr);
+
+		ret = unwind_frame_kernel(fr);
+		if (ret < 0)
+			break;
+	}
+}
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static unsigned long
+user_backtrace(struct perf_callchain_entry_ctx *entry, unsigned long fp,
+	       unsigned long reg_lr)
+{
+	struct stackframe buftail;
+	unsigned long lr = 0;
+	unsigned long *user_frame_tail = (unsigned long *)fp;
+
+	/* Check accessibility of one struct frame_tail beyond */
+	if (!access_ok(user_frame_tail, sizeof(buftail)))
+		return 0;
+	if (__copy_from_user_inatomic
+		(&buftail, user_frame_tail, sizeof(buftail)))
+		return 0;
+
+	if (reg_lr != 0) {
+		lr = reg_lr;
+	} else {
+		lr = buftail.lr;
+	}
+	fp = buftail.fp;
+	perf_callchain_store(entry, lr);
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
+ * On C-SKY platform, the program being sampled and the C library
+ * need to be compiled with * -mbacktrace, otherwise the user 
+ * stack will not contain function frame.
+ */
+void
+perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+		    struct pt_regs *regs)
+{
+	unsigned long fp = 0;
+
+	/* C-SKY does not support virtualization. */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		return;
+	}
+
+	fp = regs->regs[4];
+	perf_callchain_store(entry, regs->pc);
+	/*
+	 * While backtrace from leaf function, lr is normally
+	 * not saved inside frame on C-SKY, so get lr from pt_regs
+	 * at the sample point. However, lr value can be incorrect if
+	 * lr is used as temp register
+	 */
+	fp = user_backtrace(entry, fp, regs->lr);
+
+	while ((entry->nr < entry->max_stack) &&
+		fp && !((unsigned long)fp & 0x3))
+		fp = user_backtrace(entry, fp, 0);
+}
+
+void
+perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
+		      struct pt_regs *regs)
+{
+	struct stackframe fr;
+
+	/* C-SKY does not support virtualization. */
+	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+		pr_warn("C-SKY does not support perf in guest mode!");
+		return;
+	}
+
+	fr.fp = regs->regs[4];
+	fr.lr = regs->lr;
+	walk_stackframe(&fr, entry);
+}
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
new file mode 100644
index 0000000..55fa389
--- /dev/null
+++ b/arch/csky/kernel/perf_regs.c
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/bug.h>
+#include <linux/sched/task_stack.h>
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


--opJtzjQTFsWo+cga
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-perf-use-hweight64-instead-of-hweight_long.patch"

From adaa5acdec45e65819343b4362efd50fe0442cfa Mon Sep 17 00:00:00 2001
Message-Id: <adaa5acdec45e65819343b4362efd50fe0442cfa.1554094500.git.han_mao@c-sky.com>
In-Reply-To: <c538e33c6705c9284264a5035185edb55ace1786.1554094500.git.han_mao@c-sky.com>
References: <c538e33c6705c9284264a5035185edb55ace1786.1554094500.git.han_mao@c-sky.com>
From: Mao Han <han_mao@c-sky.com>
Date: Fri, 8 Mar 2019 13:30:59 +0800
Subject: [PATCH 2/3] perf: use hweight64 instead of hweight_long

On C-SKY platform, there are 38 registers inside pt_regs. The same
layout is directly used by perf to keep uniformity. The mask is 64
bits, but hweight_long can only handle 32 bits, which will casue
perf.data analysis mismatch on C-SKY.

Signed-off-by: Mao Han <han_mao@c-sky.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc0466..89b87a0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2305,7 +2305,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		if (data->user_regs.abi) {
 			u64 mask = evsel->attr.sample_regs_user;
 
-			sz = hweight_long(mask) * sizeof(u64);
+			sz = hweight64(mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->user_regs.mask = mask;
 			data->user_regs.regs = (u64 *)array;
-- 
2.7.4


--opJtzjQTFsWo+cga
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0003-perf-add-C-SKY-dwarf-support.patch"

From ea9e6905a22065e980234e7ed6b1d802d8bb132f Mon Sep 17 00:00:00 2001
Message-Id: <ea9e6905a22065e980234e7ed6b1d802d8bb132f.1554094500.git.han_mao@c-sky.com>
In-Reply-To: <c538e33c6705c9284264a5035185edb55ace1786.1554094500.git.han_mao@c-sky.com>
References: <c538e33c6705c9284264a5035185edb55ace1786.1554094500.git.han_mao@c-sky.com>
From: Mao Han <han_mao@c-sky.com>
Date: Fri, 8 Mar 2019 13:55:20 +0800
Subject: [PATCH 3/3] perf: add C-SKY dwarf support

This patch add registers initialization and display support for C-SKY.

Signed-off-by: Mao Han <han_mao@c-sky.com>
---
 tools/arch/csky/include/uapi/asm/perf_regs.h | 48 ++++++++++++++
 tools/perf/Makefile.config                   |  6 +-
 tools/perf/arch/csky/Build                   |  1 +
 tools/perf/arch/csky/Makefile                |  3 +
 tools/perf/arch/csky/include/perf_regs.h     | 98 ++++++++++++++++++++++++++++
 tools/perf/arch/csky/util/Build              |  2 +
 tools/perf/arch/csky/util/dwarf-regs.c       | 25 +++++++
 tools/perf/arch/csky/util/unwind-libdw.c     | 58 ++++++++++++++++
 8 files changed, 240 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/csky/Build
 create mode 100644 tools/perf/arch/csky/Makefile
 create mode 100644 tools/perf/arch/csky/include/perf_regs.h
 create mode 100644 tools/perf/arch/csky/util/Build
 create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c

diff --git a/tools/arch/csky/include/uapi/asm/perf_regs.h b/tools/arch/csky/include/uapi/asm/perf_regs.h
new file mode 100644
index 0000000..337d8fa
--- /dev/null
+++ b/tools/arch/csky/include/uapi/asm/perf_regs.h
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
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b441c88..20f68d8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -59,6 +59,10 @@ ifeq ($(SRCARCH),arm64)
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
 
+ifeq ($(SRCARCH),csky)
+  NO_PERF_REGS := 0
+endif
+
 ifeq ($(ARCH),s390)
   NO_PERF_REGS := 0
   NO_SYSCALL_TABLE := 0
@@ -77,7 +81,7 @@ endif
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
 # to the check.
-ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390))
+ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky))
   NO_LIBDW_DWARF_UNWIND := 1
 endif
 
diff --git a/tools/perf/arch/csky/Build b/tools/perf/arch/csky/Build
new file mode 100644
index 0000000..54afe4a
--- /dev/null
+++ b/tools/perf/arch/csky/Build
@@ -0,0 +1 @@
+libperf-y += util/
diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
new file mode 100644
index 0000000..7fbca17
--- /dev/null
+++ b/tools/perf/arch/csky/Makefile
@@ -0,0 +1,3 @@
+ifndef NO_DWARF
+PERF_HAVE_DWARF_REGS := 1
+endif
diff --git a/tools/perf/arch/csky/include/perf_regs.h b/tools/perf/arch/csky/include/perf_regs.h
new file mode 100644
index 0000000..6baae28
--- /dev/null
+++ b/tools/perf/arch/csky/include/perf_regs.h
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef ARCH_PERF_REGS_H
+#define ARCH_PERF_REGS_H
+
+#include <stdlib.h>
+#include <linux/types.h>
+#include <asm/perf_regs.h>
+
+#define PERF_REGS_MASK	((1ULL << PERF_REG_CSKY_MAX) - 1)
+#define PERF_REGS_MAX	PERF_REG_CSKY_MAX
+#define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
+
+#define PERF_REG_IP	PERF_REG_CSKY_PC
+#define PERF_REG_SP	PERF_REG_CSKY_SP
+
+static inline const char *perf_reg_name(int id)
+{
+	switch (id) {
+	case PERF_REG_CSKY_R0:
+		return "r0";
+	case PERF_REG_CSKY_R1:
+		return "r1";
+	case PERF_REG_CSKY_R2:
+		return "r2";
+	case PERF_REG_CSKY_R3:
+		return "r3";
+	case PERF_REG_CSKY_R4:
+		return "r4";
+	case PERF_REG_CSKY_R5:
+		return "r5";
+	case PERF_REG_CSKY_R6:
+		return "r6";
+	case PERF_REG_CSKY_R7:
+		return "r7";
+	case PERF_REG_CSKY_R8:
+		return "r8";
+	case PERF_REG_CSKY_R9:
+		return "r9";
+	case PERF_REG_CSKY_R10:
+		return "r10";
+	case PERF_REG_CSKY_R11:
+		return "r11";
+	case PERF_REG_CSKY_R12:
+		return "r12";
+	case PERF_REG_CSKY_R13:
+		return "r13";
+	case PERF_REG_CSKY_SP:
+		return "sp";
+	case PERF_REG_CSKY_LR:
+		return "lr";
+	case PERF_REG_CSKY_R16:
+		return "r16";
+	case PERF_REG_CSKY_R17:
+		return "r17";
+	case PERF_REG_CSKY_R18:
+		return "r18";
+	case PERF_REG_CSKY_R19:
+		return "r19";
+	case PERF_REG_CSKY_R20:
+		return "r20";
+	case PERF_REG_CSKY_R21:
+		return "r21";
+	case PERF_REG_CSKY_R22:
+		return "r22";
+	case PERF_REG_CSKY_R23:
+		return "r23";
+	case PERF_REG_CSKY_R24:
+		return "r24";
+	case PERF_REG_CSKY_R25:
+		return "r25";
+	case PERF_REG_CSKY_R26:
+		return "r26";
+	case PERF_REG_CSKY_R27:
+		return "r27";
+	case PERF_REG_CSKY_R28:
+		return "r28";
+	case PERF_REG_CSKY_R29:
+		return "r29";
+	case PERF_REG_CSKY_R30:
+		return "r30";
+	case PERF_REG_CSKY_TLS:
+		return "tls";
+	case PERF_REG_CSKY_PC:
+		return "pc";
+	case PERF_REG_CSKY_HI:
+		return "hi";
+	case PERF_REG_CSKY_LO:
+		return "lo";
+	default:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
new file mode 100644
index 0000000..8e45471
--- /dev/null
+++ b/tools/perf/arch/csky/util/Build
@@ -0,0 +1,2 @@
+libperf-$(CONFIG_DWARF) += dwarf-regs.o
+libperf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/csky/util/dwarf-regs.c b/tools/perf/arch/csky/util/dwarf-regs.c
new file mode 100644
index 0000000..d9b78e2
--- /dev/null
+++ b/tools/perf/arch/csky/util/dwarf-regs.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+// Mapping of DWARF debug register numbers into register names.
+
+#include <stddef.h>
+#include <dwarf-regs.h>
+
+#define CSKY_MAX_REGS 71
+
+const char *csky_regs_table[CSKY_MAX_REGS] = {
+        "%r0", "%r1", "%r2", "%r3", "%r4", "%r5", "%r6", "%r7",
+        "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%sp", "%lr",
+        "%r16", "%r17", "%r18", "%r19", "%r20", "%21", "%22", "%23",
+        "%r24", "%r25", "%r26", "%r27", "%r28", "%r29", "%r30", "%tls",
+        "%pc", "%cc", "%hi", "%lo", "%rr", "%rr", "%rr", "%rr",
+        "%rr", "%rr", "%rr", "%rr", "%rr", "%rr", "%rr", "%rr",
+        "%rr", "%rr", "%rr", "%rr", "%vr0", "%vr1", "%vr2", "%vr3",
+        "%vr4", "%vr5", "%vr6", "%vr7", "%vr8", "%vr9", "%vr10", "%vr11",
+        "%vr12", "%vr13", "%vr14", "%vr15", "%rr", "%rr", "%epc",
+};
+
+const char *get_arch_regstr(unsigned int n)
+{
+        return (n < CSKY_MAX_REGS) ? csky_regs_table[n] : NULL;
+}
diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/arch/csky/util/unwind-libdw.c
new file mode 100644
index 0000000..1b5b845
--- /dev/null
+++ b/tools/perf/arch/csky/util/unwind-libdw.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <elfutils/libdwfl.h>
+#include "../../util/unwind-libdw.h"
+#include "../../util/perf_regs.h"
+#include "../../util/event.h"
+
+bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
+{
+	struct unwind_info *ui = arg;
+	struct regs_dump *user_regs = &ui->sample->user_regs;
+	Dwarf_Word dwarf_regs[PERF_REG_CSKY_MAX];
+
+#define REG(r) ({						\
+	Dwarf_Word val = 0;					\
+	perf_reg_value(&val, user_regs, PERF_REG_CSKY_##r);	\
+	val;							\
+})
+
+	dwarf_regs[0]  = REG(R0);
+	dwarf_regs[1]  = REG(R1);
+	dwarf_regs[2]  = REG(R2);
+	dwarf_regs[3]  = REG(R3);
+	dwarf_regs[4]  = REG(R4);
+	dwarf_regs[5]  = REG(R5);
+	dwarf_regs[6]  = REG(R6);
+	dwarf_regs[7]  = REG(R7);
+	dwarf_regs[8]  = REG(R8);
+	dwarf_regs[9]  = REG(R9);
+	dwarf_regs[10] = REG(R10);
+	dwarf_regs[11] = REG(R11);
+	dwarf_regs[12] = REG(R12);
+	dwarf_regs[13] = REG(R13);
+	dwarf_regs[14] = REG(SP);
+	dwarf_regs[15] = REG(LR);
+	dwarf_regs[16] = REG(R16);
+	dwarf_regs[17] = REG(R17);
+	dwarf_regs[18] = REG(R18);
+	dwarf_regs[19] = REG(R19);
+	dwarf_regs[20] = REG(R20);
+	dwarf_regs[21] = REG(R21);
+	dwarf_regs[22] = REG(R22);
+	dwarf_regs[23] = REG(R23);
+	dwarf_regs[24] = REG(R24);
+	dwarf_regs[25] = REG(R25);
+	dwarf_regs[26] = REG(R26);
+	dwarf_regs[27] = REG(R27);
+	dwarf_regs[28] = REG(R28);
+	dwarf_regs[29] = REG(R29);
+	dwarf_regs[30] = REG(R30);
+	dwarf_regs[31] = REG(TLS);
+	dwarf_regs[32] = REG(PC);
+	dwfl_thread_state_register_pc(thread, dwarf_regs[32]);
+
+	return dwfl_thread_state_registers(thread, 0, PERF_REG_CSKY_MAX,
+					   dwarf_regs);
+}
-- 
2.7.4


--opJtzjQTFsWo+cga--
