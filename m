Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D07C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F25208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfKTR5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:57:34 -0500
Received: from foss.arm.com ([217.140.110.172]:43982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfKTR5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:57:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2828CDA7;
        Wed, 20 Nov 2019 09:57:32 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDB713F6C4;
        Wed, 20 Nov 2019 09:57:30 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH 1/3] sched/uclamp: Make uclamp_util_*() helpers use and return UL values
Date:   Wed, 20 Nov 2019 17:55:31 +0000
Message-Id: <20191120175533.4672-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191120175533.4672-1-valentin.schneider@arm.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
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
2.22.0

