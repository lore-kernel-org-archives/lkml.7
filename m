Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE81C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C332084C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 06:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfKFGPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:15:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:2425 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKFGPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:15:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 22:15:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,272,1569308400"; 
   d="scan'208";a="227382779"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2019 22:15:44 -0800
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] perf/x86: Expose more Intel perf_capabilities to other modules
Date:   Tue,  5 Nov 2019 22:09:55 +0800
Message-Id: <20191105140955.22504-1-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vPMU feature on KVM is dependent on the native perf implementation.
Now KVM needs to know more about PMU capabilities such as lbr, pebs and
full_width_write to determine what features it can provide for guests.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/events/core.c            |  1 +
 arch/x86/events/perf_event.h      | 19 -------------------
 arch/x86/include/asm/perf_event.h | 20 ++++++++++++++++++++
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b21455d7504..fe8bb51cb277 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2587,5 +2587,6 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->bit_width_fixed	= x86_pmu.cntval_bits;
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
+	cap->pmu_cap		= x86_pmu.intel_cap;
 }
 EXPORT_SYMBOL_GPL(perf_get_x86_pmu_capability);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ecacfbf4ebc1..ca1c94dd111f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -505,25 +505,6 @@ struct extra_reg {
 
 #define EVENT_EXTRA_END EVENT_EXTRA_REG(0, 0, 0, 0, RSP_0)
 
-union perf_capabilities {
-	struct {
-		u64	lbr_format:6;
-		u64	pebs_trap:1;
-		u64	pebs_arch_reg:1;
-		u64	pebs_format:4;
-		u64	smm_freeze:1;
-		/*
-		 * PMU supports separate counter range for writing
-		 * values > 32bit.
-		 */
-		u64	full_width_write:1;
-		u64     pebs_baseline:1;
-		u64	pebs_metrics_available:1;
-		u64	pebs_output_pt_available:1;
-	};
-	u64	capabilities;
-};
-
 struct x86_pmu_quirk {
 	struct x86_pmu_quirk *next;
 	void (*func)(void);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ee26e9215f18..7983cc8e5a15 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -131,6 +131,25 @@ union cpuid10_edx {
 	unsigned int full;
 };
 
+union perf_capabilities {
+	struct {
+		u64	lbr_format:6;
+		u64	pebs_trap:1;
+		u64	pebs_arch_reg:1;
+		u64	pebs_format:4;
+		u64	smm_freeze:1;
+		/*
+		 * PMU supports separate counter range for writing
+		 * values > 32bit.
+		 */
+		u64	full_width_write:1;
+		u64     pebs_baseline:1;
+		u64	pebs_metrics_available:1;
+		u64	pebs_output_pt_available:1;
+	};
+	u64	capabilities;
+};
+
 struct x86_pmu_capability {
 	int		version;
 	int		num_counters_gp;
@@ -139,6 +158,7 @@ struct x86_pmu_capability {
 	int		bit_width_fixed;
 	unsigned int	events_mask;
 	int		events_mask_len;
+	union perf_capabilities pmu_cap;
 };
 
 /*
-- 
2.21.0

