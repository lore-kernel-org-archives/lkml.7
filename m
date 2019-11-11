Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2694C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E94820656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G/OViZ4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKKInX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:43:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38664 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JKUgKa4/tYZ5hy2UGhQDHfIOpvhouvpwaZLjFqGg0Ug=; b=G/OViZ4LiDH8h/OMfuFNvpw6/
        cM7wQa4JEqZfAxwMx0nLTpP5x91UCwg1v1Op1usxRfS2VwGgwkZk9dxEXRnxsZeu6H4mvrOK/e955
        QSIhJZx3PxptyoxokUS1u736WYO8Z5j/IGRaXD+rqzZaWL8nfrcXlw58jikMWET1mkzaAWiGf6oRI
        /6oEY9BweCwUg+Hc9sA+G2NqPWkwp7IV4TnuFIJVtj5WLFKztzxQC1jX3FARyPCdq1xp7bWBMXxcs
        sKoZuny2xYQG5plYtOuCPNSN+/NUmkaQZehyEBnQcp5YeEaot8I+EGdZCwkerY2h6Twmsxugwie9C
        wpbKr/w9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iU5I5-00036r-G7; Mon, 11 Nov 2019 08:43:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72D733056BE;
        Mon, 11 Nov 2019 09:42:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD36529A83A76; Mon, 11 Nov 2019 09:43:13 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:43:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/4] irq_work: Weaken ordering in irq_work_run_list()
Message-ID: <20191111084313.GN4131@hirez.programming.kicks-ass.net>
References: <20191108160858.31665-1-frederic@kernel.org>
 <20191108160858.31665-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108160858.31665-5-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 05:08:58PM +0100, Frederic Weisbecker wrote:

> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 49c53f80a13a..b709ab05cbfd 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -34,8 +34,8 @@ static bool irq_work_claim(struct irq_work *work)
>  	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);
>  	/*
>  	 * If the work is already pending, no need to raise the IPI.
> +	 * The pairing atomic_andnot() followed by a barrier in irq_work_run()
> +	 * makes sure everything we did before is visible.
>  	 */
>  	if (oflags & IRQ_WORK_PENDING)
>  		return false;

> @@ -151,14 +151,16 @@ static void irq_work_run_list(struct llist_head *list)
>  		 * to claim that work don't rely on us to handle their data
>  		 * while we are in the middle of the func.
>  		 */
> -		flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
> +		atomic_andnot(IRQ_WORK_PENDING, &work->flags);
> +		smp_mb__after_atomic();

I think I'm prefering you use:

		flags = atomic_fetch_andnot_acquire(IRQ_WORK_PENDING, &work->flags);

Also, I'm cursing at myself for the horrible comments here.

>  		work->func(work);
>  		/*
>  		 * Clear the BUSY bit and return to the free state if
>  		 * no-one else claimed it meanwhile.
>  		 */
> -		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
> +		(void)atomic_cmpxchg(&work->flags, flags & ~IRQ_WORK_PENDING,
> +				     flags & ~IRQ_WORK_CLAIMED);
>  	}
>  }
>  
> -- 
> 2.23.0
> 
