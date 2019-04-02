Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDABC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB70206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221426;
	bh=ccHuPlXAR7ezzcldoDq4MmlGtVtin1XesNIZQ6CiHkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xGl6Kq0R77r4VCv60tZtOAKaM4QpSnf8cew/+RMgnPtymwVqSeORDc3EM2OCxnw2F
	 suvbySbNImj/lNdM4kYAd+DQ3ixh4VzG29P7jU2iF4yCVtgkgLI2/9jw9hqWjcMpUp
	 7+6DezaXhVyCRXIlO4/etHhPwmhKOHxzt7QnPDtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfDBQG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbfDBQG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:26 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D606E208E4;
        Tue,  2 Apr 2019 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221185;
        bh=ccHuPlXAR7ezzcldoDq4MmlGtVtin1XesNIZQ6CiHkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDJtqejTCwHG5mWGKNiJpvn0En/ykMMdgW+/bOLj5VTizwoMi8Bb5JzXE3nrJLvHv
         sEZaTrvVqBr0xnqyoCvqgFrCPq+kgaKIU0Zr616wMGQJ3RJ6xF8vIXUwoiSyb13iIw
         vWsLwIwsd5wUIFDG2oqg7iKKGEhiAG1gKPFZaKIo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/44] perf stat: Revert checks for duration_time
Date:   Tue,  2 Apr 2019 13:05:12 -0300
Message-Id: <20190402160549.13544-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.20.1

