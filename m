Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D38CC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D6C2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="An15MEpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfJBUsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:48:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39823 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfJBUsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:48:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so601714oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEbG0e9SVlOvdqd5lS6UQt/0LUXQ3Pzs6cUXmwlgj2s=;
        b=An15MEpMxrfLIrUSBszoUbhxmzYv80e8jb19G8ikUYtaOK0yZDQmuDkoaLvCok2aVr
         qPo2wV6Laj733065pkVk6sb/CSyJZ6VZ5D6DRYBzELSofblKm4aPP8bR1h/yCXCjSG16
         omKnb6MHKnqcncVB32rhj7vGO37C88j2zCLqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEbG0e9SVlOvdqd5lS6UQt/0LUXQ3Pzs6cUXmwlgj2s=;
        b=NgoNJwWGC+DwO5GQA+rgjmlr3TywXsRfUEmf4iyXumAyPeJF0xMN/j8CMJOWoBSlCs
         uXMex7ZZgwxuuyJm5NGsP37XvFQWeyoRhv6KgooeCxZNcExCt1vmdjDrdJOutcMeUDY/
         3FtlG8hxArtAHiCI08Gj7BZLkRXeJ9icfsjkI1EsNw1SEma5axJvhVAabSvfaiYziYML
         Muzhd0uFdzQEI1ywlbYHZi9HTopqL0ICNSUu4GK75lseJJ9UGP4KAoJ5DjnQxFONjkH6
         VQ9ZQPrxDkg5cI/OKLTpKk1LCvfhmR56NUM6UN/a5Dj+rACdpPoV5zMwM0dDs7JVB/32
         Ujzg==
X-Gm-Message-State: APjAAAWgC7xqds5KfjEtSVbJLNYnr5gBaR+uaMnAemDJL0NuQuytchAI
        zP6oALjYb7D69hU7NDZkxH3zsaYMpJxoLlh/VI/jlw==
X-Google-Smtp-Source: APXvYqwd95FnkWwLe44gfdqOQmFfpoyNR0ryu3eNLL1KwcZdDEuiJtTTjij9ZJIMPQys0ApKrcdENky0j83MxC5hcOQ=
X-Received: by 2002:aca:ab84:: with SMTP id u126mr4184593oie.115.1570049306806;
 Wed, 02 Oct 2019 13:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com> <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com> <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com> <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com> <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu> <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
In-Reply-To: <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Wed, 2 Oct 2019 16:48:14 -0400
Message-ID: <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 7:53 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> >
> Sorry, I misunderstood the fix and I did not initially see the core wide
> min_vruntime that you tried to maintain in the rq->core. This approach
> seems reasonable. I think we can fix the potential starvation that you
> mentioned in the comment by adjusting for the difference in all the children
> cfs_rq when we set the minvruntime in rq->core. Since we take the lock for
> both the queues, it should be doable and I am trying to see how we can best
> do that.
>
Attaching here with, the 2 patches I was working on in preparation of v4.

Patch 1 is an improvement of patch 2 of Aaron where I am propagating the
vruntime changes to the whole tree.
Patch 2 is an improvement for patch 3 of Aaron where we do resched_curr
only when the sibling is forced idle.

Micro benchmarks seems good. Will be doing larger set of tests and hopefully
posting v4 by end of week. Please let me know what you think of these patches
(patch 1 is on top of Aaron's patch 2, patch 2 replaces Aaron's patch 3)

Thanks,
Vineeth

[PATCH 1/2] sched/fair: propagate the min_vruntime change to the whole rq tree

When we adjust the min_vruntime of rq->core, we need to propgate
that down the tree so as to not cause starvation of existing tasks
based on previous vruntime.
---
 kernel/sched/fair.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 59cb01a1563b..e8dd78a8c54d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -476,6 +476,23 @@ static inline u64 cfs_rq_min_vruntime(struct
cfs_rq *cfs_rq)
                return cfs_rq->min_vruntime;
 }

+static void coresched_adjust_vruntime(struct cfs_rq *cfs_rq, u64 delta)
+{
+       struct sched_entity *se, *next;
+
+       if (!cfs_rq)
+               return;
+
+       cfs_rq->min_vruntime -= delta;
+       rbtree_postorder_for_each_entry_safe(se, next,
+                       &cfs_rq->tasks_timeline.rb_root, run_node) {
+               if (se->vruntime > delta)
+                       se->vruntime -= delta;
+               if (se->my_q)
+                       coresched_adjust_vruntime(se->my_q, delta);
+       }
+}
+
 static void update_core_cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
 {
        struct cfs_rq *cfs_rq_core;
@@ -487,8 +504,11 @@ static void
update_core_cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
                return;

        cfs_rq_core = core_cfs_rq(cfs_rq);
-       cfs_rq_core->min_vruntime = max(cfs_rq_core->min_vruntime,
-                                       cfs_rq->min_vruntime);
+       if (cfs_rq_core != cfs_rq &&
+           cfs_rq->min_vruntime < cfs_rq_core->min_vruntime) {
+               u64 delta = cfs_rq_core->min_vruntime - cfs_rq->min_vruntime;
+               coresched_adjust_vruntime(cfs_rq_core, delta);
+       }
 }

 bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
--
2.17.1

[PATCH 2/2] sched/fair : Wake up forced idle siblings if needed

If a cpu has only one task and if it has used up its timeslice,
then we should try to wake up the sibling to give the forced idle
thread a chance.
We do that by triggering schedule which will IPI the sibling if
the task in the sibling wins the priority check.
---
 kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8dd78a8c54d..ba4d929abae6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4165,6 +4165,13 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct
sched_entity *se, int flags)
                update_min_vruntime(cfs_rq);
 }

+static inline bool
+__entity_slice_used(struct sched_entity *se)
+{
+       return (se->sum_exec_runtime - se->prev_sum_exec_runtime) >
+               sched_slice(cfs_rq_of(se), se);
+}
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -10052,6 +10059,39 @@ static void rq_offline_fair(struct rq *rq)

 #endif /* CONFIG_SMP */

+#ifdef CONFIG_SCHED_CORE
+/*
+ * If runqueue has only one task which used up its slice and
+ * if the sibling is forced idle, then trigger schedule
+ * to give forced idle task a chance.
+ */
+static void resched_forceidle(struct rq *rq, struct sched_entity *se)
+{
+       int cpu = cpu_of(rq), sibling_cpu;
+       if (rq->cfs.nr_running > 1 || !__entity_slice_used(se))
+               return;
+
+       for_each_cpu(sibling_cpu, cpu_smt_mask(cpu)) {
+               struct rq *sibling_rq;
+               if (sibling_cpu == cpu)
+                       continue;
+               if (cpu_is_offline(sibling_cpu))
+                       continue;
+
+               sibling_rq = cpu_rq(sibling_cpu);
+               if (sibling_rq->core_forceidle) {
+                       resched_curr(rq);
+                       break;
+               }
+       }
+}
+#else
+static inline void resched_forceidle(struct rq *rq, struct sched_entity *se)
+{
+}
+#endif
+
+
 /*
  * scheduler tick hitting a task of our scheduling class.
  *
@@ -10075,6 +10115,9 @@ static void task_tick_fair(struct rq *rq,
struct task_struct *curr, int queued)

        update_misfit_status(curr, rq);
        update_overutilized_status(task_rq(curr));
+
+       if (sched_core_enabled(rq))
+               resched_forceidle(rq, &curr->se);
 }

 /*
--
2.17.1
