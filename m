Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8113EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBB5207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfCIOid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:38:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56947 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCIOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:38:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29EcEGR3109009
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:38:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29EcCfp3109006;
        Sat, 9 Mar 2019 06:38:12 -0800
Date:   Sat, 9 Mar 2019 06:38:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-ce28d2e53cda890771360d32259495dd6a9c4253@git.kernel.org>
Cc:     peterz@infradead.org, morten.rasmussen@arm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        riel@surriel.com, torvalds@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org,
        valentin.schneider@arm.com, tglx@linutronix.de
Reply-To: morten.rasmussen@arm.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, bp@alien8.de,
          mingo@kernel.org, riel@surriel.com,
          torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
          luto@kernel.org, tglx@linutronix.de, valentin.schneider@arm.com
In-Reply-To: <20190211175946.4961-4-valentin.schneider@arm.com>
References: <20190211175946.4961-4-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Skip LLC NOHZ logic for asymmetric
 systems
Git-Commit-ID: ce28d2e53cda890771360d32259495dd6a9c4253
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

Commit-ID:  ce28d2e53cda890771360d32259495dd6a9c4253
Gitweb:     https://git.kernel.org/tip/ce28d2e53cda890771360d32259495dd6a9c4253
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 11 Feb 2019 17:59:46 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:03:53 +0100

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
