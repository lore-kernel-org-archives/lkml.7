Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D8DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EA5222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCufCuWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634111AbfJRN1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:27:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50538 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410304AbfJRN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:26:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so6213746wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B8mzip3+tA6BeidSYtlNqITD3DSe2ulF+ZWQ0m84V5I=;
        b=zCufCuWZkU+wU1JLp+asFBiOQ0bhsNUSe83udjSDa+1I4WD37Kt+NZ4m96hUm3/5Jb
         Jr3073a+WBS2tL510iWr/zKwahzlpBpAhfnNB6Cde4OyNbdtc9FmseNsczNReToG4Pfj
         0cdDn3rXzUF9oddIsjG48uQ9uP0ULEdpLG8pXv0rp2cKf5i0qJ1v9BsbawcCxQyNVVDs
         3LOSV89LrKWe7vXv3klu5cYLdOiS+c2uDqYMWE9exaUfEYZQaLaUm5FJSKhWBlI8Pu43
         fuj87npoKTK6jP1UmuA51tv8fTBWCHvfP5+8yuuFXvN3tys6002i7UXuRe8Qm3fmQing
         2G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B8mzip3+tA6BeidSYtlNqITD3DSe2ulF+ZWQ0m84V5I=;
        b=sEBOebNnFfqYUeboprbpinq5pQnPiWLMKqGJVeFgoPOOsQK2RfuR3NgzJ3vY6432fE
         xrQqz0YX/ekscndgq/cGDN5TTIfpFhjUM12X0o1DReUbgCEriew5TGiHEFSeQ+wx99CA
         RPv+Zkgw0rDxl73QP+VEv6kBszsmRDLEZ5ic+IObyyx42NbBqqZus7EComRN4F+9ms/s
         hiZyKGVXDL08D0pkprEJj0ZZzOeLfihiYBcOmHNqnazToS7arWlxA9DZ15NVIcKqnRlY
         c2iEgWpFMYX0jKlHPUNtGR3ofynYnLwWArt0v9FVPog8c7ZOXfxVq9NELwiHkJZZ3zlo
         VvZg==
X-Gm-Message-State: APjAAAUBqLPP6WK6m7Euq8KId/IN9wOMCNqY3lG9GiyTPXVyZP8cBMDF
        vaLXDuk/buXKWiduQovkbqbuysY5Bjo=
X-Google-Smtp-Source: APXvYqzwfi9t3/bsM75lt1733OIAg5cI9RD0yQ9CSm0Rwc+j3K/QVzDZ1YlQntFYhPAZzw3/TtcYAA==
X-Received: by 2002:a1c:9d4c:: with SMTP id g73mr8094349wme.92.1571405214681;
        Fri, 18 Oct 2019 06:26:54 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:53 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 06/11] sched/fair: use load instead of runnable load in load_balance
Date:   Fri, 18 Oct 2019 15:26:33 +0200
Message-Id: <1571405198-27570-7-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
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
 kernel/sched/fair.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e09fe12b..9ac2264 100644
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
@@ -8059,7 +8064,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
 			env->flags |= LBF_NOHZ_AGAIN;
 
-		sgs->group_load += cpu_runnable_load(rq);
+		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
@@ -8517,7 +8522,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	init_sd_lb_stats(&sds);
 
 	/*
-	 * Compute the various statistics relavent for load balancing at
+	 * Compute the various statistics relevant for load balancing at
 	 * this level.
 	 */
 	update_sd_lb_stats(env, &sds);
@@ -8677,11 +8682,10 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		switch (env->migration_type) {
 		case migrate_load:
 			/*
-			 * When comparing with load imbalance, use
-			 * cpu_runnable_load() which is not scaled with the CPU
-			 * capacity.
+			 * When comparing with load imbalance, use cpu_load()
+			 * which is not scaled with the CPU capacity.
 			 */
-			load = cpu_runnable_load(rq);
+			load = cpu_load(rq);
 
 			if (nr_running == 1 && load > env->imbalance &&
 			    !check_cpu_capacity(rq, env->sd))
@@ -8689,10 +8693,10 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 
 			/*
 			 * For the load comparisons with the other CPU's,
-			 * consider the cpu_runnable_load() scaled with the CPU
-			 * capacity, so that the load can be moved away from
-			 * the CPU that is potentially running at a lower
-			 * capacity.
+			 * consider the cpu_load() scaled with the CPU
+			 * capacity, so that the load can be moved away
+			 * from the CPU that is potentially running at a
+			 * lower capacity.
 			 *
 			 * Thus we're looking for max(load_i / capacity_i),
 			 * crosswise multiplication to rid ourselves of the
-- 
2.7.4

