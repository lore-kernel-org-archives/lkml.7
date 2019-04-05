Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F16C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B0621871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfDELio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:38:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33621 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:38:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BcYjH2734462
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:38:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BcYaG2734459;
        Fri, 5 Apr 2019 04:38:34 -0700
Date:   Fri, 5 Apr 2019 04:38:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-c2b3c170db610896e4e633cba2135045333811c2@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        ak@linux.intel.com
Reply-To: mingo@kernel.org, ak@linux.intel.com, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, hpa@zytor.com
In-Reply-To: <20190326221823.11518-2-andi@firstfloor.org>
References: <20190326221823.11518-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Revert checks for duration_time
Git-Commit-ID: c2b3c170db610896e4e633cba2135045333811c2
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

Commit-ID:  c2b3c170db610896e4e633cba2135045333811c2
Gitweb:     https://git.kernel.org/tip/c2b3c170db610896e4e633cba2135045333811c2
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 26 Mar 2019 15:18:20 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 14:49:24 -0300

perf stat: Revert checks for duration_time

This reverts e864c5ca145e ("perf stat: Hide internal duration_time
counter") but doing it manually since the code has now moved to a
different file.

The next patch will properly implement duration_time as a full event, so
no need to hide it anymore.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190326221823.11518-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
