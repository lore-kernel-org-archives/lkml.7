Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB7521916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfCVQju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:39:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:60735 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbfCVQjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:39:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="144356634"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2019 09:39:40 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 14/23] perf/x86/intel: Support overflows on SLOTS
Date:   Fri, 22 Mar 2019 09:37:09 -0700
Message-Id: <20190322163718.2191-15-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322163718.2191-1-kan.liang@linux.intel.com>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
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

No changes since V2.

 arch/x86/events/intel/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5c8f0df137bc..2da822414627 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2231,12 +2231,35 @@ static void intel_pmu_add_event(struct perf_event *event)
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
2.17.1

