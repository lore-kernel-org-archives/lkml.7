Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A73EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469292086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ACPVRgsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404283AbfHHXaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:30:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32845 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHHXaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:30:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so44966271pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fbtUbKzMjQggfyJoXEwOvtq7UssFlb6V5+VWKviPdQc=;
        b=ACPVRgsD+IdMhNn6fmN5OZenUm3BevU8eQ3cPcdHIdgK4aygRe36SXj2b8dA9kPf1I
         0QQkNGpnbmH1MC1NdxOd3FpFqHQUTrF7UvzeOKcYkV011GhrWCR//qP/qrzAodPXhwpq
         Od0TeHoB8ErWKLMuPLT9iScnHp0XtCmRzpS3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fbtUbKzMjQggfyJoXEwOvtq7UssFlb6V5+VWKviPdQc=;
        b=ftHUfKnkwRZMNGpFO6WbGZxKM8RXLkovnfio6CWRi/cTMoYf3B/zbAb7ctMiO0K+DK
         S4wUN9ELZq4FG6h2L+hwrIvwer33VRlDgpjLfC6Z8knrbINEINsDYc+hzytGRwOOlFmR
         Rrg8jNLzcRG0GZyB55r4bup0PJFwd2n1vhqnNxHVqH9TuUQiqlipkxypnQTzF4kVIdrb
         YQoANbHAcokUVRFs5ZXb+iGbCq96xHb1xgLM9x9CtbzGLvBlYVvCX8blAS8T0aR7hQ5v
         bckx8TY38HlreN2ZIGgeTSsUWAyuKjCv6vgvb6aRuojMhbJMMdGRyPUNNIyhasDiLhVM
         hgUA==
X-Gm-Message-State: APjAAAUD92BJz9BY479XYF6D6/oaAoUsMXXHrxNuz88aLy9+yzjnJF3t
        BudRPF058/vhlM6a6x1INy15ug==
X-Google-Smtp-Source: APXvYqwlBgxNYBk4zVtuAsxKB/6z770GZoySjs5PO5M1n4vtH9PuJYbRVvwVUODvTX3bKoKW4aZ4bg==
X-Received: by 2002:a62:e301:: with SMTP id g1mr17410292pfh.119.1565307016304;
        Thu, 08 Aug 2019 16:30:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p13sm3734889pjb.30.2019.08.08.16.30.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 16:30:15 -0700 (PDT)
Date:   Thu, 8 Aug 2019 19:30:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190808233014.GA184373@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808125607.GB261256@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 08:56:07AM -0400, Joel Fernandes wrote:
> On Thu, Aug 08, 2019 at 06:52:32PM +0900, Byungchul Park wrote:
> > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > > [ . . . ]
> > > > > > +	for (; head; head = next) {
> > > > > > +		next = head->next;
> > > > > > +		head->next = NULL;
> > > > > > +		__call_rcu(head, head->func, -1, 1);
> > > > > 
> > > > > We need at least a cond_resched() here.  200,000 times through this loop
> > > > > in a PREEMPT=n kernel might not always be pretty.  Except that this is
> > > > > invoked directly from kfree_rcu() which might be invoked with interrupts
> > > > > disabled, which precludes calls to cond_resched().  So the realtime guys
> > > > > are not going to be at all happy with this loop.
> > > > 
> > > > Ok, will add this here.
> > > > 
> > > > > And this loop could be avoided entirely by having a third rcu_head list
> > > > > in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
> > > > > KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
> > > > > should be OK, or at least more OK than queuing 200,000 callbacks with
> > > > > interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
> > > > > pointers can be used to reduce the probability of oversized batches.)
> > > > > This would also mean that the equality comparisons with KFREE_MAX_BATCH
> > > > > need to become greater-or-equal comparisons or some such.
> > > > 
> > > > Yes, certainly we can do these kinds of improvements after this patch, and
> > > > then add more tests to validate the improvements.
> > > 
> > > Out of pity for people bisecting, we need this fixed up front.
> > > 
> > > My suggestion is to just allow ->head to grow until ->head_free becomes
> > > available.  That way you are looping with interrupts and preemption
> > > enabled in workqueue context, which is much less damaging than doing so
> > > with interrupts disabled, and possibly even from hard-irq context.
> > 
> > Agree.
> > 
> > Or after introducing another limit like KFREE_MAX_BATCH_FORCE(>=
> > KFREE_MAX_BATCH):
> > 
> > 1. Try to drain it on hitting KFREE_MAX_BATCH as it does.
> > 
> >    On success: Same as now.
> >    On fail: let ->head grow and drain if possible, until reaching to
> >             KFREE_MAX_BATCH_FORCE.
> > 
> > 3. On hitting KFREE_MAX_BATCH_FORCE, give up batching but handle one by
> >    one from now on to prevent too many pending requests from being
> >    queued for batching work.
> 
> I also agree. But this _FORCE thing will still not solve the issue Paul is
> raising which is doing this loop possibly in irq disabled / hardirq context.
> We can't even cond_resched() here. In fact since _FORCE is larger, it will be
> even worse. Consider a real-time system with a lot of memory, in this case
> letting ->head grow large is Ok, but looping for long time in IRQ disabled
> would not be Ok.
> 
> But I could make it something like:
> 1. Letting ->head grow if ->head_free busy
> 2. If head_free is busy, then just queue/requeue the monitor to try again.
> 
> This would even improve performance, but will still risk going out of memory.

It seems I can indeed hit an out of memory condition once I changed it to
"letting list grow" (diff is below which applies on top of this patch) while
at the same time removing the schedule_timeout(2) and replacing it with
cond_resched() in the rcuperf test.  I think the reason is the rcuperf test
starves the worker threads that are executing in workqueue context after a
grace period and those are unable to get enough CPU time to kfree things fast
enough. But I am not fully sure about it and need to test/trace more to
figure out why this is happening.

If I add back the schedule_uninterruptibe_timeout(2) call, the out of memory
situation goes away.

Clearly we need to do more work on this patch.

In the regular kfree_rcu_no_batch() case, I don't hit this issue. I believe
that since the kfree is happening in softirq context in the _no_batch() case,
it fares better. The question then I guess is how do we run the rcu_work in a
higher priority context so it is not starved and runs often enough. I'll
trace more.

Perhaps I can also lower the priority of the rcuperf threads to give the
worker thread some more room to run and see if anything changes. But I am not
sure then if we're preparing the code for the real world with such
modifications.

Any thoughts?

thanks,

 - Joel

---8<-----------------------

From 098d62e5a1b84a11139236c9b1f59e7f32289b40 Mon Sep 17 00:00:00 2001
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Thu, 8 Aug 2019 16:29:58 -0400
Subject: [PATCH] Let list grow

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuperf.c |  2 +-
 kernel/rcu/tree.c    | 52 +++++++++++++++++++-------------------------
 2 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 34658760da5e..7dc831db89ae 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -654,7 +654,7 @@ kfree_perf_thread(void *arg)
 			}
 		}
 
-		schedule_timeout_uninterruptible(2);
+		cond_resched();
 	} while (!torture_must_stop() && ++l < kfree_loops);
 
 	kfree(alloc_ptrs);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bdbd483606ce..bab77220d8ac 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2595,7 +2595,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 
 /* Maximum number of jiffies to wait before draining batch */
-#define KFREE_DRAIN_JIFFIES 50
+#define KFREE_DRAIN_JIFFIES (HZ / 20)
 
 /*
  * Maximum number of kfree(s) to batch, if limit is hit
@@ -2684,27 +2684,19 @@ static void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krc,
 {
 	struct rcu_head *head, *next;
 
-	/* It is time to do bulk reclaim after grace period */
-	krc->monitor_todo = false;
+	/* It is time to do bulk reclaim after grace period. */
 	if (queue_kfree_rcu_work(krc)) {
 		spin_unlock_irqrestore(&krc->lock, flags);
 		return;
 	}
 
-	/*
-	 * Use non-batch regular call_rcu for kfree_rcu in case things are too
-	 * busy and batching of kfree_rcu could not be used.
-	 */
-	head = krc->head;
-	krc->head = NULL;
-	krc->kfree_batch_len = 0;
-	spin_unlock_irqrestore(&krc->lock, flags);
-
-	for (; head; head = next) {
-		next = head->next;
-		head->next = NULL;
-		__call_rcu(head, head->func, -1, 1);
+	/* Previous batch did not get free yet, let us try again soon. */
+	if (krc->monitor_todo == false) {
+		schedule_delayed_work_on(smp_processor_id(),
+				&krc->monitor_work,  KFREE_DRAIN_JIFFIES/4);
+		krc->monitor_todo = true;
 	}
+	spin_unlock_irqrestore(&krc->lock, flags);
 }
 
 /*
-- 
2.23.0.rc1.153.gdeed80330f-goog

