Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BC7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfCZWS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:18:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:55268 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbfCZWS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:18:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 15:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="145482959"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2019 15:18:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AC4753015ED; Tue, 26 Mar 2019 15:18:28 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/4] perf, tools: Revert checks for duration_time
Date:   Tue, 26 Mar 2019 15:18:20 -0700
Message-Id: <20190326221823.11518-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326221823.11518-1-andi@firstfloor.org>
References: <20190326221823.11518-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

This reverts e864c5ca145e perf stat: Hide internal duration_time counter
but doing it manually since the code has now moved to a different file.

The next patch will properly implement duration_time as a full
event, so no need to hide it anymore.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/stat-display.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6d043c78f3c2..3324f23c7efc 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -18,11 +18,6 @@
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
 
-static bool is_duration_time(struct perf_evsel *evsel)
-{
-	return !strcmp(evsel->name, "duration_time");
-}
-
 static void print_running(struct perf_stat_config *config,
 			  u64 run, u64 ena)
 {
@@ -628,9 +623,6 @@ static void print_aggr(struct perf_stat_config *config,
 		ad.id = id = config->aggr_map->map[s];
 		first = true;
 		evlist__for_each_entry(evlist, counter) {
-			if (is_duration_time(counter))
-				continue;
-
 			ad.val = ad.ena = ad.run = 0;
 			ad.nr = 0;
 			if (!collect_data(config, counter, aggr_cb, &ad))
@@ -848,8 +840,6 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 		if (prefix)
 			fputs(prefix, config->output);
 		evlist__for_each_entry(evlist, counter) {
-			if (is_duration_time(counter))
-				continue;
 			if (first) {
 				aggr_printout(config, counter, cpu, 0);
 				first = false;
@@ -906,8 +896,6 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
-		if (is_duration_time(counter))
-			continue;
 		os.evsel = counter;
 		out.ctx = &os;
 		out.print_metric = print_metric_header;
@@ -1136,15 +1124,11 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		break;
 	case AGGR_THREAD:
 		evlist__for_each_entry(evlist, counter) {
-			if (is_duration_time(counter))
-				continue;
 			print_aggr_thread(config, _target, counter, prefix);
 		}
 		break;
 	case AGGR_GLOBAL:
 		evlist__for_each_entry(evlist, counter) {
-			if (is_duration_time(counter))
-				continue;
 			print_counter_aggr(config, counter, prefix);
 		}
 		if (metric_only)
@@ -1155,8 +1139,6 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_no_aggr_metric(config, evlist, prefix);
 		else {
 			evlist__for_each_entry(evlist, counter) {
-				if (is_duration_time(counter))
-					continue;
 				print_counter(config, counter, prefix);
 			}
 		}
-- 
2.20.1

