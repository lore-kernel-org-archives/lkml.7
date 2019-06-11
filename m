Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5BEC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B1A212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fjO0Aztz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403793AbfFKNOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:14:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389077AbfFKNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jTRI0sUYzBjbqkRPqRB0al8MVf/JfGUcO0S+nPEvatk=; b=fjO0Aztzc+pyUxCYwqc+vs43g
        9rPrhQ89XcSL3p7dXSABlmjWx7puSS4lkAmMVaplO0j2zgrha07weiRGAOnNiH4sluZMkFByC89cT
        LVHVO5l5L+nBxAAoniGrGKXUg0RI4nqSYvhzyAoAxKhnqrRColkp+6H3Vxg0PofvzPGrVC63WfHwB
        zEB/Tap8Zqbj83rqp0AsFFhxvS1ktdmWqnJVgjXJwW7f0NMi4wNIEdL78HQoVh7JMay8mWT9g1F4c
        IxMwx6CjmDCi145Ibou4gy/hnkENzBj1sO++rdlsCPrzgi8yMOVET0efIptnELmP6tB1nqHDbFJ7U
        /ekJrFNtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hagbA-0004VQ-K7; Tue, 11 Jun 2019 13:14:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23DE520234FA4; Tue, 11 Jun 2019 15:13:59 +0200 (CEST)
Date:   Tue, 11 Jun 2019 15:13:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 16/19] locking/rwsem: Guard against making count
 negative
Message-ID: <20190611131359.GH3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-17-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205918.22251-17-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:15PM -0400, Waiman Long wrote:
>  static struct rw_semaphore __sched *
> +rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long adjustment)
>  {
> +	long count;
>  	bool wake = false;
>  	struct rwsem_waiter waiter;
>  	DEFINE_WAKE_Q(wake_q);
>  
> +	if (unlikely(!adjustment)) {
> +		/*
> +		 * This shouldn't happen. If it does, there is probably
> +		 * something wrong in the system.
> +		 */
> +		WARN_ON_ONCE(1);

	if (WARN_ON_ONCE(!adjustment)) {

> +
> +		/*
> +		 * An adjustment of 0 means that there are too many readers
> +		 * holding or trying to acquire the lock. So disable
> +		 * optimistic spinning and go directly into the wait list.
> +		 */
> +		if (rwsem_test_oflags(sem, RWSEM_RD_NONSPINNABLE))
> +			rwsem_set_nonspinnable(sem);

ISTR rwsem_set_nonspinnable() already does that test, so no need to do
it again, right?

> +		goto queue;
> +	}
> +
>  	/*
>  	 * Save the current read-owner of rwsem, if available, and the
>  	 * reader nonspinnable bit.
