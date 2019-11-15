Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD69C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA632073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKOKjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:39:21 -0500
Received: from foss.arm.com ([217.140.110.172]:56870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfKOKjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:39:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9479630E;
        Fri, 15 Nov 2019 02:39:20 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 235E23F534;
        Fri, 15 Nov 2019 02:39:19 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, tj@kernel.org,
        patrick.bellasi@matbug.net, surenb@google.com, qperret@google.com,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2] sched/uclamp: Fix overzealous type replacement
Date:   Fri, 15 Nov 2019 10:39:08 +0000
Message-Id: <20191115103908.27610-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some uclamp helpers had their return type changed from 'unsigned int' to
'enum uclamp_id' by commit

  0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")

but it happens that some do return a value in the [0, SCHED_CAPACITY_SCALE]
range, which should really be unsigned int. The affected helpers are
uclamp_none(), uclamp_rq_max_value() and uclamp_eff_value(). Fix those up.

Note that this doesn't lead to any obj diff using a relatively recent
aarch64 compiler (8.3-2019.03). The current code of e.g. uclamp_eff_value()
properly returns an 11 bit value (bits_per(1024)) and doesn't seem to do
anything funny. I'm still marking this as fixing the above commit to be on
the safe side.

Fixes: 0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
v2 changes:
o Also fix uclamp_none() (Vincent)
o Collect reviewed-by
o Slightly reword changelog
---
 kernel/sched/core.c  | 6 +++---
 kernel/sched/sched.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 513a4794ff36..3ceff1c93ef1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -810,7 +810,7 @@ static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
 	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
 }
 
-static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
+static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
 {
 	if (clamp_id == UCLAMP_MIN)
 		return 0;
@@ -853,7 +853,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 }
 
 static inline
-enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
+unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 				   unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
@@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
-enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
+unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 05c282775f21..280a3c735935 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2300,7 +2300,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
+unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
 unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
-- 
2.22.0

