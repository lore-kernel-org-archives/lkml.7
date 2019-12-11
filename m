Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5449DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2532073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfLKLjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:39:17 -0500
Received: from foss.arm.com ([217.140.110.172]:54984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfLKLjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:39:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2087D31B;
        Wed, 11 Dec 2019 03:39:15 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB5E83F6CF;
        Wed, 11 Dec 2019 03:39:13 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v3 1/5] sched/uclamp: Remove uclamp_util()
Date:   Wed, 11 Dec 2019 11:38:47 +0000
Message-Id: <20191211113851.24241-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211113851.24241-1-valentin.schneider@arm.com>
References: <20191211113851.24241-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sole user of uclamp_util(), schedutil_cpu_util(), was made to use
uclamp_util_with() instead in commit

  af24bde8df20 ("sched/uclamp: Add uclamp support to energy_compute()")

From then on, uclamp_util() has remained unused. Being a simple wrapper
around uclamp_util_with(), we can get rid of it and win back a few lines.

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/sched.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..d9b24513d71d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2324,21 +2324,12 @@ unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
 
 	return clamp(util, min_util, max_util);
 }
-
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
-{
-	return uclamp_util_with(rq, util, NULL);
-}
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
 					    struct task_struct *p)
 {
 	return util;
 }
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
-{
-	return util;
-}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef arch_scale_freq_capacity
-- 
2.24.0

