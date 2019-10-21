Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741EDCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEDA2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfJUJNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33996 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfJUJNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMTk3-0005JV-CP; Mon, 21 Oct 2019 11:12:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F16D01C0494;
        Mon, 21 Oct 2019 11:12:42 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:12:42 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use load instead of runnable load in
 load_balance()
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Morten.Rasmussen@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, hdanton@sina.com,
        parth@linux.ibm.com, pauld@redhat.com, quentin.perret@arm.com,
        riel@surriel.com, srikar@linux.vnet.ibm.com,
        valentin.schneider@arm.com, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1571405198-27570-7-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-7-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157164916272.29376.5420060091017285531.tip-bot2@tip-bot2>
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

Commit-ID:     b0fb1eb4f04ae4768231b9731efb1134e22053a4
Gitweb:        https://git.kernel.org/tip/b0fb1eb4f04ae4768231b9731efb1134e22053a4
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 15:26:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 09:40:54 +02:00

sched/fair: Use load instead of runnable load in load_balance()

'runnable load' was originally introduced to take into account the case
where blocked load biases the load balance decision which was selecting
underutilized groups with huge blocked load whereas other groups were
overloaded.

The load is now only used when groups are overloaded. In this case,
it's worth being conservative and taking into account the sleeping
tasks that might wake up on the CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
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
Cc: riel@surriel.com
Cc: srikar@linux.vnet.ibm.com
Cc: valentin.schneider@arm.com
Link: https://lkml.kernel.org/r/1571405198-27570-7-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4e7396c..e6a3db0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5375,6 +5375,11 @@ static unsigned long cpu_runnable_load(struct rq *rq)
 	return cfs_rq_runnable_load_avg(&rq->cfs);
 }
 
+static unsigned long cpu_load(struct rq *rq)
+{
+	return cfs_rq_load_avg(&rq->cfs);
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -8049,7 +8054,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
-		sgs->group_load += cpu_runnable_load(rq);
+		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
@@ -8507,7 +8512,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	init_sd_lb_stats(&sds);
 
 	/*
-	 * Compute the various statistics relavent for load balancing at
+	 * Compute the various statistics relevant for load balancing at
 	 * this level.
 	 */
 	update_sd_lb_stats(env, &sds);
@@ -8667,11 +8672,10 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		switch (env->migration_type) {
 		case migrate_load:
 			/*
-			 * When comparing with load imbalance, use
-			 * cpu_runnable_load() which is not scaled with the CPU
-			 * capacity.
+			 * When comparing with load imbalance, use cpu_load()
+			 * which is not scaled with the CPU capacity.
 			 */
-			load = cpu_runnable_load(rq);
+			load = cpu_load(rq);
 
 			if (nr_running == 1 && load > env->imbalance &&
 			    !check_cpu_capacity(rq, env->sd))
@@ -8679,10 +8683,10 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 			/*
 			 * For the load comparisons with the other CPUs,
-			 * consider the cpu_runnable_load() scaled with the CPU
-			 * capacity, so that the load can be moved away from
-			 * the CPU that is potentially running at a lower
-			 * capacity.
+			 * consider the cpu_load() scaled with the CPU
+			 * capacity, so that the load can be moved away
+			 * from the CPU that is potentially running at a
+			 * lower capacity.
 			 *
 			 * Thus we're looking for max(load_i / capacity_i),
 			 * crosswise multiplication to rid ourselves of the
