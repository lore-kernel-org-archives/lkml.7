Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37A3C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3121783
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfHOOx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfHOOx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:53:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FC384F1DC;
        Thu, 15 Aug 2019 14:53:56 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8411EA;
        Thu, 15 Aug 2019 14:53:55 +0000 (UTC)
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH] sched/rt: silence double clock update warning by using rq_lock wrappers
Date:   Thu, 15 Aug 2019 10:53:54 -0400
Message-Id: <20190815145354.27484-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 15 Aug 2019 14:53:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With WARN_DOUBLE_CLOCK enabled a false positive warning can occur in rt

        [] rq->clock_update_flags & RQCF_UPDATED
        [] WARNING: CPU: 6 PID: 21426 at kernel/sched/core.c:225 
						update_rq_clock+0x90/0x130
          [] Call Trace:
          []  update_rq_clock+0x90/0x130
          []  sched_rt_period_timer+0x11f/0x340
          []  __hrtimer_run_queues+0x100/0x280
          []  hrtimer_interrupt+0x100/0x220
          []  smp_apic_timer_interrupt+0x6a/0x130
          []  apic_timer_interrupt+0xf/0x20

sched_rt_period_timer does:
                raw_spin_lock(&rq->lock);
                update_rq_clock(rq);

which triggers the warning because of not using the rq_lock wrappers.
So, use the wrappers.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/rt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a532558a5176..0846e71114ee 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -831,6 +831,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		int enqueue = 0;
 		struct rt_rq *rt_rq = sched_rt_period_rt_rq(rt_b, i);
 		struct rq *rq = rq_of_rt_rq(rt_rq);
+		struct rq_flags rf;
 		int skip;
 
 		/*
@@ -845,7 +846,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		if (skip)
 			continue;
 
-		raw_spin_lock(&rq->lock);
+		rq_lock(rq, &rf);
 		update_rq_clock(rq);
 
 		if (rt_rq->rt_time) {
@@ -883,7 +884,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 		if (enqueue)
 			sched_rt_rq_enqueue(rt_rq);
-		raw_spin_unlock(&rq->lock);
+		rq_unlock(rq, &rf);
 	}
 
 	if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF))
-- 
2.18.0

