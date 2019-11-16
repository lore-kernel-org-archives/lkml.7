Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A432C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 21:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5987D20733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 21:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573940269;
	bh=Cv21lmRLeO5ZMhbHnjSIcu8o8qDKzClIZCGd8M/3Cns=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ct6KCLcXMdkVuQhp7Av8yl40juiWQq/vtmsG/XWMjSBnDGFWLVnGblHvzBxcWY+We
	 ZYOhxQfqBd8FqFr4Hdp8Q9ZVcLfAOHUA5+0cb6bzngojq8qqn0iaGZz0vqX7GbA9T5
	 PTmxuYiJZ8qZpiXcZLkbf6SMMsgux2Vep3M6TkAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfKPVhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 16:37:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33496 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfKPVhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 16:37:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id a17so12842280wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nIPMIXcIHSuD0eUoJ9kzDvA6Ixdh05Bz4H//3mqWohY=;
        b=kCxBNaLLxJlXduhne/EHAZ8IM9WEjQkdtrGqv29Xs/xSrT4oH3rWE3razRPfQQkh1q
         PwMGOpAqPGvsngeWtTVviTAalhdB1sEGJ8bN2NJYA67ODeFiYdH3s58pjOfHdjnopIt8
         JNGEDfcy86/hhTVyW6zK/kOraOIFlsFPi6FuLR9k+dUGlA8m0xFfrish/c8zNHCzYcPy
         KJLPvMwVOiqP3dVo3jg0hIBRHoC++XLJFBx50QiXZSp5FZxvIzUjF50bnVAQ2WG3Ibkn
         plS9uUxXuT0us/irrR2q1BvP4motLKCiIEuAOcd6rzRLTuJkR+g0SWYlwCqXNJY1iUSK
         OWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=nIPMIXcIHSuD0eUoJ9kzDvA6Ixdh05Bz4H//3mqWohY=;
        b=D8fUSGFZXnaet/tKBY2RfNOyxqKxAsn3cf4McVwEmg/O06g4yBr3VuSXp6L4USbUHP
         kHPmC2q5Jt3mF7SM5xV11Yb5YNLRdkyQVxXUDlgtk4E1kJwsMDNsRbB3WySeONDJYJha
         5jlUFhIkjh9PI51o3aYKQuF4B3dbykdGTZ796BqGMJECqvUEGsg2R4fsnj+cky5xHMJ0
         dOI1yKqdxkvImVSU7lP3SCeUcA6DgUBxqcg+1e65V+O2+S1KeVHUOMm44CpWtFAZFgjF
         YKaYtKHdkBkqsY9nFTVJrQ2byEPFKW9ZuT2/ZalMtjW5fwn1r+dUDAPm5ZxgBUP5KzNd
         k1mw==
X-Gm-Message-State: APjAAAU/mOH+Mp9o8OGc58VgzycYGl64/mJ8Frqia1oACkhNrFiNMLfF
        1i7Mfi1kdBOkegA0GW5ixOc=
X-Google-Smtp-Source: APXvYqxgdBLBl0AvbyKRIRh5j89aPIYMURy+SlJrXwQM/Au3D56zHvE37JP0CpYEohUQloUQtleD6A==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr22997494wme.90.1573940264594;
        Sat, 16 Nov 2019 13:37:44 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id r2sm12413718wma.44.2019.11.16.13.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 13:37:43 -0800 (PST)
Date:   Sat, 16 Nov 2019 22:37:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20191116213742.GA7450@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 48a723d23b0d957e5b5861b974864e53c6841de8 sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks

Misc fixes:

 - Fix potential deadlock under CONFIG_DEBUG_OBJECTS=y
 - PELT metrics update ordering fix
 - uclamp logic fix
 - a type casting fix
 - final fix (hopefully) for Juno r0 2+4 big.LITTLE systems.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      sched/core: Avoid spurious lock dependencies

Qais Yousef (1):
      sched/uclamp: Fix incorrect condition

Valentin Schneider (2):
      sched/uclamp: Fix overzealous type replacement
      sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks

Vincent Guittot (1):
      sched/pelt: Fix update of blocked PELT ordering


 kernel/cgroup/cpuset.c |  8 +++++++-
 kernel/sched/core.c    |  9 +++++----
 kernel/sched/fair.c    | 29 ++++++++++++++++++++---------
 kernel/sched/sched.h   |  2 +-
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c87ee6412b36..e4c10785dc7c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -798,8 +798,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
 		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
 			continue;
 
+		/*
+		 * Skip cpusets that would lead to an empty sched domain.
+		 * That could be because effective_cpus is empty, or because
+		 * it's only spanning CPUs outside the housekeeping mask.
+		 */
 		if (is_sched_load_balance(cp) &&
-		    !cpumask_empty(cp->effective_cpus))
+		    cpumask_intersects(cp->effective_cpus,
+				       housekeeping_cpumask(HK_FLAG_DOMAIN)))
 			csa[csn++] = cp;
 
 		/* skip @cp's subtree if not a partition root */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f2eb3629070..a4f76d3f5011 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -853,7 +853,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 }
 
 static inline
-enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
+unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 				   unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
@@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
-enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
+unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
 
@@ -1065,7 +1065,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 	 * affecting a valid clamp bucket, the next time it's enqueued,
 	 * it will already see the updated clamp bucket value.
 	 */
-	if (!p->uclamp[clamp_id].active) {
+	if (p->uclamp[clamp_id].active) {
 		uclamp_rq_dec_id(rq, p, clamp_id);
 		uclamp_rq_inc_id(rq, p, clamp_id);
 	}
@@ -6019,10 +6019,11 @@ void init_idle(struct task_struct *idle, int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
+	__sched_fork(0, idle);
+
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_lock(&rq->lock);
 
-	__sched_fork(0, idle);
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
 	idle->flags |= PF_IDLE;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 22a2fed29054..69a81a5709ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7547,6 +7547,19 @@ static void update_blocked_averages(int cpu)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
+	/*
+	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
+	 * that RT, DL and IRQ signals have been updated before updating CFS.
+	 */
+	curr_class = rq->curr->sched_class;
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	update_irq_load_avg(rq, 0);
+
+	/* Don't need periodic decay once load/util_avg are null */
+	if (others_have_blocked(rq))
+		done = false;
+
 	/*
 	 * Iterates the task_group tree in a bottom up fashion, see
 	 * list_add_leaf_cfs_rq() for details.
@@ -7574,14 +7587,6 @@ static void update_blocked_averages(int cpu)
 			done = false;
 	}
 
-	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
-	/* Don't need periodic decay once load/util_avg are null */
-	if (others_have_blocked(rq))
-		done = false;
-
 	update_blocked_load_status(rq, !done);
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -7642,12 +7647,18 @@ static inline void update_blocked_averages(int cpu)
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
-	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
 
+	/*
+	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
+	 * that RT, DL and IRQ signals have been updated before updating CFS.
+	 */
 	curr_class = rq->curr->sched_class;
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
+
+	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+
 	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
 	rq_unlock_irqrestore(rq, &rf);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8870c5bd7df..49ed949f850c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2309,7 +2309,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
+unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
 unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
