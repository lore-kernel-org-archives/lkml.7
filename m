Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C26C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062F021726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfE0GVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:21:46 -0400
Received: from foss.arm.com ([217.140.101.70]:56172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfE0GVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:21:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D0B15A2;
        Sun, 26 May 2019 23:21:43 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D3BB3F59C;
        Sun, 26 May 2019 23:21:41 -0700 (PDT)
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
Subject: [PATCH 5/7] sched: Remove sd->*_idx
Date:   Mon, 27 May 2019 07:21:14 +0100
Message-Id: <20190527062116.11512-6-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527062116.11512-1-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched domain per rq load index files also disappear from the
/proc/sys/kernel/sched_domain/cpuX/domainY directories.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched/topology.h |  5 -----
 kernel/sched/debug.c           | 25 ++++++++++---------------
 kernel/sched/topology.c        | 10 ----------
 3 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index cfc0a89a7159..53afbe07354a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -84,11 +84,6 @@ struct sched_domain {
 	unsigned int busy_factor;	/* less balancing by factor if busy */
 	unsigned int imbalance_pct;	/* No balance until over watermark */
 	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
-	unsigned int busy_idx;
-	unsigned int idle_idx;
-	unsigned int newidle_idx;
-	unsigned int wake_idx;
-	unsigned int forkexec_idx;
 
 	int nohz_idle;			/* NOHZ IDLE status */
 	int flags;			/* See SD_* */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c2eeaa44b274..4d91c8e41962 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -251,25 +251,20 @@ set_table_entry(struct ctl_table *entry,
 static struct ctl_table *
 sd_alloc_ctl_domain_table(struct sched_domain *sd)
 {
-	struct ctl_table *table = sd_alloc_ctl_entry(14);
+	struct ctl_table *table = sd_alloc_ctl_entry(9);
 
 	if (table == NULL)
 		return NULL;
 
-	set_table_entry(&table[0],  "min_interval",	   &sd->min_interval,	     sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[1],  "max_interval",	   &sd->max_interval,	     sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[2],  "busy_idx",		   &sd->busy_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[3],  "idle_idx",		   &sd->idle_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[4],  "newidle_idx",	   &sd->newidle_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[5],  "wake_idx",		   &sd->wake_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[6],  "forkexec_idx",	   &sd->forkexec_idx,	     sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[7],  "busy_factor",	   &sd->busy_factor,	     sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[8],  "imbalance_pct",	   &sd->imbalance_pct,	     sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[9],  "cache_nice_tries",	   &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[10], "flags",		   &sd->flags,		     sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[11], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
-	set_table_entry(&table[12], "name",		   sd->name,		CORENAME_MAX_SIZE, 0444, proc_dostring);
-	/* &table[13] is terminator */
+	set_table_entry(&table[0], "min_interval",	  &sd->min_interval,	    sizeof(long), 0644, proc_doulongvec_minmax);
+	set_table_entry(&table[1], "max_interval",	  &sd->max_interval,	    sizeof(long), 0644, proc_doulongvec_minmax);
+	set_table_entry(&table[2], "busy_factor",	  &sd->busy_factor,	    sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[3], "imbalance_pct",	  &sd->imbalance_pct,	    sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[4], "cache_nice_tries",	  &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[6], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
+	set_table_entry(&table[7], "name",		  sd->name,	       CORENAME_MAX_SIZE, 0444, proc_dostring);
+	/* &table[8] is terminator */
 
 	return table;
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f53f89df837d..63184cf0d0d7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1344,11 +1344,6 @@ sd_init(struct sched_domain_topology_level *tl,
 		.imbalance_pct		= 125,
 
 		.cache_nice_tries	= 0,
-		.busy_idx		= 0,
-		.idle_idx		= 0,
-		.newidle_idx		= 0,
-		.wake_idx		= 0,
-		.forkexec_idx		= 0,
 
 		.flags			= 1*SD_LOAD_BALANCE
 					| 1*SD_BALANCE_NEWIDLE
@@ -1400,13 +1395,10 @@ sd_init(struct sched_domain_topology_level *tl,
 	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
 		sd->imbalance_pct = 117;
 		sd->cache_nice_tries = 1;
-		sd->busy_idx = 2;
 
 #ifdef CONFIG_NUMA
 	} else if (sd->flags & SD_NUMA) {
 		sd->cache_nice_tries = 2;
-		sd->busy_idx = 3;
-		sd->idle_idx = 2;
 
 		sd->flags &= ~SD_PREFER_SIBLING;
 		sd->flags |= SD_SERIALIZE;
@@ -1419,8 +1411,6 @@ sd_init(struct sched_domain_topology_level *tl,
 #endif
 	} else {
 		sd->cache_nice_tries = 1;
-		sd->busy_idx = 2;
-		sd->idle_idx = 1;
 	}
 
 	/*
-- 
2.17.1

