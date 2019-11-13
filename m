Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2173C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C5C206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APqs78Vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKMUVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:21:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46484 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKMUVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:21:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so3855381wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 12:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Vxg7fErovmPZRUiQLFPaUndHhsTa0KcxJAK3E2kbzLs=;
        b=APqs78VoQYRNRcD2z55wsNoVUmqjCvT6dJijUhx0swgrmfCQpKU250Sj2yybQ0+l4w
         7DyuggHzS7QqSqNTPA2EuRROfb6hPMtcZ91+ttOf9ZaFKX6T7HECTJEZUhpjotm0u020
         eU9fViHK5VcofIfXsFJ2KLCQP4lnDDD/vxA524dl2Lo5Evjuatpdplj4FRU9e6No9A5q
         JTzwN6Gt0a2bkHGDdzXSutW2Ov9XccKwR2JJXBLi/uQ+MMEjbsNcd+1PJI12mUBw83E1
         lIHX/M8S61BMF5oG6/RkshN2v/dRXh8sPz5mdhX8S0NZrcvF/3O5imEYTYJRQ5y0hhJ0
         3rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vxg7fErovmPZRUiQLFPaUndHhsTa0KcxJAK3E2kbzLs=;
        b=VTbr46CmUQHf1FiV1oFxnWftPrUCqYfzPqcllQEJJJHac20+FhQ+XrNpbH4Q0ZCAqa
         8VcRZ/jDGNfC8j1dyw33u658yPdE8v5eTW9i9aYt0z3x5UeCoj612G/3SXTrzgmQed6A
         OHFzVugEjXByW/XhWnlAT8GOEuunHbNJu+HLDdg14nXwr7Etle2hRkoZ64n1Oug4F/RR
         5Bw/LkwRyK0xdwbpxAdX3X54JoDkfgA5ovaoAznfXvBM9aIXtkgu2nDquugotcAcKyMP
         nSwyYqFtqXCim9AclugsdeUpoPVbi3T8j/Vat6tyO3Is+cMNv+oXX87B44EEVYUgESl0
         sOhg==
X-Gm-Message-State: APjAAAW+gexyboIGEj128vUD5OKptH8BTnC93ETkpPL6+9Ivyk9BxvWZ
        y3Hk8qT/laZMJNeokqoM/PuJjd455Yg=
X-Google-Smtp-Source: APXvYqzFEApVCTLE8xYkeDbklVfQuPHlUEPb5AYmu9bzcn/4nBX3xRxtrONHlzi+7zFsI2+zvVw4lQ==
X-Received: by 2002:a5d:4f06:: with SMTP id c6mr4661339wru.211.1573676470480;
        Wed, 13 Nov 2019 12:21:10 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:bdd0:28e6:f0d9:a18c])
        by smtp.gmail.com with ESMTPSA id n1sm4262231wrr.24.2019.11.13.12.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Nov 2019 12:21:09 -0800 (PST)
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
Subject: [PATCH v3] sched/freq: move call to cpufreq_update_util
Date:   Wed, 13 Nov 2019 21:21:01 +0100
Message-Id: <1573676461-7990-1-git-send-email-vincent.guittot@linaro.org>
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
---

changes for v3:
- fix typo
- test the decay of root cfs_rq even for !CONFIG_FAIR_GROUP_SCHED case

 kernel/sched/fair.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a81a5..0a8f4ea 100644
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
@@ -7543,6 +7544,7 @@ static void update_blocked_averages(int cpu)
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
+	int decayed;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7552,9 +7554,9 @@ static void update_blocked_averages(int cpu)
 	 * that RT, DL and IRQ signals have been updated before updating CFS.
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
 
@@ -7644,6 +7653,7 @@ static inline void update_blocked_averages(int cpu)
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
+	int decayed;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7653,13 +7663,16 @@ static inline void update_blocked_averages(int cpu)
 	 * that RT, DL and IRQ signals have been updated before updating CFS.
 	 */
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

