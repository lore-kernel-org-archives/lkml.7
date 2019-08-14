Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E32C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055482084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eODpRzxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfHNOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:38:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46994 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:38:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so50773893plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dnhILnEfWOqxStPq7LG3lZYrD1YBx6HctrxOo4+vauA=;
        b=eODpRzxIkgIJR99qXWTLR56HXfqAoLmEtZgoxfiXI0rnJ0soVmu1BAJtI83IHdZKj6
         C08V0jbW1QvLehPruwxySoqAPP0DaTEReVNWcRbuTHrQF2VV+AFPalRx46KDJHZuzkUs
         aJRFLTstOJ9dkNb8sx63T3xuiEI3IbFwtRWKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dnhILnEfWOqxStPq7LG3lZYrD1YBx6HctrxOo4+vauA=;
        b=TgG+Hfo7mEohGqHzNwrpyxtVHo7TRa9XJkk0yNyRLPiWI4TplW86jaUzXAHZPxF0tB
         4XsARXdEZhT0TbAPaYYZSRPczAQVwZ2dRcrSMgSaxbXnQfYNOQ1GsQEjFscEG3hNqHSF
         kUYjTudMF8rOSgc/NdgPiRipBFaEVbTX8ew+0QysGVdrWCrbY4ajo1gUQUptiDT5695q
         joeRLMHCNB3QBzrrIgQGcc8wFC76ImSgwFgeZN8heIrU+oDiZ0/5Q2pJs5mGXh+2EO+G
         GMe4W+Y18e3NEWqMsvjsiv6i/osoOcZqdZPD8LjgCmu4n0LHOO6vqlaBHsl89CTcrB1x
         Kzuw==
X-Gm-Message-State: APjAAAVGxwboEyOwvdX7AJHhZdnyvgAyimwfyFxdqhc3O35SYG6MfXrs
        UwF5TbbNiFf32/fkw8YbukoWWg==
X-Google-Smtp-Source: APXvYqzJ70fC8jqYG7wscPIi503VBMvV+odnD7tjx4JNTIRzG/6hBbKRwleq2MDxXx9U80gwWV1MQQ==
X-Received: by 2002:a17:902:a01:: with SMTP id 1mr7070003plo.278.1565793500035;
        Wed, 14 Aug 2019 07:38:20 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y128sm138039448pgy.41.2019.08.14.07.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:38:18 -0700 (PDT)
Date:   Wed, 14 Aug 2019 10:38:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] rcu/tree: Add basic support for kfree_rcu batching
Message-ID: <20190814143817.GA253999@google.com>
References: <20190813170046.81707-1-joel@joelfernandes.org>
 <20190813190738.GH28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813190738.GH28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 12:07:38PM -0700, Paul E. McKenney wrote:
[snip]
> > This patch adds basic batching support for kfree_rcu(). It is "basic"
> > because we do none of the slab management, dynamic allocation, code
> > moving or any of the other things, some of which previous attempts did
> > [2]. These fancier improvements can be follow-up patches and there are
> > different ideas being discussed in those regards.
> > 
> > Torture tests follow in the next patch and show improvements of around
> > 400% in reduction of number of  grace periods on a 16 CPU system. More
> 
> s/400% in reduction/a 5x reduction/

Ok. That's more clear.

> > details and test data are in that patch.
> > 
> > This is an effort to start simple, and build up from there. In the
> > future, an extension to use kfree_bulk and possibly per-slab batching
> > could be done to further improve performance due to cache-locality and
> > slab-specific bulk free optimizations. By using an array of pointers,
> > the worker thread processing the work would need to read lesser data
> > since it does not need to deal with large rcu_head(s) any longer.
> 
> This should be combined with the second paragraph -- they both discuss
> possible follow-on work.

Ack.

> > There is an implication with rcu_barrier() with this patch. Since the
> > kfree_rcu() calls can be batched, and may not be handed yet to the RCU
> > machinery in fact, the monitor may not have even run yet to do the
> > queue_rcu_work(), there seems no easy way of implementing rcu_barrier()
> > to wait for those kfree_rcu()s that are already made. So this means a
> > kfree_rcu() followed by an rcu_barrier() does not imply that memory will
> > be freed once rcu_barrier() returns.
> 
> The usual approach (should kfree_rcu_barrier() in fact be needed) is to
> record the address of the most recent block being kfree_rcu()'d on
> each CPU, count the number of recorded addresses, and have the
> kfree() side check the address, and do the usual atomic_dec_and_test()
> and wakeup dance.  This gets a bit more crazy should the kfree_rcu()
> requests be grouped per slab, of course!  So yes, good to avoid in
> the meantime.

Good idea!

> > Another implication is higher active memory usage (although not
> > run-away..) until the kfree_rcu() flooding ends, in comparison to
> > without batching. More details about this are in the second patch which
> > adds an rcuperf test.
> 
> But this is adjustable, at least via patching at build time, via
> KFREE_DRAIN_JIFFIES, right?

Yes.

> > Finally, in the near future we will get rid of kfree_rcu special casing
> > within RCU such as in rcu_do_batch and switch everything to just
> > batching. Currently we don't do that since timer subsystem is not yet up
> > and we cannot schedule the kfree_rcu() monitor as the timer subsystem's
> > lock are not initialized. That would also mean getting rid of
> > kfree_call_rcu_nobatch() entirely.
> 
> Please consistently put "()" after function names.

Done.

> > [1] http://lore.kernel.org/lkml/20190723035725-mutt-send-email-mst@kernel.org
> > [2] https://lkml.org/lkml/2017/12/19/824
> > 
> > Cc: Rao Shoaib <rao.shoaib@oracle.com>
> > Cc: max.byungchul.park@gmail.com
> > Cc: byungchul.park@lge.com
> > Cc: kernel-team@android.com
> > Cc: kernel-team@lge.com
> > Co-developed-by: Byungchul Park <byungchul.park@lge.com>
> > Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > ---
> > v2->v3: Just some code comment changes thanks to Byungchul.
> > 
> > RFCv1->PATCH v2: Removed limits on the ->head list, just let it grow.
> >                    Dropped KFREE_MAX_JIFFIES to HZ/50 from HZ/20 to reduce OOM occurrence.
> >                    Removed sleeps in rcuperf test, just using cond_resched()in loop.
> >                    Better code comments ;)
> > 
> >  .../admin-guide/kernel-parameters.txt         |  17 ++
> >  include/linux/rcutiny.h                       |   5 +
> >  include/linux/rcutree.h                       |   1 +
> >  kernel/rcu/tree.c                             | 204 +++++++++++++++++-
> >  4 files changed, 221 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 7ccd158b3894..a9156ca5de24 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3895,6 +3895,23 @@
> >  			test until boot completes in order to avoid
> >  			interference.
> >  
> > +	rcuperf.kfree_rcu_test= [KNL]
> > +			Set to measure performance of kfree_rcu() flooding.
> > +
> > +	rcuperf.kfree_nthreads= [KNL]
> > +			The number of threads running loops of kfree_rcu().
> > +
> > +	rcuperf.kfree_alloc_num= [KNL]
> > +			Number of allocations and frees done in an iteration.
> > +
> > +	rcuperf.kfree_loops= [KNL]
> > +			Number of loops doing rcuperf.kfree_alloc_num number
> > +			of allocations and frees.
> > +
> > +	rcuperf.kfree_no_batch= [KNL]
> > +			Use the non-batching (slower) version of kfree_rcu.
> > +			This is useful for comparing with the batched version.
> > +
> >  	rcuperf.nreaders= [KNL]
> >  			Set number of RCU readers.  The value -1 selects
> >  			N, where N is the number of CPUs.  A value
> 
> This change to kernel-parameters.txt really needs to be in the
> rcuperf patch rather than this one.

Fixed.

FWIW, my new tool (sort of under wraps) to move hunks from one patch to
another in a git tree makes this easy: https://github.com/joelagnel/git-edit
(I hit 'p' to edit patches and it commits back the results when I close the
editor).

[snip]
> > - * Queue an RCU callback for lazy invocation after a grace period.
> > - * This will likely be later named something like "call_rcu_lazy()",
> > - * but this change will require some way of tagging the lazy RCU
> > - * callbacks in the list of pending callbacks. Until then, this
> > - * function may only be called from __kfree_rcu().
> > + * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
> > + * kfree(s) is queued for freeing after a grace period, right away.
> >   */
> > -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > +struct kfree_rcu_cpu {
> > +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> > +	 * is done after a grace period.
> > +	 */
> > +	struct rcu_work rcu_work;
> > +
> > +	/* The list of objects being queued in a batch but are not yet
> > +	 * scheduled to be freed.
> > +	 */
> > +	struct rcu_head *head;
> > +
> > +	/* The list of objects that have now left ->head and are queued for
> > +	 * freeing after a grace period.
> > +	 */
> > +	struct rcu_head *head_free;
> 
> So this is not yet the one that does multiple batches concurrently
> awaiting grace periods, correct?  Or am I missing something subtle?

Yes, it is not. I honestly, still did not understand that idea. Or how it
would improve things. May be we can discuss at LPC on pen and paper? But I
think that can also be a follow-up optimization.

> If it is not doing the multiple-batch optimization, what does the
> 400% in the commit log refer to?

The 400% is the reduction in the number of grace periods just with this patch
(single batch processed at a time). The improvement is because of batching, we end
up having to start fewer grace periods while still managing to attend to the
kfree_rcu() load.

There is concurrency, because ->head continues to grow while ->head_free is
being processed.

> > +	/* Protect concurrent access to this structure. */
> > +	spinlock_t lock;
> > +
> > +	/* The delayed work that flushes ->head to ->head_free incase ->head
> > +	 * within KFREE_DRAIN_JIFFIES. In case flushing cannot be done if RCU
> > +	 * is busy, ->head just continues to grow and we retry flushing later.
> > +	 */
> > +	struct delayed_work monitor_work;
> > +	bool monitor_todo;	/* Is a delayed work pending execution? */
> > +};
> > +
> > +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
> > +
> > +/*
> > + * This function is invoked in workqueue context after a grace period.
> > + * It frees all the objects queued on ->head_free.
> > + */
> > +static void kfree_rcu_work(struct work_struct *work)
> > +{
> > +	unsigned long flags;
> > +	struct rcu_head *head, *next;
> > +	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
> > +					struct kfree_rcu_cpu, rcu_work);
> > +
> > +	spin_lock_irqsave(&krcp->lock, flags);
> > +	head = krcp->head_free;
> > +	krcp->head_free = NULL;
> > +	spin_unlock_irqrestore(&krcp->lock, flags);
> > +
> > +	/*
> > +	 * The head is detached and not referenced from anywhere, so lockless
> > +	 * access is Ok.
> > +	 */
> > +	for (; head; head = next) {
> > +		next = head->next;
> > +		head->next = NULL;
> 
> Why do we need to NULL ->next?  Could produce an expensive cache miss,
> and I don't see how it helps anything.  What am I missing here?

You're right. I will get rid of hit, no reason to have it.

[snip]
> > +static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > +				   unsigned long flags)
> > +{
> > +	/* Flush ->head to ->head_free, all objects on ->head_free will be
> > +	 * kfree'd after a grace period.
> > +	 */
> > +	if (queue_kfree_rcu_work(krcp)) {
> > +		/* Success! Our job is done here. */
> > +		spin_unlock_irqrestore(&krcp->lock, flags);
> > +		return;
> > +	}
> > +
> > +	/* Previous batch did not get free yet, let us try again soon. */
> > +	if (krcp->monitor_todo == false) {
> > +		schedule_delayed_work_on(smp_processor_id(),
> > +				&krcp->monitor_work,  KFREE_DRAIN_JIFFIES);
> 
> Given that we are using a lock, do we need to restrict to the current
> CPU?  In any case, we do need to handle the case where the current
> CPU has gone offline before we get around to sending a batch off to
> wait for a grace period, correct?

The results either way are similar, but I agree it is better to not use the
CPU specific API, and use the generic one especially because it tries to
queue on the local CPU if possible.

Will respin!

thanks,

 - Joel

