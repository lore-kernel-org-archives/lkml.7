Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BDAC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B466320679
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfJHHGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:06:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:64439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbfJHHGR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:06:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 00:06:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="196522445"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2019 00:06:14 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/5] perf util: Count the total cycles of all samples
Date:   Tue,  8 Oct 2019 15:04:59 +0800
Message-Id: <20191008070502.22551-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008070502.22551-1-yao.jin@linux.intel.com>
References: <20191008070502.22551-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can get the per sample cycles by hist__account_cycles(). It's also
useful to know the total cycles of all samples in order to get the
cycles coverage for a single program block in further. For example,

coverage = per block sampled cycles / total sampled cycles

This patch creates a new argument 'total_cycles' in hist__account_cycles(),
which will be added with the cycles of each sample.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-annotate.c | 2 +-
 tools/perf/builtin-diff.c     | 3 ++-
 tools/perf/builtin-report.c   | 2 +-
 tools/perf/builtin-top.c      | 3 ++-
 tools/perf/util/hist.c        | 6 +++++-
 tools/perf/util/hist.h        | 3 ++-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8db8fc9bddef..6ab0cc45b287 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -201,7 +201,7 @@ static int process_branch_callback(struct evsel *evsel,
 	if (a.map != NULL)
 		a.map->dso->hit = 1;
 
-	hist__account_cycles(sample->branch_stack, al, sample, false);
+	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
 
 	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 	return ret;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c5242737a6df..029da813bfa6 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -421,7 +421,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
 			goto out_put;
 		}
 
-		hist__account_cycles(sample->branch_stack, &al, sample, false);
+		hist__account_cycles(sample->branch_stack, &al, sample, false,
+				     NULL);
 	}
 
 	/*
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index aae0e57c60fb..094bb43cbcf5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -292,7 +292,7 @@ static int process_sample_event(struct perf_tool *tool,
 
 	if (ui__has_annotation() || rep->symbol_ipc) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
-				     rep->nonany_branch_mode);
+				     rep->nonany_branch_mode, NULL);
 	}
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 611d03030abc..d2fc44da8b03 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -724,7 +724,8 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 		perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
-		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY));
+		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
+		     NULL);
 	return 0;
 }
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 26ee45a3e5d0..af65ce950ba2 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2570,7 +2570,8 @@ int hists__unlink(struct hists *hists)
 }
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
-			  struct perf_sample *sample, bool nonany_branch_mode)
+			  struct perf_sample *sample, bool nonany_branch_mode,
+			  u64 *total_cycles)
 {
 	struct branch_info *bi;
 
@@ -2597,6 +2598,9 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
 				prev = &bi[i].to;
+
+				if (total_cycles)
+					*total_cycles += bi[i].flags.cycles;
 			}
 			free(bi);
 		}
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6a186b668303..4d87c7b4c1b2 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -527,7 +527,8 @@ unsigned int hists__sort_list_width(struct hists *hists);
 unsigned int hists__overhead_width(struct hists *hists);
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
-			  struct perf_sample *sample, bool nonany_branch_mode);
+			  struct perf_sample *sample, bool nonany_branch_mode,
+			  u64 *total_cycles);
 
 struct option;
 int parse_filter_percentage(const struct option *opt, const char *arg, int unset);
-- 
2.17.1

