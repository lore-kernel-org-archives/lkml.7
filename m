Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAACDC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FDF2817A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfFCLyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:54:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFCLyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:54:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2EB515A2;
        Mon,  3 Jun 2019 04:54:45 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F9BB3F5AF;
        Mon,  3 Jun 2019 04:54:44 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     cai@lca.pw, peterz@infradead.org, mingo@kernel.org,
        vincent.guittot@linaro.org
Subject: [PATCH v2] sched/fair: Cleanup definition of NOHZ blocked load functions
Date:   Mon,  3 Jun 2019 12:54:24 +0100
Message-Id: <20190603115424.7951-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
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

[Addition by Peter Zijlstra]
While at it, remove the CONFIG_NO_HZ_COMMON block from the
!CONFIG_FAIR_GROUP_SCHED definition of update_blocked_averages() by
using the newly-introduced update_blocked_load_status() helper.

No change in functionality intended.

Reported-by: Qian Cai <cai@lca.pw>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

---
Changes since v1:

Squashed Peter's extra cleanup [1]
Added ack from Vincent

[1]: https://lore.kernel.org/lkml/20190603093835.GF3436@hirez.programming.kicks-ass.net/
---
 kernel/sched/fair.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..72030ad97638 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7695,6 +7695,7 @@ static void attach_tasks(struct lb_env *env)
 	rq_unlock(env->dst_rq, &rf);
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->avg.load_avg)
@@ -7722,6 +7723,19 @@ static inline bool others_have_blocked(struct rq *rq)
 	return false;
 }
 
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+{
+	rq->last_blocked_load_update_tick = jiffies;
+
+	if (!has_blocked)
+		rq->has_blocked_load = 0;
+}
+#else
+static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
+static inline bool others_have_blocked(struct rq *rq) { return false; }
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7787,11 +7801,7 @@ static void update_blocked_averages(int cpu)
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
 
@@ -7857,11 +7867,7 @@ static inline void update_blocked_averages(int cpu)
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
-#ifdef CONFIG_NO_HZ_COMMON
-	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !others_have_blocked(rq))
-		rq->has_blocked_load = 0;
-#endif
+	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-- 
2.20.1

