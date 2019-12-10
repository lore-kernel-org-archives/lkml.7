Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C76C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD28D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew2wtssY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfLJJyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:54:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39913 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLJJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:54:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id e10so19119364ljj.6;
        Tue, 10 Dec 2019 01:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6cqsGsp+ZUO8m1vGxlpJnKGWq2w7yuiDyolBR1vJcuo=;
        b=Ew2wtssYP8SmMU1ROaoHiHzoktWVWSAYckzYFBievnIGc0dUBEi2Z9tlOcfiP4ljO+
         0Brnhv2C53NbpncwbTrFhMCdvgqt6InfYfOpiJWlobU1eAyEnpLzFJqPCcKdITsvs6zE
         Ow8Bxz3uJCCvf1Jc6V8NY2QJzwHWI1a2cAXD9rgKJuiw9/0iqLvNgKMVcHWSAt65x0he
         PfXXwx9xjdqaj5vM7hnxAm4ffPm2vo4j4umi1C+0gJIFVWpQFGkF7TqsY9xg4fc4uFRD
         Wx7VxEVhP9l6CimjAvNmtz/zineDsgABTiHNNevqSXwgLLLbvymyz1rSSCmgCaK37fBY
         qIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6cqsGsp+ZUO8m1vGxlpJnKGWq2w7yuiDyolBR1vJcuo=;
        b=h9zS+ubkT0o4/lSIhRMhubLMJYSXTnPoucvKYGUwfY45+9AfGxxj6VaSeF6ZAFqzaM
         bjaDvEsJr6x0colztiiHiBnfWfh0YBY1R4lDNd0FEr9hPX+/A2rhFamVlrSDICytQoPP
         58FEfXL9PnKyT+Cu4d1P1UuBovMz07yHpeqtbq7+nwlzgydOE3ZOGSSBuKKPxnoPZj1C
         HFCpc5KikTk52k2AIQMUFfKr/yfJpKAB0sI+gE9P/Qc4KGGGb00WY2eY/QEy78xRbZBD
         YOf9LSNDKDsZ072/nQgiRsO53xec4eglRMsa+WBw+PQhw1R9LXQDAkn+Lvy3BjigjmnG
         0yMg==
X-Gm-Message-State: APjAAAWzEQ33lE/2TDqgKkgMATa9qNHeR5MjhsYD2E2KIWJfftWmFwm3
        FqyYS9Ame+jpkTCRpm6gGMY=
X-Google-Smtp-Source: APXvYqyrtlbfYzZ/pCO/3gmb09kNQZyF9u6YoHH2Co0UmXVsW3aFy02gbouF6hbKQHeTXYLkKnYsFw==
X-Received: by 2002:a2e:9694:: with SMTP id q20mr3206696lji.248.1575971637302;
        Tue, 10 Dec 2019 01:53:57 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id g27sm1201547lfh.57.2019.12.10.01.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:53:56 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 10 Dec 2019 10:53:48 +0100
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel-team@lge.com, Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20191210095348.GA420@pc636>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190918095811.GA25821@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918095811.GA25821@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:58:11AM +0200, Uladzislau Rezki wrote:
> > Recently a discussion about stability and performance of a system
> > involving a high rate of kfree_rcu() calls surfaced on the list [1]
> > which led to another discussion how to prepare for this situation.
> > 
> > This patch adds basic batching support for kfree_rcu(). It is "basic"
> > because we do none of the slab management, dynamic allocation, code
> > moving or any of the other things, some of which previous attempts did
> > [2]. These fancier improvements can be follow-up patches and there are
> > different ideas being discussed in those regards. This is an effort to
> > start simple, and build up from there. In the future, an extension to
> > use kfree_bulk and possibly per-slab batching could be done to further
> > improve performance due to cache-locality and slab-specific bulk free
> > optimizations. By using an array of pointers, the worker thread
> > processing the work would need to read lesser data since it does not
> > need to deal with large rcu_head(s) any longer.
> > 
According to https://lkml.org/lkml/2017/12/19/706 there was an attempt
to make use of kfree_bulk() interface. I have done some tests based on
your patch and enhanced kfree_bulk() logic. Basically storing pointers 
in an array with a specific size makes sense to me and seems to others
as well. I mean in comparison with "pointer chasing" way, when there is
probably a cache misses each time the access is done to next element:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1fe0418a5901..4f68662c1568 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2595,6 +2595,13 @@ EXPORT_SYMBOL_GPL(call_rcu);

 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_BULK_MAX_SIZE 64
+
+struct kfree_rcu_bulk_data {
+       int nr_records;
+       void *records[KFREE_BULK_MAX_SIZE];
+       struct kfree_rcu_bulk_data *next;
+};

 /*
  * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
@@ -2607,15 +2614,24 @@ struct kfree_rcu_cpu {
        struct rcu_work rcu_work;

        /* The list of objects being queued in a batch but are not yet
-        * scheduled to be freed.
+        * scheduled to be freed. For emergency path only.
         */
        struct rcu_head *head;

        /* The list of objects that have now left ->head and are queued for
-        * freeing after a grace period.
+        * freeing after a grace period. For emergency path only.
         */
        struct rcu_head *head_free;

+       /*
+        * It is a block list that keeps pointers in the array of specific
+        * size which are freed by the kfree_bulk() logic. Intends to improve
+        * drain throughput.
+        */
+       struct kfree_rcu_bulk_data *bhead;
+       struct kfree_rcu_bulk_data *bhead_free;
+       struct kfree_rcu_bulk_data *bcached;
+
        /* Protect concurrent access to this structure. */
        spinlock_t lock;
@@ -2637,23 +2653,39 @@ static void kfree_rcu_work(struct work_struct *work)
 {
        unsigned long flags;
        struct rcu_head *head, *next;
+       struct kfree_rcu_bulk_data *bhead, *bnext;
        struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
                                        struct kfree_rcu_cpu, rcu_work);
 
        spin_lock_irqsave(&krcp->lock, flags);
        head = krcp->head_free;
        krcp->head_free = NULL;
+       bhead = krcp->bhead_free;
+       krcp->bhead_free = NULL;
        spin_unlock_irqrestore(&krcp->lock, flags);
 
        /*
         * The head is detached and not referenced from anywhere, so lockless
         * access is Ok.
         */
+       for (; bhead; bhead = bnext) {
+               bnext = bhead->next;
+               kfree_bulk(bhead->nr_records, bhead->records);
+
+               if (cmpxchg(&krcp->bcached, NULL, bhead))
+                       kfree(bhead);
+
+               cond_resched_tasks_rcu_qs();
+       }
+
+       /*
+        * Emergency case only. It can happen under low
+        * memory condition when kmalloc gets failed, so
+        * the "bulk" path can not be temporary maintained.
+        */
        for (; head; head = next) {
                next = head->next;
-               /* Could be possible to optimize with kfree_bulk in future */
                __rcu_reclaim(rcu_state.name, head);
-               cond_resched_tasks_rcu_qs();
        }
 }

@@ -2671,11 +2703,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
         * another one, just refuse the optimization and it will be retried
         * again in KFREE_DRAIN_JIFFIES time.
         */
-       if (krcp->head_free)
+       if (krcp->bhead_free || krcp->head_free)
                return false;

        krcp->head_free = krcp->head;
        krcp->head = NULL;
+
+       krcp->bhead_free = krcp->bhead;
+       krcp->bhead = NULL;
+
        INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
        queue_rcu_work(system_wq, &krcp->rcu_work);

@@ -2747,6 +2783,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
        unsigned long flags;
        struct kfree_rcu_cpu *krcp;
+       struct kfree_rcu_bulk_data *bnode;

        /* kfree_call_rcu() batching requires timers to be up. If the scheduler
         * is not yet up, just skip batching and do the non-batched version.
@@ -2754,16 +2791,35 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
        if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
                return kfree_call_rcu_nobatch(head, func);

-       head->func = func;
-
        local_irq_save(flags);  /* For safely calling this_cpu_ptr(). */
        krcp = this_cpu_ptr(&krc);
        spin_lock(&krcp->lock);

+       if (!krcp->bhead ||
+                       krcp->bhead->nr_records == KFREE_BULK_MAX_SIZE) {
+               /* Need a new block. */
+               if (!(bnode = xchg(&krcp->bcached, NULL)))
+                       bnode = kmalloc(sizeof(struct kfree_rcu_bulk_data),
+                               GFP_ATOMIC | __GFP_NOWARN);
+
+               /* If gets failed, maintain the list instead. */
+               if (unlikely(!bnode)) {
+                       head->func = func;
+                       head->next = krcp->head;
+                       krcp->head = head;
+                       goto check_and_schedule;
+               }
+
+               bnode->nr_records = 0;
+               bnode->next = krcp->bhead;
+               krcp->bhead = bnode;
+       }
+
        /* Queue the kfree but don't yet schedule the batch. */
-       head->next = krcp->head;
-       krcp->head = head;
+       krcp->bhead->records[krcp->bhead->nr_records++] =
+               (void *) head - (unsigned long) func;
 
+check_and_schedule:
        /* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
        if (!xchg(&krcp->monitor_todo, true))
                schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);

See below some test results with/without this patch:

# HiKey 960 8xCPUs
rcuperf.ko kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1
[  159.017771] Total time taken by all kfree'ers: 92783584881 ns, loops: 200000, batches: 5117
[  126.862573] Total time taken by all kfree'ers: 70935580718 ns, loops: 200000, batches: 3953

Running the "rcuperf" shows approximately ~23% better throughput in case of using
"bulk" interface, so we have 92783584881 vs 70935580718 as total time. The "drain logic"
or its RCU callback does the work faster that leads to better throughput.

I can upload the RFC/PATCH of that change providing the test details and so on. 

Any thoughts about it?

Thank you in advance!

--
Vlad Rezki
