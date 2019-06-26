Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D289C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F7A208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZFkA//D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFZFGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:06:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45466 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfFZFGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:06:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so709630plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 22:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fr132i4NOwwkZ0nQOvkdNyG2SrvzvLzQB1yU26SI4s0=;
        b=hZFkA//DidyxzfiIni3hgxCy98Rh1YTXfmE4Lzbw0Uo7JnNfCPTM7t70dWOkAic4GR
         FjpMfBzkvBtc+B7cCHSJl1wXbkddZRmT8EGh+Lc+W6AuYLHafOhkNDco/i3bXEwQwH04
         ZXExF4I+ZFAZKKeeKnQcj/AhOk3/wd/63E56dO9F6qf7g9Zomnyt49H2+tjQJAQs9oar
         bImpoWNW4R9nAF5blWn0nO+Kv2B2XjrkzWhbBjcL5RLAcSnfb8N72puiMs5bvatVokMV
         7MS3he27x8OWbNip+cd1UbabCs3PWvpGPqQ9VEzn/UbyHis58/GZJkww//6qxLktmRve
         aAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fr132i4NOwwkZ0nQOvkdNyG2SrvzvLzQB1yU26SI4s0=;
        b=Md7UnOc5lowdLBxmyzYtcGjVoEFfEa73jy8Z5kN9UaI06cRNOTzw173XKWOcCdIUSK
         78weyHpzwSrT7Q0VlSj6Jk09WQH/FZtIXXzQiPo0devbDCpkd9CNMZUVZiuAhRqFY87Q
         kT7R8kVHcIDnjZrZyyGEJskOqs1O22Vpaj/IFCI/Qec2LAYZllcJ4SRa/S36hCpauSa9
         Ya1I4mQjo5oDcVIpi/vjPk+ilriYxUihX6IWNJtGmmOnybuCdJdW4DwCsO0sIcf0JAjo
         E+bzP9tL5x137eAeu+Gbju+/Uc8TjN8B1evgFAV05+HPR0vXVR1g9TeZNzsPOMbPFHG0
         DQLA==
X-Gm-Message-State: APjAAAWD8mfpfKBLDCP8oNd1zkzNIFwdocpTsZFY8vUNj1tsjkGKcEJa
        rCiSVVKJXZlCFutNNcxvKEr0otNdI+w=
X-Google-Smtp-Source: APXvYqxwDn2w30UEEbHfo9d5Uzbuk5koe1PV0ZeorOsjfxGSxBQF6UFAZ36zfH17CohSkr1GuCXd7g==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr2928225plr.309.1561525607817;
        Tue, 25 Jun 2019 22:06:47 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id z2sm15276614pgg.58.2019.06.25.22.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 22:06:47 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com,
        songliubraving@fb.com
Subject: [PATCH V3 1/2] sched: Start tracking SCHED_IDLE tasks count in cfs_rq
Date:   Wed, 26 Jun 2019 10:36:29 +0530
Message-Id: <0d3cdc427fc68808ad5bccc40e86ed0bf9da8bb4.1561523542.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561523542.git.viresh.kumar@linaro.org>
References: <cover.1561523542.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track how many tasks are present with SCHED_IDLE policy in each cfs_rq.
This will be used by later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c  | 14 ++++++++++++--
 kernel/sched/sched.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..1277adc3e7ed 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4500,7 +4500,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, dequeue = 1;
+	long task_delta, idle_task_delta, dequeue = 1;
 	bool empty;
 
 	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
@@ -4511,6 +4511,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	rcu_read_unlock();
 
 	task_delta = cfs_rq->h_nr_running;
+	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
@@ -4520,6 +4521,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (dequeue)
 			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
 		if (qcfs_rq->load.weight)
 			dequeue = 0;
@@ -4559,7 +4561,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	int enqueue = 1;
-	long task_delta;
+	long task_delta, idle_task_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -4579,6 +4581,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		return;
 
 	task_delta = cfs_rq->h_nr_running;
+	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			enqueue = 0;
@@ -4587,6 +4590,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (enqueue)
 			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
 		cfs_rq->h_nr_running += task_delta;
+		cfs_rq->idle_h_nr_running += idle_task_delta;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5200,6 +5204,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	int idle_h_nr_running = task_has_idle_policy(p);
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5232,6 +5237,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		flags = ENQUEUE_WAKEUP;
 	}
@@ -5239,6 +5245,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running++;
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5300,6 +5307,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int task_sleep = flags & DEQUEUE_SLEEP;
+	int idle_h_nr_running = task_has_idle_policy(p);
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -5314,6 +5322,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -5333,6 +5342,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		cfs_rq->h_nr_running--;
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
 		if (cfs_rq_throttled(cfs_rq))
 			break;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..1f95411f5e61 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -484,6 +484,8 @@ struct cfs_rq {
 	unsigned long		runnable_weight;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;
+	/* h_nr_running for SCHED_IDLE tasks */
+	unsigned int		idle_h_nr_running;
 
 	u64			exec_clock;
 	u64			min_vruntime;
-- 
2.21.0.rc0.269.g1a574e7a288b

