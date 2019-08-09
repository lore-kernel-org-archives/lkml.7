Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78275C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EFA208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UiDW//jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436745AbfHIPj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:39:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33708 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436687AbfHIPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:39:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so46258466pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BWGiOMo6Oo+hB+6Iqb/+xexv7iVbAnlBrvAjyVUrnGU=;
        b=UiDW//jfXDbHnMeP/t661vQybdTVh1f0WdabueMcgF7vjn5qW7cTxVBRLNWm5Bzfb5
         kVfWGccBIQESBP72iCU2FIuZK2LVU6/kezBpWaIRpUJTqKacCYrzDfXv0ghuItToJIM8
         3TQ9GmA9ufThdnSTzJegdrPD7S2m/heaMLMTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BWGiOMo6Oo+hB+6Iqb/+xexv7iVbAnlBrvAjyVUrnGU=;
        b=SQHMkVPXhWwSuluoe7ISqeQXsCIFAaBj/l2cE1Frbg3V5lD+e6YjYdyuCMCAzfGmFA
         /KfG3Eik9GPS1hxLH7eBiq+xZmejUsSe78J9rQxbSpZqcgEmQMkRtocAlsp0kTMLDHXR
         YIo9BWolccyo7rTOUYs7IaXfMgvJGAu2mesXCni7ucL03LF5FrSxDC6UXvmkTfOepivv
         xIkW5rwFjaMeinYQq+fxvWWerrGIvA0oDvzuPkztcG1oR4P9i0sBGIWTlGaFGX5Rdg+9
         R7nGMol73BoRc/uda8UodwI+bpGtV9S4eLh7FiDFRbKKgkaD7K5FKxQNu/v+ZDukh/Fx
         lekw==
X-Gm-Message-State: APjAAAWIYkkbNA6WIcQFvJUbiRmDBpsyKYOPuDISDh39bUd8ie2let9S
        KmMZoYBmpBE/t9tB4DustdOuog==
X-Google-Smtp-Source: APXvYqwj9Bm+IjBq8TcyQqfE2kIQOdUWE291Fs+ja+1kXJLI/Tjc+w+spg+xCKdFEcPlR52Rd+ZHSA==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr10084347pjn.134.1565365166702;
        Fri, 09 Aug 2019 08:39:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p2sm139275661pfb.118.2019.08.09.08.39.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 08:39:25 -0700 (PDT)
Date:   Fri, 9 Aug 2019 11:39:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190809153924.GB211412@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809151619.GD28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 08:16:19AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 08, 2019 at 07:30:14PM -0400, Joel Fernandes wrote:
[snip]
> > > But I could make it something like:
> > > 1. Letting ->head grow if ->head_free busy
> > > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > > 
> > > This would even improve performance, but will still risk going out of memory.
> > 
> > It seems I can indeed hit an out of memory condition once I changed it to
> > "letting list grow" (diff is below which applies on top of this patch) while
> > at the same time removing the schedule_timeout(2) and replacing it with
> > cond_resched() in the rcuperf test.  I think the reason is the rcuperf test
> > starves the worker threads that are executing in workqueue context after a
> > grace period and those are unable to get enough CPU time to kfree things fast
> > enough. But I am not fully sure about it and need to test/trace more to
> > figure out why this is happening.
> > 
> > If I add back the schedule_uninterruptibe_timeout(2) call, the out of memory
> > situation goes away.
> > 
> > Clearly we need to do more work on this patch.
> > 
> > In the regular kfree_rcu_no_batch() case, I don't hit this issue. I believe
> > that since the kfree is happening in softirq context in the _no_batch() case,
> > it fares better. The question then I guess is how do we run the rcu_work in a
> > higher priority context so it is not starved and runs often enough. I'll
> > trace more.
> > 
> > Perhaps I can also lower the priority of the rcuperf threads to give the
> > worker thread some more room to run and see if anything changes. But I am not
> > sure then if we're preparing the code for the real world with such
> > modifications.
> > 
> > Any thoughts?
> 
> Several!  With luck, perhaps some are useful.  ;-)
> 
> o	Increase the memory via kvm.sh "--memory 1G" or more.  The
> 	default is "--memory 500M".

Thanks, this definitely helped.

> o	Leave a CPU free to run things like the RCU grace-period kthread.
> 	You might also need to bind that kthread to that CPU.
> 
> o	Alternatively, use the "rcutree.kthread_prio=" boot parameter to
> 	boost the RCU kthreads to real-time priority.  This won't do
> 	anything for ksoftirqd, though.

I will try these as well.

> 
> o	Along with the above boot parameter, use "rcutree.use_softirq=0"
> 	to cause RCU to use kthreads instead of softirq.  (You might well
> 	find issues in priority setting as well, but might as well find
> 	them now if so!)

Doesn't think one actually reduce the priority of the core RCU work? softirq
will always have higher priority than any there. So wouldn't that have the
effect of not reclaiming things fast enough? (Or, in my case not scheduling
the rcu_work which does the reclaim).

> o	With any of the above, invoke rcu_momentary_dyntick_idle() along
> 	with cond_resched() in your kfree_rcu() loop.  This simulates
> 	a trip to userspace for nohz_full CPUs, so if this helps for
> 	non-nohz_full CPUs, adjustments to the kernel might be called for.

Ok, will try it.

Save these bullet points for future reference! ;-)  thanks,

 - Joel


> 
> Probably others, but this should do for a start.
> 
> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > ---8<-----------------------
> > 
> > >From 098d62e5a1b84a11139236c9b1f59e7f32289b40 Mon Sep 17 00:00:00 2001
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Date: Thu, 8 Aug 2019 16:29:58 -0400
> > Subject: [PATCH] Let list grow
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/rcuperf.c |  2 +-
> >  kernel/rcu/tree.c    | 52 +++++++++++++++++++-------------------------
> >  2 files changed, 23 insertions(+), 31 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index 34658760da5e..7dc831db89ae 100644
> > --- a/kernel/rcu/rcuperf.c
> > +++ b/kernel/rcu/rcuperf.c
> > @@ -654,7 +654,7 @@ kfree_perf_thread(void *arg)
> >  			}
> >  		}
> >  
> > -		schedule_timeout_uninterruptible(2);
> > +		cond_resched();
> >  	} while (!torture_must_stop() && ++l < kfree_loops);
> >  
> >  	kfree(alloc_ptrs);
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index bdbd483606ce..bab77220d8ac 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2595,7 +2595,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
> >  
> >  
> >  /* Maximum number of jiffies to wait before draining batch */
> > -#define KFREE_DRAIN_JIFFIES 50
> > +#define KFREE_DRAIN_JIFFIES (HZ / 20)
> >  
> >  /*
> >   * Maximum number of kfree(s) to batch, if limit is hit
> > @@ -2684,27 +2684,19 @@ static void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krc,
> >  {
> >  	struct rcu_head *head, *next;
> >  
> > -	/* It is time to do bulk reclaim after grace period */
> > -	krc->monitor_todo = false;
> > +	/* It is time to do bulk reclaim after grace period. */
> >  	if (queue_kfree_rcu_work(krc)) {
> >  		spin_unlock_irqrestore(&krc->lock, flags);
> >  		return;
> >  	}
> >  
> > -	/*
> > -	 * Use non-batch regular call_rcu for kfree_rcu in case things are too
> > -	 * busy and batching of kfree_rcu could not be used.
> > -	 */
> > -	head = krc->head;
> > -	krc->head = NULL;
> > -	krc->kfree_batch_len = 0;
> > -	spin_unlock_irqrestore(&krc->lock, flags);
> > -
> > -	for (; head; head = next) {
> > -		next = head->next;
> > -		head->next = NULL;
> > -		__call_rcu(head, head->func, -1, 1);
> > +	/* Previous batch did not get free yet, let us try again soon. */
> > +	if (krc->monitor_todo == false) {
> > +		schedule_delayed_work_on(smp_processor_id(),
> > +				&krc->monitor_work,  KFREE_DRAIN_JIFFIES/4);
> > +		krc->monitor_todo = true;
> >  	}
> > +	spin_unlock_irqrestore(&krc->lock, flags);
> >  }
> >  
> >  /*
> > -- 
> > 2.23.0.rc1.153.gdeed80330f-goog
> > 
> 
