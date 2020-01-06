Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BFFC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6802207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 03:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgAGDLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:11:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:30988 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgAGDLU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 22:11:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 19:11:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="217009579"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jan 2020 19:11:17 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/3] perf util: Flexible to set block info output formats
Date:   Tue,  7 Jan 2020 03:45:24 +0800
Message-Id: <20200106194525.12228-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106194525.12228-1-yao.jin@linux.intel.com>
References: <20200106194525.12228-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use a predefined array to set the
block info output formats, it's fixed and inflexible.

This patch adds two parameters "block_hpps" and "nr_hpps"
in block_info__create_report and other static functions,
in order to let user decide which columns to report and
with specified report ordering. It should be more flexible.

Buffers will be allocated to contain the new fmts, of course,
we need to release them before perf exits.

 v2:
 ---
 New patch created in v2.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c  | 25 +++++++++++---
 tools/perf/util/block-info.c | 64 ++++++++++++++++++++++++++----------
 tools/perf/util/block-info.h | 12 +++++--
 3 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index de988589d99b..81ae1f862d11 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -104,6 +104,7 @@ struct report {
 	bool			symbol_ipc;
 	bool			total_cycles_mode;
 	struct block_report	*block_reports;
+	int			nr_block_reports;
 };
 
 static int report__config(const char *var, const char *value, void *cb)
@@ -503,7 +504,7 @@ static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
 		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
 						 rep->min_percent, pos,
 						 &rep->session->header.env,
-						 &rep->annotation_opts);
+						 &rep->annotation_opts, true);
 		if (ret != 0)
 			return ret;
 	}
@@ -536,7 +537,7 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 		if (rep->total_cycles_mode) {
 			report__browse_block_hists(&rep->block_reports[i++].hist,
 						   rep->min_percent, pos,
-						   NULL, NULL);
+						   NULL, NULL, true);
 			continue;
 		}
 
@@ -966,8 +967,19 @@ static int __cmd_report(struct report *rep)
 	report__output_resort(rep);
 
 	if (rep->total_cycles_mode) {
+		int block_hpps[6] = {
+			PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
+			PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
+			PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
+			PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
+			PERF_HPP_REPORT__BLOCK_RANGE,
+			PERF_HPP_REPORT__BLOCK_DSO,
+		};
+
 		rep->block_reports = block_info__create_report(session->evlist,
-							       rep->total_cycles);
+							       rep->total_cycles,
+							       block_hpps, 6,
+							       &rep->nr_block_reports);
 		if (!rep->block_reports)
 			return -1;
 	}
@@ -1543,8 +1555,11 @@ int cmd_report(int argc, const char **argv)
 		zfree(&report.ptime_range);
 	}
 
-	if (report.block_reports)
-		zfree(&report.block_reports);
+	if (report.block_reports) {
+		block_info__free_report(report.block_reports,
+					report.nr_block_reports);
+		report.block_reports = NULL;
+	}
 
 	zstd_fini(&(session->zstd_data));
 	perf_session__delete(session);
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 18a445938681..0818db17b3f2 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -376,33 +376,42 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
 }
 
 static void register_block_columns(struct perf_hpp_list *hpp_list,
-				   struct block_fmt *block_fmts)
+				   struct block_fmt *block_fmts,
+				   int *block_hpps, int nr_hpps)
 {
-	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++)
-		hpp_register(&block_fmts[i], i, hpp_list);
+	for (int i = 0; i < nr_hpps; i++)
+		hpp_register(&block_fmts[i], block_hpps[i], hpp_list);
 }
 
-static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts)
+static void init_block_hist(struct block_hist *bh, struct block_fmt *block_fmts,
+			    int *block_hpps, int nr_hpps)
 {
 	__hists__init(&bh->block_hists, &bh->block_list);
 	perf_hpp_list__init(&bh->block_list);
 	bh->block_list.nr_header_lines = 1;
 
-	register_block_columns(&bh->block_list, block_fmts);
+	register_block_columns(&bh->block_list, block_fmts,
+			       block_hpps, nr_hpps);
 
-	perf_hpp_list__register_sort_field(&bh->block_list,
-		&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
+	/* Sort by the first fmt */
+	perf_hpp_list__register_sort_field(&bh->block_list, &block_fmts[0].fmt);
 }
 
-static void process_block_report(struct hists *hists,
-				 struct block_report *block_report,
-				 u64 total_cycles)
+static int process_block_report(struct hists *hists,
+				struct block_report *block_report,
+				u64 total_cycles, int *block_hpps,
+				int nr_hpps)
 {
 	struct rb_node *next = rb_first_cached(&hists->entries);
 	struct block_hist *bh = &block_report->hist;
 	struct hist_entry *he;
 
-	init_block_hist(bh, block_report->fmts);
+	block_report->fmts = calloc(nr_hpps, sizeof(struct block_fmt));
+	if (!block_report->fmts)
+		return -1;
+
+	block_report->nr_fmts = nr_hpps;
+	init_block_hist(bh, block_report->fmts, block_hpps, nr_hpps);
 
 	while (next) {
 		he = rb_entry(next, struct hist_entry, rb_node);
@@ -411,16 +420,19 @@ static void process_block_report(struct hists *hists,
 		next = rb_next(&he->rb_node);
 	}
 
-	for (int i = 0; i < PERF_HPP_REPORT__BLOCK_MAX_INDEX; i++) {
+	for (int i = 0; i < nr_hpps; i++) {
 		block_report->fmts[i].total_cycles = total_cycles;
 		block_report->fmts[i].block_cycles = block_report->cycles;
 	}
 
 	hists__output_resort(&bh->block_hists, NULL);
+	return 0;
 }
 
 struct block_report *block_info__create_report(struct evlist *evlist,
-					       u64 total_cycles)
+					       u64 total_cycles,
+					       int *block_hpps, int nr_hpps,
+					       int *nr_reps)
 {
 	struct block_report *block_reports;
 	int nr_hists = evlist->core.nr_entries, i = 0;
@@ -433,16 +445,30 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
-		process_block_report(hists, &block_reports[i], total_cycles);
+		process_block_report(hists, &block_reports[i], total_cycles,
+				     block_hpps, nr_hpps);
 		i++;
 	}
 
+	*nr_reps = nr_hists;
 	return block_reports;
 }
 
+void block_info__free_report(struct block_report *reps, int nr_reps)
+{
+	for (int i = 0; i < nr_reps; i++) {
+		hists__delete_entries(&reps[i].hist.block_hists);
+		if (reps[i].fmts)
+			free(reps[i].fmts);
+	}
+
+	free(reps);
+}
+
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       struct evsel *evsel, struct perf_env *env,
-			       struct annotation_options *annotation_opts)
+			       struct annotation_options *annotation_opts,
+			       bool release)
 {
 	int ret;
 
@@ -451,13 +477,17 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 		symbol_conf.report_individual_block = true;
 		hists__fprintf(&bh->block_hists, true, 0, 0, min_percent,
 			       stdout, true);
-		hists__delete_entries(&bh->block_hists);
+		if (release)
+			hists__delete_entries(&bh->block_hists);
+
 		return 0;
 	case 1:
 		symbol_conf.report_individual_block = true;
 		ret = block_hists_tui_browse(bh, evsel, min_percent,
 					     env, annotation_opts);
-		hists__delete_entries(&bh->block_hists);
+		if (release)
+			hists__delete_entries(&bh->block_hists);
+
 		return ret;
 	default:
 		return -1;
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index bfa22c59195d..0bf01e3a423d 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -44,7 +44,8 @@ enum {
 struct block_report {
 	struct block_hist	hist;
 	u64			cycles;
-	struct block_fmt	fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
+	struct block_fmt	*fmts;
+	int			nr_fmts;
 };
 
 struct block_hist;
@@ -68,11 +69,16 @@ int block_info__process_sym(struct hist_entry *he, struct block_hist *bh,
 			    u64 *block_cycles_aggr, u64 total_cycles);
 
 struct block_report *block_info__create_report(struct evlist *evlist,
-					       u64 total_cycles);
+					       u64 total_cycles,
+					       int *block_hpps, int nr_hpps,
+					       int *nr_reps);
+
+void block_info__free_report(struct block_report *reps, int nr_reps);
 
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       struct evsel *evsel, struct perf_env *env,
-			       struct annotation_options *annotation_opts);
+			       struct annotation_options *annotation_opts,
+			       bool release);
 
 float block_info__total_cycles_percent(struct hist_entry *he);
 
-- 
2.17.1

