Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8589EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEED24E42
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NDEd435r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfFCNDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:03:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFCNDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:03:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D3UMd602412
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:03:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D3UMd602412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567011;
        bh=sfc0k++Mi1BMilo2QMC3tOzYzrbD88d5pwRgZ9GEWAM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NDEd435rXjA1WClnJTLLyzX27nbarhaadr8SURYYfjN0K2iVA+Ux9WrHxjmdyv6tf
         HYbzkQLeJRHQxH3Ru/QMZ/w8FqBYPPdZ9nXRALk5Hl4WShPB82LiNN7c++F5QEidn3
         Cx3uJ8nUmcLSXxqFV6aBiG0Bkwe9BED8Zof6QdfFEvR7xO2AuPiDAlPFoHZRXe2d/G
         9VeXRflwnu6HavrUKE6hBVgOFok3lMc7OBq/gt21jiGwGV4hXCjOqNo4vOtgq2HC42
         TfJkGlC1jFKAOfJFrS4ypnMSY236kNl2c7cx5OkibsSCFnw9vIS1yNk+aLWhj/NWBl
         Y0GSa2WbAiE5Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D3T7f602409;
        Mon, 3 Jun 2019 06:03:29 -0700
Date:   Mon, 3 Jun 2019 06:03:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-3d8d53554405952993bb0279ef3ebebc51740074@git.kernel.org>
Cc:     tglx@linutronix.de, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, hpa@zytor.com, patrick.bellasi@arm.com,
        peterz@infradead.org, riel@surriel.com, quentin.perret@arm.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        fweisbec@gmail.com, vincent.guittot@linaro.org
Reply-To: peterz@infradead.org, riel@surriel.com, quentin.perret@arm.com,
          mingo@kernel.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
          fweisbec@gmail.com, vincent.guittot@linaro.org,
          tglx@linutronix.de, morten.rasmussen@arm.com,
          dietmar.eggemann@arm.com, hpa@zytor.com, patrick.bellasi@arm.com
In-Reply-To: <20190527062116.11512-4-dietmar.eggemann@arm.com>
References: <20190527062116.11512-4-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Remove sd->*_idx range on sysctl
Git-Commit-ID: 3d8d53554405952993bb0279ef3ebebc51740074
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

Commit-ID:  3d8d53554405952993bb0279ef3ebebc51740074
Gitweb:     https://git.kernel.org/tip/3d8d53554405952993bb0279ef3ebebc51740074
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Mon, 27 May 2019 07:21:12 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:49:39 +0200

sched/debug: Remove sd->*_idx range on sysctl

This reverts:

  commit 201c373e8e48 ("sched/debug: Limit sd->*_idx range on sysctl")

Load indexes (sd->*_idx) are no longer needed without rq->cpu_load[].
The range check for load indexes can be removed as well. Get rid of it
before the rq->cpu_load[] since it uses CPU_LOAD_IDX_MAX.

At the same time, fix the following coding style issues detected by
scripts/checkpatch.pl:

  ERROR: space prohibited before that ','
  ERROR: space prohibited before that close parenthesis ')'

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
Link: https://lkml.kernel.org/r/20190527062116.11512-4-dietmar.eggemann@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/debug.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 150043e1d716..5c7b066d7de6 100644
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
