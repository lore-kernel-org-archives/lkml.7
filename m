Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB3FCA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6ED20873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="esYxh7cK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfJ3SeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:34:08 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45765 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfJ3SeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:34:06 -0400
Received: by mail-yw1-f65.google.com with SMTP id x65so1173853ywf.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YrBb/5Lfj4oTQCTzA3u0J6X1ZzDDqWH30ti84WG7bd4=;
        b=esYxh7cK32bWERNgkZjMkkMoHlTd14od/Z3qsnP9+qQtAH2B940Fu2xNl6KXhK0i6F
         mc4fdoJRA15/S3DHjv1/nReMvH8G9rCdHPFlD2TNJtOCtvFBO6v7EjXdfFCYH/ja/J6k
         jZcWJMz1AA8zOSBf6jEgwljS6QzKKJn0MIars=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YrBb/5Lfj4oTQCTzA3u0J6X1ZzDDqWH30ti84WG7bd4=;
        b=bUBCT+vqXnrUHhH3Pkpxi0YGTtLHLLhVFq1SvRFISiPCxH3Sz2AytKt42F6MN8QSjx
         HKLlZ8JLV/11ac8smvuS5hJ1YxU0KYFBG9XvCXyKy0d91w6ykrAnzPgut1AfQydVVzQK
         7JavuJbXMh9MNrURUB7SYJBrB4lNCWfltZ1o6LyabLFaZRZ+K6jvkyIF9GmK+sZDNjeq
         Z/KouJ8+J+iQrB+PIztBDH3xfn5jrxh58tIV4dow5xctj1VIFlqSgk8ePy9VMt7wRqzy
         5FuD9QzYenBqAORqSTGY0uMriHi84K/LGMdQ773IR/q2BJoTKf1tdbtu71jmBym3CJK6
         T8Iw==
X-Gm-Message-State: APjAAAWa4yN0hRuLU8qjtAjT2Z7foi9glsQo+4V35malGexb784mXOxL
        JM78UO8Shsrba+ghXfuTlHyXlA==
X-Google-Smtp-Source: APXvYqxCvQIH5sG3FSS56ge0tqsxZIlUcoO2FCTkyAOcTKDoNEerrUZayQqeLUX8DEH7wuikMui5hQ==
X-Received: by 2002:a81:8987:: with SMTP id z129mr860465ywf.391.1572460444946;
        Wed, 30 Oct 2019 11:34:04 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id j5sm912901ywc.57.2019.10.30.11.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:34:04 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 04/19] sched/{rt,deadline}: Fix set_next_task vs pick_next_task
Date:   Wed, 30 Oct 2019 18:33:17 +0000
Message-Id: <177d6db22ed0e4a323b32b2334f5ab322325888f.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
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
index 899e988d4811..4b53e7c696c8 100644
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
index 5651d9e65897..f4590ac6fd92 100644
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

