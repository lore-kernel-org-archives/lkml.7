Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A32190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfGVRfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:35:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37758 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGVReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:34:23 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hpcC8-0003HL-9s; Mon, 22 Jul 2019 13:33:52 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org, Rik van Riel <riel@surriel.com>
Subject: [PATCH 08/14] sched,fair: simplify timeslice length code
Date:   Mon, 22 Jul 2019 13:33:42 -0400
Message-Id: <20190722173348.9241-9-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722173348.9241-1-riel@surriel.com>
References: <20190722173348.9241-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea behind __sched_period makes sense, but the results do not always.

When a CPU has one high priority task and a large number of low priority
tasks, __sched_period will return a value larger than sysctl_sched_latency,
and the one high priority task may end up getting a timeslice all for itself
that is also much larger than sysctl_sched_latency.

The low priority tasks will have their time slices rounded up to
sysctl_sched_min_granularity, resulting in an even larger scheduling
latency than targeted by __sched_period.

Simplify the code by simply ripping out __sched_period and always taking
fractions of sysctl_sched_latency.

If a high priority task ends up getting a "too small" time slice compared
to low priority tasks, the vruntime scaling ensures that it will simply
get scheduled more frequently than low priority tasks.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ff69b927a3c..b4fc328032e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -691,22 +691,6 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 	return delta;
 }
 
-/*
- * The idea is to set a period in which each task runs once.
- *
- * When there are too many tasks (sched_nr_latency) we have to stretch
- * this period because otherwise the slices get too small.
- *
- * p = (nr <= nl) ? l : l*nr/nl
- */
-static u64 __sched_period(unsigned long nr_running)
-{
-	if (unlikely(nr_running > sched_nr_latency))
-		return nr_running * sysctl_sched_min_granularity;
-	else
-		return sysctl_sched_latency;
-}
-
 /*
  * We calculate the wall-time slice from the period by taking a part
  * proportional to the weight.
@@ -715,7 +699,7 @@ static u64 __sched_period(unsigned long nr_running)
  */
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
+	u64 slice = sysctl_sched_latency;
 
 	for_each_sched_entity(se) {
 		struct load_weight *load;
-- 
2.20.1

