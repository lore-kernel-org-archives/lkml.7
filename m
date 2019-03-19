Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72F920828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCSLQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:16:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSLQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:16:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2JBDogh3396153
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 19 Mar 2019 04:13:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2JBDolb3396149;
        Tue, 19 Mar 2019 04:13:50 -0700
Date:   Tue, 19 Mar 2019 04:13:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-b9a7b8831600afc51c9ba52c05f12db2266f01c7@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        valentin.schneider@arm.com, peterz@infradead.org, luto@kernel.org,
        morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, riel@surriel.com,
        torvalds@linux-foundation.org, bp@alien8.de
Reply-To: dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          bp@alien8.de, torvalds@linux-foundation.org, riel@surriel.com,
          hpa@zytor.com, mingo@kernel.org, luto@kernel.org,
          morten.rasmussen@arm.com, peterz@infradead.org,
          valentin.schneider@arm.com, tglx@linutronix.de
In-Reply-To: <20190211175946.4961-4-valentin.schneider@arm.com>
References: <20190211175946.4961-4-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Skip LLC NOHZ logic for asymmetric
 systems
Git-Commit-ID: b9a7b8831600afc51c9ba52c05f12db2266f01c7
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

Commit-ID:  b9a7b8831600afc51c9ba52c05f12db2266f01c7
Gitweb:     https://git.kernel.org/tip/b9a7b8831600afc51c9ba52c05f12db2266f01c7
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 11 Feb 2019 17:59:46 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 19 Mar 2019 12:06:15 +0100

sched/fair: Skip LLC NOHZ logic for asymmetric systems

The LLC NOHZ condition will become true as soon as >=2 CPUs in a
single LLC domain are busy. On big.LITTLE systems, this translates to
two or more CPUs of a "cluster" (big or LITTLE) being busy.

Issuing a NOHZ kick in these conditions isn't desired for asymmetric
systems, as if the busy CPUs can provide enough compute capacity to
the running tasks, then we can leave the NOHZ CPUs in peace.

Skip the LLC NOHZ condition for asymmetric systems, and rely on
nr_running & capacity checks to trigger NOHZ kicks when the system
actually needs them.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dietmar.Eggemann@arm.com
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/20190211175946.4961-4-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 65 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f0d2f8a352bf..51003e1c794d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9603,24 +9603,6 @@ static void nohz_balancer_kick(struct rq *rq)
 	}
 
 	rcu_read_lock();
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds) {
-		/*
-		 * If there is an imbalance between LLC domains (IOW we could
-		 * increase the overall cache use), we need some less-loaded LLC
-		 * domain to pull some load. Likewise, we may need to spread
-		 * load within the current LLC domain (e.g. packed SMT cores but
-		 * other CPUs are idle). We can't really know from here how busy
-		 * the others are - so just get a nohz balance going if it looks
-		 * like this LLC domain has tasks we could move.
-		 */
-		nr_busy = atomic_read(&sds->nr_busy_cpus);
-		if (nr_busy > 1) {
-			flags = NOHZ_KICK_MASK;
-			goto unlock;
-		}
-
-	}
 
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
@@ -9635,6 +9617,21 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
+	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
+	if (sd) {
+		/*
+		 * When ASYM_PACKING; see if there's a more preferred CPU
+		 * currently idle; in which case, kick the ILB to move tasks
+		 * around.
+		 */
+		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
+			if (sched_asym_prefer(i, cpu)) {
+				flags = NOHZ_KICK_MASK;
+				goto unlock;
+			}
+		}
+	}
+
 	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
 	if (sd) {
 		/*
@@ -9645,20 +9642,32 @@ static void nohz_balancer_kick(struct rq *rq)
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
+
+		/*
+		 * For asymmetric systems, we do not want to nicely balance
+		 * cache use, instead we want to embrace asymmetry and only
+		 * ensure tasks have enough CPU capacity.
+		 *
+		 * Skip the LLC logic because it's not relevant in that case.
+		 */
+		goto unlock;
 	}
 
-	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
-	if (sd) {
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
 		/*
-		 * When ASYM_PACKING; see if there's a more preferred CPU
-		 * currently idle; in which case, kick the ILB to move tasks
-		 * around.
+		 * If there is an imbalance between LLC domains (IOW we could
+		 * increase the overall cache use), we need some less-loaded LLC
+		 * domain to pull some load. Likewise, we may need to spread
+		 * load within the current LLC domain (e.g. packed SMT cores but
+		 * other CPUs are idle). We can't really know from here how busy
+		 * the others are - so just get a nohz balance going if it looks
+		 * like this LLC domain has tasks we could move.
 		 */
-		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_asym_prefer(i, cpu)) {
-				flags = NOHZ_KICK_MASK;
-				goto unlock;
-			}
+		nr_busy = atomic_read(&sds->nr_busy_cpus);
+		if (nr_busy > 1) {
+			flags = NOHZ_KICK_MASK;
+			goto unlock;
 		}
 	}
 unlock:
