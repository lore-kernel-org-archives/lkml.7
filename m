Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A007C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFAA20726
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1lXEQW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfLPMqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:46:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46432 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfLPMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:46:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so4098764lfl.13;
        Mon, 16 Dec 2019 04:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GFnDmlNyZSZLrsighJZzy59L+HK3ELB/DG/zXIrfnnM=;
        b=R1lXEQW3HswWqhaDwTcSWyBJie5csrvSooXpmx6S1OQEi61P5fV2zDi4130XmOCWnv
         6PB+zjTHnTDCyyi7BdrYT5EFfL4Ef8gQp0p9uA93SudkD69yRGGyJJ2NVyMkbgcRL1FG
         LwxaNiDbcVarB456pkBKpbwzljH4fS451yyJz0bO3mZW2Rigsbl/+o/TZDJraLnCZ+wr
         OrAGSr4M53qVacx37ej0xb+rQ1PhSXnKx0o+lugpQ5TSoLWRiT8NkXEzFtay2Br6YLYG
         QGC/Y3d5O+rUKtQPfmWuYD/uvhVR8Sk4s8ISHvHVHozWfOjhGzxljAAfQSNmiVq+rY6R
         uczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GFnDmlNyZSZLrsighJZzy59L+HK3ELB/DG/zXIrfnnM=;
        b=KC/T/7QwkNVffgeTOCFOZ3GBT5Zz3UI6FgLim9lMuS5TQMUVfN3UguKq4rkkghCJne
         zQDJp57S4kGtLXTxqKDKzWZgBpiyb7zWwDTWxeMPqA1SvxInxIEs5RyfYQY8Ox663JEt
         bMAM1dT/8Q/a3wN+HEgWeaz5nAjiKlgjdYlgwRwKXI+ILGVrQlN+At/vHvgqRhkLY2so
         QEFwG7E9THWH8EBxca0nUSb6tSjojFKK4uaK8w1TQDa7JD9lo5Ue8BUDNvfcVbpVJQjJ
         08VFSbXZJ0zSCHSu24JlNBTvtfzDRzdnwCKKxHUCxSHW/Bp0O82hI8SnaTGSHMOyZAkg
         5i5g==
X-Gm-Message-State: APjAAAVXJ7LwzoMS7YX60Wxy4LL0Y1PQEh2Xs0Jct6XvNGakHEXvVdi2
        VQzTZGqDXUKWvGGQiT4QfUY=
X-Google-Smtp-Source: APXvYqz/hOoNT77xo7Mg+lPe87uGWP+P6k1y0fUhRNddlghaaiBEPe/X63gcFMdCPsXsZjQVhK5SIQ==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr16416888lfy.11.1576500385872;
        Mon, 16 Dec 2019 04:46:25 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id m16sm10544906ljb.47.2019.12.16.04.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 04:46:25 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Dec 2019 13:46:17 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel-team@lge.com, Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20191216124617.GA13293@pc636>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190918095811.GA25821@pc636>
 <20191210095348.GA420@pc636>
 <20191212052727.GA125322@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212052727.GA125322@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:27:27AM -0500, Joel Fernandes wrote:
> On Tue, Dec 10, 2019 at 10:53:48AM +0100, Uladzislau Rezki wrote:
> > On Wed, Sep 18, 2019 at 11:58:11AM +0200, Uladzislau Rezki wrote:
> > > > Recently a discussion about stability and performance of a system
> > > > involving a high rate of kfree_rcu() calls surfaced on the list [1]
> > > > which led to another discussion how to prepare for this situation.
> > > > 
> > > > This patch adds basic batching support for kfree_rcu(). It is "basic"
> > > > because we do none of the slab management, dynamic allocation, code
> > > > moving or any of the other things, some of which previous attempts did
> > > > [2]. These fancier improvements can be follow-up patches and there are
> > > > different ideas being discussed in those regards. This is an effort to
> > > > start simple, and build up from there. In the future, an extension to
> > > > use kfree_bulk and possibly per-slab batching could be done to further
> > > > improve performance due to cache-locality and slab-specific bulk free
> > > > optimizations. By using an array of pointers, the worker thread
> > > > processing the work would need to read lesser data since it does not
> > > > need to deal with large rcu_head(s) any longer.
> > > > 
> > According to https://lkml.org/lkml/2017/12/19/706 there was an attempt
> > to make use of kfree_bulk() interface. I have done some tests based on
> > your patch and enhanced kfree_bulk() logic. Basically storing pointers 
> > in an array with a specific size makes sense to me and seems to others
> > as well. I mean in comparison with "pointer chasing" way, when there is
> > probably a cache misses each time the access is done to next element:
> 
> This looks like a great idea to me, that is chaining blocks together.
> 
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 1fe0418a5901..4f68662c1568 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2595,6 +2595,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
> > 
> >  /* Maximum number of jiffies to wait before draining a batch. */
> >  #define KFREE_DRAIN_JIFFIES (HZ / 50)
> > +#define KFREE_BULK_MAX_SIZE 64
> > +
> > +struct kfree_rcu_bulk_data {
> > +       int nr_records;
> > +       void *records[KFREE_BULK_MAX_SIZE];
> > +       struct kfree_rcu_bulk_data *next;
> > +};
> > 
> >  /*
> >   * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
> > @@ -2607,15 +2614,24 @@ struct kfree_rcu_cpu {
> >         struct rcu_work rcu_work;
> > 
> >         /* The list of objects being queued in a batch but are not yet
> > -        * scheduled to be freed.
> > +        * scheduled to be freed. For emergency path only.
> >          */
> >         struct rcu_head *head;
> > 
> >         /* The list of objects that have now left ->head and are queued for
> > -        * freeing after a grace period.
> > +        * freeing after a grace period. For emergency path only.
> >          */
> >         struct rcu_head *head_free;
> > 
> > +       /*
> > +        * It is a block list that keeps pointers in the array of specific
> > +        * size which are freed by the kfree_bulk() logic. Intends to improve
> > +        * drain throughput.
> > +        */
> > +       struct kfree_rcu_bulk_data *bhead;
> > +       struct kfree_rcu_bulk_data *bhead_free;
> > +       struct kfree_rcu_bulk_data *bcached;
> > +
> >         /* Protect concurrent access to this structure. */
> >         spinlock_t lock;
> > @@ -2637,23 +2653,39 @@ static void kfree_rcu_work(struct work_struct *work)
> >  {
> >         unsigned long flags;
> >         struct rcu_head *head, *next;
> > +       struct kfree_rcu_bulk_data *bhead, *bnext;
> >         struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
> >                                         struct kfree_rcu_cpu, rcu_work);
> >  
> >         spin_lock_irqsave(&krcp->lock, flags);
> >         head = krcp->head_free;
> >         krcp->head_free = NULL;
> > +       bhead = krcp->bhead_free;
> > +       krcp->bhead_free = NULL;
> >         spin_unlock_irqrestore(&krcp->lock, flags);
> >  
> >         /*
> >          * The head is detached and not referenced from anywhere, so lockless
> >          * access is Ok.
> >          */
> > +       for (; bhead; bhead = bnext) {
> > +               bnext = bhead->next;
> > +               kfree_bulk(bhead->nr_records, bhead->records);
> > +
> > +               if (cmpxchg(&krcp->bcached, NULL, bhead))
> > +                       kfree(bhead);
> 
> After the first iteration of loop, say cmpxchg succeeded, then is there a
> point it doing repeated cmpxchg in future loops? AIUI, cmpxchg has a
> serializing cost and better be avoided where possible.
> 
I see your point. I also do not like calling cmpxchg() in the loop. From
the other hand the number of loops depends on how many "chain blocks" we
have in our list. To reduce that number we can increase KFREE_BULK_MAX_SIZE,
i.e. the list will become shorter.

>
> But... there can be a case where bcached was used up while the loop is
> running. Then there could be a point in reassigning it in future loop
> iterations.
> 
Sound like that, therefore i keep it in the loop.

> > +
> > +               cond_resched_tasks_rcu_qs();
> > +       }
> > +
> > +       /*
> > +        * Emergency case only. It can happen under low
> > +        * memory condition when kmalloc gets failed, so
> > +        * the "bulk" path can not be temporary maintained.
> > +        */
> >         for (; head; head = next) {
> >                 next = head->next;
> > -               /* Could be possible to optimize with kfree_bulk in future */
> 
> I'm glad I had left this comment ;-) ;-)
> 
It is always good to leave valuable comments :)


> >                 __rcu_reclaim(rcu_state.name, head);
> > -               cond_resched_tasks_rcu_qs();
> 
> Why take off this cond_resched..() ?
> 
I can keep it. I removed it because it becomes as "emergency path"
only that is most likely never triggered.

> >         }
> >  }
> > 
> > @@ -2671,11 +2703,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> >          * another one, just refuse the optimization and it will be retried
> >          * again in KFREE_DRAIN_JIFFIES time.
> >          */
> > -       if (krcp->head_free)
> > +       if (krcp->bhead_free || krcp->head_free)
> >                 return false;
> > 
> >         krcp->head_free = krcp->head;
> >         krcp->head = NULL;
> > +
> > +       krcp->bhead_free = krcp->bhead;
> > +       krcp->bhead = NULL;
> > +
> >         INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
> >         queue_rcu_work(system_wq, &krcp->rcu_work);
> > 
> > @@ -2747,6 +2783,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> >         unsigned long flags;
> >         struct kfree_rcu_cpu *krcp;
> > +       struct kfree_rcu_bulk_data *bnode;
> > 
> >         /* kfree_call_rcu() batching requires timers to be up. If the scheduler
> >          * is not yet up, just skip batching and do the non-batched version.
> > @@ -2754,16 +2791,35 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >         if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
> >                 return kfree_call_rcu_nobatch(head, func);
> > 
> > -       head->func = func;
> > -
> >         local_irq_save(flags);  /* For safely calling this_cpu_ptr(). */
> >         krcp = this_cpu_ptr(&krc);
> >         spin_lock(&krcp->lock);
> > 
> > +       if (!krcp->bhead ||
> > +                       krcp->bhead->nr_records == KFREE_BULK_MAX_SIZE) {
> > +               /* Need a new block. */
> > +               if (!(bnode = xchg(&krcp->bcached, NULL)))
> 
> Is it better to cache more than 1 block? But this is also Ok I think.
> 
I was thinking about it. In that case we need to answer the question
how many blocks are worth to cache. As of now we can go with one if
nobody minds.

> > +                       bnode = kmalloc(sizeof(struct kfree_rcu_bulk_data),
> > +                               GFP_ATOMIC | __GFP_NOWARN);
> > +
> > +               /* If gets failed, maintain the list instead. */
> > +               if (unlikely(!bnode)) {
> > +                       head->func = func;
> > +                       head->next = krcp->head;
> > +                       krcp->head = head;
> > +                       goto check_and_schedule;
> > +               }
> > +
> > +               bnode->nr_records = 0;
> > +               bnode->next = krcp->bhead;
> > +               krcp->bhead = bnode;
> > +       }
> > +
> >         /* Queue the kfree but don't yet schedule the batch. */
> > -       head->next = krcp->head;
> > -       krcp->head = head;
> > +       krcp->bhead->records[krcp->bhead->nr_records++] =
> > +               (void *) head - (unsigned long) func;
> >  
> > +check_and_schedule:
> 
> >         /* Schedule monitor for timely drain after KFREE_DRAIN_JIFFIES. */
> >         if (!xchg(&krcp->monitor_todo, true))
> >                 schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > 
> > See below some test results with/without this patch:
> > 
> > # HiKey 960 8xCPUs
> > rcuperf.ko kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1
> > [  159.017771] Total time taken by all kfree'ers: 92783584881 ns, loops: 200000, batches: 5117
> > [  126.862573] Total time taken by all kfree'ers: 70935580718 ns, loops: 200000, batches: 3953
> > 
> > Running the "rcuperf" shows approximately ~23% better throughput in case of using
> 
> Awesome. Wow. Is this +23% with a slab allocator configuration?
> 
I have checked CONFIG_SLAB but on the virtual machine running under KVM
the difference was ~15%. As for HiKey board and provided results above,
i have just checked, it uses CONFIG_SLUB allocator. I can also check
CONFIG_SLAB on HiKey 960 8xCPUs board.

>
> You mentioned you will post a new version. Once you do it, I can take
> another look and run some tests. Then I'll give your patch the Reviewed-by tag.
> 
OK.

Thank you Joel for your comments!

--
Vlad Rezki
