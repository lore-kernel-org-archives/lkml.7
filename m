Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9DFC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B685421901
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfGZI3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:29:45 -0400
Received: from foss.arm.com ([217.140.110.172]:39532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfGZI3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:29:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3294C152D;
        Fri, 26 Jul 2019 01:29:41 -0700 (PDT)
Received: from e107985-lin.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AD413F71A;
        Fri, 26 Jul 2019 01:29:39 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] sched/deadline: Use return value of SCHED_WARN_ON() in bw accounting
Date:   Fri, 26 Jul 2019 09:27:56 +0100
Message-Id: <20190726082756.5525-6-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726082756.5525-1-dietmar.eggemann@arm.com>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the decision whether to set rq or running bw to 0 in underflow
case use the return value of SCHED_WARN_ON() rather than an extra if
condition.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a9cb52ceb761..66c594b5507e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -95,8 +95,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
 	dl_rq->running_bw -= dl_bw;
-	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
-	if (dl_rq->running_bw > old)
+	if (SCHED_WARN_ON(dl_rq->running_bw > old)) /* underflow */
 		dl_rq->running_bw = 0;
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
@@ -119,8 +118,7 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
 	dl_rq->this_bw -= dl_bw;
-	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
-	if (dl_rq->this_bw > old)
+	if (SCHED_WARN_ON(dl_rq->this_bw > old)) /* underflow */
 		dl_rq->this_bw = 0;
 	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
 }
-- 
2.17.1

