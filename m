Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8ECC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1451D27977
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfFBQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:41:49 -0400
Received: from foss.arm.com ([217.140.101.70]:40928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFBQls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:41:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B19C374;
        Sun,  2 Jun 2019 09:41:48 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9EA83F246;
        Sun,  2 Jun 2019 09:41:46 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] sched/fair: Cleanup definition of NOHZ blocked load functions
Date:   Sun,  2 Jun 2019 17:41:10 +0100
Message-Id: <20190602164110.23231-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw>
References: <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs_rq_has_blocked() and others_have_blocked() are only used within
update_blocked_averages(). The !CONFIG_FAIR_GROUP_SCHED version of the
latter calls them within a #define CONFIG_NO_HZ_COMMON block, whereas
the CONFIG_FAIR_GROUP_SCHED one calls them unconditionnally.

As reported by Qian, the above leads to this warning in
!CONFIG_NO_HZ_COMMON configs:

  kernel/sched/fair.c: In function 'update_blocked_averages':
  kernel/sched/fair.c:7750:7: warning: variable 'done' set but not used
  [-Wunused-but-set-variable]

It wouldn't be wrong to keep cfs_rq_has_blocked() and
others_have_blocked() as they are, but since their only current use is
to figure out when we can stop calling update_blocked_averages() on
fully decayed NOHZ idle CPUs, we can give them a new definition for
!CONFIG_NO_HZ_COMMON.

Change the definition of cfs_rq_has_blocked() and
others_have_blocked() for !CONFIG_NO_HZ_COMMON so that the
NOHZ-specific blocks of update_blocked_averages() become no-ops and
the 'done' variable gets optimised out.

No change in functionality intended.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..03919a316a03 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7695,6 +7695,7 @@ static void attach_tasks(struct lb_env *env)
 	rq_unlock(env->dst_rq, &rf);
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->avg.load_avg)
@@ -7721,6 +7722,10 @@ static inline bool others_have_blocked(struct rq *rq)
 
 	return false;
 }
+#else
+static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
+static inline bool others_have_blocked(struct rq *rq) { return false; }
+#endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
@@ -7741,6 +7746,18 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	return true;
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+{
+	rq->last_blocked_load_update_tick = jiffies;
+
+	if (!has_blocked)
+		rq->has_blocked_load = 0;
+}
+#else
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
+#endif
+
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7787,11 +7804,7 @@ static void update_blocked_averages(int cpu)
 	if (others_have_blocked(rq))
 		done = false;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	rq->last_blocked_load_update_tick = jiffies;
-	if (done)
-		rq->has_blocked_load = 0;
-#endif
+	update_blocked_load_status(rq, !done);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-- 
2.20.1

