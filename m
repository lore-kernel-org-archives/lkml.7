Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6834C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2D627F3F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CPeIBww0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfFCNEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:04:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFCNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:04:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D4Ecf604060
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:04:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D4Ecf604060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567055;
        bh=a5RLB2yK0DvvTtv+ts8FkarYrQCpWHP14WeMo02Y9fs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CPeIBww0LbDuFktOXgysgfA913rk8QeXjui9Gb7+8W42cXSpgNk4NDXiZlVjTYvXQ
         qo+Ld5NGg09QEm4YAkGcohu2GiUCHL9ajYeTO+SEN7Nu4M7PgMLJXTlvV/PIw/mL1M
         dDM660ykruvwPBKfY0nE7vPxVbcpbySazZT/YIV4Bt655EZr8zqpbIyDDcpXB8EDof
         Y55HcBYms9hj2T7XeeyMByAqGivAwtXWS1YdsVdfbs1kkdikpVMkY9Wl2xy2N6qUrU
         cQSTj/ynMIFBaVa018AO/AebMwHOWUlG6dNqfdwgfJyQMi96r9Dk2epPmrrbE/0U5R
         60CLPKaipUOlQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D4Ef5604057;
        Mon, 3 Jun 2019 06:04:14 -0700
Date:   Mon, 3 Jun 2019 06:04:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dietmar Eggemann <tipbot@zytor.com>
Message-ID: <tip-55627e3cd22c315c4a02fe3bbbb7234ec439cb1d@git.kernel.org>
Cc:     peterz@infradead.org, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        fweisbec@gmail.com, tglx@linutronix.de, dietmar.eggemann@arm.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        morten.rasmussen@arm.com, hpa@zytor.com, quentin.perret@arm.com,
        patrick.bellasi@arm.com, riel@surriel.com
Reply-To: quentin.perret@arm.com, patrick.bellasi@arm.com,
          riel@surriel.com, hpa@zytor.com, morten.rasmussen@arm.com,
          mingo@kernel.org, dietmar.eggemann@arm.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          fweisbec@gmail.com, tglx@linutronix.de,
          vincent.guittot@linaro.org, valentin.schneider@arm.com,
          peterz@infradead.org
In-Reply-To: <20190527062116.11512-5-dietmar.eggemann@arm.com>
References: <20190527062116.11512-5-dietmar.eggemann@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Remove rq->cpu_load[]
Git-Commit-ID: 55627e3cd22c315c4a02fe3bbbb7234ec439cb1d
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

Commit-ID:  55627e3cd22c315c4a02fe3bbbb7234ec439cb1d
Gitweb:     https://git.kernel.org/tip/55627e3cd22c315c4a02fe3bbbb7234ec439cb1d
Author:     Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate: Mon, 27 May 2019 07:21:13 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:49:40 +0200

sched/core: Remove rq->cpu_load[]

The per rq load array values also disappear from the cpu#X sections in
/proc/sched_debug.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20190527062116.11512-5-dietmar.eggemann@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 6 +-----
 kernel/sched/debug.c | 5 -----
 kernel/sched/sched.h | 2 --
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 00b8966802a8..29984d8c41f0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5901,8 +5901,8 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 void __init sched_init(void)
 {
-	int i, j;
 	unsigned long alloc_size = 0, ptr;
+	int i;
 
 	wait_bit_init();
 
@@ -6004,10 +6004,6 @@ void __init sched_init(void)
 #ifdef CONFIG_RT_GROUP_SCHED
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
-
-		for (j = 0; j < CPU_LOAD_IDX_MAX; j++)
-			rq->cpu_load[j] = 0;
-
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
 		rq->rd = NULL;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 5c7b066d7de6..a0b0d6e21e5b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -654,11 +654,6 @@ do {									\
 	SEQ_printf(m, "  .%-30s: %ld\n", "curr->pid", (long)(task_pid_nr(rq->curr)));
 	PN(clock);
 	PN(clock_task);
-	P(cpu_load[0]);
-	P(cpu_load[1]);
-	P(cpu_load[2]);
-	P(cpu_load[3]);
-	P(cpu_load[4]);
 #undef P
 #undef PN
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3750b5e53792..607859a18b2a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -812,8 +812,6 @@ struct rq {
 	unsigned int		nr_preferred_running;
 	unsigned int		numa_migrate_on;
 #endif
-	#define CPU_LOAD_IDX_MAX 5
-	unsigned long		cpu_load[CPU_LOAD_IDX_MAX];
 #ifdef CONFIG_NO_HZ_COMMON
 #ifdef CONFIG_SMP
 	unsigned long		last_load_update_tick;
