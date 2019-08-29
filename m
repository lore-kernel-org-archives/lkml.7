Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A204C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B802189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CpRKjFU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfH2V0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:26:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44746 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfH2V0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:26:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so2176895plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ne4fb8rmErhHKddOiLagesqEGyy4GKWd57VmqftMrAE=;
        b=CpRKjFU+Fp6R1GVUINYMequFSM8Um8fr63tWRRakTxcQeRjOKG+6RgenSV1JtTqFSi
         psUdRAuIwx3v6J81J+lebdE1PygjlyCctXwOKYkgTy4+5QA/vDvajnNKsnUzqB1+6PBj
         3OJBGVir/Qu5aDjQFmrL4T/sYuHevyWXWwFaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ne4fb8rmErhHKddOiLagesqEGyy4GKWd57VmqftMrAE=;
        b=G5uhkgCeOg35oVxKWVRadFRgLno08+8Zjyq+yVGEoRlzyZQAuVRJFV5NH0mQIXlQGI
         rSGE8VPkbugIwlL6xfUxmS0sRZPBKebWYdtkGmnKVC7geHBzJuhwe16dzBZVcy5n44J2
         FUMwpkFJJGIojWiJdlhw7Cui6kKwg5Kmrdoo1ylHkTYzZLHvwnttm99CqNbbk80DO8dk
         EDBjQWvwxMwwNcdR/IAbtE6CDA5en7o04h6oBoxQtS4DI/XDqBbCOhTGW7tmeVlBiA7k
         qAfS77G1/yd4XibfSKdTEgDQaShtCbXjd/m5L2DT3R/OxaxrUMyZ/bVzvARYUWtLL6dh
         GUUw==
X-Gm-Message-State: APjAAAUr6Oh/O2FsZVA+4rZkaDO2JSUVzYudvHwdMwTYubmfCFDoLEC8
        N9+MDboYGgl15HFLlj/+XmkxYw==
X-Google-Smtp-Source: APXvYqzyTJnwYTYKxMPRtDoPHgvzWEYG7ODL1oxifcC9iUay2BnI9eqzjbyA2iG+svfoAf+aQpNifw==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr12143591plm.306.1567113979260;
        Thu, 29 Aug 2019 14:26:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m4sm3178732pgs.71.2019.08.29.14.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 14:26:18 -0700 (PDT)
Date:   Thu, 29 Aug 2019 17:26:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/tree: Add multiple in-flight batches of kfree_rcu
 work
Message-ID: <20190829212617.GA183862@google.com>
References: <5d657e35.1c69fb81.54250.01de@mx.google.com>
 <20190828140952.258739-1-joel@joelfernandes.org>
 <20190828204521.GU26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828204521.GU26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:45:21PM -0700, Paul E. McKenney wrote:
> On Wed, Aug 28, 2019 at 10:09:52AM -0400, Joel Fernandes (Google) wrote:
> > During testing, it was observed that amount of memory consumed due
> > kfree_rcu() batching is 300-400MB. Previously we had only a single
> > head_free pointer pointing to the list of rcu_head(s) that are to be
> > freed after a grace period. Until this list is drained, we cannot queue
> > any more objects on it since such objects may not be ready to be
> > reclaimed when the worker thread eventually gets to drainin g the
> > head_free list.
> > 
> > We can do better by maintaining multiple lists as done by this patch.
> > Testing shows that memory consumption came down by around 100-150MB with
> > just adding another list. Adding more than 1 additional list did not
> > show any improvement.
[snip]
> > @@ -2730,12 +2739,14 @@ static void kfree_rcu_work(struct work_struct *work)
> >  {
> >  	unsigned long flags;
> >  	struct rcu_head *head, *next;
> > -	struct kfree_rcu_cpu *krcp = container_of(to_rcu_work(work),
> > -					struct kfree_rcu_cpu, rcu_work);
> > +	struct kfree_rcu_work *krwp = container_of(to_rcu_work(work),
> > +					struct kfree_rcu_work, rcu_work);
> > +	struct kfree_rcu_cpu *krcp;
> > +
> > +	krcp = krwp->krcp;
> >  
> >  	spin_lock_irqsave(&krcp->lock, flags);
> > -	head = krcp->head_free;
> > -	krcp->head_free = NULL;
> > +	head = xchg(&krwp->head_free, NULL);
> 
> Given that we hold the lock, why the xchg()?  Alternatively, why not
> just acquire the lock in the other places you use xchg()?  This is a
> per-CPU lock, so contention should not be a problem, should it?

I realized I was being silly :(. Was trying to reduce lines of code and hence
implemented it like that as a one-liner. Locking protocol is not needed or
intended for that xchg since as pointed, a lock is held.

> >  	spin_unlock_irqrestore(&krcp->lock, flags);
> >  
> >  	/*
> > @@ -2758,19 +2769,28 @@ static void kfree_rcu_work(struct work_struct *work)
> >   */
> >  static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
> >  {
> > +	int i = 0;
> > +	struct kfree_rcu_work *krwp = NULL;
> > +
> >  	lockdep_assert_held(&krcp->lock);
> > +	while (i < KFREE_N_BATCHES) {
> > +		if (!krcp->krw_arr[i].head_free) {
> > +			krwp = &(krcp->krw_arr[i]);
> > +			break;
> > +		}
> > +		i++;
> > +	}
> >  
> > -	/* If a previous RCU batch work is already in progress, we cannot queue
> > +	/* If both RCU batches are already in progress, we cannot queue
> >  	 * another one, just refuse the optimization and it will be retried
> >  	 * again in KFREE_DRAIN_JIFFIES time.
> >  	 */
> 
> If you are going to remove the traditional first "/*" line of a comment,
> why not go all the way and cut the last one as well?  "//".

Will add the /* in the beginning :)

> > -	if (krcp->head_free)
> > +	if (!krwp)
> >  		return false;
> >  
> > -	krcp->head_free = krcp->head;
> > -	krcp->head = NULL;
> > -	INIT_RCU_WORK(&krcp->rcu_work, kfree_rcu_work);
> > -	queue_rcu_work(system_wq, &krcp->rcu_work);
> > +	krwp->head_free = xchg(&krcp->head, NULL);
> 
> This isn't anywhere near a fastpath, so just acquiring the lock is a
> better choice here.

My reasoning was same as above. Will change it to 2 statements since lock is
already held.

> > +	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
> > +	queue_rcu_work(system_wq, &krwp->rcu_work);
> >  
> >  	return true;
> >  }
> > @@ -3736,8 +3756,11 @@ static void __init kfree_rcu_batch_init(void)
> >  
> >  	for_each_possible_cpu(cpu) {
> >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > +		int i = KFREE_N_BATCHES;
> >  
> >  		spin_lock_init(&krcp->lock);
> > +		while (i--)
> > +			krcp->krw_arr[i].krcp = krcp;
> 
> This was indeed a nice trick back in the PDP-11 days of 64-kilobyte
> address spaces, so thank you for the nostalgia!  However, a straight-up
> "for" loop is less vulnerable to code being added between the declaration
> of "i" and the "while" loop.

Ok, will do.

thanks,

 - Joel

