Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D3C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0C92184C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfEUVlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:41:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:32416 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfEUVln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:41:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 14:41:42 -0700
X-ExtLoop1: 1
Received: from otc-icl-cdi-210.jf.intel.com ([10.54.55.28])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2019 14:41:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/9] perf/x86/intel: Support overflows on SLOTS
Date:   Tue, 21 May 2019 14:40:49 -0700
Message-Id: <20190521214055.31060-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190521214055.31060-1-kan.liang@linux.intel.com>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The internal counters used for the metrics can overflow. If this happens
an overflow is triggered on the SLOTS fixed counter. Add special code
that resets all the slave metric counters in this case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 75ed91a36413..a66dc761f09d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2279,12 +2279,35 @@ static void intel_pmu_add_event(struct perf_event *event)
 		intel_pmu_lbr_add(event);
 }
 
+/* When SLOTS overflowed update all the active topdown-* events */
+static void intel_pmu_update_metrics(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int idx;
+	u64 slots_events;
+
+	slots_events = *(u64 *)cpuc->enabled_events & INTEL_PMC_MSK_ANY_SLOTS;
+
+	for_each_set_bit(idx, (unsigned long *)&slots_events, 64) {
+		struct perf_event *ev = cpuc->events[idx];
+
+		if (ev == event)
+			continue;
+		x86_perf_event_update(event);
+	}
+}
+
 /*
  * Save and restart an expired event. Called by NMI contexts,
  * so it has to be careful about preempting normal event ops:
  */
 int intel_pmu_save_and_restart(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (unlikely(hwc->reg_idx == INTEL_PMC_IDX_FIXED_SLOTS))
+		intel_pmu_update_metrics(event);
+
 	x86_perf_event_update(event);
 	/*
 	 * For a checkpointed counter always reset back to 0.  This
-- 
2.14.5

