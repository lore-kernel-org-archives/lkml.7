Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB5C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4B620C01
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="H/Rs0B3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfERJgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:36:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbfERJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:36:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9a61l1742998
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:36:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9a61l1742998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558172167;
        bh=3Z48mcT8j8am1sRY0udwCO08Hmk2fDYgq3uU6MG3WEw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=H/Rs0B3U28xgjUGIgpip/ZTFemV/YF4479uaNtjRP8E042jeF7kq5pIfCqT+ljdlj
         Mus1Wh2aECfu1yEz3qQafOd8hBgDyYzkpaQVFxRwmmgWBDmPY2bYAPXsLcAsbiuVYb
         OX6uGk5uo5pVABRSJMpAVlRk2Qd5jO9eXNgvioiPS1jVEe0GtCKQXTybTd1VyzAJ3o
         ifWpPjrQXuYFGOzrBGEIu0oB7/eVzbFTASyNx18C+xUHfPlcP5QywhV1V3Iht6ghKU
         MG/lB1m2Vr85FkjmLGncvIWd5wS44l/OxzhkMZb0aV/3s7KcuC6xluwsuRarlw4cdQ
         18W2Q0yal10Hg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9a62M1742995;
        Sat, 18 May 2019 02:36:06 -0700
Date:   Sat, 18 May 2019 02:36:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-40480a8136700d678dc07222c4d7287c89d0c04d@git.kernel.org>
Cc:     yao.jin@intel.com, acme@redhat.com, kan.liang@linux.intel.com,
        yao.jin@linux.intel.com, jolsa@kernel.org,
        ravi.bangoria@linux.ibm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        hpa@zytor.com
Reply-To: ak@linux.intel.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          hpa@zytor.com, acme@redhat.com, kan.liang@linux.intel.com,
          jolsa@kernel.org, ravi.bangoria@linux.ibm.com, yao.jin@intel.com,
          yao.jin@linux.intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <1555077590-27664-3-git-send-email-yao.jin@linux.intel.com>
References: <1555077590-27664-3-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Factor out aggregate counts printing
Git-Commit-ID: 40480a8136700d678dc07222c4d7287c89d0c04d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  40480a8136700d678dc07222c4d7287c89d0c04d
Gitweb:     https://git.kernel.org/tip/40480a8136700d678dc07222c4d7287c89d0c04d
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 12 Apr 2019 21:59:48 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:24 -0300

perf stat: Factor out aggregate counts printing

Move the aggregate counts printing to a new function
print_counter_aggrdata, which will be used in following patches.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1555077590-27664-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 64 +++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 3324f23c7efc..f5b4ee79568c 100644
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
