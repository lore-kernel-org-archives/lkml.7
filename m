Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC86C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB082177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LGcZz8DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfDQNjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:39:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQNjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zv/MxQNlcnE/NTFtxq8iHLXcYTq6O6gWh9P8aV5JkY8=; b=LGcZz8DL9x/PYJoP4ZVgjh8Za
        kanp3v7Pak5hISnoBVBvZhqBo6bi0zxjYgIliuMgXlq/uGh9Yc4UiGoZkymq4/MDJXbXl07E9bnK2
        2HARlUHF94PaGp6KODmZLila3uESRL+I0diu0FfCKcAgHYeyrZWE2tbre/HWrRE2fXA9+HeaZn1z2
        6mdVKQOtuxD2G+eY8HQzMg0IPjnoKmPoPmT9aJIBe0w0LiXdeIx1/aV2mqOO4iI2atkV23f0h5bBL
        ZdAoBC7viKdwYHvQWrGE15jh7jAAWnveJ0Zq2vDo8RWxIi3/3zOfWEWSsqKo86afwOZ65peivcTHt
        S7/Nk6htQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGkmp-0003B7-8J; Wed, 17 Apr 2019 13:39:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 057B529B52926; Wed, 17 Apr 2019 15:39:38 +0200 (CEST)
Date:   Wed, 17 Apr 2019 15:39:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 10/16] locking/rwsem: Wake up almost all readers in
 wait queue
Message-ID: <20190417133937.GG4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-11-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-11-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:53PM -0400, Waiman Long wrote:
> When the front of the wait queue is a reader, other readers
> immediately following the first reader will also be woken up at the
> same time. However, if there is a writer in between. Those readers
> behind the writer will not be woken up.
> 
> Because of optimistic spinning, the lock acquisition order is not FIFO
> anyway. The lock handoff mechanism will ensure that lock starvation
> will not happen.
> 
> Assuming that the lock hold times of the other readers still in the
> queue will be about the same as the readers that are being woken up,
> there is really not much additional cost other than the additional
> latency due to the wakeup of additional tasks by the waker. Therefore
> all the readers up to a maximum of 256 in the queue are woken up when
> the first waiter is a reader to improve reader throughput.
> 
> With a locking microbenchmark running on 5.1 based kernel, the total
> locking rates (in kops/s) on a 8-socket IvyBridge-EX system with
> equal numbers of readers and writers before and after this patch were
> as follows:
> 
>    # of Threads  Pre-Patch   Post-patch
>    ------------  ---------   ----------
>         4          1,641        1,674
>         8            731        1,062
>        16            564          924
>        32             78          300
>        64             38          195
>       240             50          149
> 
> There is no performance gain at low contention level. At high contention
> level, however, this patch gives a pretty decent performance boost.

Right, so this basically completes the convertion from task-fair (FIFO)
to phase-fair.

https://cs.unc.edu/~anderson/papers/rtsj10-for-web.pdf
