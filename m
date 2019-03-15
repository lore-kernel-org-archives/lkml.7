Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B56218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfCOFzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 01:55:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:42325 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfCOFzT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 01:55:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 22:55:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="134239238"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga003.jf.intel.com with ESMTP; 14 Mar 2019 22:55:17 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf annotate/report: Remove hist__account_cycles from callback
Date:   Fri, 15 Mar 2019 21:46:01 +0800
Message-Id: <1552657561-15744-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hist__account_cycles is executed when the hist_iter__branch_callback
is called. But it looks it's not necessary. In hist__account_cycles, it
already walks on all branch entries.

This patch moves the hist__account_cycles out of callback, now the data
processing is much faster than before.

Previous code has an issue that the ch[offset].num++
(in __symbol__account_cycles) is executed repeatedly since
hist__account_cycles is called in each hist_iter__branch_callback,
so the counting of ch[offset].num is not correct (too big).
With this patch, the issue is fixed. And we don't need the code of
"ch->reset >= ch->num / 2" to check if there are too many overlaps
(in annotation__count_and_fill), otherwise some data would be
hidden.

Now, we can try, for example:

perf record -b ...
perf annotate or perf report -s symbol

The before/after output should be no change.

 v2:
 ---
 1. Cover the similar perf report
 2. Remove the checking code "ch->reset >= ch->num / 2"

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-annotate.c | 4 ++--
 tools/perf/builtin-report.c   | 9 +++------
 tools/perf/util/annotate.c    | 2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 67f9d9f..77deb3a 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -159,8 +159,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 	int err;
 
-	hist__account_cycles(sample->branch_stack, al, sample, false);
-
 	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 
@@ -199,6 +197,8 @@ static int process_branch_callback(struct perf_evsel *evsel,
 	if (a.map != NULL)
 		a.map->dso->hit = 1;
 
+	hist__account_cycles(sample->branch_stack, al, sample, false);
+
 	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 	return ret;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1921aaa..80874fa 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -136,9 +136,6 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	hist__account_cycles(sample->branch_stack, al, sample,
-			     rep->nonany_branch_mode);
-
 	if (sort__mode == SORT_MODE__BRANCH) {
 		bi = he->branch_info;
 		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
@@ -181,9 +178,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	hist__account_cycles(sample->branch_stack, al, sample,
-			     rep->nonany_branch_mode);
-
 	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 	if (err)
@@ -282,6 +276,9 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
+	hist__account_cycles(sample->branch_stack, &al, sample,
+			     rep->nonany_branch_mode);
+
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
 	if (ret < 0)
 		pr_debug("problem adding hist entry, skipping event\n");
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5f6dbbf..e8080c0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1015,7 +1015,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
 
 		/* Hide data when there are too many overlaps. */
-		if (ch->reset >= 0x7fff || ch->reset >= ch->num / 2)
+		if (ch->reset >= 0x7fff)
 			return;
 
 		for (offset = start; offset <= end; offset++) {
-- 
2.7.4

