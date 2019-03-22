Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0267720693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ljPjHhKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfCVNfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:35:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47774 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbfCVNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s1uWVPMBLfGNeSuw3sabKjebwEXiHejM54freog362Y=; b=ljPjHhKWGYUBZloqpCcEsBSAc
        zaqu4TpzqT9gOo32lS4bPHdqG3p7lMkoBX+AVT4oB6/9NN3mVZrLyXgVEyAGRqt+5rvlZHtzPYUQ5
        fBEPLUZ7jJ0pnjKyBvtJmDw9Gh8Hu0+e/NUWqOs7n9oc1Tph2xpEcR0nEq3fWBE2a/5KiLUyU0eql
        P6+uVgh5Kp4Gg+HIdCzgDxEQxluUcGgpA7bTsn/VMEz8/37smM6vgc0MJ9/7iyBytZnUlPj1yD47U
        DGVabsFx7/p2QOnNtR2jAOc6vSOy0xVTwY0TWyQVAaeAzmDxn0LvSDFUtuCrkAhMv8SrdtnKJrl8B
        OJg5mGjpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7KJv-0001hI-CJ; Fri, 22 Mar 2019 13:34:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C20512038C224; Fri, 22 Mar 2019 14:34:48 +0100 (CET)
Date:   Fri, 22 Mar 2019 14:34:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Message-ID: <20190322133448.GT6058@hirez.programming.kicks-ass.net>
References: <15f3f7e6-5dce-6bbf-30af-7cffbd7bb0c3@oracle.com>
 <1553203217-11444-1-git-send-email-jdesfossez@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553203217-11444-1-git-send-email-jdesfossez@digitalocean.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:20:17PM -0400, Julien Desfossez wrote:
> On further investigation, we could see that the contention is mostly in the
> way rq locks are taken. With this patchset, we lock the whole core if
> cpu.tag is set for at least one cgroup. Due to this, __schedule() is more or
> less serialized for the core and that attributes to the performance loss
> that we are seeing. We also saw that newidle_balance() takes considerably
> long time in load_balance() due to the rq spinlock contention. Do you think
> it would help if the core-wide locking was only performed when absolutely
> needed ?

Something like that could be done, but then you end up with 2 locks,
something which I was hoping to avoid.

Basically you keep rq->lock as it exists today, but add something like
rq->core->core_lock, you then have to take that second lock (nested
under rq->lock) for every scheduling action involving a tagged task.

It makes things complicatd though; because now my head hurts thikning
about pick_next_task().

(this can obviously do away with the whole rq->lock wrappery)

Also, completely untested..

---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -146,6 +146,8 @@ void sched_core_enqueue(struct rq *rq, s
 	if (!p->core_cookie)
 		return;
 
+	raw_spin_lock(&rq->core->core_lock);
+
 	node = &rq->core_tree.rb_node;
 	parent = *node;
 
@@ -161,6 +163,8 @@ void sched_core_enqueue(struct rq *rq, s
 
 	rb_link_node(&p->core_node, parent, node);
 	rb_insert_color(&p->core_node, &rq->core_tree);
+
+	raw_spin_unlock(&rq->core->core_lock);
 }
 
 void sched_core_dequeue(struct rq *rq, struct task_struct *p)
@@ -170,7 +174,9 @@ void sched_core_dequeue(struct rq *rq, s
 	if (!p->core_cookie)
 		return;
 
+	raw_spin_lock(&rq->core->core_lock);
 	rb_erase(&p->core_node, &rq->core_tree);
+	raw_spin_unlock(&rq->core->core_lock);
 }
 
 /*
@@ -181,6 +187,8 @@ struct task_struct *sched_core_find(stru
 	struct rb_node *node = rq->core_tree.rb_node;
 	struct task_struct *node_task, *match;
 
+	lockdep_assert_held(&rq->core->core_lock);
+
 	/*
 	 * The idle task always matches any cookie!
 	 */
@@ -206,6 +214,8 @@ struct task_struct *sched_core_next(stru
 {
 	struct rb_node *node = &p->core_node;
 
+	lockdep_assert_held(&rq->core->core_lock);
+
 	node = rb_next(node);
 	if (!node)
 		return NULL;
@@ -3685,6 +3695,8 @@ pick_next_task(struct rq *rq, struct tas
 	 * If there were no {en,de}queues since we picked (IOW, the task
 	 * pointers are all still valid), and we haven't scheduled the last
 	 * pick yet, do so now.
+	 *
+	 * XXX probably OK without ->core_lock
 	 */
 	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
 	    rq->core->core_pick_seq != rq->core_sched_seq) {
@@ -3710,6 +3722,20 @@ pick_next_task(struct rq *rq, struct tas
 	if (!rq->nr_running)
 		newidle_balance(rq, rf);
 
+	if (!rq->core->core_cookie) {
+		for_each_class(class) {
+			next = pick_task(rq, class, NULL);
+			if (next)
+				break;
+		}
+
+		if (!next->core_cookie) {
+			set_next_task(rq, next);
+			return next;
+		}
+	}
+
+	raw_spin_lock(&rq->core->core_lock);
 	cpu = cpu_of(rq);
 	smt_mask = cpu_smt_mask(cpu);
 
@@ -3849,6 +3875,7 @@ next_class:;
 	trace_printk("picked: %s/%d %lx\n", next->comm, next->pid, next->core_cookie);
 
 done:
+	raw_spin_unlock(&rq->core->core_lock);
 	set_next_task(rq, next);
 	return next;
 }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -966,6 +966,7 @@ struct rq {
 	struct rb_root		core_tree;
 
 	/* shared state */
+	raw_spinlock_t		core_lock;
 	unsigned int		core_task_seq;
 	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
@@ -1007,9 +1008,6 @@ static inline bool sched_core_enabled(st
 
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
-	if (sched_core_enabled(rq))
-		return &rq->core->__lock;
-
 	return &rq->__lock;
 }
 
