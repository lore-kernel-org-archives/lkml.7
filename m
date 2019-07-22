Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A1EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CF021900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfGVReZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:34:25 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37752 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfGVReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:34:22 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hpcC8-0003HL-CV; Mon, 22 Jul 2019 13:33:52 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 10/14] sched,fair: add helper functions for flattened runqueue
Date:   Mon, 22 Jul 2019 13:33:44 -0400
Message-Id: <20190722173348.9241-11-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722173348.9241-1-riel@surriel.com>
References: <20190722173348.9241-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper functions to make the flattened runqueue patch a little smaller.

The task_se_h_weight function is similar to task_se_h_load, but scales the
task weight by the group weight, without taking the task's duty cycle into
account.

The task_se_in_cgroup helper is functionally identical to parent_entity,
but directly calling a function with that name obscures what the other
code is trying to use it for, and would make the code harder to understand.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c944729423bd..6073fabb171b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -243,6 +243,7 @@ static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_weight
 
 const struct sched_class fair_sched_class;
 static unsigned long task_se_h_load(struct sched_entity *se);
+static unsigned long task_se_h_weight(struct sched_entity *se);
 
 /**************************************************************
  * CFS operations on generic schedulable entities:
@@ -431,6 +432,12 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
 	return se->parent;
 }
 
+/* Is this (task) sched_entity in a non-root cgroup? */
+static inline bool task_se_in_cgroup(struct sched_entity *se)
+{
+	return parent_entity(se);
+}
+
 static void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
@@ -513,6 +520,11 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
 	return NULL;
 }
 
+static inline bool task_se_in_cgroup(struct sched_entity *se)
+{
+	return false;
+}
+
 static inline void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
@@ -7835,6 +7847,20 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs_rq)
 	}
 }
 
+static unsigned long task_se_h_weight(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq;
+
+	if (!task_se_in_cgroup(se))
+		return se->load.weight;
+
+	cfs_rq = group_cfs_rq_of_parent(se);
+	update_cfs_rq_h_load(cfs_rq);
+
+	/* Reduce the load.weight by the h_load of the group the task is in. */
+	return (cfs_rq->h_load * se->load.weight) >> SCHED_FIXEDPOINT_SHIFT;
+}
+
 static unsigned long task_se_h_load(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = group_cfs_rq_of_parent(se);
@@ -7871,6 +7897,11 @@ static unsigned long task_se_h_load(struct sched_entity *se)
 {
 	return se->avg.load_avg;
 }
+
+static unsigned long task_se_h_weight(struct sched_entity *se)
+{
+	return se->load.weight;
+}
 #endif
 
 /********** Helpers for find_busiest_group ************************/
-- 
2.20.1

