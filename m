Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33BCC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814CA206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfCIUBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:01:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:01:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K0qkW3203550
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:00:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K0qdP3203547;
        Sat, 9 Mar 2019 12:00:52 -0800
Date:   Sat, 9 Mar 2019 12:00:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-daca23b2007595b6a48255ca08c763f56050d1c5@git.kernel.org>
Cc:     kan.liang@linux.intel.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, acme@redhat.com, yao.jin@linux.intel.com,
        yao.jin@intel.com, ak@linux.intel.com
Reply-To: ak@linux.intel.com, yao.jin@intel.com, yao.jin@linux.intel.com,
          hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org, jolsa@kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          kan.liang@linux.intel.com
In-Reply-To: <1551791143-10334-3-git-send-email-yao.jin@linux.intel.com>
References: <1551791143-10334-3-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf diff: Support --cpu filter option
Git-Commit-ID: daca23b2007595b6a48255ca08c763f56050d1c5
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

Commit-ID:  daca23b2007595b6a48255ca08c763f56050d1c5
Gitweb:     https://git.kernel.org/tip/daca23b2007595b6a48255ca08c763f56050d1c5
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Tue, 5 Mar 2019 21:05:42 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:05:21 -0300

perf diff: Support --cpu filter option

To improve 'perf diff', implement a --cpu filter option.

Multiple CPUs can be provided as a comma-separated list with no space:
0,1.  Ranges of CPUs are specified with -: 0-2. Default is to report
samples on all CPUs.

For example,

  perf diff --cpu 0,1

It only diff the samples for CPU0 and CPU1.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1551791143-10334-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt |  5 +++++
 tools/perf/builtin-diff.c              | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index 036d65bded51..8c2c229faf50 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -163,6 +163,11 @@ OPTIONS
 	the end of perf.data.old and analyzes the perf.data from the
 	timestamp 3971.150589 to the end of perf.data.
 
+--cpu:: Only diff samples for the list of CPUs provided. Multiple CPUs can
+	be provided as a comma-separated list with no space: 0,1. Ranges of
+	CPUs are specified with -: 0-2. Default is to report samples on all
+	CPUs.
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 17cd898074c8..dfe6c7606f5a 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -83,6 +83,9 @@ static unsigned int sort_compute = 1;
 static s64 compute_wdiff_w1;
 static s64 compute_wdiff_w2;
 
+static const char		*cpu_list;
+static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
 enum {
 	COMPUTE_DELTA,
 	COMPUTE_RATIO,
@@ -354,6 +357,11 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		return -1;
 	}
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap)) {
+		ret = 0;
+		goto out_put;
+	}
+
 	if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample, true)) {
 		pr_warning("problem incrementing symbol period, skipping event\n");
 		goto out_put;
@@ -892,6 +900,13 @@ static int __cmd_diff(void)
 				goto out_delete;
 		}
 
+		if (cpu_list) {
+			ret = perf_session__cpu_bitmap(d->session, cpu_list,
+						       cpu_bitmap);
+			if (ret < 0)
+				goto out_delete;
+		}
+
 		ret = perf_session__process_events(d->session);
 		if (ret) {
 			pr_err("Failed to process %s\n", d->data.path);
@@ -969,6 +984,7 @@ static const struct option options[] = {
 		     "How to display percentage of filtered entries", parse_filter_percentage),
 	OPT_STRING(0, "time", &pdiff.time_str, "str",
 		   "Time span (time percent or absolute timestamp)"),
+	OPT_STRING(0, "cpu", &cpu_list, "cpu", "list of cpus to profile"),
 	OPT_END()
 };
 
