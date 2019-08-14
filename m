Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E54BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC63B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="M2x3Lm7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfHNWeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:34:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39254 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHNWeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:34:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id z3so250876pln.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P47TDuRTyb4CTcChk4uKRWf5tpIOxFmUJ6D7+RADtYo=;
        b=M2x3Lm7CFOMXtOC79ogniyQQEDRqCpNlYjaZNzCuXhVjeQYuKgD+SNsCBQ8tFoBDcB
         91PCVHFy9XsArKaAs6S7pipslLdcyN5rDy9gemdNddoN88SunkS5Gl1WTla/FdH6MzZe
         KoC2+zz/M9Eo7iEW7Dc+jNnTGiuvaLRv17Yjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P47TDuRTyb4CTcChk4uKRWf5tpIOxFmUJ6D7+RADtYo=;
        b=bTbY5S24/XhILw12KpcINpGgNgj6ZuCP8Hff+jKMmADXkIw5qL4U5P8uV3/GLUewkz
         CNBy+9CO4PkTBzt8x6mHuTVTzqFjyFmQnEB+ZRHYp2vFoIJyU4EnWAWTrv9lxtA5kuOU
         beQLirSOUqWu9AkkKImgjL6p9Z1Oj9GrwTzJOE01zSWSoFneicW2xPvmXcY/jxADflfj
         H/KfRDRczPQsnvsTZellcckwJCclaLg3x4UZpW1nrALUv5dYbf8cyta+zg8SjQ6Z4kEu
         V+1gByL9XUbOKev0fa3ViO2k4u7w9PMAYW4KKzlV9UgRy8wjgt4kYJEJSllGuYQL1zL6
         BMQQ==
X-Gm-Message-State: APjAAAX/11ODgWV5IDiN5z4aTN3nUqqU/h602Byt5jZiTIjXOU+8WyBy
        Q9HojMuRELw1bDdzaRBldP2xZA==
X-Google-Smtp-Source: APXvYqyB8uTK4c4CzFde17hlAvp2SoyFZ6korIE0B42TuaiK9xhuzlbI0Urmfviqv4gAvDB6Ub0urw==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr1575891ple.192.1565822055899;
        Wed, 14 Aug 2019 15:34:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c13sm935755pfi.17.2019.08.14.15.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 15:34:14 -0700 (PDT)
Date:   Wed, 14 Aug 2019 18:34:13 -0400
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
Message-ID: <20190814223413.GB69375@google.com>
References: <20190813170046.81707-1-joel@joelfernandes.org>
 <20190813190738.GH28441@linux.ibm.com>
 <20190814143817.GA253999@google.com>
 <20190814172233.GA68498@google.com>
 <20190814184429.GV28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814184429.GV28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 11:44:29AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 14, 2019 at 01:22:33PM -0400, Joel Fernandes wrote:
> > On Wed, Aug 14, 2019 at 10:38:17AM -0400, Joel Fernandes wrote:
> > > On Tue, Aug 13, 2019 at 12:07:38PM -0700, Paul E. McKenney wrote:
> >  [snip]
> > > > > - * Queue an RCU callback for lazy invocation after a grace period.
> > > > > - * This will likely be later named something like "call_rcu_lazy()",
> > > > > - * but this change will require some way of tagging the lazy RCU
> > > > > - * callbacks in the list of pending callbacks. Until then, this
> > > > > - * function may only be called from __kfree_rcu().
> > > > > + * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
> > > > > + * kfree(s) is queued for freeing after a grace period, right away.
> > > > >   */
> > > > > -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > > +struct kfree_rcu_cpu {
> > > > > +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> > > > > +	 * is done after a grace period.
> > > > > +	 */
> > > > > +	struct rcu_work rcu_work;
> > > > > +
> > > > > +	/* The list of objects being queued in a batch but are not yet
> > > > > +	 * scheduled to be freed.
> > > > > +	 */
> > > > > +	struct rcu_head *head;
> > > > > +
> > > > > +	/* The list of objects that have now left ->head and are queued for
> > > > > +	 * freeing after a grace period.
> > > > > +	 */
> > > > > +	struct rcu_head *head_free;
> > > > 
> > > > So this is not yet the one that does multiple batches concurrently
> > > > awaiting grace periods, correct?  Or am I missing something subtle?
> > > 
> > > Yes, it is not. I honestly, still did not understand that idea. Or how it
> > > would improve things. May be we can discuss at LPC on pen and paper? But I
> > > think that can also be a follow-up optimization.
> > 
> > I got it now. Basically we can benefit a bit more by having another list
> > (that is have multiple kfree_rcu batches in flight). I will think more about
> > it - but hopefully we don't need to gate this patch by that.
> 
> I am willing to take this as a later optimization.
> 
> > It'll be interesting to see what rcuperf says about such an improvement :)
> 
> Indeed, no guarantees either way.  The reason for hope assumes a busy
> system where each grace period is immediately followed by another
> grace period.  On such a system, the current setup allows each CPU to
> make use only of every second grace period for its kfree_rcu() work.
> The hope would therefore be that this would reduce the memory footprint
> substantially with no increase in overhead.

Good news! I was able to bring down memory foot print by almost 30% by adding
another batch. Below is the patch. Thanks for the suggestion!

I can add this as a patch on top of the initial one, for easier review.

The memory consumed drops from 300-350MB to 200-250MB. Increasing
KFREE_N_BATCHES did not cause a reduction in memory, though.

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] WIP: Multiple batches

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 58 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1d1847cadea2..a272c893dbdc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2596,26 +2596,35 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
+#define KFREE_N_BATCHES 2
+
+struct kfree_rcu_work {
+	/* The rcu_work node for queuing work with queue_rcu_work(). The work
+	 * is done after a grace period.
+	 */
+	struct rcu_work rcu_work;
+
+	/* The list of objects that have now left ->head and are queued for
+	 * freeing after a grace period.
+	 */
+	struct rcu_head *head_free;
+
+	struct kfree_rcu_cpu *krc;
+};
+static DEFINE_PER_CPU(__typeof__(struct kfree_rcu_work)[KFREE_N_BATCHES], krw);
 
 /*
  * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
  * kfree(s) is queued for freeing after a grace period, right away.
  */
 struct kfree_rcu_cpu {
-	/* The rcu_work node for queuing work with queue_rcu_work(). The work
-	 * is done after a grace period.
-	 */
-	struct rcu_work rcu_work;
 
 	/* The list of objects being queued in a batch but are not yet
 	 * scheduled to be freed.
 	 */
 	struct rcu_head *head;
 
-	/* The list of objects that have now left ->head and are queued for
-	 * freeing after a grace period.
-	 */
-	struct rcu_head *head_free;
+	struct kfree_rcu_work *krw;
 
 	/* Protect concurrent access to this structure. */
 	spinlock_t lock;
@@ -2638,12 +2647,15 @@ static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
 	struct rcu_head *head, *next;
-	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
-					struct kfree_rcu_cpu, rcu_work);
+	struct kfree_rcu_work *krw = container_of(to_rcu_work(work),
+					struct kfree_rcu_work, rcu_work);
+	struct kfree_rcu_cpu *krcp;
+
+	krcp = krw->krc;
 
 	spin_lock_irqsave(&krcp->lock, flags);
-	head = krcp->head_free;
-	krcp->head_free = NULL;
+	head = krw->head_free;
+	krw->head_free = NULL;
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
 	/*
@@ -2666,19 +2678,30 @@ static void kfree_rcu_work(struct work_struct *work)
  */
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
+	int i = 0;
+	struct kfree_rcu_work *krw = NULL;
+
 	lockdep_assert_held(&krcp->lock);
+	while (i < KFREE_N_BATCHES) {
+		if (!krcp->krw[i].head_free) {
+			krw = &(krcp->krw[i]);
+			break;
+		}
+		i++;
+	}
 
-	/* If a previous RCU batch work is already in progress, we cannot queue
+	/* If both RCU batches are already in progress, we cannot queue
 	 * another one, just refuse the optimization and it will be retried
 	 * again in KFREE_DRAIN_JIFFIES time.
 	 */
-	if (krcp->head_free)
+	if (!krw)
 		return false;
 
-	krcp->head_free = krcp->head;
+	krw->head_free = krcp->head;
+	krw->krc = krcp;   /* Should need to do only once, optimize later. */
 	krcp->head = NULL;
-	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
-	queue_rcu_work(system_wq, &krcp->rcu_work);
+	INIT_RCU_WORK(&krw->rcu_work, kfree_rcu_work);
+	queue_rcu_work(system_wq, &krw->rcu_work);
 
 	return true;
 }
@@ -3631,6 +3654,7 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		spin_lock_init(&krcp->lock);
+		krcp->krw = &(per_cpu(krw, cpu)[0]);
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 	}
 }
-- 
2.23.0.rc1.153.gdeed80330f-goog

