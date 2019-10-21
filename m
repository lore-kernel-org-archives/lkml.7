Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B383CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE25F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfJUJNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33962 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfJUJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMTk7-0005Ji-S9; Mon, 21 Oct 2019 11:12:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 777141C047B;
        Mon, 21 Oct 2019 11:12:44 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:12:44 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Clean up asym packing
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Rik van Riel <riel@surriel.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Morten.Rasmussen@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, hdanton@sina.com,
        parth@linux.ibm.com, pauld@redhat.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571405198-27570-2-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-2-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157164916428.29376.1584839618089201858.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     490ba971d8b498ba3a47999ab94c6a0d1830ad41
Gitweb:        https://git.kernel.org/tip/490ba971d8b498ba3a47999ab94c6a0d1830ad41
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 15:26:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 09:40:53 +02:00

sched/fair: Clean up asym packing

Clean up asym packing to follow the default load balance behavior:

- classify the group by creating a group_asym_packing field.
- calculate the imbalance in calculate_imbalance() instead of bypassing it.

We don't need to test twice same conditions anymore to detect asym packing
and we consolidate the calculation of imbalance in calculate_imbalance().

There is no functional changes.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: hdanton@sina.com
Cc: parth@linux.ibm.com
Cc: pauld@redhat.com
Cc: quentin.perret@arm.com
Cc: srikar@linux.vnet.ibm.com
Cc: valentin.schneider@arm.com
Link: https://lkml.kernel.org/r/1571405198-27570-2-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 63 +++++++++++---------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754..5ce0f71 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7665,6 +7665,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -8119,9 +8120,17 @@ asym_packing:
 	 * ASYM_PACKING needs to move all the work to the highest
 	 * prority CPUs in the group, therefore mark all groups
 	 * of lower priority than ourself as busy.
+	 *
+	 * This is primarily intended to used at the sibling level.  Some
+	 * cores like POWER7 prefer to use lower numbered SMT threads.  In the
+	 * case of POWER7, it can move to lower SMT modes only when higher
+	 * threads are idle.  When in lower SMT modes, the threads will
+	 * perform better since they share less core resources.  Hence when we
+	 * have idle threads, we want them to be the higher ones.
 	 */
 	if (sgs->sum_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
+		sgs->group_asym_packing = 1;
 		if (!sds->busiest)
 			return true;
 
@@ -8263,51 +8272,6 @@ next_group:
 }
 
 /**
- * check_asym_packing - Check to see if the group is packed into the
- *			sched domain.
- *
- * This is primarily intended to used at the sibling level.  Some
- * cores like POWER7 prefer to use lower numbered SMT threads.  In the
- * case of POWER7, it can move to lower SMT modes only when higher
- * threads are idle.  When in lower SMT modes, the threads will
- * perform better since they share less core resources.  Hence when we
- * have idle threads, we want them to be the higher ones.
- *
- * This packing function is run on idle threads.  It checks to see if
- * the busiest CPU in this domain (core in the P7 case) has a higher
- * CPU number than the packing function is being run on.  Here we are
- * assuming lower CPU number will be equivalent to lower a SMT thread
- * number.
- *
- * Return: 1 when packing is required and a task should be moved to
- * this CPU.  The amount of the imbalance is returned in env->imbalance.
- *
- * @env: The load balancing environment.
- * @sds: Statistics of the sched_domain which is to be packed
- */
-static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
-{
-	int busiest_cpu;
-
-	if (!(env->sd->flags & SD_ASYM_PACKING))
-		return 0;
-
-	if (env->idle == CPU_NOT_IDLE)
-		return 0;
-
-	if (!sds->busiest)
-		return 0;
-
-	busiest_cpu = sds->busiest->asym_prefer_cpu;
-	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
-		return 0;
-
-	env->imbalance = sds->busiest_stat.group_load;
-
-	return 1;
-}
-
-/**
  * fix_small_imbalance - Calculate the minor imbalance that exists
  *			amongst the groups of a sched_domain, during
  *			load balancing.
@@ -8391,6 +8355,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
+	if (busiest->group_asym_packing) {
+		env->imbalance = busiest->group_load;
+		return;
+	}
+
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
@@ -8495,8 +8464,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	busiest = &sds.busiest_stat;
 
 	/* ASYM feature bypasses nice load balance check */
-	if (check_asym_packing(env, &sds))
-		return sds.busiest;
+	if (busiest->group_asym_packing)
+		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
 	if (!sds.busiest || busiest->sum_nr_running == 0)
