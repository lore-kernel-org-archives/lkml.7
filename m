Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D8C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5269A2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HKI8cWtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbfJNN6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:58:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbfJNN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kgs9bqvyVpw9soHAyFCmszbV5/zLcW17e2OOtQJqQmM=; b=HKI8cWtHi2xlWWe7fAXFD6PgA
        it7YGMapylf8PQSv2dYPBczatiaiWqqimUwWlXuKaqxxLGS1DYd7ZryMM08Qg1DYSrspH8uFIIqCz
        bpaieuWKuOSqdFFJ/NHVWlG5mnFesdN+in6LlNiFcQBtRoR7+ZJ1btIImW8p1xOSqtb+duv0K445h
        ht7BZ3Nf6hN0Zvu6A65QoWeLJ64chu6SDJjnfE6ZPbHaBlTyP7mh4MVJMbTxAGyzFEOlTHVa7VY4E
        6uVZR8ATVeV3uyMvJ1so34kdhmgi57F+fu3aXvspB1oM+RaR8Yaa4m8i33prmWK+57050oOgw7GD7
        Bqgl7UD0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK0rq-0003L6-Or; Mon, 14 Oct 2019 13:58:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AACB6300F3F;
        Mon, 14 Oct 2019 15:57:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B438B284DE584; Mon, 14 Oct 2019 15:58:32 +0200 (CEST)
Date:   Mon, 14 Oct 2019 15:58:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/6] ipc/mqueue.c: Update/document memory barriers
Message-ID: <20191014135832.GO2359@hirez.programming.kicks-ass.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-4-manfred@colorfullife.com>
 <20191014125911.GF2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014125911.GF2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 02:59:11PM +0200, Peter Zijlstra wrote:
> On Sat, Oct 12, 2019 at 07:49:55AM +0200, Manfred Spraul wrote:
> 
> >  	for (;;) {
> > +		/* memory barrier not required, we hold info->lock */
> >  		__set_current_state(TASK_INTERRUPTIBLE);
> >  
> >  		spin_unlock(&info->lock);
> >  		time = schedule_hrtimeout_range_clock(timeout, 0,
> >  			HRTIMER_MODE_ABS, CLOCK_REALTIME);
> >  
> > +		if (READ_ONCE(ewp->state) == STATE_READY) {
> > +			/*
> > +			 * Pairs, together with READ_ONCE(), with
> > +			 * the barrier in __pipelined_op().
> > +			 */
> > +			smp_acquire__after_ctrl_dep();
> >  			retval = 0;
> >  			goto out;
> >  		}
> >  		spin_lock(&info->lock);
> > +
> > +		/* we hold info->lock, so no memory barrier required */
> > +		if (READ_ONCE(ewp->state) == STATE_READY) {
> >  			retval = 0;
> >  			goto out_unlock;
> >  		}
> > @@ -925,14 +933,12 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
> >  	list_del(&this->list);
> >  	wake_q_add(wake_q, this->task);
> >  	/*
> > +	 * The barrier is required to ensure that the refcount increase
> > +	 * inside wake_q_add() is completed before the state is updated.
> 
> fails to explain *why* this is important.
> 
> > +	 *
> > +	 * The barrier pairs with READ_ONCE()+smp_mb__after_ctrl_dep().
> >  	 */
> > +        smp_store_release(&this->state, STATE_READY);
> 
> You retained the whitespace damage.
> 
> And I'm terribly confused by this code, probably due to the lack of
> 'why' as per the above. What is this trying to do?
> 
> Are we worried about something like:
> 
> 	A			B				C
> 
> 
> 				wq_sleep()
> 				  schedule_...();
> 
> 								/* spuriuos wakeup */
> 								wake_up_process(B)
> 
> 	wake_q_add(A)
> 	  if (cmpxchg()) // success
> 
> 	->state = STATE_READY (reordered)
> 
> 				  if (READ_ONCE() == STATE_READY)
> 				    goto out;
> 
> 				exit();
> 
> 
> 	    get_task_struct() // UaF
> 
> 
> Can we put the exact and full race in the comment please?

Like Davidlohr already suggested, elsewhere we write it like so:


--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -930,15 +930,10 @@ static inline void __pipelined_op(struct
 				  struct mqueue_inode_info *info,
 				  struct ext_wait_queue *this)
 {
+	get_task_struct(this->task);
 	list_del(&this->list);
-	wake_q_add(wake_q, this->task);
-	/*
-	 * The barrier is required to ensure that the refcount increase
-	 * inside wake_q_add() is completed before the state is updated.
-	 *
-	 * The barrier pairs with READ_ONCE()+smp_mb__after_ctrl_dep().
-	 */
-        smp_store_release(&this->state, STATE_READY);
+	smp_store_release(&this->state, STATE_READY);
+	wake_q_add_safe(wake_q, this->task);
 }
 
 /* pipelined_send() - send a message directly to the task waiting in
