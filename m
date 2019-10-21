Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AF5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DBE21BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665172;
	bh=tQ5Eu/dGDBjNPpllm/RwUE/neYd3yqJXsJch3BZl1cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flZrPijBeVsOf+feVc3A1G4XmRrKPM6AAqBiRNpBLyVCD5eBbo4psBXAhKZXA91Xv
	 MeDRG9+dhjlROPEj+hPYbMcgFyzvCK5BfJuSyFlKU8LMUXLTX4UJeeYeRQeL0aGi++
	 MHfkH+uWqBH54wf9Ql6bY/JgIpZw6Qup6eEfQ10M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfJUNja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfJUNj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7346D21A4A;
        Mon, 21 Oct 2019 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665166;
        bh=tQ5Eu/dGDBjNPpllm/RwUE/neYd3yqJXsJch3BZl1cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnJHeYrToiVZ3JknwnFbPLrrAwAbEeQ2tAjvZx4P/CUP0VW5bXOoRigLEW9Z+hUEw
         wqSH6S5nsoy2smp6XDp+4xotXMwH47I85wQ3swt1vyJCpx5c4jfiQSKF3v8FvAU86y
         2IKLQPS2gKt+iwGaolZoXwN/FKfs5G7urBLIzelY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/57] perf stat: Support --all-kernel/--all-user
Date:   Mon, 21 Oct 2019 10:37:50 -0300
Message-Id: <20191021133834.25998-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

'perf record' has supported --all-kernel / --all-user to configure all
used events to run in kernel space or run in user space. But 'perf stat'
doesn't support these options.

It would be useful to support these options in 'perf stat' too to keep
the same semantics available in both tools.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191011050545.3899-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt |  6 ++++++
 tools/perf/builtin-stat.c              |  6 ++++++
 tools/perf/util/stat.c                 | 10 ++++++++++
 tools/perf/util/stat.h                 |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 930c51c01201..a9af4e440e80 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -323,6 +323,12 @@ The output is SMI cycles%, equals to (aperf - unhalted core cycles) / aperf
 
 Users who wants to get the actual value can apply --no-metric-only.
 
+--all-kernel::
+Configure all used events to run in kernel space.
+
+--all-user::
+Configure all used events to run in user space.
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 468fc49420ce..c88d4e118409 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -803,6 +803,12 @@ static struct option stat_options[] = {
 	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
 		     "monitor specified metrics or metric groups (separated by ,)",
 		     parse_metric_groups),
+	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
+			 "Configure all used events to run in kernel space.",
+			 PARSE_OPT_EXCLUSIVE),
+	OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
+			 "Configure all used events to run in user space.",
+			 PARSE_OPT_EXCLUSIVE),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index ebdd130557fb..6822e4ffe224 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -490,6 +490,16 @@ int create_perf_stat_counter(struct evsel *evsel,
 	if (config->identifier)
 		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
 
+	if (config->all_user) {
+		attr->exclude_kernel = 1;
+		attr->exclude_user   = 0;
+	}
+
+	if (config->all_kernel) {
+		attr->exclude_kernel = 0;
+		attr->exclude_user   = 1;
+	}
+
 	/*
 	 * Disabling all counters initially, they will be enabled
 	 * either manually by us or by kernel via enable_on_exec
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index edbeb2f63e8d..081c4a5113c6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -106,6 +106,8 @@ struct perf_stat_config {
 	bool			 big_num;
 	bool			 no_merge;
 	bool			 walltime_run_table;
+	bool			 all_kernel;
+	bool			 all_user;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.21.0

