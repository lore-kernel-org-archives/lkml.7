Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AEAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B13627FCE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ny0Nx61a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfFCNFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:05:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfFCNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:05:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D4wYC604148
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:04:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D4wYC604148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567099;
        bh=D6DpzBwzh/Z+6H+FWVWChRq72LuKqmNRa06S+03s8vE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ny0Nx61a95BmITLLYKedhcPUC6y2qXRQ6+pAbjMMJ2/Fsb12wCoR1tme6Im/UcVdf
         xpb7nKqjGmflTgup6T8tFOoKW16HwXnA6nrG/g/WATV+0k0GLsvbSIPea9/BfF+n7g
         JWn4Z3dLnV9AYrjqYosRpFFptIjqvAh0UYky/uUc0K4k6gt9X3E5nSh2nxCzjgxaTl
         eTtkGF+9dm8hBnm1rsBbW7/ajcezUj0jMH3oTTcuWpSycPlsQBdtxsFWu4BNSh22K7
         C90ZS6wJJVekI/F84OmX21dSncuwz03jLRVPlbFe6vmT+LpN/Ry6vdrRvbJ8vhCMPk
         +2GjFb3Z4C9LA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D4vHU604145;
        Mon, 3 Jun 2019 06:04:57 -0700
Date:   Mon, 3 Jun 2019 06:04:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-0e1fef63d92d61ed561e504c3a078a827a0f9bfe@git.kernel.org>
Cc:     morten.rasmussen@arm.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, quentin.perret@arm.com,
        riel@surriel.com, mingo@kernel.org, dietmar.eggemann@arm.com,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        valentin.schneider@arm.com, fweisbec@gmail.com,
        patrick.bellasi@arm.com, vincent.guittot@linaro.org
Reply-To: valentin.schneider@arm.com, fweisbec@gmail.com,
          patrick.bellasi@arm.com, vincent.guittot@linaro.org,
          tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
          quentin.perret@arm.com, riel@surriel.com, mingo@kernel.org,
          dietmar.eggemann@arm.com, torvalds@linux-foundation.org,
          morten.rasmussen@arm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190527062116.11512-6-dietmar.eggemann@arm.com>
References: <20190527062116.11512-6-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Remove sd->*_idx
Git-Commit-ID: 0e1fef63d92d61ed561e504c3a078a827a0f9bfe
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

Commit-ID:  0e1fef63d92d61ed561e504c3a078a827a0f9bfe
Gitweb:     https://git.kernel.org/tip/0e1fef63d92d61ed561e504c3a078a827a0f9bfe
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Mon, 27 May 2019 07:21:14 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:49:40 +0200

sched/core: Remove sd->*_idx

The sched domain per rq load index files also disappear from the
/proc/sys/kernel/sched_domain/cpuX/domainY directories.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20190527062116.11512-6-dietmar.eggemann@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
index a0b0d6e21e5b..7ffde8ce82fd 100644
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
