Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC82C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444D320857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfDBTrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:47:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:54553 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfDBTrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:47:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 12:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="130892961"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga008.jf.intel.com with ESMTP; 02 Apr 2019 12:47:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 01/12] perf/x86: Fix wrong PEBS_REGS
Date:   Tue,  2 Apr 2019 12:44:58 -0700
Message-Id: <20190402194509.2832-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402194509.2832-1-kan.liang@linux.intel.com>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

PEBS_REGS used as mask for the supported registers for large PEBS.
However, the mask cannot filter the sample_regs_user/sample_regs_intr
correctly.

(1ULL << PERF_REG_X86_*) should be used to replace PERF_REG_X86_*, which
is only the index.

Rename PEBS_REGS to PEBS_GPRS_REGS. Because the mask is only for general
purpose registers.

Fixes: 2fe1bc1f501d ("perf/x86: Enable free running PEBS for REGS_USER/INTR")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch for V5

 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/perf_event.h | 38 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8baa441d8000..a9721457f187 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3131,7 +3131,7 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_REGS)
+	if (event->attr.sample_regs_user & ~PEBS_GPRS_REGS)
 		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
 	return flags;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a75955741c50..00f700dd3c2d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -96,25 +96,25 @@ struct amd_nb {
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
 	PERF_SAMPLE_PERIOD)
 
-#define PEBS_REGS \
-	(PERF_REG_X86_AX | \
-	 PERF_REG_X86_BX | \
-	 PERF_REG_X86_CX | \
-	 PERF_REG_X86_DX | \
-	 PERF_REG_X86_DI | \
-	 PERF_REG_X86_SI | \
-	 PERF_REG_X86_SP | \
-	 PERF_REG_X86_BP | \
-	 PERF_REG_X86_IP | \
-	 PERF_REG_X86_FLAGS | \
-	 PERF_REG_X86_R8 | \
-	 PERF_REG_X86_R9 | \
-	 PERF_REG_X86_R10 | \
-	 PERF_REG_X86_R11 | \
-	 PERF_REG_X86_R12 | \
-	 PERF_REG_X86_R13 | \
-	 PERF_REG_X86_R14 | \
-	 PERF_REG_X86_R15)
+#define PEBS_GPRS_REGS                  \
+	((1ULL << PERF_REG_X86_AX)    | \
+	 (1ULL << PERF_REG_X86_BX)    | \
+	 (1ULL << PERF_REG_X86_CX)    | \
+	 (1ULL << PERF_REG_X86_DX)    | \
+	 (1ULL << PERF_REG_X86_DI)    | \
+	 (1ULL << PERF_REG_X86_SI)    | \
+	 (1ULL << PERF_REG_X86_SP)    | \
+	 (1ULL << PERF_REG_X86_BP)    | \
+	 (1ULL << PERF_REG_X86_IP)    | \
+	 (1ULL << PERF_REG_X86_FLAGS) | \
+	 (1ULL << PERF_REG_X86_R8)    | \
+	 (1ULL << PERF_REG_X86_R9)    | \
+	 (1ULL << PERF_REG_X86_R10)   | \
+	 (1ULL << PERF_REG_X86_R11)   | \
+	 (1ULL << PERF_REG_X86_R12)   | \
+	 (1ULL << PERF_REG_X86_R13)   | \
+	 (1ULL << PERF_REG_X86_R14)   | \
+	 (1ULL << PERF_REG_X86_R15))
 
 /*
  * Per register state.
-- 
2.17.1

