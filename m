Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C318CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE69920873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfJUJNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33978 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfJUJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMTk2-0005JS-VI; Mon, 21 Oct 2019 11:12:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B7721C047B;
        Mon, 21 Oct 2019 11:12:42 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:12:42 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Spread out tasks evenly when not overloaded
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
In-Reply-To: <1571405198-27570-8-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-8-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157164916243.29376.10093977370174875453.tip-bot2@tip-bot2>
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

Commit-ID:     2ab4092fc82d6001fdd9d51dbba27d04dec967e0
Gitweb:        https://git.kernel.org/tip/2ab4092fc82d6001fdd9d51dbba27d04dec967e0
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 15:26:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 09:40:54 +02:00

sched/fair: Spread out tasks evenly when not overloaded

When there is only one CPU per group, using the idle CPUs to evenly spread
tasks doesn't make sense and nr_running is a better metrics.

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
Link: https://lkml.kernel.org/r/1571405198-27570-8-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e6a3db0..f489f60 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8591,18 +8591,34 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
-	if (busiest->group_type != group_overloaded &&
-	     (env->idle == CPU_NOT_IDLE ||
-	      local->idle_cpus <= (busiest->idle_cpus + 1)))
-		/*
-		 * If the busiest group is not overloaded
-		 * and there is no imbalance between this and busiest group
-		 * wrt. idle CPUs, it is balanced. The imbalance
-		 * becomes significant if the diff is greater than 1 otherwise
-		 * we might end up just moving the imbalance to another
-		 * group.
-		 */
-		goto out_balanced;
+	if (busiest->group_type != group_overloaded) {
+		if (env->idle == CPU_NOT_IDLE)
+			/*
+			 * If the busiest group is not overloaded (and as a
+			 * result the local one too) but this CPU is already
+			 * busy, let another idle CPU try to pull task.
+			 */
+			goto out_balanced;
+
+		if (busiest->group_weight > 1 &&
+		    local->idle_cpus <= (busiest->idle_cpus + 1))
+			/*
+			 * If the busiest group is not overloaded
+			 * and there is no imbalance between this and busiest
+			 * group wrt idle CPUs, it is balanced. The imbalance
+			 * becomes significant if the diff is greater than 1
+			 * otherwise we might end up to just move the imbalance
+			 * on another group. Of course this applies only if
+			 * there is more than 1 CPU per group.
+			 */
+			goto out_balanced;
+
+		if (busiest->sum_h_nr_running == 1)
+			/*
+			 * busiest doesn't have any tasks waiting to run
+			 */
+			goto out_balanced;
+	}
 
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
