Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FE7C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB162081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfETFiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:38:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:24172 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730374AbfETFiH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:38:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 May 2019 22:38:07 -0700
X-ExtLoop1: 1
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2019 22:38:05 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 4/9] perf diff: Get a list of symbols(functions)
Date:   Mon, 20 May 2019 21:27:51 +0800
Message-Id: <1558358876-32211-5-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
References: <1558358876-32211-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have a function hist__account_cycles() which can be used
to account cycles per basic block in symbol/function. But we also
need to know what the symbols are, since we need to get basic blocks
of all symbols(functions) before diff.

This patch records the sorted symbols in sym_hists, which will be
used in next patch for accounting cycles per basic block per
function.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 81 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 6023f8c..e067ac6 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -26,6 +26,12 @@
 #include <stdlib.h>
 #include <math.h>
 
+struct block_hists {
+	struct hists		sym_hists;
+	struct perf_hpp_list	sym_list;
+	struct perf_hpp_fmt	sym_fmt;
+};
+
 struct perf_diff {
 	struct perf_tool		 tool;
 	const char			*time_str;
@@ -33,6 +39,8 @@ struct perf_diff {
 	int				 range_size;
 	int				 range_num;
 	bool				 has_br_stack;
+	bool				 basic_block;
+	struct block_hists		*block_hists;
 };
 
 /* Diff command specific HPP columns. */
@@ -62,6 +70,7 @@ struct data__file {
 	int			 idx;
 	struct hists		*hists;
 	struct diff_hpp_fmt	 fmt[PERF_HPP_DIFF__MAX_INDEX];
+	struct block_hists       block_hists;
 };
 
 static struct data__file *data__files;
@@ -363,9 +372,18 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		goto out_put;
 	}
 
-	if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample, true)) {
-		pr_warning("problem incrementing symbol period, skipping event\n");
-		goto out_put;
+	if (pdiff->has_br_stack && pdiff->basic_block) {
+		if (!hists__add_entry(&pdiff->block_hists->sym_hists, &al,
+			NULL, NULL, NULL, sample, false)) {
+			pr_warning("problem counting symbol for basic block\n");
+			goto out_put;
+		}
+	} else {
+		if (!hists__add_entry(hists, &al, NULL, NULL, NULL,
+				      sample, true)) {
+			pr_warning("problem incrementing symbol period, skipping event\n");
+			goto out_put;
+		}
 	}
 
 	/*
@@ -899,6 +917,37 @@ static int check_file_brstack(void)
 	return 0;
 }
 
+static int64_t symbol_se_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+			     struct hist_entry *a, struct hist_entry *b)
+{
+	return sort_sym.se_cmp(a, b);
+}
+
+static int block_sym_hists_init(struct block_hists *hists)
+{
+	struct perf_hpp_fmt *fmt;
+
+	__hists__init(&hists->sym_hists, &hists->sym_list);
+	perf_hpp_list__init(&hists->sym_list);
+	fmt = &hists->sym_fmt;
+	INIT_LIST_HEAD(&fmt->list);
+	INIT_LIST_HEAD(&fmt->sort_list);
+
+	fmt->cmp = symbol_se_cmp;
+	perf_hpp_list__register_sort_field(&hists->sym_list, fmt);
+	return 0;
+}
+
+static void basic_block_process(void)
+{
+	struct data__file *d;
+	int i;
+
+	data__for_each_file(i, d) {
+		hists__delete_entries(&d->block_hists.sym_hists);
+	}
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
@@ -937,6 +986,16 @@ static int __cmd_diff(void)
 				goto out_delete;
 		}
 
+		if (pdiff.has_br_stack && pdiff.basic_block) {
+			ret = block_sym_hists_init(&d->block_hists);
+			if (ret) {
+				pr_err("Failed to initialize basic block hists\n");
+				goto out_delete;
+			}
+
+			pdiff.block_hists = &d->block_hists;
+		}
+
 		ret = perf_session__process_events(d->session);
 		if (ret) {
 			pr_err("Failed to process %s\n", d->data.path);
@@ -949,7 +1008,10 @@ static int __cmd_diff(void)
 			zfree(&pdiff.ptime_range);
 	}
 
-	data_process();
+	if (pdiff.has_br_stack && pdiff.basic_block)
+		basic_block_process();
+	else
+		data_process();
 
  out_delete:
 	data__for_each_file(i, d) {
@@ -1019,6 +1081,8 @@ static const struct option options[] = {
 		   "only consider symbols in these pids"),
 	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "only consider symbols in these tids"),
+	OPT_BOOLEAN(0, "basic-block", &pdiff.basic_block,
+		    "display the differential program basic block"),
 	OPT_END()
 };
 
@@ -1517,10 +1581,11 @@ int cmd_diff(int argc, const char **argv)
 	if (data_init(argc, argv) < 0)
 		return -1;
 
-	if (ui_init() < 0)
-		return -1;
-
-	sort__mode = SORT_MODE__DIFF;
+	if (!pdiff.basic_block) {
+		if (ui_init() < 0)
+			return -1;
+		sort__mode = SORT_MODE__DIFF;
+	}
 
 	if (setup_sorting(NULL) < 0)
 		usage_with_options(diff_usage, options);
-- 
2.7.4

