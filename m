Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B70C2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842422073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfLKLjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:39:20 -0500
Received: from foss.arm.com ([217.140.110.172]:55000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbfLKLjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:39:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6F94DA7;
        Wed, 11 Dec 2019 03:39:16 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 535FC3F6CF;
        Wed, 11 Dec 2019 03:39:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v3 2/5] sched/uclamp: Make uclamp util helpers use and return UL values
Date:   Wed, 11 Dec 2019 11:38:48 +0000
Message-Id: <20191211113851.24241-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211113851.24241-1-valentin.schneider@arm.com>
References: <20191211113851.24241-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent pointed out recently that the canonical type for utilization
values is 'unsigned long'. Internally uclamp uses 'unsigned int' values for
cache optimization, but this doesn't have to be exported to its users.

Make the uclamp helpers that deal with utilization use and return unsigned
long values.

Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c  |  6 +++---
 kernel/sched/sched.h | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..9c41b6551bc9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -919,17 +919,17 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
-unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
+unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
 
 	/* Task currently refcounted: use back-annotated (effective) value */
 	if (p->uclamp[clamp_id].active)
-		return p->uclamp[clamp_id].value;
+		return (unsigned long)p->uclamp[clamp_id].value;
 
 	uc_eff = uclamp_eff_get(p, clamp_id);
 
-	return uc_eff.value;
+	return (unsigned long)uc_eff.value;
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d9b24513d71d..b478474ea847 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2300,14 +2300,14 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
+unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
-unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
-			      struct task_struct *p)
+unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
+			       struct task_struct *p)
 {
-	unsigned int min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
-	unsigned int max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
+	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
 
 	if (p) {
 		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
@@ -2325,8 +2325,8 @@ unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
 	return clamp(util, min_util, max_util);
 }
 #else /* CONFIG_UCLAMP_TASK */
-static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
-					    struct task_struct *p)
+static inline unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
+					     struct task_struct *p)
 {
 	return util;
 }
-- 
2.24.0

