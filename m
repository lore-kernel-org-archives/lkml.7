Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FD62173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfCRVp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:45:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:57586 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbfCRVoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:44:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 14:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="308301771"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 14:44:10 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 01/22] perf/core: Support outputting registers from a separate array
Date:   Mon, 18 Mar 2019 14:41:23 -0700
Message-Id: <20190318214144.4639-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318214144.4639-1-kan.liang@linux.intel.com>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add support to the perf core for outputting registers from a separate
array and add support for outputting XMM registers for x86.

This requires changing all the perf_reg_value functions for the
different architectures to pass the additional argument. Except for x86,
they just ignore it.

XMM registers are 128 bit. To simplify the code, they are handled like
two different registers, which means setting two bits in the register
bitmap. This also allows only sampling the lower 64bit bits in XMM.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/arm/kernel/perf_regs.c           |  2 +-
 arch/arm64/kernel/perf_regs.c         |  2 +-
 arch/powerpc/perf/perf_regs.c         |  2 +-
 arch/s390/kernel/perf_regs.c          |  2 +-
 arch/x86/include/uapi/asm/perf_regs.h | 25 +++++++++++++++++++++++--
 arch/x86/kernel/perf_regs.c           | 17 ++++++++++++-----
 include/linux/perf_event.h            |  2 ++
 include/linux/perf_regs.h             |  4 ++--
 kernel/events/core.c                  |  7 +++++--
 9 files changed, 48 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index 05fe92aa7d98..1feedc151e87 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -8,7 +8,7 @@
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct pt_regs *regs, u64 *extra_regs, int idx)
 {
 	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM_MAX))
 		return 0;
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 0bbac612146e..85d7db5e5428 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -9,7 +9,7 @@
 #include <asm/perf_regs.h>
 #include <asm/ptrace.h>
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct pt_regs *regs, u64 *extra_regs, int idx)
 {
 	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ARM64_MAX))
 		return 0;
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 3349f3f8fe84..29380a99473a 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -73,7 +73,7 @@ static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_POWERPC_MMCRA, dsisr),
 };
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct pt_regs *regs, u64 *extra_regs, int idx)
 {
 	if (WARN_ON_ONCE(idx >= PERF_REG_POWERPC_MAX))
 		return 0;
diff --git a/arch/s390/kernel/perf_regs.c b/arch/s390/kernel/perf_regs.c
index 4352a504f235..88974116dbc6 100644
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -8,7 +8,7 @@
 #include <asm/fpu/api.h>
 #include <asm/fpu/types.h>
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct pt_regs *regs, u64 *extra_regs, int idx)
 {
 	freg_t fp;
 
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index f3329cabce5c..1ff0df1c97ae 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -28,7 +28,28 @@ enum perf_event_x86_regs {
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
+	PERF_REG_X86_MAX = PERF_REG_X86_XMM15 + 2,
 };
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index c06c4c16c6b6..8b44a4c5a161 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -10,14 +10,14 @@
 #include <asm/ptrace.h>
 
 #ifdef CONFIG_X86_32
-#define PERF_REG_X86_MAX PERF_REG_X86_32_MAX
+#define PERF_REG_GPR_X86_MAX PERF_REG_GPR_X86_32_MAX
 #else
-#define PERF_REG_X86_MAX PERF_REG_X86_64_MAX
+#define PERF_REG_GPR_X86_MAX PERF_REG_GPR_X86_64_MAX
 #endif
 
 #define PT_REGS_OFFSET(id, r) [id] = offsetof(struct pt_regs, r)
 
-static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
+static unsigned int pt_regs_offset[PERF_REG_GPR_X86_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_X86_AX, ax),
 	PT_REGS_OFFSET(PERF_REG_X86_BX, bx),
 	PT_REGS_OFFSET(PERF_REG_X86_CX, cx),
@@ -57,15 +57,22 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 #endif
 };
 
-u64 perf_reg_value(struct pt_regs *regs, int idx)
+u64 perf_reg_value(struct pt_regs *regs, u64 *extra_regs, int idx)
 {
+	if (idx >= 32 && idx < 64) {
+		if (!extra_regs)
+			return 0;
+		return extra_regs[idx - 32];
+	}
+
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
 		return 0;
 
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
-#define REG_RESERVED (~((1ULL << PERF_REG_X86_MAX) - 1ULL))
+#define REG_RESERVED \
+	(PERF_REG_X86_MAX == 64 ? 0 : ~((1ULL << PERF_REG_X86_MAX)) - 1ULL)
 
 #ifdef CONFIG_X86_32
 int perf_reg_validate(u64 mask)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e47ef764f613..bd3d6a89ccd4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -948,6 +948,7 @@ struct perf_sample_data {
 	u64				stack_user_size;
 
 	u64				phys_addr;
+	u64				*extra_regs;
 } ____cacheline_aligned;
 
 /* default value for data source */
@@ -968,6 +969,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->weight = 0;
 	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
+	data->extra_regs = NULL;
 }
 
 extern void perf_output_sample(struct perf_output_handle *handle,
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 476747456bca..9884c64d5598 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -11,14 +11,14 @@ struct perf_regs {
 
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
-u64 perf_reg_value(struct pt_regs *regs, int idx);
+u64 perf_reg_value(struct pt_regs *regs, u64 *extra_regs, int idx);
 int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs,
 			struct pt_regs *regs_user_copy);
 #else
-static inline u64 perf_reg_value(struct pt_regs *regs, int idx)
+static inline u64 perf_reg_value(struct pt_regs *regs, u64 *extra_regs, int idx)
 {
 	return 0;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f59d848171e..560ac237b8be 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5858,7 +5858,8 @@ EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 
 static void
 perf_output_sample_regs(struct perf_output_handle *handle,
-			struct pt_regs *regs, u64 mask)
+			struct pt_regs *regs,
+			u64 *extra_regs, u64 mask)
 {
 	int bit;
 	DECLARE_BITMAP(_mask, 64);
@@ -5867,7 +5868,7 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 	for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
 		u64 val;
 
-		val = perf_reg_value(regs, bit);
+		val = perf_reg_value(regs, extra_regs, bit);
 		perf_output_put(handle, val);
 	}
 }
@@ -6274,6 +6275,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 			u64 mask = event->attr.sample_regs_user;
 			perf_output_sample_regs(handle,
 						data->regs_user.regs,
+						NULL,
 						mask);
 		}
 	}
@@ -6306,6 +6308,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 
 			perf_output_sample_regs(handle,
 						data->regs_intr.regs,
+						data->extra_regs,
 						mask);
 		}
 	}
-- 
2.17.1

