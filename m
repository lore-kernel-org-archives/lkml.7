Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B09C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B50A2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfJKFGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:06:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:1472 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKFGj (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:06:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 22:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="394294608"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2019 22:06:36 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Support --all-kernel/--all-user
Date:   Fri, 11 Oct 2019 13:05:45 +0800
Message-Id: <20191011050545.3899-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf record has supported --all-kernel / --all-user to configure all
used events to run in kernel space or run in user space. But perf
stat doesn't support these options.

It would be useful to support these options in perf-stat too to keep
the same semantics.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
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
2.17.1

