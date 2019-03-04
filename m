Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CE7208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCDFCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:02:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:45419 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCDFCB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:02:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 21:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,438,1544515200"; 
   d="scan'208";a="138837946"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2019 21:01:59 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 3/3] perf diff: Support --pid/--tid filter options
Date:   Mon,  4 Mar 2019 20:52:40 +0800
Message-Id: <1551703960-28957-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551703960-28957-1-git-send-email-yao.jin@linux.intel.com>
References: <1551703960-28957-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better filtering support for perf diff, it would be useful to
add --pid and --tid filter options.

For example,
perf diff --tid 13965

It only diff the samples for thread 13965.

 v3:
 ---
 No logical changes.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt | 6 ++++++
 tools/perf/builtin-diff.c              | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index ed13b3f..83c9496 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -164,6 +164,12 @@ OPTIONS
 	CPUs are specified with -: 0-2. Default is to report samples on all
 	CPUs.
 
+--pid=::
+	Only diff samples for given process ID (comma separated list).
+
+--tid=::
+	Only diff samples for given thread ID (comma separated list).
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index cebf394..222abeb 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -975,6 +975,10 @@ static const struct option options[] = {
 	OPT_STRING(0, "time", &pdiff.time_str, "str",
 		   "Time span (time percent or absolute timestamp)"),
 	OPT_STRING(0, "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_STRING(0, "pid", &symbol_conf.pid_list_str, "pid[,pid...]",
+		   "only consider symbols in these pids"),
+	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
+		   "only consider symbols in these tids"),
 	OPT_END()
 };
 
-- 
2.7.4

