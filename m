Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B722186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfDLGJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:09:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:15191 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfDLGJh (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:09:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 23:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; 
   d="scan'208";a="148609856"
Received: from skl.sh.intel.com ([10.239.159.132])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2019 23:09:35 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 2/4] perf stat: Factor out aggregate counts printing
Date:   Fri, 12 Apr 2019 21:59:48 +0800
Message-Id: <1555077590-27664-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
References: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the aggregate counts printing to a new function
print_counter_aggrdata, which will be used in following
patches.

 v4:
 ---
 Rebase to latest perf/core branch.

 v3:
 ---
 No change

 v2:
 ---
 Create this patch according to Jiri's comments.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat-display.c | 64 +++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 3324f23..f5b4ee7 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -594,6 +594,41 @@ static void aggr_cb(struct perf_stat_config *config,
 	}
 }
 
+static void print_counter_aggrdata(struct perf_stat_config *config,
+				   struct perf_evsel *counter, int s,
+				   char *prefix, bool metric_only,
+				   bool *first)
+{
+	struct aggr_data ad;
+	FILE *output = config->output;
+	u64 ena, run, val;
+	int id, nr;
+	double uval;
+
+	ad.id = id = config->aggr_map->map[s];
+	ad.val = ad.ena = ad.run = 0;
+	ad.nr = 0;
+	if (!collect_data(config, counter, aggr_cb, &ad))
+		return;
+
+	nr = ad.nr;
+	ena = ad.ena;
+	run = ad.run;
+	val = ad.val;
+	if (*first && metric_only) {
+		*first = false;
+		aggr_printout(config, counter, id, nr);
+	}
+	if (prefix && !metric_only)
+		fprintf(output, "%s", prefix);
+
+	uval = val * counter->scale;
+	printout(config, id, nr, counter, uval, prefix,
+		 run, ena, 1.0, &rt_stat);
+	if (!metric_only)
+		fputc('\n', output);
+}
+
 static void print_aggr(struct perf_stat_config *config,
 		       struct perf_evlist *evlist,
 		       char *prefix)
@@ -601,9 +636,7 @@ static void print_aggr(struct perf_stat_config *config,
 	bool metric_only = config->metric_only;
 	FILE *output = config->output;
 	struct perf_evsel *counter;
-	int s, id, nr;
-	double uval;
-	u64 ena, run, val;
+	int s;
 	bool first;
 
 	if (!(config->aggr_map || config->aggr_get_id))
@@ -616,33 +649,14 @@ static void print_aggr(struct perf_stat_config *config,
 	 * Without each counter has its own line.
 	 */
 	for (s = 0; s < config->aggr_map->nr; s++) {
-		struct aggr_data ad;
 		if (prefix && metric_only)
 			fprintf(output, "%s", prefix);
 
-		ad.id = id = config->aggr_map->map[s];
 		first = true;
 		evlist__for_each_entry(evlist, counter) {
-			ad.val = ad.ena = ad.run = 0;
-			ad.nr = 0;
-			if (!collect_data(config, counter, aggr_cb, &ad))
-				continue;
-			nr = ad.nr;
-			ena = ad.ena;
-			run = ad.run;
-			val = ad.val;
-			if (first && metric_only) {
-				first = false;
-				aggr_printout(config, counter, id, nr);
-			}
-			if (prefix && !metric_only)
-				fprintf(output, "%s", prefix);
-
-			uval = val * counter->scale;
-			printout(config, id, nr, counter, uval, prefix,
-				 run, ena, 1.0, &rt_stat);
-			if (!metric_only)
-				fputc('\n', output);
+			print_counter_aggrdata(config, counter, s,
+					       prefix, metric_only,
+					       &first);
 		}
 		if (metric_only)
 			fputc('\n', output);
-- 
2.7.4

