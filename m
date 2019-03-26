Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B92C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BACD20811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbfCZQL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:11:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:55251 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCZQLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:11:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 09:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,273,1549958400"; 
   d="scan'208";a="217714722"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2019 09:11:25 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 03/23] perf/x86/intel/ds: Extract code of event update in short period
Date:   Tue, 26 Mar 2019 09:08:41 -0700
Message-Id: <20190326160901.4887-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326160901.4887-1-kan.liang@linux.intel.com>
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The drain_pebs() could be called twice in a short period for auto-reload
event in pmu::read(). The intel_pmu_save_and_restart_reload() should be
called to update the event->count.
This case should also be handled on Icelake. Extract the codes for reuse
later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V3.

 arch/x86/events/intel/ds.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c02cd19fe640..efc054aee3c1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1491,6 +1491,26 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
 	__intel_pmu_pebs_event(event, iregs, at, top, 0, n);
 }
 
+static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc,
+						 int size)
+{
+	struct perf_event *event;
+	int bit;
+
+	/*
+	 * The drain_pebs() could be called twice in a short period
+	 * for auto-reload event in pmu::read(). There are no
+	 * overflows have happened in between.
+	 * It needs to call intel_pmu_save_and_restart_reload() to
+	 * update the event->count for this case.
+	 */
+	for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled, size) {
+		event = cpuc->events[bit];
+		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+			intel_pmu_save_and_restart_reload(event, 0);
+	}
+}
+
 static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1518,19 +1538,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 	}
 
 	if (unlikely(base >= top)) {
-		/*
-		 * The drain_pebs() could be called twice in a short period
-		 * for auto-reload event in pmu::read(). There are no
-		 * overflows have happened in between.
-		 * It needs to call intel_pmu_save_and_restart_reload() to
-		 * update the event->count for this case.
-		 */
-		for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled,
-				 size) {
-			event = cpuc->events[bit];
-			if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
-				intel_pmu_save_and_restart_reload(event, 0);
-		}
+		intel_pmu_pebs_event_update_no_drain(cpuc, size);
 		return;
 	}
 
-- 
2.17.1

