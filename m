Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4E6C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C60620727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573987280;
	bh=kHu6rSBVRdI91SpCdkh7Jk6LaxUxC4fOKIMpyHmfmg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tH/6u5oD7iWxK9vw3tW20+sff0xO+La+ZoINgAFsy5fvjDJKQ9GURVaLa9Uek5MpM
	 cWQra8LbRV5wkLRkEFQB1jaJno9ZkOsfZWXcpdP7TVhtYlXSeuxZ66M1FggwtnM/yX
	 RsvZVjgHUmCi7sqdt5ua1Hp8QoRqnkL92zIJ3oZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfKQKlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 05:41:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38358 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfKQKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 05:41:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so15580897wmk.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 02:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9+/iN3PmpjU871QyEVs4CDFzsUtwfbS/C/IpIa/S70I=;
        b=VjP6gJqCuDu5F4+moEfwKsSA+JgXV4nawA1xmXUmyPc63J52JfqKE/tl7uauPRIp0m
         DBr3FqPyFftlLV0Q8AJ/cGq8CLJ4O/QKHY/lyI7kMyE6gV9n9wGX2Y4GzW2VgihZ7nDw
         I6jEULlmpLj502AJhPemMTqUptkz7W/MxqfwXH8rcaTC1amAjS20yr99V8I7YPhsgoop
         WFUg50hVDXqW+2Xl6G/NNozbrkURcTASu0Ez4LfMmwgXy/IJv3rIR1RBpXcJt/VMgYrU
         dInWD+6NmXOSLub7P4ZEEsJS7IP512qwqpuHXmnFLmw1xDMtkZRwiXYSt348ktr9pv/9
         weUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9+/iN3PmpjU871QyEVs4CDFzsUtwfbS/C/IpIa/S70I=;
        b=Ew1zY1egqZ9yWNkAghnT7V0/qptSCUlHpF/0rXeqEX0i+fXrBtM/sY5g7n82MkKL9P
         LCeEvlNQZB382tLF53zHgbdo7Tb8l8Wsei8eevMYGBD0nyHD6V8IYslCLFotVjw3zDyn
         F3ATJypT+FOyFTy3QIGXzJJrGb+vLHPEyIDWsp6gVsCyJipYf/yRNORvtCYtfTlLCJ+/
         cRCtqXJ2Lw/HNoJRMQaxQ9tKb1C1+YRuuVCsqGpopo5tJ6eqJS4DqajoI86gQe7Mym8W
         dvgOzedbJOEMJ/u4ACKjjSJjb/jAZW/NWUsZTQoRQJjyWg/hiYdDPGuTmwqKvQy5rNUL
         DdCw==
X-Gm-Message-State: APjAAAX/SoXdug1BPchMyv/0GeCC0BdbR5viaGQm754147EAmY6AcV71
        cvMn/CPzovMMnR0+HAMxg/o=
X-Google-Smtp-Source: APXvYqy7GbrsDVSGegLLXO6fJeJyt+TREXuKnB962aH4OLropDC4fXYS6IZ8VpZhBsSsHpmNzrsOHQ==
X-Received: by 2002:a05:600c:506:: with SMTP id i6mr24818743wmc.153.1573987276033;
        Sun, 17 Nov 2019 02:41:16 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 4sm17589474wmd.33.2019.11.17.02.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 02:41:14 -0800 (PST)
Date:   Sun, 17 Nov 2019 11:41:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL v2] scheduler fixes
Message-ID: <20191117104112.GB56088@gmail.com>
References: <20191116213742.GA7450@gmail.com>
 <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
 <CAHk-=wiFvP0idYrvWVtEwt6FM9jZ9TRF5yQhT1-X3vx31GRHTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFvP0idYrvWVtEwt6FM9jZ9TRF5yQhT1-X3vx31GRHTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Nov 16, 2019 at 2:44 PM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > > Valentin Schneider (2):
> > >       sched/uclamp: Fix overzealous type replacement
> >
> > This one got a v2 (was missing one location), acked by Vincent:
> >
> >   20191115103908.27610-1-valentin.schneider@arm.com
> >
> > >       sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks
> >
> > And this one is no longer needed, as Michal & I understood (IOW the fix in
> > rc6 is sufficient), see:
> >
> >   c425c5cb-ba8a-e5f6-d91c-5479779cfb7a@arm.com
> 
> Ingo, what do you want me to do? Pull it anyway and send updates
> later? Or skip this pull request?
> 
> I'll leave it pending for now,

We ended up zapping the final two commits from sched/urgent.

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 6e1ff0773f49c7d38e8b4a9df598def6afb9f415 sched/uclamp: Fix incorrect condition

Misc fixes:

 - Fix potential deadlock under CONFIG_DEBUG_OBJECTS=y
 - PELT metrics update ordering fix
 - uclamp logic fix

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      sched/core: Avoid spurious lock dependencies

Qais Yousef (1):
      sched/uclamp: Fix incorrect condition

Vincent Guittot (1):
      sched/pelt: Fix update of blocked PELT ordering


 kernel/sched/core.c |  5 +++--
 kernel/sched/fair.c | 29 ++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0f2eb3629070..44123b4d14e8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
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
