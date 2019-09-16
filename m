Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E4BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9680621848
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbfIPNm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:42:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:53809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733255AbfIPNm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:42:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 06:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="387208985"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2019 06:42:57 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 01/14] perf/x86/intel: Introduce the fourth fixed counter
Date:   Mon, 16 Sep 2019 06:41:15 -0700
Message-Id: <20190916134128.18120-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916134128.18120-1-kan.liang@linux.intel.com>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The fourth fixed counter, TOPDOWN.SLOTS, is introduced in Ice Lake.

Add MSR address and macros for the new fixed counter, which will be used
in the following patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch for V4

 arch/x86/include/asm/perf_event.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ee26e9215f18..9f15a700d1db 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -146,12 +146,12 @@ struct x86_pmu_capability {
  */
 
 /*
- * All 3 fixed-mode PMCs are configured via this single MSR:
+ * All 4 fixed-mode PMCs are configured via this single MSR:
  */
 #define MSR_ARCH_PERFMON_FIXED_CTR_CTRL	0x38d
 
 /*
- * The counts are available in three separate MSRs:
+ * The counts are available in four separate MSRs:
  */
 
 /* Instr_Retired.Any: */
@@ -167,6 +167,11 @@ struct x86_pmu_capability {
 #define INTEL_PMC_IDX_FIXED_REF_CYCLES	(INTEL_PMC_IDX_FIXED + 2)
 #define INTEL_PMC_MSK_FIXED_REF_CYCLES	(1ULL << INTEL_PMC_IDX_FIXED_REF_CYCLES)
 
+/* TOPDOWN.SLOTS: */
+#define MSR_ARCH_PERFMON_FIXED_CTR3	0x30c
+#define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
+#define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
+
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
-- 
2.17.1

