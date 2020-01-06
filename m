Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335B3C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F581206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgAFUau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:30:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:10725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAFUa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:30:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 12:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="245699510"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 12:30:28 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 RESEND 11/14] perf/x86: Use event_base_rdpmc for RDPMC userspace support
Date:   Mon,  6 Jan 2020 12:29:16 -0800
Message-Id: <20200106202919.2943-12-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106202919.2943-1-kan.liang@linux.intel.com>
References: <20200106202919.2943-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The RDPMC index is always re-calculated in RDPMC userspace support,
especially for fixed counters.

The RDPMC index value is stored in variable event_base_rdpmc for kernel
usage, which can be used for RDPMC userspace support as well. Only the
metrics event has to be specially handled.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

 arch/x86/events/core.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 48dd920c5e7d..3ab18277e4a7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2203,20 +2203,16 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 
 static int x86_pmu_event_idx(struct perf_event *event)
 {
-	int idx = event->hw.idx;
+	struct hw_perf_event *hwc = &event->hw;
 
-	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(hwc->flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return 0;
 
 	/* Return PERF_METRICS MSR value for metrics event */
-	if (is_metric_idx(idx))
-		idx = 1 << 29;
-	else if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
-		idx -= INTEL_PMC_IDX_FIXED;
-		idx |= 1 << 30;
-	}
-
-	return idx + 1;
+	if (is_metric_idx(hwc->idx))
+		return (1 << 29) + 1;
+	else
+		return hwc->event_base_rdpmc + 1;
 }
 
 static ssize_t get_attr_rdpmc(struct device *cdev,
-- 
2.17.1

