Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD2ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB68D2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PWct1W3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfJNM7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:59:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56724 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfJNM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nYZzMOWo5U02mAyXOr7p02iwmu148eoTzwjxG/FDO3s=; b=PWct1W3w0TghcRBnhM90SUTun
        v3LagxB7rjb9DCB5iJr71NmQb9YShqHhpXni4vTOG3tcpPnuljX8dH913o6ElAWUsQnzJU0xcZufy
        F1n+2Yi4Gak23LPEXSAJ8rNQLZPv0bYLy7qbBX7ruSNTnxAPNU+GPaIBWrF5LoLgJat/7gVlQ/+Af
        7eWkzirnCFtdMz7qEkcr7szuOuSmemDcjJyQkg7n+3DRwZk/wcBiqNHvO+4V0RAyQ9a1wx3BmTAs9
        3FrIxy+pz0yyJkmJ/BEielsCttbVqJ+rANwNq+sya0nugJb53uADqt71wrtm61ogl0TcVc1ggCNpR
        E0ADpQ6Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJzwQ-0000Ua-Qj; Mon, 14 Oct 2019 12:59:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CE00305E42;
        Mon, 14 Oct 2019 14:58:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE6A82829A4C8; Mon, 14 Oct 2019 14:59:11 +0200 (CEST)
Date:   Mon, 14 Oct 2019 14:59:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/6] ipc/mqueue.c: Update/document memory barriers
Message-ID: <20191014125911.GF2328@hirez.programming.kicks-ass.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-4-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012054958.3624-4-manfred@colorfullife.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 07:49:55AM +0200, Manfred Spraul wrote:

>  	for (;;) {
> +		/* memory barrier not required, we hold info->lock */
>  		__set_current_state(TASK_INTERRUPTIBLE);
>  
>  		spin_unlock(&info->lock);
>  		time = schedule_hrtimeout_range_clock(timeout, 0,
>  			HRTIMER_MODE_ABS, CLOCK_REALTIME);
>  
> +		if (READ_ONCE(ewp->state) == STATE_READY) {
> +			/*
> +			 * Pairs, together with READ_ONCE(), with
> +			 * the barrier in __pipelined_op().
> +			 */
> +			smp_acquire__after_ctrl_dep();
>  			retval = 0;
>  			goto out;
>  		}
>  		spin_lock(&info->lock);
> +
> +		/* we hold info->lock, so no memory barrier required */
> +		if (READ_ONCE(ewp->state) == STATE_READY) {
>  			retval = 0;
>  			goto out_unlock;
>  		}
> @@ -925,14 +933,12 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
>  	list_del(&this->list);
>  	wake_q_add(wake_q, this->task);
>  	/*
> +	 * The barrier is required to ensure that the refcount increase
> +	 * inside wake_q_add() is completed before the state is updated.

fails to explain *why* this is important.

> +	 *
> +	 * The barrier pairs with READ_ONCE()+smp_mb__after_ctrl_dep().
>  	 */
> +        smp_store_release(&this->state, STATE_READY);

You retained the whitespace damage.

And I'm terribly confused by this code, probably due to the lack of
'why' as per the above. What is this trying to do?

Are we worried about something like:

	A			B				C


				wq_sleep()
				  schedule_...();

								/* spuriuos wakeup */
								wake_up_process(B)

	wake_q_add(A)
	  if (cmpxchg()) // success

	->state = STATE_READY (reordered)

				  if (READ_ONCE() == STATE_READY)
				    goto out;

				exit();


	    get_task_struct() // UaF


Can we put the exact and full race in the comment please?
