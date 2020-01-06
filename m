Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990B3C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C0D24672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgAFUaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:30:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:10708 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgAFUaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:30:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 12:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="245699408"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 12:30:17 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 RESEND 01/14] perf/x86/intel: Introduce the fourth fixed counter
Date:   Mon,  6 Jan 2020 12:29:06 -0800
Message-Id: <20200106202919.2943-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106202919.2943-1-kan.liang@linux.intel.com>
References: <20200106202919.2943-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The fourth fixed counter, TOPDOWN.SLOTS, is introduced in Ice Lake.

Add MSR address and macros for the new fixed counter, which will be used
in the following patch.

Add comments to explain the event encoding rules for fixed counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V4:
- Add description regarding to event-code naming for fixed counters

 arch/x86/include/asm/perf_event.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ee26e9215f18..55a4d05ba6ec 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -146,12 +146,22 @@ struct x86_pmu_capability {
  */
 
 /*
- * All 3 fixed-mode PMCs are configured via this single MSR:
+ * All fixed-mode PMCs are configured via this single MSR:
  */
 #define MSR_ARCH_PERFMON_FIXED_CTR_CTRL	0x38d
 
 /*
- * The counts are available in three separate MSRs:
+ * There is no event-code assigned to fixed-mode PMCs.
+ * For the fixed-mode PMC which has an equivalent event on general-purpose PMCs,
+ * using the event-code of the equivalent event for the fixed-mode PMC.
+ * E.g. Instr_Retired.Any, CPU_CLK_Unhalted.Core
+ *
+ * For the fixed-mode PMCs which doesn't have an equivalent event,
+ * using pseudo-encoding, e.g. CPU_CLK_Unhalted.Ref, TOPDOWN.SLOTS.
+ * The event-code for fixed-mode PMCs must be 0x00.
+ * The umask-code is 0x0X. X indicates the index of the fixed counter.
+ *
+ * The counts are available in separate MSRs:
  */
 
 /* Instr_Retired.Any: */
@@ -162,11 +172,16 @@ struct x86_pmu_capability {
 #define MSR_ARCH_PERFMON_FIXED_CTR1	0x30a
 #define INTEL_PMC_IDX_FIXED_CPU_CYCLES	(INTEL_PMC_IDX_FIXED + 1)
 
-/* CPU_CLK_Unhalted.Ref: */
+/* CPU_CLK_Unhalted.Ref: event=0x00,umask=0x3 (pseudo-encoding) */
 #define MSR_ARCH_PERFMON_FIXED_CTR2	0x30b
 #define INTEL_PMC_IDX_FIXED_REF_CYCLES	(INTEL_PMC_IDX_FIXED + 2)
 #define INTEL_PMC_MSK_FIXED_REF_CYCLES	(1ULL << INTEL_PMC_IDX_FIXED_REF_CYCLES)
 
+/* TOPDOWN.SLOTS: event=0x00,umask=0x4 (pseudo-encoding) */
+#define MSR_ARCH_PERFMON_FIXED_CTR3	0x30c
+#define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
+#define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
+
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
-- 
2.17.1

