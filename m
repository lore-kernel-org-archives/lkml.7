Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD4CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705E4214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfJUJN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33964 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJUJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMTk2-0005JN-Nj; Mon, 21 Oct 2019 11:12:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 538951C0092;
        Mon, 21 Oct 2019 11:12:42 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:12:42 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use utilization to select misfit task
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
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
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571405198-27570-9-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-9-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157164916215.29376.14056001196691062623.tip-bot2@tip-bot2>
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

Commit-ID:     c63be7be59de65d12ff7b4329acea99cf734d6de
Gitweb:        https://git.kernel.org/tip/c63be7be59de65d12ff7b4329acea99cf734d6de
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 15:26:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 09:40:54 +02:00

sched/fair: Use utilization to select misfit task

Utilization is used to detect a misfit task but the load is then used to
select the task on the CPU which can lead to select a small task with
high weight instead of the task that triggered the misfit migration.

Check that task can't fit the CPU's capacity when selecting the misfit
task instead of using the load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Valentin Schneider <valentin.schneider@arm.com>
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
Link: https://lkml.kernel.org/r/1571405198-27570-9-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f489f60..1fd6f39 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7408,13 +7408,8 @@ static int detach_tasks(struct lb_env *env)
 			break;
 
 		case migrate_misfit:
-			load = task_h_load(p);
-
-			/*
-			 * Load of misfit task might decrease a bit since it has
-			 * been recorded. Be conservative in the condition.
-			 */
-			if (load/2 < env->imbalance)
+			/* This is not a misfit task */
+			if (task_fits_capacity(p, capacity_of(env->src_cpu)))
 				goto next;
 
 			env->imbalance = 0;
@@ -8358,7 +8353,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	if (busiest->group_type == group_misfit_task) {
 		/* Set imbalance to allow misfit tasks to be balanced. */
 		env->migration_type = migrate_misfit;
-		env->imbalance = busiest->group_misfit_task_load;
+		env->imbalance = 1;
 		return;
 	}
 
