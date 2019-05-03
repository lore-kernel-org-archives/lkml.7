Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C66C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 02:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA8B2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 02:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfECCbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 22:31:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41422 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfECCba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 22:31:30 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BEEB9C71FAE21CCD323E;
        Fri,  3 May 2019 10:31:28 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 May 2019 10:31:20 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <acme@kernel.org>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <xiezhipeng1@huawei.com>
Subject: [PATCH] fix use-after-free in perf_sched__lat
Date:   Fri, 3 May 2019 10:35:55 +0800
Message-ID: <20190503023555.24736-1-liwei391@huawei.com>
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
 tools/perf/builtin-sched.c | 44 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cbf39dab19c1..17849ae2eb1e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3130,11 +3130,48 @@ static void perf_sched__merge_lat(struct perf_sched *sched)
 static int perf_sched__lat(struct perf_sched *sched)
 {
 	struct rb_node *next;
+	const struct perf_evsel_str_handler handlers[] = {
+		{ "sched:sched_switch",	      process_sched_switch_event, },
+		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
+		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
+		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
+		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
+	};
+	struct perf_session *session;
+	struct perf_data data = {
+		.file      = {
+			.path = input_name,
+		},
+		.mode      = PERF_DATA_MODE_READ,
+		.force     = sched->force,
+	};
+	int rc = -1;
 
 	setup_pager();
 
-	if (perf_sched__read_events(sched))
+	session = perf_session__new(&data, false, &sched->tool);
+	if (session == NULL) {
+		pr_debug("No Memory for session\n");
 		return -1;
+	}
+
+	symbol__init(&session->header.env);
+
+	if (perf_session__set_tracepoints_handlers(session, handlers))
+		goto out_delete;
+
+	if (perf_session__has_traces(session, "record -R")) {
+		int err = perf_session__process_events(session);
+
+		if (err) {
+			pr_err("Failed to process events, error %d", err);
+			goto out_delete;
+		}
+
+		sched->nr_events      = session->evlist->stats.nr_events[0];
+		sched->nr_lost_events = session->evlist->stats.total_lost;
+		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+	}
 
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
@@ -3163,7 +3200,10 @@ static int perf_sched__lat(struct perf_sched *sched)
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

