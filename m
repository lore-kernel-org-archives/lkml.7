Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADCB20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tcrTrP0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfDPQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:17:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=puOlvjKB3Y3WOVRPAmxyhbtthgJ+YL5qig7OLr+ohsc=; b=tcrTrP0P0B/fwDtHvJAtUjuQP
        IO9VA4Azju/qglP18WD9SwkBmbD56neNBCy7nemOs44hiCj81O+s6FlR14weA4/b+q58MK7gvlWHB
        cZ/ivhWMNJtye5FWk69DI6vOwfGga76FH+xNZ9WVtk2VzY2kESG4yCcRpjZzIYLsxZr4ZFt7q143K
        RML9YT4FAOGRUZbEOrsIPdm4dqRlo4zpS5LDOr7Q+cEI0u8sq4MDXvQa/jcYakFUr2IkAUjczkR4f
        2A1HLWsv/aoe7/YA062css1+8A4RpzgT0hWVufG5AObkOEzpMmC3Yrpzy/W8X0lAO3/xSbVCmqZTe
        O84Epel1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGQm0-0003q2-LD; Tue, 16 Apr 2019 16:17:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2776129AC1641; Tue, 16 Apr 2019 18:17:27 +0200 (CEST)
Date:   Tue, 16 Apr 2019 18:17:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 06/16] locking/rwsem: Code cleanup after files merging
Message-ID: <20190416161727.GS14281@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-7-longman@redhat.com>
 <20190416160113.GM12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416160113.GM12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 06:01:13PM +0200, Peter Zijlstra wrote:
> @@ -794,34 +770,38 @@ static inline int __down_read_trylock(st
>   */
>  static inline void __down_write(struct rw_semaphore *sem)
>  {
> -	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
> -						 RWSEM_WRITER_LOCKED)))
> -		rwsem_down_write_failed(sem);
> +	long tmp = RWSEM_UNLOCKED_VALUE;
> +
> +	if (unlikely(atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> +						     RWSEM_WRITER_LOCKED)))

!

> +		rwsem_down_write_slow(sem, TASK_UNINTERRUPTIBLE);
>  	rwsem_set_owner(sem);
>  }
>  
>  static inline int __down_write_killable(struct rw_semaphore *sem)
>  {
> -	if (unlikely(atomic_long_cmpxchg_acquire(&sem->count, 0,
> -						 RWSEM_WRITER_LOCKED)))
> -		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
> +	long tmp = RWSEM_UNLOCKED_VALUE;
> +
> +	if (unlikely(atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> +						     RWSEM_WRITER_LOCKED))) {

also !

> +		if (IS_ERR(rwsem_down_write_slow(sem, TASK_KILLABLE)))
>  			return -EINTR;
> +	}
>  	rwsem_set_owner(sem);
>  	return 0;
>  }

I'm having a great day it seems, it's like back in uni, trying to find
all the missing - signs in this page-long DE.
