Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B73C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F4D20869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555860831;
	bh=MgCZV90sHZrYqsprfn4+zTfU1avE756W5wm3mWtHzi0=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=ZEsuZQEwUxv9GkwjTcL8U3R8Q173k2iNbLViVJ9zwgXqZdezWupbZFRApi0B8O2Pa
	 UqBjpaIDzk/zxezLDoYTB8h1HcMhz1HMh/WCZlJCO3j+sbn/B7Bp9vKBV+8Sum66mZ
	 v9cY5RUmf44GjUZUAIpxEc9dMZCAvdOUn0QUBhFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfDUPds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 11:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfDUPds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 11:33:48 -0400
Received: from localhost.localdomain (unknown [115.206.242.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0831920833;
        Sun, 21 Apr 2019 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555860827;
        bh=MgCZV90sHZrYqsprfn4+zTfU1avE756W5wm3mWtHzi0=;
        h=From:To:Cc:Subject:Date:From;
        b=lRm6AXkZxnwRZblQpLDn8tUp8pPPSd77WtSTuxbFVB1GAjakSPrutMs7MOh5qd/R/
         GrKyTjdGk/7RrSbqJoKNdVqqu1hHH+7C7e9X5qA7KvwBcN1hLnNlqVoC9tDMOwrmP4
         xv+SOP4HzNo+ozF7NNBV7C3QpVy0Ax9PUXp9H1Z4=
From:   guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Mao Han <han_mao@c-sky.com>, Guo Ren <ren_guo@c-sky.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnd Bergmann <arnd@arnd.de>
Subject: [PATCH] csky: Add support for libdw
Date:   Sun, 21 Apr 2019 23:33:14 +0800
Message-Id: <1555860794-10572-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

This patch add support for DWARF register mappings and libdw registers
initialization, which is used by perf callchain analyzing when
--call-graph=dwarf is given.

Here is elfutils csky backend patch set:
https://sourceware.org/ml/elfutils-devel/2019-q2/msg00007.html

Signed-off-by: Mao Han <han_mao@c-sky.com>
Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnd Bergmann <arnd@arnd.de>
---
 tools/arch/csky/include/uapi/asm/perf_regs.h |  51 ++++++++++++++
 tools/perf/Makefile.config                   |   6 +-
 tools/perf/arch/csky/Build                   |   1 +
 tools/perf/arch/csky/Makefile                |   3 +
 tools/perf/arch/csky/include/perf_regs.h     | 100 +++++++++++++++++++++++++++
 tools/perf/arch/csky/util/Build              |   2 +
 tools/perf/arch/csky/util/dwarf-regs.c       |  49 +++++++++++++
 tools/perf/arch/csky/util/unwind-libdw.c     |  77 +++++++++++++++++++++
 8 files changed, 288 insertions(+), 1 deletion(-)
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
index 0000000..ca86eca
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
+#define CSKY_MAX_REGS 73
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
+	"%pc", NULL, NULL, NULL, "%hi", "%lo", NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	"%epc",
+};
+#else
+#define CSKY_MAX_REGS 57
+const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
+	/* r0 ~ r8 */
+	"%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
+	/* r9 ~ r15 */
+	"%regs2", "%regs3", "%regs4", "%regs5", "%regs6", "%regs7", "%regs8",
+	"%lr",
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+	"%epc",
+};
+#endif
+
+const char *get_arch_regstr(unsigned int n)
+{
+	return (n < CSKY_MAX_REGS) ? csky_dwarf_regs_table[n] : NULL;
+}
diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/arch/csky/util/unwind-libdw.c
new file mode 100644
index 0000000..4bb4a06
--- /dev/null
+++ b/tools/perf/arch/csky/util/unwind-libdw.c
@@ -0,0 +1,77 @@
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
+#endif
+	dwfl_thread_state_register_pc(thread, REG(PC));
+
+	return dwfl_thread_state_registers(thread, 0, PERF_REG_CSKY_MAX,
+					   dwarf_regs);
+}
-- 
2.7.4

