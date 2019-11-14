Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D94C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E227206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHZK123e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfKNRHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:07:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37707 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfKNRHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:07:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so7346769wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 09:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1ttFX6mWZtj3YRIFFgJ6Wwp3zHGzs5AKoNMo4yJ71bI=;
        b=WHZK123eBZHkZP/Y8D8MlnOe/2Nmnk2EbmjV7pOYxzOF9bglYHQM0CpE466xwJDzf2
         QvmrWlPfr91t6/5XVDBgljgZAcUAfQ+8pdBV4Rx/QS5M149hHSGdvgIMEqVFhxPUaHqp
         yFyA+EQDWwXaszXyanRYc0Sw9uWoX6A+lKIK+C2fJvaArIv5PMiWTgRh9VFwzorrv3JR
         mAnoCLpiELtGgwpUzV1zRUREx++WEjZea5oXN8PnwnG1f3nCHbX/nloFHWfL2bS7upie
         RUZ153xCXEB8LgmG7Ie0RchcaEFi1ZIKZPN3zRnUyH5LISFUX98YBQ/VULbiqGcYaDIz
         NaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ttFX6mWZtj3YRIFFgJ6Wwp3zHGzs5AKoNMo4yJ71bI=;
        b=kwM5saTO9ajnul0ou9HzkOmzOXoouCVHJmxv0n/Ta+aSsvgSZiNXil/bY8EwsFKY5R
         50Du1bmnSgybaPMhcdWURxlU7s8laell3NdfOgQxOQXO2igUoYpYWySwQPl9tkSHopQP
         7QipJzTyW91yoZdNm34bru2DnWvKlol4rk5q9H0vARlEuuxU8X5g9JLJe5VNHSbk+onz
         z36zoKRTFdaERvQ+N0/NB4Pbh2fVHvCdr6gSYK6WRb+napUkx0qaVT5r2I1KPwstAER5
         hpMD38t/mwzkqqUF/0WZc6wV7nx1zBFR+DvNQgMxshVJD1zJi4dJwxSgdyVW1GDQNe97
         w42Q==
X-Gm-Message-State: APjAAAXVtk+95H0e70YqVxeAgQDkTovmEAAA0i0xzAD0erjycHzT1Wf+
        iB+cO3qqoqR0z3PIv66cvF9We9hGX5o=
X-Google-Smtp-Source: APXvYqw/DbqT30oaTSSQCsMzIEM6CXlElniAe550T4zmltle7nwi+XIYxEvJuCHQhA1ntJ7bpz/9lA==
X-Received: by 2002:adf:82c6:: with SMTP id 64mr8827756wrc.151.1573751255472;
        Thu, 14 Nov 2019 09:07:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b163:2e66:cb71:e145])
        by smtp.gmail.com with ESMTPSA id m3sm7552619wrw.20.2019.11.14.09.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Nov 2019 09:07:34 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4] sched/freq: move call to cpufreq_update_util
Date:   Thu, 14 Nov 2019 18:07:31 +0100
Message-Id: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
which might be inefficient when cpufreq driver has rate limitation.

When a task is attached on a CPU, we have call path:

update_load_avg()
  update_cfs_rq_load_avg()
    cfs_rq_util_change -- > trig frequency update
  attach_entity_load_avg()
    cfs_rq_util_change -- > trig frequency update

The 1st frequency update will not take into account the utilization of the
newly attached task and the 2nd one might be discard because of rate
limitation of the cpufreq driver.

update_cfs_rq_load_avg() is only called by update_blocked_averages()
and update_load_avg() so we can move the call to
cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
interesting to notice that update_load_avg() already calls directly
cfs_rq_util_change() for !SMP case.

This changes will also ensure that cpufreq_update_util() is called even
when there is no more CFS rq in the leaf_cfs_rq_list to update but only
irq, rt or dl pelt signals.

Reported-by: Doug Smythies <dsmythies@telus.net>
Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

this patch applies on tip/sched/urgent as there is a dependency with
commit b90f7c9d2198 ("sched/pelt: Fix update of blocked PELT ordering")

Changes for v4:
- updated comments
- added Reviewed-by and Acked-by 

 kernel/sched/fair.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a81a5..3be44e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3504,9 +3504,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed)
-		cfs_rq_util_change(cfs_rq, 0);
-
 	return decayed;
 }
 
@@ -3616,8 +3613,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
 		update_tg_load_avg(cfs_rq, 0);
 
-	} else if (decayed && (flags & UPDATE_TG))
-		update_tg_load_avg(cfs_rq, 0);
+	} else if (decayed) {
+		cfs_rq_util_change(cfs_rq, 0);
+
+		if (flags & UPDATE_TG)
+			update_tg_load_avg(cfs_rq, 0);
+	}
 }
 
 #ifndef CONFIG_64BIT
@@ -7543,18 +7544,19 @@ static void update_blocked_averages(int cpu)
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
+	int decayed;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
 	/*
-	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
-	 * that RT, DL and IRQ signals have been updated before updating CFS.
+	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
+	 * DL and IRQ signals have been updated before updating CFS.
 	 */
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	decayed |= update_irq_load_avg(rq, 0);
 
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7567,9 +7569,13 @@ static void update_blocked_averages(int cpu)
 	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
 		struct sched_entity *se;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq, 0);
 
+			if (cfs_rq == &rq->cfs)
+				decayed = 1;
+		}
+
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))
@@ -7588,6 +7594,9 @@ static void update_blocked_averages(int cpu)
 	}
 
 	update_blocked_load_status(rq, !done);
+
+	if (decayed)
+		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7644,22 +7653,22 @@ static inline void update_blocked_averages(int cpu)
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
+	int decayed;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	/*
-	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
-	 * that RT, DL and IRQ signals have been updated before updating CFS.
-	 */
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	decayed |= update_irq_load_avg(rq, 0);
 
-	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	decayed |= update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
 
 	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
+
+	if (decayed)
+		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-- 
2.7.4

