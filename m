Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4664FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7A322468
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfKLLSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:18:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33496 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfKLLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBD-0000Ct-0N; Tue, 12 Nov 2019 12:17:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 972C01C0084;
        Tue, 12 Nov 2019 12:17:50 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:50 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf hist: Count the total cycles of all samples
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191107074719.26139-4-yao.jin@linux.intel.com>
References: <20191107074719.26139-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157355747026.29376.2534753507000044849.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7841f40aed933dd3838f8d9f2dfcf286c352b7ee
Gitweb:        https://git.kernel.org/tip/7841f40aed933dd3838f8d9f2dfcf286c352b7ee
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Thu, 07 Nov 2019 15:47:15 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 09:14:15 -03:00

perf hist: Count the total cycles of all samples

We can get the per sample cycles by hist__account_cycles(). It's also
useful to know the total cycles of all samples in order to get the
cycles coverage for a single program block in further. For example:

  coverage = per block sampled cycles / total sampled cycles

This patch creates a new argument 'total_cycles' in hist__account_cycles(),
which will be added with the cycles of each sample.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191107074719.26139-4-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 2 +-
 tools/perf/builtin-diff.c     | 3 ++-
 tools/perf/builtin-report.c   | 2 +-
 tools/perf/builtin-top.c      | 3 ++-
 tools/perf/util/hist.c        | 6 +++++-
 tools/perf/util/hist.h        | 3 ++-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8db8fc9..6ab0cc4 100644
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
index 6728568..376dbf1 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -426,7 +426,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
 			goto out_put;
 		}
 
-		hist__account_cycles(sample->branch_stack, &al, sample, false);
+		hist__account_cycles(sample->branch_stack, &al, sample, false,
+				     NULL);
 	}
 
 	/*
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3bbad03..bc15b9d 100644
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
index d96f24c..14c52e4 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -725,7 +725,8 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 		perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
-		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY));
+		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
+		     NULL);
 	return 0;
 }
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index a7fa061..0e27d68 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2572,7 +2572,8 @@ int hists__unlink(struct hists *hists)
 }
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
-			  struct perf_sample *sample, bool nonany_branch_mode)
+			  struct perf_sample *sample, bool nonany_branch_mode,
+			  u64 *total_cycles)
 {
 	struct branch_info *bi;
 
@@ -2599,6 +2600,9 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
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
index 6a186b6..4d87c7b 100644
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
