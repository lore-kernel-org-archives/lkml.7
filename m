Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D693C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E317A20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980785;
	bh=K9lgsUsrch1owE910fjj47RGNpvQwwnJUMZMl4n+5UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nR8SH259xYGV4KuOlvc55yTtn/80xKFLc1IsOOQ0rRGA+dz8kV0QhLx3qW9pR4aO0
	 HSt8hPuSd9KnLN8HP5KVWqzhaE0Iibm4LfHeC2/8CkvXf3J2DsPNSGKhwUkkrVi28r
	 VCG7u8IYU5Gj/eR3DlLR2UpxMnnBV8XsCYFj1jMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfCGRqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfCGRqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:21 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 151F621019;
        Thu,  7 Mar 2019 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980780;
        bh=K9lgsUsrch1owE910fjj47RGNpvQwwnJUMZMl4n+5UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tig1vTdZYC0rEL/Chx63UWIvvs4uRQklxUcQ4ef5rZR2raUQtuoQSwhxdj9sB4y7T
         Q3Cl+ozqCT3VC1jDZn8RJVJiv1xw+X1O6qL2h6ieNnJr6zL/4y8W9EY4ob5iAGRdAf
         guJtDvZ1Xod4YOzbspg1zhlV4gv/nRBHGP0WEuzU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/35] perf diff: Support --cpu filter option
Date:   Thu,  7 Mar 2019 14:44:20 -0300
Message-Id: <20190307174433.28819-23-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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
 
-- 
2.20.1

