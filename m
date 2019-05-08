Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A1C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3A21655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfEHO2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:28:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52442 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfEHO2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:28:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 252892C6F3213E655003;
        Wed,  8 May 2019 22:28:35 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 May 2019 22:28:27 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <acme@kernel.org>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <xiezhipeng1@huawei.com>
Subject: [PATCH v2] fix use-after-free in perf_sched__lat
Date:   Wed, 8 May 2019 22:36:48 +0800
Message-ID: <20190508143648.8153-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After thread is added to machine->threads[i].dead in
__machine__remove_thread, the machine->threads[i].dead is freed
when calling free(session) in perf_session__delete(). So it get a
Segmentation fault when accessing it in thread__put().

In this patch, we delay the perf_session__delete until all threads
have been deleted.

This can be reproduced by following steps:
	ulimit -c unlimited
	export MALLOC_MMAP_THRESHOLD_=0
	perf sched record sleep 10
	perf sched latency --sort max
	Segmentation fault (core dumped)

Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/builtin-sched.c | 63 ++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 275f2d92a7bf..8a4841fa124c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1774,7 +1774,8 @@ static int perf_sched__process_comm(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int perf_sched__read_events(struct perf_sched *sched)
+static int __perf_sched__read_events(struct perf_sched *sched,
+					struct perf_session *session)
 {
 	const struct perf_evsel_str_handler handlers[] = {
 		{ "sched:sched_switch",	      process_sched_switch_event, },
@@ -1783,30 +1784,17 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
 		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
 	};
-	struct perf_session *session;
-	struct perf_data data = {
-		.path  = input_name,
-		.mode  = PERF_DATA_MODE_READ,
-		.force = sched->force,
-	};
-	int rc = -1;
-
-	session = perf_session__new(&data, false, &sched->tool);
-	if (session == NULL) {
-		pr_debug("No Memory for session\n");
-		return -1;
-	}
 
 	symbol__init(&session->header.env);
 
 	if (perf_session__set_tracepoints_handlers(session, handlers))
-		goto out_delete;
+		return -1;
 
 	if (perf_session__has_traces(session, "record -R")) {
 		int err = perf_session__process_events(session);
 		if (err) {
 			pr_err("Failed to process events, error %d", err);
-			goto out_delete;
+			return -1;
 		}
 
 		sched->nr_events      = session->evlist->stats.nr_events[0];
@@ -1814,9 +1802,28 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
 	}
 
-	rc = 0;
-out_delete:
+	return 0;
+}
+
+static int perf_sched__read_events(struct perf_sched *sched)
+{
+	struct perf_session *session;
+	struct perf_data data = {
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = sched->force,
+	};
+	int rc;
+
+	session = perf_session__new(&data, false, &sched->tool);
+	if (session == NULL) {
+		pr_debug("No Memory for session\n");
+		return -1;
+	}
+
+	rc = __perf_sched__read_events(sched, session);
 	perf_session__delete(session);
+
 	return rc;
 }
 
@@ -3130,12 +3137,25 @@ static void perf_sched__merge_lat(struct perf_sched *sched)
 
 static int perf_sched__lat(struct perf_sched *sched)
 {
+	struct perf_session *session;
+	struct perf_data data = {
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = sched->force,
+	};
 	struct rb_node *next;
+	int rc = -1;
 
 	setup_pager();
 
-	if (perf_sched__read_events(sched))
+	session = perf_session__new(&data, false, &sched->tool);
+	if (session == NULL) {
+		pr_debug("No Memory for session\n");
 		return -1;
+	}
+
+	if (__perf_sched__read_events(sched, session))
+		goto out_delete;
 
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
@@ -3164,7 +3184,10 @@ static int perf_sched__lat(struct perf_sched *sched)
 	print_bad_events(sched);
 	printf("\n");
 
-	return 0;
+	rc = 0;
+out_delete:
+	perf_session__delete(session);
+	return rc;
 }
 
 static int setup_map_cpus(struct perf_sched *sched)
-- 
2.17.1

