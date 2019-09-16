Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E0CC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42262216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbfIPNnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:43:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:53831 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387874AbfIPNnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:43:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 06:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="387209048"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga006.fm.intel.com with ESMTP; 16 Sep 2019 06:43:11 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 12/14] perf/x86: Use event_base_rdpmc for RDPMC userspace support
Date:   Mon, 16 Sep 2019 06:41:26 -0700
Message-Id: <20190916134128.18120-13-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916134128.18120-1-kan.liang@linux.intel.com>
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
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
 arch/x86/events/core.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 350c21aaea61..10ce4c381425 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2197,20 +2197,16 @@ static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *m
 
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

