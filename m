Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3501BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FE52070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406302AbfIFTOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:14:11 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38316 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406268AbfIFTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:14:08 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i6Jey-0003p8-7q; Fri, 06 Sep 2019 15:12:40 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 02/15] sched: change /proc/sched_debug fields
Date:   Fri,  6 Sep 2019 15:12:24 -0400
Message-Id: <20190906191237.27006-3-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906191237.27006-1-riel@surriel.com>
References: <20190906191237.27006-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some fields from /proc/sched_debug that are removed from
sched_entity in a subsequent patch, and add h_load, which comes in
very handy to debug CPU controller weight distribution.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/sched/debug.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 14c6a8716ba1..f6beaca97a09 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -416,11 +416,9 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	}
 
 	P(se->load.weight);
-	P(se->runnable_weight);
 #ifdef CONFIG_SMP
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
-	P(se->avg.runnable_load_avg);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -538,7 +536,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
-	SEQ_printf(m, "  .%-30s: %ld\n", "runnable_weight", cfs_rq->runnable_weight);
 	SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_load_avg",
@@ -547,17 +544,15 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
 			cfs_rq->avg.util_est.enqueued);
-	SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
-			cfs_rq->removed.load_avg);
 	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
 			cfs_rq->removed.util_avg);
-	SEQ_printf(m, "  .%-30s: %ld\n", "removed.runnable_sum",
-			cfs_rq->removed.runnable_sum);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "  .%-30s: %lu\n", "tg_load_avg_contrib",
 			cfs_rq->tg_load_avg_contrib);
 	SEQ_printf(m, "  .%-30s: %ld\n", "tg_load_avg",
 			atomic_long_read(&cfs_rq->tg->load_avg));
+	SEQ_printf(m, "  .%-30s: %lu\n", "h_load",
+			cfs_rq->h_load);
 #endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -961,10 +956,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		   "nr_involuntary_switches", (long long)p->nivcsw);
 
 	P(se.load.weight);
-	P(se.runnable_weight);
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
-	P(se.avg.runnable_load_sum);
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
 	P(se.avg.runnable_load_avg);
-- 
2.20.1

