Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7EEC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6E924691
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgAFUam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:30:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:10726 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbgAFUab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:30:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 12:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="245699533"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.50])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 12:30:30 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 RESEND 13/14] perf, tools, stat: Check Topdown Metric group
Date:   Mon,  6 Jan 2020 12:29:18 -0800
Message-Id: <20200106202919.2943-14-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106202919.2943-1-kan.liang@linux.intel.com>
References: <20200106202919.2943-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The slots event is required in a Topdown Metric group.

Add a check to examine the Topdown Metric group. Error out if there is
no slots event detected.

Only check the group on the platform which using topdown_metric_attrs,
e.g. Ice Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New for V5

 tools/perf/builtin-stat.c | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0ed191bf8b5e..948a0300410c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1134,6 +1134,72 @@ static int topdown_filter_events(const char **attr, char **str, bool use_group)
 	return 0;
 }
 
+/* Event encoding for Topdown Metric events */
+#define TOPDOWN_SLOTS		0x0400
+#define TOPDOWN_RETIRE		0x1000
+#define TOPDOWN_BAD_SPEC	0x1100
+#define TOPDOWN_FE_BOUND	0x1200
+#define TOPDOWN_BE_BOUND	0x1300
+
+static bool is_topdown_metric_event(struct evsel *counter)
+{
+	if (!counter->pmu_name)
+		return false;
+
+	if (strcmp(counter->pmu_name, "cpu"))
+		return false;
+
+	if ((counter->core.attr.config == TOPDOWN_RETIRE) ||
+	    (counter->core.attr.config == TOPDOWN_BAD_SPEC) ||
+	    (counter->core.attr.config == TOPDOWN_FE_BOUND) ||
+	    (counter->core.attr.config == TOPDOWN_BE_BOUND))
+		return true;
+
+	return false;
+}
+
+static bool is_topdown_slots_event(struct evsel *counter)
+{
+	if (!counter->pmu_name)
+		return false;
+
+	if (strcmp(counter->pmu_name, "cpu"))
+		return false;
+
+	if (counter->core.attr.config == TOPDOWN_SLOTS)
+		return true;
+
+	return false;
+}
+
+static bool topdown_check_group_member(void)
+{
+	struct evsel *counter, *leader, *member;
+	bool has_slots;
+
+	if (!pmu_have_event("cpu", topdown_metric_attrs[0]))
+		return true;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		if (!is_topdown_metric_event(counter))
+			continue;
+
+		leader = counter->leader;
+		has_slots = false;
+
+		for_each_group_evsel(member, leader) {
+			if (is_topdown_slots_event(member))
+				has_slots = true;
+			counter = member;
+		}
+
+		if (!has_slots)
+			return false;
+	}
+
+	return true;
+}
+
 __weak bool arch_topdown_check_group(bool *warn)
 {
 	*warn = false;
@@ -1740,6 +1806,12 @@ int cmd_stat(int argc, const char **argv)
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
 	perf_stat__collect_metric_expr(evsel_list);
+
+	if (!topdown_check_group_member()) {
+		fprintf(stderr, "Topdown group must include slots event\n");
+		goto out;
+	}
+
 	perf_stat__init_shadow_stats();
 
 	if (stat_config.csv_sep) {
-- 
2.17.1

