Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA71C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA3521744
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbfFLTct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:32:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50394 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFLTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:32:48 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hb8z1-0001BN-RO; Wed, 12 Jun 2019 15:32:31 -0400
From:   Rik van Riel <riel@surriel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/8] sched: introduce task_se_h_load helper
Date:   Wed, 12 Jun 2019 15:32:20 -0400
Message-Id: <20190612193227.993-2-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612193227.993-1-riel@surriel.com>
References: <20190612193227.993-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the hierarchical load of a sched_entity needs to be calculated.
Split out task_h_load into a task_se_h_load that takes a sched_entity pointer
as its argument, and a task_h_load wrapper that calls task_se_h_load.

No functional changes.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..df624f7a68e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -706,6 +706,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #ifdef CONFIG_SMP
 
 static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
+static unsigned long task_se_h_load(struct sched_entity *se);
 static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
@@ -7833,14 +7834,19 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	}
 }
 
-static unsigned long task_h_load(struct task_struct *p)
+static unsigned long task_se_h_load(struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq = task_cfs_rq(p);
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	update_cfs_rq_h_load(cfs_rq);
-	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
+	return div64_ul(se->avg.load_avg * cfs_rq->h_load,
 			cfs_rq_load_avg(cfs_rq) + 1);
 }
+
+static unsigned long task_h_load(struct task_struct *p)
+{
+	return task_se_h_load(&p->se);
+}
 #else
 static inline void update_blocked_averages(int cpu)
 {
@@ -7865,6 +7871,11 @@ static inline void update_blocked_averages(int cpu)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
+static unsigned long task_se_h_load(struct sched_entity *se)
+{
+	return se->avg.load_avg;
+}
+
 static unsigned long task_h_load(struct task_struct *p)
 {
 	return p->se.avg.load_avg;
-- 
2.20.1

