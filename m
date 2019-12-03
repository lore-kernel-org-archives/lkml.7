Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE72C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F027206E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfLCQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:02:15 -0500
Received: from foss.arm.com ([217.140.110.172]:44810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCQCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:02:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D279ADA7;
        Tue,  3 Dec 2019 08:02:11 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83DBE3F52E;
        Tue,  3 Dec 2019 08:02:10 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v2 1/4] sched/uclamp: Make uclamp_util_*() helpers use and return UL values
Date:   Tue,  3 Dec 2019 15:59:04 +0000
Message-Id: <20191203155907.2086-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203155907.2086-1-valentin.schneider@arm.com>
References: <20191203155907.2086-1-valentin.schneider@arm.com>
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
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/sched.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..f1d035e5df7e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2303,15 +2303,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
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
-		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
-		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
+		min_util = max_t(unsigned long, min_util, uclamp_eff_value(p, UCLAMP_MIN));
+		max_util = max_t(unsigned long, max_util, uclamp_eff_value(p, UCLAMP_MAX));
 	}
 
 	/*
@@ -2325,17 +2325,17 @@ unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
 	return clamp(util, min_util, max_util);
 }
 
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
 {
 	return uclamp_util_with(rq, util, NULL);
 }
 #else /* CONFIG_UCLAMP_TASK */
-static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
-					    struct task_struct *p)
+static inline unsigned long uclamp_util_with(struct rq *rq, unsigned long util,
+					     struct task_struct *p)
 {
 	return util;
 }
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
+static inline unsigned long uclamp_util(struct rq *rq, unsigned long util)
 {
 	return util;
 }
-- 
2.24.0

