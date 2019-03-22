Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC0CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AE021900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfCVQjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:39:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:60745 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbfCVQjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:39:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 09:39:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="144356643"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2019 09:39:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 18/23] perf/x86/intel: Disable sampling read slots and topdown
Date:   Fri, 22 Mar 2019 09:37:13 -0700
Message-Id: <20190322163718.2191-19-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322163718.2191-1-kan.liang@linux.intel.com>
References: <20190322163718.2191-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To get correct PERF_METRICS value, the fixed counter 3 must start from
0. It would bring problems when sampling read slots and topdown events.
For example,
        perf record -e '{slots, topdown-retiring}:S'
The slots would not overflow if it starts from 0.

Add specific validate_group() support to reject the case and error out
for Icelake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2.

 arch/x86/events/core.c       |  2 ++
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7d4d56f76436..b9bee53e53d8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2122,6 +2122,8 @@ static int validate_group(struct perf_event *event)
 
 	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
 
+	if (x86_pmu.validate_group)
+		ret = x86_pmu.validate_group(fake_cpuc, n);
 out:
 	free_fake_cpuc(fake_cpuc);
 	return ret;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b08e361fc718..ef6045544628 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4331,6 +4331,25 @@ static int icl_set_period(struct perf_event *event)
 	return 1;
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
+		if (is_perf_metrics_event(e))
+			has_metrics = true;
+	}
+	if (unlikely(has_sampling_slots && has_metrics))
+		return -EINVAL;
+	return 0;
+}
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_hsw,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_hsw,	"event=0xd0,umask=0x82")
 
@@ -5037,6 +5056,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.has_metric = x86_pmu.intel_cap.perf_metrics;
 		x86_pmu.metric_update_event = icl_metric_update_event;
 		x86_pmu.set_period = icl_set_period;
+		x86_pmu.validate_group = icl_validate_group;
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6500463bda85..077d44a96d31 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -631,6 +631,8 @@ struct x86_pmu {
 	u64		(*limit_period)(struct perf_event *event, u64 l);
 	int		(*set_period)(struct perf_event *event);
 
+	int		(*validate_group)(struct cpu_hw_events *cpuc, int n);
+
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
 			counter_freezing	:1;
-- 
2.17.1

