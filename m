Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE20C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2209827FD9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V+FTL4Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfFCNF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:05:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfFCNF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:05:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D5epf604292
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:05:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D5epf604292
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567141;
        bh=ziOCPvfE6TBUUfAhHTQ2jx6jP/6NC/Buj7SN0rRArlg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=V+FTL4JakcYriOKzxkBUVcFWIfBNKgA5/iqq3WcD7SEcdoMLSf6MLl8tfup8yYF2X
         hDL9z72j5S99iyTOV1KFcvpquzbxrhjI7TmV0RAnBgJ+vqnbRHWodg/VyOW9msJodC
         Qz9Xpxc4a7o3PjISPqXPYdY3mzbWSyFd0a+0mYxgziCu6W2/qe3glavmZK3raP7uCe
         wjWBxhLxX8z7dCfKa1V1O+bS+MoUMasZohjQu5ZxJYno6WFpNusgWmOXWmc7+nZupq
         jPtDSiO7PSaehSWGAAN5F0fbD/l18w4uyDmif54vTWWcx2zxtySsBWszzuEdenQ1NS
         S/BTd2OZr4BPQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D5eDE604289;
        Mon, 3 Jun 2019 06:05:40 -0700
Date:   Mon, 3 Jun 2019 06:05:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-af75d1a9a9f75bf030c2f35705f1ff6d226f96fe@git.kernel.org>
Cc:     quentin.perret@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com, hpa@zytor.com,
        mingo@kernel.org, morten.rasmussen@arm.com, peterz@infradead.org,
        riel@surriel.com, fweisbec@gmail.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Reply-To: vincent.guittot@linaro.org, valentin.schneider@arm.com,
          fweisbec@gmail.com, riel@surriel.com, peterz@infradead.org,
          mingo@kernel.org, morten.rasmussen@arm.com,
          patrick.bellasi@arm.com, torvalds@linux-foundation.org,
          dietmar.eggemann@arm.com, hpa@zytor.com, tglx@linutronix.de,
          quentin.perret@arm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190527062116.11512-7-dietmar.eggemann@arm.com>
References: <20190527062116.11512-7-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Remove sgs->sum_weighted_load
Git-Commit-ID: af75d1a9a9f75bf030c2f35705f1ff6d226f96fe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  af75d1a9a9f75bf030c2f35705f1ff6d226f96fe
Gitweb:     https://git.kernel.org/tip/af75d1a9a9f75bf030c2f35705f1ff6d226f96fe
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Mon, 27 May 2019 07:21:15 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:49:41 +0200

sched/fair: Remove sgs->sum_weighted_load

Since sg_lb_stats::sum_weighted_load is now identical with
sg_lb_stats::group_load remove it and replace its use case
(calculating load per task) with the latter.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@surriel.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20190527062116.11512-7-dietmar.eggemann@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5b9691e5ea59..7f8d477f90fe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7577,7 +7577,6 @@ static unsigned long task_h_load(struct task_struct *p)
 struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
-	unsigned long sum_weighted_load; /* Weighted load of group's tasks */
 	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
@@ -7944,7 +7943,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->nr_numa_running += rq->nr_numa_running;
 		sgs->nr_preferred_running += rq->nr_preferred_running;
 #endif
-		sgs->sum_weighted_load += weighted_cpuload(rq);
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
 		 */
@@ -7963,7 +7961,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
 	if (sgs->sum_nr_running)
-		sgs->load_per_task = sgs->sum_weighted_load / sgs->sum_nr_running;
+		sgs->load_per_task = sgs->group_load / sgs->sum_nr_running;
 
 	sgs->group_weight = group->group_weight;
 
