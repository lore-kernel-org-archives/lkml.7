Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D091C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62162133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfDBGkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:40:51 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56129 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728768AbfDBGkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:40:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.366838-0.0141586-0.619003;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.EFvSTDh_1554187243;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EFvSTDh_1554187243)
          by smtp.aliyun-inc.com(10.147.42.22);
          Tue, 02 Apr 2019 14:40:43 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 2/2] csky: add support for libdw
Date:   Tue,  2 Apr 2019 14:35:43 +0800
Message-Id: <3490576b6f88fc0f0c733282535671d263d67533.1554186270.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1554186270.git.han_mao@c-sky.com>
References: <cover.1554186270.git.han_mao@c-sky.com>
In-Reply-To: <cover.1554186270.git.han_mao@c-sky.com>
References: <cover.1554186270.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for DWARF register mappings and libdw registers
initialization, which is used by perf callchain analyzing when
--call-graph=dwarf is given.

CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Namhyung Kim <namhyung@kernel.org>
CC: Guo Ren <guoren@kernel.org>

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
index fe3f97e..42985ae 100644
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

