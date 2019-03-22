Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B393C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B7621900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfCVQk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:40:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:60745 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbfCVQjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:39:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="144356653"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2019 09:39:48 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 20/23] perf, tools: Add support for recording and printing XMM registers
Date:   Fri, 22 Mar 2019 09:37:15 -0700
Message-Id: <20190322163718.2191-21-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322163718.2191-1-kan.liang@linux.intel.com>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Newer kernel code can collect XMM registers in some cases.
Add support for perf script to dump them, and support
for the register parser in perf record -I ... to configure them.
For now they are just printed in hex, could potentially add
other formats too.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2.

 tools/arch/x86/include/uapi/asm/perf_regs.h | 26 ++++++++++++++++--
 tools/perf/arch/x86/include/perf_regs.h     | 29 ++++++++++++++++++---
 tools/perf/arch/x86/util/perf_regs.c        | 16 ++++++++++++
 tools/perf/util/perf_regs.h                 |  1 +
 4 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index f3329cabce5c..b33995313d17 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -28,7 +28,29 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
 
-	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	/* These all need two bits set because they are 128bit */
+	PERF_REG_X86_XMM0  = 32,
+	PERF_REG_X86_XMM1  = 34,
+	PERF_REG_X86_XMM2  = 36,
+	PERF_REG_X86_XMM3  = 38,
+	PERF_REG_X86_XMM4  = 40,
+	PERF_REG_X86_XMM5  = 42,
+	PERF_REG_X86_XMM6  = 44,
+	PERF_REG_X86_XMM7  = 46,
+	PERF_REG_X86_XMM8  = 48,
+	PERF_REG_X86_XMM9  = 50,
+	PERF_REG_X86_XMM10 = 52,
+	PERF_REG_X86_XMM11 = 54,
+	PERF_REG_X86_XMM12 = 56,
+	PERF_REG_X86_XMM13 = 58,
+	PERF_REG_X86_XMM14 = 60,
+	PERF_REG_X86_XMM15 = 62,
+
+	/* This does not include the XMMX registers */
+	PERF_REG_GPR_X86_32_MAX = PERF_REG_X86_GS + 1,
+	PERF_REG_GPR_X86_64_MAX = PERF_REG_X86_R15 + 1,
+
+	/* All registers include the XMMX registers */
+	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,
 };
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index 7f6d538f8a89..023484e9aebd 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -8,17 +8,16 @@
 
 void perf_regs_load(u64 *regs);
 
+#define PERF_REGS_MAX PERF_REG_X86_MAX
 #ifndef HAVE_ARCH_X86_64_SUPPORT
-#define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
-#define PERF_REGS_MAX PERF_REG_X86_32_MAX
+#define PERF_REGS_MASK ((1ULL << PERF_REG_GPR_X86_32_MAX) - 1)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
 #else
 #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_DS) | \
 		       (1ULL << PERF_REG_X86_ES) | \
 		       (1ULL << PERF_REG_X86_FS) | \
 		       (1ULL << PERF_REG_X86_GS))
-#define PERF_REGS_MASK (((1ULL << PERF_REG_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
-#define PERF_REGS_MAX PERF_REG_X86_64_MAX
+#define PERF_REGS_MASK (((1ULL << PERF_REG_GPR_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
 #endif
 #define PERF_REG_IP PERF_REG_X86_IP
@@ -77,6 +76,28 @@ static inline const char *perf_reg_name(int id)
 	case PERF_REG_X86_R15:
 		return "R15";
 #endif /* HAVE_ARCH_X86_64_SUPPORT */
+
+#define XMM(x) \
+	case PERF_REG_X86_XMM ## x:	\
+	case PERF_REG_X86_XMM ## x + 1:	\
+		return "XMM" #x;
+	XMM(0)
+	XMM(1)
+	XMM(2)
+	XMM(3)
+	XMM(4)
+	XMM(5)
+	XMM(6)
+	XMM(7)
+	XMM(8)
+	XMM(9)
+	XMM(10)
+	XMM(11)
+	XMM(12)
+	XMM(13)
+	XMM(14)
+	XMM(15)
+#undef XMM
 	default:
 		return NULL;
 	}
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index fead6b3b4206..71d7604dbf0b 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -31,6 +31,22 @@ const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(R14, PERF_REG_X86_R14),
 	SMPL_REG(R15, PERF_REG_X86_R15),
 #endif
+	SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
+	SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
+	SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
+	SMPL_REG2(XMM3, PERF_REG_X86_XMM3),
+	SMPL_REG2(XMM4, PERF_REG_X86_XMM4),
+	SMPL_REG2(XMM5, PERF_REG_X86_XMM5),
+	SMPL_REG2(XMM6, PERF_REG_X86_XMM6),
+	SMPL_REG2(XMM7, PERF_REG_X86_XMM7),
+	SMPL_REG2(XMM8, PERF_REG_X86_XMM8),
+	SMPL_REG2(XMM9, PERF_REG_X86_XMM9),
+	SMPL_REG2(XMM10, PERF_REG_X86_XMM10),
+	SMPL_REG2(XMM11, PERF_REG_X86_XMM11),
+	SMPL_REG2(XMM12, PERF_REG_X86_XMM12),
+	SMPL_REG2(XMM13, PERF_REG_X86_XMM13),
+	SMPL_REG2(XMM14, PERF_REG_X86_XMM14),
+	SMPL_REG2(XMM15, PERF_REG_X86_XMM15),
 	SMPL_REG_END
 };
 
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index c9319f8d17a6..1a15a4bfc28d 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -12,6 +12,7 @@ struct sample_reg {
 	uint64_t mask;
 };
 #define SMPL_REG(n, b) { .name = #n, .mask = 1ULL << (b) }
+#define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
 #define SMPL_REG_END { .name = NULL }
 
 extern const struct sample_reg sample_reg_masks[];
-- 
2.17.1

