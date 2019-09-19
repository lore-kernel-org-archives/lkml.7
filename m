Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C12C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3EE21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpdpNkOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbfISHea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34680 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388640AbfISHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id y135so6509734wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9SzE/B4CCxEhq7OsUQcCE6/p2xSl6Tj+2wygHScnuHQ=;
        b=hpdpNkOFGyBlI+JIZTTOrrKnLGNHOyR3/Uo/YEbDvJwWRpq+FfFJr36/DtYuQnCB4P
         oV9ELP1JFK+ucFywfSXLCkqVr3qymX3epBYwjZl7k74iWcLhjX0A8g9Jw1z30lo9mYVO
         AzNZprjiq4UlGFI9XBLMI3exJpQean5hs42gBpkmz8b1wYcvrzZKo4UVZdNOHdzZyPXE
         RAV07EYoWylGVWJm6I1NZWIaHW4PhwlxNs+qlncWjpWvjt5lFRVo+ctXIbV29nYXkohU
         Y5libxhM/0WpS4DQqG2wU4R2vLD2YrpI/1RCMJwGkg7yqk5HuDz5BKLCy75tXVoQGMmJ
         1yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9SzE/B4CCxEhq7OsUQcCE6/p2xSl6Tj+2wygHScnuHQ=;
        b=VWfqPYmpSZi1EI5qnmOQTApfum4vq6fbTh5Fo1mbZgppcD6e+0KagQgntzkk2cLo0u
         /KK9pL9PJpJSqGY4v0qRHy667zoNLkhQby4LqjW4+bb9rlhX3Bk6xj1CG+ZNxw8BolW+
         QPASRcQw6QFuAP2DtWyhnx6Sd9Xpdif4fwjiotgudLzKlt2NXlRgg3HNbMbJFixczBN9
         hdjj7qKuPkStXLjyiY5OmNv5YXxWpxLVGzvhf0BDvt8DNf/1zMy97XrF1NL4y7hSWDfY
         4sNwSjc6VwD6elHNz+M1hI8avi/Ku983NTN9wPJkx3oNkTYzSq8TF0dDwMJfFaO8dfKE
         FrZw==
X-Gm-Message-State: APjAAAWwaLrKgon+u+uCPBZ8ja5uSbrt7p5aHbiWw7wI6VbG+Qmhj3ye
        unntrETAni/l+tfBg+XPjg2ExDYVVUM=
X-Google-Smtp-Source: APXvYqxtwDBqVAaigCJSTD+3rCOpW3iRFaXENEcI8RILdm38maDws+6NW8u0AiH0vLdRcMtBu8yrGg==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr1492487wmz.88.1568878446575;
        Thu, 19 Sep 2019 00:34:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:34:05 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 06/10] sched/fair: use load instead of runnable load in load_balance
Date:   Thu, 19 Sep 2019 09:33:37 +0200
Message-Id: <1568878421-12301-7-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

runnable load has been introduced to take into account the case
where blocked load biases the load balance decision which was selecting
underutilized group with huge blocked load whereas other groups were
overloaded.

The load is now only used when groups are overloaded. In this case,
it's worth being conservative and taking into account the sleeping
tasks that might wakeup on the cpu.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e74836..15ec38c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5385,6 +5385,11 @@ static unsigned long cpu_runnable_load(struct rq *rq)
 	return cfs_rq_runnable_load_avg(&rq->cfs);
 }
 
+static unsigned long cpu_load(struct rq *rq)
+{
+	return cfs_rq_load_avg(&rq->cfs);
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -8070,7 +8075,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
-		sgs->group_load += cpu_runnable_load(rq);
+		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
@@ -8512,7 +8517,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	init_sd_lb_stats(&sds);
 
 	/*
-	 * Compute the various statistics relavent for load balancing at
+	 * Compute the various statistics relevant for load balancing at
 	 * this level.
 	 */
 	update_sd_lb_stats(env, &sds);
@@ -8672,10 +8677,10 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		switch (env->balance_type) {
 		case migrate_load:
 			/*
-			 * When comparing with load imbalance, use cpu_runnable_load()
+			 * When comparing with load imbalance, use cpu_load()
 			 * which is not scaled with the CPU capacity.
 			 */
-			load = cpu_runnable_load(rq);
+			load = cpu_load(rq);
 
 			if (nr_running == 1 && load > env->imbalance &&
 			    !check_cpu_capacity(rq, env->sd))
@@ -8683,7 +8688,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 			/*
 			 * For the load comparisons with the other CPU's, consider
-			 * the cpu_runnable_load() scaled with the CPU capacity, so
+			 * the cpu_load() scaled with the CPU capacity, so
 			 * that the load can be moved away from the CPU that is
 			 * potentially running at a lower capacity.
 			 *
-- 
2.7.4

