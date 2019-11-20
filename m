Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3502C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9367620878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfKTR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:57:39 -0500
Received: from foss.arm.com ([217.140.110.172]:43996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfKTR5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:57:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA2911045;
        Wed, 20 Nov 2019 09:57:33 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BEBE3F6C4;
        Wed, 20 Nov 2019 09:57:32 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH 2/3] sched/uclamp: Rename uclamp_util_*() into uclamp_rq_util_*()
Date:   Wed, 20 Nov 2019 17:55:32 +0000
Message-Id: <20191120175533.4672-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191120175533.4672-1-valentin.schneider@arm.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current helpers return (CPU) rq utilization with uclamp restrictions
taken into account. As I'm about to introduce a task clamped utilization
variant, make it explicit that those deal with runqueues.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/sched.h             | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 86800b4d5453..9deb3a13416d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -240,7 +240,7 @@ unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
 	 */
 	util = util_cfs + cpu_util_rt(rq);
 	if (type == FREQUENCY_UTIL)
-		util = uclamp_util_with(rq, util, p);
+		util = uclamp_rq_util_with(rq, util, p);
 
 	dl_util = cpu_util_dl(rq);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f1d035e5df7e..900328c4eeef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2303,8 +2303,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
-unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
-			       struct task_struct *p)
+unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
+				  struct task_struct *p)
 {
 	unsigned long min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
 	unsigned long max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
@@ -2325,17 +2325,17 @@ unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
 	return clamp(util, min_util, max_util);
 }
 
-static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
+static inline unsigned long uclamp_rq_util(struct rq *rq, unsigned long util)
 {
-	return uclamp_util_with(rq, util, NULL);
+	return uclamp_rq_util_with(rq, util, NULL);
 }
 #else /* CONFIG_UCLAMP_TASK */
-static inline unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
-					     struct task_struct *p)
+static inline unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
+						struct task_struct *p)
 {
 	return util;
 }
-static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
+static inline unsigned long uclamp_rq_util(struct rq *rq, unsigned long util)
 {
 	return util;
 }
-- 
2.22.0

