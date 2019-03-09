Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3B4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0086A206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCIUBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:01:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIUBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:01:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K1W1B3203594
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:01:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K1V6c3203591;
        Sat, 9 Mar 2019 12:01:31 -0800
Date:   Sat, 9 Mar 2019 12:01:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-c1d3e633e16db3eb64f519c7099171bfcef94b20@git.kernel.org>
Cc:     yao.jin@intel.com, kan.liang@linux.intel.com, acme@redhat.com,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: ak@linux.intel.com, yao.jin@linux.intel.com, mingo@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, yao.jin@intel.com,
          kan.liang@linux.intel.com, acme@redhat.com
In-Reply-To: <1551791143-10334-4-git-send-email-yao.jin@linux.intel.com>
References: <1551791143-10334-4-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf diff: Support --pid/--tid filter options
Git-Commit-ID: c1d3e633e16db3eb64f519c7099171bfcef94b20
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

Commit-ID:  c1d3e633e16db3eb64f519c7099171bfcef94b20
Gitweb:     https://git.kernel.org/tip/c1d3e633e16db3eb64f519c7099171bfcef94b20
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Tue, 5 Mar 2019 21:05:43 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:06:16 -0300

perf diff: Support --pid/--tid filter options

Using the existing symbol_conf.pid_list_str and symbol_conf.tid_list_str
logic.

For example:

  perf diff --tid 13965

It'll only diff the samples for thread 13965.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1551791143-10334-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt | 6 ++++++
 tools/perf/builtin-diff.c              | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index 8c2c229faf50..da7809b15cc9 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -168,6 +168,12 @@ OPTIONS
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
index dfe6c7606f5a..6e7920793729 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -985,6 +985,10 @@ static const struct option options[] = {
 	OPT_STRING(0, "time", &pdiff.time_str, "str",
 		   "Time span (time percent or absolute timestamp)"),
 	OPT_STRING(0, "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_STRING(0, "pid", &symbol_conf.pid_list_str, "pid[,pid...]",
+		   "only consider symbols in these pids"),
+	OPT_STRING(0, "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
+		   "only consider symbols in these tids"),
 	OPT_END()
 };
 
