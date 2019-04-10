Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B3BC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC29206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfDJIY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:24:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49363 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729024AbfDJIYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:24:52 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.355592-0.0122352-0.632173;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03277;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.EJJhwpo_1554884688;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EJJhwpo_1554884688)
          by smtp.aliyun-inc.com(10.147.41.158);
          Wed, 10 Apr 2019 16:24:49 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 3/3] csky: add support for libdw
Date:   Wed, 10 Apr 2019 16:16:45 +0800
Message-Id: <19865a61b3f77ea5e691f6b36da3c61bccdc095e.1554883878.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1554883878.git.han_mao@c-sky.com>
References: <cover.1554883878.git.han_mao@c-sky.com>
In-Reply-To: <cover.1554883878.git.han_mao@c-sky.com>
References: <cover.1554883878.git.han_mao@c-sky.com>
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

Signed-off-by: Mao Han <han_mao@c-sky.com>
---
 tools/arch/csky/include/uapi/asm/perf_regs.h |  51 ++++++++++++++
 tools/perf/Makefile.config                   |   6 +-
 tools/perf/arch/csky/Build                   |   1 +
 tools/perf/arch/csky/Makefile                |   3 +
 tools/perf/arch/csky/include/perf_regs.h     | 100 +++++++++++++++++++++++++++
 tools/perf/arch/csky/util/Build              |   2 +
 tools/perf/arch/csky/util/dwarf-regs.c       |  49 +++++++++++++
 tools/perf/arch/csky/util/unwind-libdw.c     |  78 +++++++++++++++++++++
 8 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/csky/Build
 create mode 100644 tools/perf/arch/csky/Makefile
 create mode 100644 tools/perf/arch/csky/include/perf_regs.h
 create mode 100644 tools/perf/arch/csky/util/Build
 create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c

diff --git a/tools/arch/csky/include/uapi/asm/perf_regs.h b/tools/arch/csky/include/uapi/asm/perf_regs.h
new file mode 100644
index 0000000..ee323d8
--- /dev/null
+++ b/tools/arch/csky/include/uapi/asm/perf_regs.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef _ASM_CSKY_PERF_REGS_H
+#define _ASM_CSKY_PERF_REGS_H
+
+/* Index of struct pt_regs */
+enum perf_event_csky_regs {
+	PERF_REG_CSKY_TLS,
+	PERF_REG_CSKY_LR,
+	PERF_REG_CSKY_PC,
+	PERF_REG_CSKY_SR,
+	PERF_REG_CSKY_SP,
+	PERF_REG_CSKY_ORIG_A0,
+	PERF_REG_CSKY_A0,
+	PERF_REG_CSKY_A1,
+	PERF_REG_CSKY_A2,
+	PERF_REG_CSKY_A3,
+	PERF_REG_CSKY_REGS0,
+	PERF_REG_CSKY_REGS1,
+	PERF_REG_CSKY_REGS2,
+	PERF_REG_CSKY_REGS3,
+	PERF_REG_CSKY_REGS4,
+	PERF_REG_CSKY_REGS5,
+	PERF_REG_CSKY_REGS6,
+	PERF_REG_CSKY_REGS7,
+	PERF_REG_CSKY_REGS8,
+	PERF_REG_CSKY_REGS9,
+#if defined(__CSKYABIV2__)
+	PERF_REG_CSKY_EXREGS0,
+	PERF_REG_CSKY_EXREGS1,
+	PERF_REG_CSKY_EXREGS2,
+	PERF_REG_CSKY_EXREGS3,
+	PERF_REG_CSKY_EXREGS4,
+	PERF_REG_CSKY_EXREGS5,
+	PERF_REG_CSKY_EXREGS6,
+	PERF_REG_CSKY_EXREGS7,
+	PERF_REG_CSKY_EXREGS8,
+	PERF_REG_CSKY_EXREGS9,
+	PERF_REG_CSKY_EXREGS10,
+	PERF_REG_CSKY_EXREGS11,
+	PERF_REG_CSKY_EXREGS12,
+	PERF_REG_CSKY_EXREGS13,
+	PERF_REG_CSKY_EXREGS14,
+	PERF_REG_CSKY_HI,
+	PERF_REG_CSKY_LO,
+	PERF_REG_CSKY_DCSR,
+#endif
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
index 0000000..e4e5f33
--- /dev/null
+++ b/tools/perf/arch/csky/Build
@@ -0,0 +1 @@
+perf-y += util/
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
index 0000000..8f336ea
--- /dev/null
+++ b/tools/perf/arch/csky/include/perf_regs.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
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
+	case PERF_REG_CSKY_A0:
+		return "a0";
+	case PERF_REG_CSKY_A1:
+		return "a1";
+	case PERF_REG_CSKY_A2:
+		return "a2";
+	case PERF_REG_CSKY_A3:
+		return "a3";
+	case PERF_REG_CSKY_REGS0:
+		return "regs0";
+	case PERF_REG_CSKY_REGS1:
+		return "regs1";
+	case PERF_REG_CSKY_REGS2:
+		return "regs2";
+	case PERF_REG_CSKY_REGS3:
+		return "regs3";
+	case PERF_REG_CSKY_REGS4:
+		return "regs4";
+	case PERF_REG_CSKY_REGS5:
+		return "regs5";
+	case PERF_REG_CSKY_REGS6:
+		return "regs6";
+	case PERF_REG_CSKY_REGS7:
+		return "regs7";
+	case PERF_REG_CSKY_REGS8:
+		return "regs8";
+	case PERF_REG_CSKY_REGS9:
+		return "regs9";
+	case PERF_REG_CSKY_SP:
+		return "sp";
+	case PERF_REG_CSKY_LR:
+		return "lr";
+	case PERF_REG_CSKY_PC:
+		return "pc";
+#if defined(__CSKYABIV2__)
+	case PERF_REG_CSKY_EXREGS0:
+		return "exregs0";
+	case PERF_REG_CSKY_EXREGS1:
+		return "exregs1";
+	case PERF_REG_CSKY_EXREGS2:
+		return "exregs2";
+	case PERF_REG_CSKY_EXREGS3:
+		return "exregs3";
+	case PERF_REG_CSKY_EXREGS4:
+		return "exregs4";
+	case PERF_REG_CSKY_EXREGS5:
+		return "exregs5";
+	case PERF_REG_CSKY_EXREGS6:
+		return "exregs6";
+	case PERF_REG_CSKY_EXREGS7:
+		return "exregs7";
+	case PERF_REG_CSKY_EXREGS8:
+		return "exregs8";
+	case PERF_REG_CSKY_EXREGS9:
+		return "exregs9";
+	case PERF_REG_CSKY_EXREGS10:
+		return "exregs10";
+	case PERF_REG_CSKY_EXREGS11:
+		return "exregs11";
+	case PERF_REG_CSKY_EXREGS12:
+		return "exregs12";
+	case PERF_REG_CSKY_EXREGS13:
+		return "exregs13";
+	case PERF_REG_CSKY_EXREGS14:
+		return "exregs14";
+	case PERF_REG_CSKY_TLS:
+		return "tls";
+	case PERF_REG_CSKY_HI:
+		return "hi";
+	case PERF_REG_CSKY_LO:
+		return "lo";
+#endif
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
index 0000000..1160bb2
--- /dev/null
+++ b/tools/perf/arch/csky/util/Build
@@ -0,0 +1,2 @@
+perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/csky/util/dwarf-regs.c b/tools/perf/arch/csky/util/dwarf-regs.c
new file mode 100644
index 0000000..3591ca1
--- /dev/null
+++ b/tools/perf/arch/csky/util/dwarf-regs.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+// Mapping of DWARF debug register numbers into register names.
+
+#include <stddef.h>
+#include <dwarf-regs.h>
+
+#if defined(__CSKYABIV2__)
+#define CSKY_MAX_REGS 71
+const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
+	/* r0 ~ r8 */
+	"%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3",
+	/* r9 ~ r15 */
+	"%regs4", "%regs5", "%regs6", "%regs7", "%regs8", "%regs9", "%sp",
+	"%lr",
+	/* r16 ~ r23 */
+	"%exregs0", "%exregs1", "%exregs2", "%exregs3", "%exregs4",
+	"%exregs5", "%exregs6", "%exregs7",
+	/* r24 ~ r31 */
+	"%exregs8", "%exregs9", "%exregs10", "%exregs11", "%exregs12",
+	"%exregs13", "%exregs14", "%tls",
+	"%pc", "%cc", "%hi", "%lo", NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, "%vr0", "%vr1", "%vr2", "%vr3",
+	"%vr4", "%vr5", "%vr6", "%vr7", "%vr8", "%vr9", "%vr10", "%vr11",
+	"%vr12", "%vr13", "%vr14", "%vr15", NULL, NULL, "%epc",
+};
+#else
+#define CSKY_MAX_REGS 70
+const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
+	/* r0 ~ r8 */
+	"%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
+	/* r9 ~ r15 */
+	"%regs2", "%regs3", "%regs4", "%regs5", "%regs6", "%regs7", "%regs8",
+	"%lr",
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	"%vap", "%cc", "%vfp", "%epc", "%hi", "%lo", "%fr0", "%fr1",
+	"%fr2", "%fr3", "%fr4", "%fr5", "%fr6", "%fr7", "%fr8", "%fr9",
+	"%fr10", "%fr11", "%fr12", "%fr13", "%fr14", "%fr15", "%fr16", "%fr17",
+	"%fr18", "%fr19", "%fr20", "%fr21", "%fr22", "%fr23", "%fr24", "%fr25",
+	"%fr26", "%fr27", "%fr28", "%fr29", "%fr30", "%fr31"
+};
+#endif
+
+const char *get_arch_regstr(unsigned int n)
+{
+	return (n < CSKY_MAX_REGS) ? csky_dwarf_regs_table[n] : NULL;
+}
diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/arch/csky/util/unwind-libdw.c
new file mode 100644
index 0000000..078951b
--- /dev/null
+++ b/tools/perf/arch/csky/util/unwind-libdw.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
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
+#if defined(__CSKYABIV2__)
+	dwarf_regs[0]  = REG(A0);
+	dwarf_regs[1]  = REG(A1);
+	dwarf_regs[2]  = REG(A2);
+	dwarf_regs[3]  = REG(A3);
+	dwarf_regs[4]  = REG(REGS0);
+	dwarf_regs[5]  = REG(REGS1);
+	dwarf_regs[6]  = REG(REGS2);
+	dwarf_regs[7]  = REG(REGS3);
+	dwarf_regs[8]  = REG(REGS4);
+	dwarf_regs[9]  = REG(REGS5);
+	dwarf_regs[10] = REG(REGS6);
+	dwarf_regs[11] = REG(REGS7);
+	dwarf_regs[12] = REG(REGS8);
+	dwarf_regs[13] = REG(REGS9);
+	dwarf_regs[14] = REG(SP);
+	dwarf_regs[15] = REG(LR);
+	dwarf_regs[16] = REG(EXREGS0);
+	dwarf_regs[17] = REG(EXREGS1);
+	dwarf_regs[18] = REG(EXREGS2);
+	dwarf_regs[19] = REG(EXREGS3);
+	dwarf_regs[20] = REG(EXREGS4);
+	dwarf_regs[21] = REG(EXREGS5);
+	dwarf_regs[22] = REG(EXREGS6);
+	dwarf_regs[23] = REG(EXREGS7);
+	dwarf_regs[24] = REG(EXREGS8);
+	dwarf_regs[25] = REG(EXREGS9);
+	dwarf_regs[26] = REG(EXREGS10);
+	dwarf_regs[27] = REG(EXREGS11);
+	dwarf_regs[28] = REG(EXREGS12);
+	dwarf_regs[29] = REG(EXREGS13);
+	dwarf_regs[30] = REG(EXREGS14);
+	dwarf_regs[31] = REG(TLS);
+	dwarf_regs[32] = REG(PC);
+#else
+	dwarf_regs[0]  = REG(SP);
+	dwarf_regs[1]  = REG(REGS9);
+	dwarf_regs[2]  = REG(A0);
+	dwarf_regs[3]  = REG(A1);
+	dwarf_regs[4]  = REG(A2);
+	dwarf_regs[5]  = REG(A3);
+	dwarf_regs[6]  = REG(REGS0);
+	dwarf_regs[7]  = REG(REGS1);
+	dwarf_regs[8]  = REG(REGS2);
+	dwarf_regs[9]  = REG(REGS3);
+	dwarf_regs[10] = REG(REGS4);
+	dwarf_regs[11] = REG(REGS5);
+	dwarf_regs[12] = REG(REGS6);
+	dwarf_regs[13] = REG(REGS7);
+	dwarf_regs[14] = REG(REGS8);
+	dwarf_regs[15] = REG(LR);
+	dwarf_regs[32] = REG(PC);
+#endif
+	dwfl_thread_state_register_pc(thread, dwarf_regs[32]);
+
+	return dwfl_thread_state_registers(thread, 0, PERF_REG_CSKY_MAX,
+					   dwarf_regs);
+}
-- 
2.7.4

