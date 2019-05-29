Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D8F2419F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="XfqTF9U8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfE2UiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:38:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55803 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfE2UhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:37:02 -0400
Received: by mail-it1-f195.google.com with SMTP id g24so6235648iti.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=G0IRZhtbIKeaZkChlh1OzdrtZcJGCkc1xSr+O9r8B4A=;
        b=XfqTF9U8bytYV7Iqoj+RDzMO5rbryTRYkoLmkUd1ovcAQ+Vs1nZT+W781PY9UNEqOl
         eWg7YyCW5fl18c/Jhf/GcnRXgoiJR/k3/7oCiGmM283Rjon4U6iabol62H6TWsxhkE6h
         t/SPWIpwfBjiV1S0k7EBlKlo8OEttx9vHLZaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=G0IRZhtbIKeaZkChlh1OzdrtZcJGCkc1xSr+O9r8B4A=;
        b=aQLkw5XvU0ApJaQH8YU1VqsQmNJjfl6LpeHLwSlvUxgcUKpY9FYH3uDO/RtxNt4p39
         wfsSNDWXOFOlcJJlnm7P4fEY55FaSZXqep9MpFGBRLDAr5MR4tk+yzd3ZhfmdldNSsdW
         bNVdoB9a+SNSpQDSCYTxGhinq5U46CadJXW0N0ct9RQtpzKiJIhd+eZxb5/79F/BMMyF
         cZho7hUJil8n4Q133eQ+UQFr5z/nvp+D5Z8Ms1DwjVU9zxg1DzW109GbIqWAzKSYyY2j
         y1T9vPi3KOahbNbHbhUlzJ3u1DX6vDpmHCkcE3RH0pjTLgWA2gatm5nFo0HSRuWv9cCw
         Nk2A==
X-Gm-Message-State: APjAAAXolCdtisZstp1EieBF77F+tXz4/2XcvFr3HdJrqWYI9zS8RK/2
        rxupMl2TXPrtVV13Q/pBbY9MTA==
X-Google-Smtp-Source: APXvYqwdKNbVRZRjz9+a7xs2XWjpURlkHK8nibbUMX4tA6+hMcFJjyqKj4gih+2q/hgA1s5l2sjqLw==
X-Received: by 2002:a24:78d1:: with SMTP id p200mr161999itc.69.1559162221330;
        Wed, 29 May 2019 13:37:01 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id t63sm161997ita.42.2019.05.29.13.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:37:00 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 04/16] sched/{rt,deadline}: Fix set_next_task vs pick_next_task
Date:   Wed, 29 May 2019 20:36:40 +0000
Message-Id: <38c61d5240553e043c27c5e00b9dd0d184dd6081.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Because pick_next_task() implies set_curr_task() and some of the
details haven't matter too much, some of what _should_ be in
set_curr_task() ended up in pick_next_task, correct this.

This prepares the way for a pick_next_task() variant that does not
affect the current state; allowing remote picking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c | 23 ++++++++++++-----------
 kernel/sched/rt.c       | 27 ++++++++++++++-------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e683d4c19ab8..0783dfa65150 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1694,12 +1694,21 @@ static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
 }
 #endif
 
-static inline void set_next_task(struct rq *rq, struct task_struct *p)
+static void set_next_task_dl(struct rq *rq, struct task_struct *p)
 {
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
+
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, p);
+
+	if (rq->curr->sched_class != &dl_sched_class)
+		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+	if (rq->curr != p)
+		deadline_queue_push_tasks(rq);
 }
 
 static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
@@ -1758,15 +1767,7 @@ pick_next_task_dl(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = dl_task_of(dl_se);
 
-	set_next_task(rq, p);
-
-	if (hrtick_enabled(rq))
-		start_hrtick_dl(rq, p);
-
-	deadline_queue_push_tasks(rq);
-
-	if (rq->curr->sched_class != &dl_sched_class)
-		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+	set_next_task_dl(rq, p);
 
 	return p;
 }
@@ -1813,7 +1814,7 @@ static void task_fork_dl(struct task_struct *p)
 
 static void set_curr_task_dl(struct rq *rq)
 {
-	set_next_task(rq, rq->curr);
+	set_next_task_dl(rq, rq->curr);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3d9db8c75d53..353ad960691b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1498,12 +1498,23 @@ static void check_preempt_curr_rt(struct rq *rq, struct task_struct *p, int flag
 #endif
 }
 
-static inline void set_next_task(struct rq *rq, struct task_struct *p)
+static inline void set_next_task_rt(struct rq *rq, struct task_struct *p)
 {
 	p->se.exec_start = rq_clock_task(rq);
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
+
+	/*
+	 * If prev task was rt, put_prev_task() has already updated the
+	 * utilization. We only care of the case where we start to schedule a
+	 * rt task
+	 */
+	if (rq->curr->sched_class != &rt_sched_class)
+		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+	if (rq->curr != p)
+		rt_queue_push_tasks(rq);
 }
 
 static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
@@ -1577,17 +1588,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	p = _pick_next_task_rt(rq);
 
-	set_next_task(rq, p);
-
-	rt_queue_push_tasks(rq);
-
-	/*
-	 * If prev task was rt, put_prev_task() has already updated the
-	 * utilization. We only care of the case where we start to schedule a
-	 * rt task
-	 */
-	if (rq->curr->sched_class != &rt_sched_class)
-		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+	set_next_task_rt(rq, p);
 
 	return p;
 }
@@ -2356,7 +2357,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 
 static void set_curr_task_rt(struct rq *rq)
 {
-	set_next_task(rq, rq->curr);
+	set_next_task_rt(rq, rq->curr);
 }
 
 static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
-- 
2.17.1

