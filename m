Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DABCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C32D21744
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfJUJNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfJUJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMTk3-0005JY-Ne; Mon, 21 Oct 2019 11:12:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 545271C0092;
        Mon, 21 Oct 2019 11:12:43 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:12:43 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use rq->nr_running when balancing load
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
In-Reply-To: <1571405198-27570-6-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-6-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157164916309.29376.18106664431086525097.tip-bot2@tip-bot2>
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

Commit-ID:     5e23e474431529b7d1480f649ce33d0e9c1b2e48
Gitweb:        https://git.kernel.org/tip/5e23e474431529b7d1480f649ce33d0e9c1b2e48
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 15:26:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 09:40:54 +02:00

sched/fair: Use rq->nr_running when balancing load

CFS load_balance() only takes care of CFS tasks whereas CPUs can be used by
other scheduling classes. Typically, a CFS task preempted by an RT or deadline
task will not get a chance to be pulled by another CPU because
load_balance() doesn't take into account tasks from other classes.
Add sum of nr_running in the statistics and use it to detect such
situations.

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
Link: https://lkml.kernel.org/r/1571405198-27570-6-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 76a2aa8..4e7396c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7694,6 +7694,7 @@ struct sg_lb_stats {
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
+	unsigned int sum_nr_running; /* Nr of tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
@@ -7928,7 +7929,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running < sgs->group_weight)
+	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7949,7 +7950,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running <= sgs->group_weight)
+	if (sgs->sum_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8053,6 +8054,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
+		sgs->sum_nr_running += nr_running;
+
 		if (nr_running > 1)
 			*sg_status |= SG_OVERLOAD;
 
@@ -8410,13 +8413,13 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
-			unsigned int nr_diff = busiest->sum_h_nr_running;
+			unsigned int nr_diff = busiest->sum_nr_running;
 			/*
 			 * When prefer sibling, evenly spread running tasks on
 			 * groups.
 			 */
 			env->migration_type = migrate_task;
-			lsub_positive(&nr_diff, local->sum_h_nr_running);
+			lsub_positive(&nr_diff, local->sum_nr_running);
 			env->imbalance = nr_diff >> 1;
 			return;
 		}
@@ -8580,7 +8583,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 
 	/* Try to move all excess tasks to child's sibling domain */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
+	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded &&
