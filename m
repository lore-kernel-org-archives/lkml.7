Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3405CC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1122721726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfE0GWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:22:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56140 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE0GVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:21:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE231688;
        Sun, 26 May 2019 23:21:39 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D2553F59C;
        Sun, 26 May 2019 23:21:36 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] sched/debug: Remove sd->*_idx range on sysctl
Date:   Mon, 27 May 2019 07:21:12 +0100
Message-Id: <20190527062116.11512-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527062116.11512-1-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 201c373e8e48 ("sched/debug: Limit sd->*_idx range on
sysctl").

Load indexes (sd->*_idx) are no longer needed without rq->cpu_load[].
The range check for load indexes can be removed as well. Get rid of it
before the rq->cpu_load[] since it uses CPU_LOAD_IDX_MAX.

At the same time, fix the following coding style issues detected by
scripts/checkpatch.pl:

  ERROR: space prohibited before that ','
  ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/debug.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 678bfb9bd87f..b070fb61caca 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -236,25 +236,16 @@ static void sd_free_ctl_entry(struct ctl_table **tablep)
 	*tablep = NULL;
 }
 
-static int min_load_idx = 0;
-static int max_load_idx = CPU_LOAD_IDX_MAX-1;
-
 static void
 set_table_entry(struct ctl_table *entry,
 		const char *procname, void *data, int maxlen,
-		umode_t mode, proc_handler *proc_handler,
-		bool load_idx)
+		umode_t mode, proc_handler *proc_handler)
 {
 	entry->procname = procname;
 	entry->data = data;
 	entry->maxlen = maxlen;
 	entry->mode = mode;
 	entry->proc_handler = proc_handler;
-
-	if (load_idx) {
-		entry->extra1 = &min_load_idx;
-		entry->extra2 = &max_load_idx;
-	}
 }
 
 static struct ctl_table *
@@ -265,19 +256,19 @@ sd_alloc_ctl_domain_table(struct sched_domain *sd)
 	if (table == NULL)
 		return NULL;
 
-	set_table_entry(&table[0] , "min_interval",	   &sd->min_interval,	     sizeof(long), 0644, proc_doulongvec_minmax, false);
-	set_table_entry(&table[1] , "max_interval",	   &sd->max_interval,	     sizeof(long), 0644, proc_doulongvec_minmax, false);
-	set_table_entry(&table[2] , "busy_idx",		   &sd->busy_idx,	     sizeof(int) , 0644, proc_dointvec_minmax,   true );
-	set_table_entry(&table[3] , "idle_idx",		   &sd->idle_idx,	     sizeof(int) , 0644, proc_dointvec_minmax,   true );
-	set_table_entry(&table[4] , "newidle_idx",	   &sd->newidle_idx,	     sizeof(int) , 0644, proc_dointvec_minmax,   true );
-	set_table_entry(&table[5] , "wake_idx",		   &sd->wake_idx,	     sizeof(int) , 0644, proc_dointvec_minmax,   true );
-	set_table_entry(&table[6] , "forkexec_idx",	   &sd->forkexec_idx,	     sizeof(int) , 0644, proc_dointvec_minmax,   true );
-	set_table_entry(&table[7] , "busy_factor",	   &sd->busy_factor,	     sizeof(int) , 0644, proc_dointvec_minmax,   false);
-	set_table_entry(&table[8] , "imbalance_pct",	   &sd->imbalance_pct,	     sizeof(int) , 0644, proc_dointvec_minmax,   false);
-	set_table_entry(&table[9] , "cache_nice_tries",	   &sd->cache_nice_tries,    sizeof(int) , 0644, proc_dointvec_minmax,   false);
-	set_table_entry(&table[10], "flags",		   &sd->flags,		     sizeof(int) , 0644, proc_dointvec_minmax,   false);
-	set_table_entry(&table[11], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax, false);
-	set_table_entry(&table[12], "name",		   sd->name,		CORENAME_MAX_SIZE, 0444, proc_dostring,		 false);
+	set_table_entry(&table[0],  "min_interval",	   &sd->min_interval,	     sizeof(long), 0644, proc_doulongvec_minmax);
+	set_table_entry(&table[1],  "max_interval",	   &sd->max_interval,	     sizeof(long), 0644, proc_doulongvec_minmax);
+	set_table_entry(&table[2],  "busy_idx",		   &sd->busy_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[3],  "idle_idx",		   &sd->idle_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[4],  "newidle_idx",	   &sd->newidle_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[5],  "wake_idx",		   &sd->wake_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[6],  "forkexec_idx",	   &sd->forkexec_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[7],  "busy_factor",	   &sd->busy_factor,	     sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[8],  "imbalance_pct",	   &sd->imbalance_pct,	     sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[9],  "cache_nice_tries",	   &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[10], "flags",		   &sd->flags,		     sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[11], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
+	set_table_entry(&table[12], "name",		   sd->name,		CORENAME_MAX_SIZE, 0444, proc_dostring);
 	/* &table[13] is terminator */
 
 	return table;
-- 
2.17.1

