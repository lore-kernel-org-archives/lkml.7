Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEBAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E1821874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wdnFgsP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfHHK6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:58:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbfHHK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:58:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78Aw0i83127884
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:58:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78Aw0i83127884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261881;
        bh=qQNImJZ/L3c1QFNOJWMJVXYgXgnQZFniH52EegkzYLg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wdnFgsP8UGdxwZizVC8Avue5DGAJJIWY5VfiChYNrERdXVP+0gqvkVZEznX8Bejx3
         F+ZVacHnXjavA4srUqndknMDfx40GiNUWKHRc8mxE0aanEg9aDfJt3AJJYDLJd90xj
         Iam8SsYhqPp1ozFYo3Hjr9pmj9JGnKEE/DP6ZpRDZ+f2MIYMAbrU6s8ue0g/wNuYjr
         WQG9D+VO+pl5odRhz2RydHgMlEUR2ePvUmSPyqD+rdCf7jY4OlrV8+geARStfG4j1t
         uROOLx5kqYvshJT6Kfdj8eUNvD0jIIpyHccswTygDXjCSohUIPZUJFkVXbSTj95rnr
         Qab9U6IbmqeTA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78Aw0HO3127881;
        Thu, 8 Aug 2019 03:58:00 -0700
Date:   Thu, 8 Aug 2019 03:58:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-5ba553eff0c3a7c099b1e29a740277a82c0c3314@git.kernel.org>
Cc:     hpa@zytor.com, naravamudan@digitalocean.com, mingo@kernel.org,
        valentin.schneider@arm.com, peterz@infradead.org,
        tglx@linutronix.de, pauld@redhat.com, aaron.lwe@gmail.com,
        jdesfossez@digitalocean.com, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, valentin.schneider@arm.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jdesfossez@digitalocean.com, aaron.lwe@gmail.com,
          pauld@redhat.com, hpa@zytor.com, naravamudan@digitalocean.com,
          mingo@kernel.org
In-Reply-To: <9e3eb1859b946f03d7e500453a885725b68957ba.1559129225.git.vpillai@digitalocean.com>
References: <9e3eb1859b946f03d7e500453a885725b68957ba.1559129225.git.vpillai@digitalocean.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Expose newidle_balance()
Git-Commit-ID: 5ba553eff0c3a7c099b1e29a740277a82c0c3314
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

Commit-ID:  5ba553eff0c3a7c099b1e29a740277a82c0c3314
Gitweb:     https://git.kernel.org/tip/5ba553eff0c3a7c099b1e29a740277a82c0c3314
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 29 May 2019 20:36:42 +0000
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:31 +0200

sched/fair: Expose newidle_balance()

For pick_next_task_fair() it is the newidle balance that requires
dropping the rq->lock; provided we do put_prev_task() early, we can
also detect the condition for doing newidle early.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: mingo@kernel.org
Cc: Phil Auld <pauld@redhat.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Link: https://lkml.kernel.org/r/9e3eb1859b946f03d7e500453a885725b68957ba.1559129225.git.vpillai@digitalocean.com
---
 kernel/sched/fair.c  | 18 ++++++++----------
 kernel/sched/sched.h |  4 ++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ce1b8893947..e7c27eda9f24 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3690,8 +3690,6 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf);
-
 static inline unsigned long task_util(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_avg);
@@ -6878,11 +6876,10 @@ done: __maybe_unused;
 	return p;
 
 idle:
-	update_misfit_status(NULL, rq);
-	new_tasks = idle_balance(rq, rf);
+	new_tasks = newidle_balance(rq, rf);
 
 	/*
-	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
+	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
 	 * must re-start the pick_next_entity() loop.
 	 */
@@ -9045,10 +9042,10 @@ out_one_pinned:
 	ld_moved = 0;
 
 	/*
-	 * idle_balance() disregards balance intervals, so we could repeatedly
-	 * reach this code, which would lead to balance_interval skyrocketting
-	 * in a short amount of time. Skip the balance_interval increase logic
-	 * to avoid that.
+	 * newidle_balance() disregards balance intervals, so we could
+	 * repeatedly reach this code, which would lead to balance_interval
+	 * skyrocketting in a short amount of time. Skip the balance_interval
+	 * increase logic to avoid that.
 	 */
 	if (env.idle == CPU_NEWLY_IDLE)
 		goto out;
@@ -9758,7 +9755,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  * idle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  */
-static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
+int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
@@ -9766,6 +9763,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 	int pulled_task = 0;
 	u64 curr_cost = 0;
 
+	update_misfit_status(NULL, this_rq);
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f3c50445bf22..304d98e712bf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1445,10 +1445,14 @@ static inline void unregister_sched_domain_sysctl(void)
 }
 #endif
 
+extern int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+
 #else
 
 static inline void sched_ttwu_pending(void) { }
 
+static inline int newidle_balance(struct rq *this_rq, struct rq_flags *rf) { return 0; }
+
 #endif /* CONFIG_SMP */
 
 #include "stats.h"
