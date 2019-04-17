Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3618FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDB206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kSu1jmql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbfDQN6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:58:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57662 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQN6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7jrL6lodRd2tckoibj5XcymQR7hqhog8uNUUZYt63g8=; b=kSu1jmqlOZvccWGxZIk1vCHId
        EtaWdONgoVTDNTreOK+aW6mSP99GHypSuWDdbfsP+5KoZuAdV3gpbAHaOCHvSoycKHg7lei9bDaz7
        tHz0Vjql7l6PWIAcKAQGQHB+aiFN6ZNo1wKIq6D6Wme/0LFQ9G8t15+s4cBMip3G4WkA7svlaNyFQ
        Uhczn6M8GlqVLn/6Mr5ylEvY1IKHXEMMLh/+BWYPt9qMroEc8L2pk2BuZKgkm1Pecl/ROvWKww7cB
        wRieRqMM3GtVv/WJrcyVYacTydeneCnE2KMtYC3HtujD3pyjyktbNVtkWdywi9e9Jih9GTbukUNEF
        mnbXdqCgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGl5H-0003SP-5l; Wed, 17 Apr 2019 13:58:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E058629B5292C; Wed, 17 Apr 2019 15:58:41 +0200 (CEST)
Date:   Wed, 17 Apr 2019 15:58:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 11/16] locking/rwsem: Enable readers spinning on writer
Message-ID: <20190417135841.GI4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-12-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-12-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:54PM -0400, Waiman Long wrote:
> +/*
> + * Try to acquire read lock before the reader is put on wait queue.
> + * Lock acquisition isn't allowed if the rwsem is locked or a writer handoff
> + * is ongoing.
> + */
> +static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
> +{
> +	long count = atomic_long_read(&sem->count);
> +
> +	if (RWSEM_COUNT_WLOCKED_OR_HANDOFF(count))
> +		return false;
> +
> +	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
> +	if (!RWSEM_COUNT_WLOCKED_OR_HANDOFF(count)) {
> +		rwsem_set_reader_owned(sem);
> +		lockevent_inc(rwsem_opt_rlock);
> +		return true;
> +	}
> +
> +	/* Back out the change */
> +	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> +	return false;
> +}

Doesn't a cmpxchg 'loop' make more sense here?
