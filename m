Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E37E2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfE1WJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:09:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:11133 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfE1WJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:09:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 15:09:16 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga002.jf.intel.com with ESMTP; 28 May 2019 15:09:16 -0700
From:   kan.liang@linux.intel.com
To:     mingo@kernel.org, acme@redhat.com, peterz@infradead.org,
        vincent.weaver@maine.edu, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        jolsa@redhat.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 5/5] perf regs x86: Use PERF_REG_EXTENDED_MASK
Date:   Tue, 28 May 2019 15:08:34 -0700
Message-Id: <1559081314-9714-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
References: <1559081314-9714-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Use the macro defined in kernel ABI header to replace the local name.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Rename PERF_REG_NON_GENERIC_MASK to PERF_REG_EXTENDED_MASK

 tools/arch/x86/include/uapi/asm/perf_regs.h | 3 +++
 tools/perf/arch/x86/include/perf_regs.h     | 1 -
 tools/perf/arch/x86/util/perf_regs.c        | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index ac67bbe..7c9d2bb 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -52,4 +52,7 @@ enum perf_event_x86_regs {
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
+
+#define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index b7cd91a..b732133 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -9,7 +9,6 @@
 void perf_regs_load(u64 *regs);
 
 #define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
-#define PERF_XMM_REGS_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 #ifndef HAVE_ARCH_X86_64_SUPPORT
 #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 7886ca5..3666c00 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -277,7 +277,7 @@ uint64_t arch__intr_reg_mask(void)
 		.type			= PERF_TYPE_HARDWARE,
 		.config			= PERF_COUNT_HW_CPU_CYCLES,
 		.sample_type		= PERF_SAMPLE_REGS_INTR,
-		.sample_regs_intr	= PERF_XMM_REGS_MASK,
+		.sample_regs_intr	= PERF_REG_EXTENDED_MASK,
 		.precise_ip		= 1,
 		.disabled 		= 1,
 		.exclude_kernel		= 1,
@@ -293,7 +293,7 @@ uint64_t arch__intr_reg_mask(void)
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 	if (fd != -1) {
 		close(fd);
-		return (PERF_XMM_REGS_MASK | PERF_REGS_MASK);
+		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
 	}
 
 	return PERF_REGS_MASK;
-- 
2.7.4

