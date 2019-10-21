Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28BFCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D36321835
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfJUJNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33989 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfJUJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMTk2-0005JJ-5B; Mon, 21 Oct 2019 11:12:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BE59A1C047B;
        Mon, 21 Oct 2019 11:12:41 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:12:41 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Optimize find_idlest_group()
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
In-Reply-To: <1571405198-27570-11-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-11-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157164916159.29376.11878648032149648593.tip-bot2@tip-bot2>
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

Commit-ID:     fc1273f4cefe6670d528715581c848abf64f391c
Gitweb:        https://git.kernel.org/tip/fc1273f4cefe6670d528715581c848abf64f391c
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 15:26:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 09:40:55 +02:00

sched/fair: Optimize find_idlest_group()

find_idlest_group() now reads CPU's load_avg in two different ways.

Consolidate the function to read and use load_avg only once and simplify
the algorithm to only look for the group with lowest load_avg.

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
Link: https://lkml.kernel.org/r/1571405198-27570-11-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 50 ++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b0703b4..95a57c7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5550,16 +5550,14 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 {
 	struct sched_group *idlest = NULL, *group = sd->groups;
 	struct sched_group *most_spare_sg = NULL;
-	unsigned long min_runnable_load = ULONG_MAX;
-	unsigned long this_runnable_load = ULONG_MAX;
-	unsigned long min_avg_load = ULONG_MAX, this_avg_load = ULONG_MAX;
+	unsigned long min_load = ULONG_MAX, this_load = ULONG_MAX;
 	unsigned long most_spare = 0, this_spare = 0;
 	int imbalance_scale = 100 + (sd->imbalance_pct-100)/2;
 	unsigned long imbalance = scale_load_down(NICE_0_LOAD) *
 				(sd->imbalance_pct-100) / 100;
 
 	do {
-		unsigned long load, avg_load, runnable_load;
+		unsigned long load;
 		unsigned long spare_cap, max_spare_cap;
 		int local_group;
 		int i;
@@ -5576,15 +5574,11 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		 * Tally up the load of all CPUs in the group and find
 		 * the group containing the CPU with most spare capacity.
 		 */
-		avg_load = 0;
-		runnable_load = 0;
+		load = 0;
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			load = cpu_load(cpu_rq(i));
-			runnable_load += load;
-
-			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
+			load += cpu_load(cpu_rq(i));
 
 			spare_cap = capacity_spare_without(i, p);
 
@@ -5593,31 +5587,15 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		}
 
 		/* Adjust by relative CPU capacity of the group */
-		avg_load = (avg_load * SCHED_CAPACITY_SCALE) /
-					group->sgc->capacity;
-		runnable_load = (runnable_load * SCHED_CAPACITY_SCALE) /
+		load = (load * SCHED_CAPACITY_SCALE) /
 					group->sgc->capacity;
 
 		if (local_group) {
-			this_runnable_load = runnable_load;
-			this_avg_load = avg_load;
+			this_load = load;
 			this_spare = max_spare_cap;
 		} else {
-			if (min_runnable_load > (runnable_load + imbalance)) {
-				/*
-				 * The runnable load is significantly smaller
-				 * so we can pick this new CPU:
-				 */
-				min_runnable_load = runnable_load;
-				min_avg_load = avg_load;
-				idlest = group;
-			} else if ((runnable_load < (min_runnable_load + imbalance)) &&
-				   (100*min_avg_load > imbalance_scale*avg_load)) {
-				/*
-				 * The runnable loads are close so take the
-				 * blocked load into account through avg_load:
-				 */
-				min_avg_load = avg_load;
+			if (load < min_load) {
+				min_load = load;
 				idlest = group;
 			}
 
@@ -5658,18 +5636,18 @@ skip_spare:
 	 * local domain to be very lightly loaded relative to the remote
 	 * domains but "imbalance" skews the comparison making remote CPUs
 	 * look much more favourable. When considering cross-domain, add
-	 * imbalance to the runnable load on the remote node and consider
-	 * staying local.
+	 * imbalance to the load on the remote node and consider staying
+	 * local.
 	 */
 	if ((sd->flags & SD_NUMA) &&
-	    min_runnable_load + imbalance >= this_runnable_load)
+	     min_load + imbalance >= this_load)
 		return NULL;
 
-	if (min_runnable_load > (this_runnable_load + imbalance))
+	if (min_load >= this_load + imbalance)
 		return NULL;
 
-	if ((this_runnable_load < (min_runnable_load + imbalance)) &&
-	     (100*this_avg_load < imbalance_scale*min_avg_load))
+	if ((this_load < (min_load + imbalance)) &&
+	    (100*this_load < imbalance_scale*min_load))
 		return NULL;
 
 	return idlest;
