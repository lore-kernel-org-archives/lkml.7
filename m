Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE11C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99652206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX/9wWbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfCFIoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:44:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35799 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfCFIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:44:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so7833997pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 00:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1vh7hA17yADLWVoUXDA26oBLsTHTn0FsDrfCzKugJug=;
        b=kX/9wWbdMl6UmRPN3n34xXStb9+lTTM55Opwuk6yDNuvsvEVms3ztmIwlWgGtvn1Af
         Yf5KBb6ya2f4KEml8Z7QVAVOH/Wrf+OLR7AvxQcSiRElTicMg1dGMoiGRMcwpZjeKxmP
         G0MAlVkeGMph6GadkSjDzTf9eO5LT3GjqoNX0ec6Hyim46VfzzB8IPeeq/NcepJW1bR4
         rQUU6PAIalOJrWT4JwKO2P0kBmDyBJ1iSLnwtzLdmWnSpLqaleSoW4BcuKNdqgTjCO6c
         3rIbDwOCPtl53fSoFi76lbm1ah8J0BU8h/SHcfhE70DS8YgpDn79sAPvpsxavrIG8UlZ
         12rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1vh7hA17yADLWVoUXDA26oBLsTHTn0FsDrfCzKugJug=;
        b=lJxUhOyqSdxsUGfsEw0afwQxIxoqn6ytUwvxC1Ykm781FiLPlhiAmYNEskLs9pAjL6
         qLElnzv4fKkQg5j/J1JPHQ+kpYD6YX5OUHfoEaikGmzAjCWKMh92teAju9AyPCJEXeGO
         ERZDo9SVBonzBMUqAiMP4lSVb08BJpvdNP/Zsn76HpTxewyLiWZanhC0InWFB1Xhin72
         e0gtrpD3xKptmDtW7433PBCrDu7s76OkslyLdXpjsJuKIFivPEO5OsvP203j8FC4hyeO
         KtYz++FoizCAr1R0n301S8E2glcv1kjjcFCRekkQVnmDMORV955ketnq8DOPGtUvS0Cj
         FdMQ==
X-Gm-Message-State: APjAAAX5jGWVxRnFTd1e18fL49hRnWsz6j4rbmA+Fmd+yTjl9lfUDvY0
        OIA+2KYBAvtjViOOHbhp7x5INiEz+KQ=
X-Google-Smtp-Source: APXvYqz0Drk2kwkNbdf2ofG/AJaAjGpTNGbZDUSAsRGGvW9NU5zOKYyInOpjRNYiI/QD5LSABA2zgQ==
X-Received: by 2002:a62:1981:: with SMTP id 123mr6114826pfz.69.1551861840392;
        Wed, 06 Mar 2019 00:44:00 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k12sm1757273pfk.109.2019.03.06.00.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 00:43:59 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] sched: fair: fix missed CONFIG_SCHEDSTATS
Date:   Wed,  6 Mar 2019 16:43:46 +0800
Message-Id: <1551861826-12592-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I'm using trace_sched_stat_{iowait, blocked, wait, sleep} to
measure how long the processes are stalled, there's always no output from
trace_pipe while there're really some tasks in uninterruptible sleep
state. That makes me confused, so I try to investigate why.
Finally I find the reason is that CONFIG_SCHEDSTATS is not set.

To avoid such kind of confusion, we should not expose these tracepoints
if CONFIG_SCHEDSTATS is not set.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/sched.h |  3 ++-
 kernel/sched/fair.c          | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfa..a261da8 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -336,6 +336,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 		  __entry->pid, __entry->old_pid)
 );
 
+#ifdef CONFIG_SCHEDSTATS
 /*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
@@ -363,7 +364,6 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 			(unsigned long long)__entry->delay)
 );
 
-
 /*
  * Tracepoint for accounting wait time (time the task is runnable
  * but not actually running due to scheduler contention).
@@ -394,6 +394,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 DEFINE_EVENT(sched_stat_template, sched_stat_blocked,
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
+#endif
 
 /*
  * Tracepoint for accounting runtime (time the task is executing
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8213ff6..a8006c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -855,6 +855,7 @@ static void update_curr_fair(struct rq *rq)
 static inline void
 update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+#ifdef CONFIG_SCHEDSTATS
 	u64 wait_start, prev_wait_start;
 
 	if (!schedstat_enabled())
@@ -868,11 +869,13 @@ static void update_curr_fair(struct rq *rq)
 		wait_start -= prev_wait_start;
 
 	__schedstat_set(se->statistics.wait_start, wait_start);
+#endif
 }
 
 static inline void
 update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+#ifdef CONFIG_SCHEDSTATS
 	struct task_struct *p;
 	u64 delta;
 
@@ -900,11 +903,13 @@ static void update_curr_fair(struct rq *rq)
 	__schedstat_inc(se->statistics.wait_count);
 	__schedstat_add(se->statistics.wait_sum, delta);
 	__schedstat_set(se->statistics.wait_start, 0);
+#endif
 }
 
 static inline void
 update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+#ifdef CONFIG_SCHEDSTATS
 	struct task_struct *tsk = NULL;
 	u64 sleep_start, block_start;
 
@@ -968,6 +973,7 @@ static void update_curr_fair(struct rq *rq)
 			account_scheduler_latency(tsk, delta >> 10, 0);
 		}
 	}
+#endif
 }
 
 /*
@@ -976,6 +982,7 @@ static void update_curr_fair(struct rq *rq)
 static inline void
 update_stats_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+#ifdef CONFIG_SCHEDSTATS
 	if (!schedstat_enabled())
 		return;
 
@@ -988,12 +995,13 @@ static void update_curr_fair(struct rq *rq)
 
 	if (flags & ENQUEUE_WAKEUP)
 		update_stats_enqueue_sleeper(cfs_rq, se);
+#endif
 }
 
 static inline void
 update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-
+#ifdef CONFIG_SCHEDSTATS
 	if (!schedstat_enabled())
 		return;
 
@@ -1014,6 +1022,7 @@ static void update_curr_fair(struct rq *rq)
 			__schedstat_set(se->statistics.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
+#endif
 }
 
 /*
@@ -4090,6 +4099,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	update_stats_curr_start(cfs_rq, se);
 	cfs_rq->curr = se;
 
+#ifdef CONFIG_SCHEDSTATS
 	/*
 	 * Track our maximum slice length, if the CPU's load is at
 	 * least twice that of our own weight (i.e. dont track it
@@ -4100,6 +4110,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 			max((u64)schedstat_val(se->statistics.slice_max),
 			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
+#endif
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
-- 
1.8.3.1

