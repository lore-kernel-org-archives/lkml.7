Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF76C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF8720840
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbfGXR1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:27:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:32494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387514AbfGXR1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:27:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 10:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="368859113"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2019 10:18:30 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 6/8] perf/x86/intel: Disable sampling read slots and topdown
Date:   Wed, 24 Jul 2019 10:17:51 -0700
Message-Id: <20190724171753.8087-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724171753.8087-1-kan.liang@linux.intel.com>
References: <20190724171753.8087-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The slots event supports sampling. Users may sampling read slots and
metrics events, e.g perf record -e '{slots, topdown-retiring}:S'.
But the metrics event will reset the fixed counter 3 which will impact
the sampling of the slots event.

Add specific validate_group() support to reject the case and error out
for Icelake.

An alternative fix may unconditionally disable SLOTS sampling. But it's
not a decent fix. Because users may want to only sampling slot events
without topdown metrics event.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  4 ++++
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 77573fa379dc..7fb98890d885 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2057,7 +2057,11 @@ static int validate_group(struct perf_event *event)
 
 	fake_cpuc->n_events = 0;
 	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
+	if (ret)
+		goto out;
 
+	if (x86_pmu.validate_group)
+		ret = x86_pmu.validate_group(fake_cpuc, n);
 out:
 	free_fake_cpuc(fake_cpuc);
 	return ret;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7925cf8830eb..4e0d60fcd1eb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4489,6 +4489,25 @@ static __init void intel_ht_bug(void)
 	x86_pmu.stop_scheduling = intel_stop_scheduling;
 }
 
+static int icl_validate_group(struct cpu_hw_events *cpuc, int n)
+{
+	bool has_sampling_slots = false, has_metrics = false;
+	struct perf_event *e;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		e = cpuc->event_list[i];
+		if (is_slots_event(e) && is_sampling_event(e))
+			has_sampling_slots = true;
+
+		if (is_metric_event(e))
+			has_metrics = true;
+	}
+	if (unlikely(has_sampling_slots && has_metrics))
+		return -EINVAL;
+	return 0;
+}
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_hsw,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_hsw,	"event=0xd0,umask=0x82")
 
@@ -5334,6 +5353,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(pmem);
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
+		x86_pmu.validate_group = icl_validate_group;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7c59f08fadc0..34c6ab5cafe8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -629,6 +629,8 @@ struct x86_pmu {
 	int		perfctr_second_write;
 	u64		(*limit_period)(struct perf_event *event, u64 l);
 
+	int		(*validate_group)(struct cpu_hw_events *cpuc, int n);
+
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
 			counter_freezing	:1;
-- 
2.17.1

