Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2A8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F072084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ku3w8EUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDJTix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:38:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Cz8inFBXRuwwoElODEl8UIYJKQqWhGMZTBjzPa6PN8=; b=Ku3w8EUPAsl61QfU8OfTndObS
        bCO+ILRk8NCzJsNE+SeGYBgECgWLb+tgFQfhWSmFtFeFM+ptfToDF/aefDMBwx+hCXRzM7iZyEoEz
        GUPMHWHyWICQo/gi//9T6DhsUznbSLH9R/DQWnF8anSGrLEz3tfjN/r8muz+tJTeqSUZa0myCPvq9
        uW7U9HBjAVZqQWTJqm5uwFhaKClCCCKpDQ8pcueIwqW7uCRrjENBqiQWyHKEGd0oysHOUAo0f96wn
        XqJDcJZjAZVv3Fff+q4JVWygkSM4HvKZtw4XRUmO95iSp9rlExyO7iMfihFV7q43Elma7esKF7GqN
        PI2ZuFjhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEJ3W-0001OE-Fm; Wed, 10 Apr 2019 19:38:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBEB129AAAAA0; Wed, 10 Apr 2019 21:38:44 +0200 (CEST)
Date:   Wed, 10 Apr 2019 21:38:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 04/14] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190410193844.GY4038@hirez.programming.kicks-ass.net>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410184231.6748-5-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hurph, I was still looking at v2.. I suppose I'll go stare at this
verison, I don't think you said there were many changes, right?

This version seems to still suffer that HANDOFF issue I found on v2.

On Wed, Apr 10, 2019 at 02:42:21PM -0400, Waiman Long wrote:
> Because of writer lock stealing, it is possible that a constant
> stream of incoming writers will cause a waiting writer or reader to
> wait indefinitely leading to lock starvation.
> 
> The mutex code has a lock handoff mechanism to prevent lock starvation.
> This patch implements a similar lock handoff mechanism to disable
> lock stealing and force lock handoff to the first waiter in the queue
> after at least a 4ms waiting period unless it is a RT writer task which
> doesn't need to wait. The waiting period is used to avoid discouraging
> lock stealing too much to affect performance.
> 
> A rwsem microbenchmark was run for 5 seconds on a 2-socket 40-core
> 80-thread Skylake system with a v5.1 based kernel and 240 write_lock
> threads with 5us sleep critical section.
> 
> Before the patch, the min/mean/max numbers of locking operations for
> the locking threads were 1/7,792/173,696. After the patch, the figures
> became 5,842/6,542/7,458.  It can be seen that the rwsem became much
> more fair, though there was a drop of about 16% in the mean locking
> operations done which was a tradeoff of having better fairness.
> 
> Making the waiter set the handoff bit right after the first wakeup can

What does 'right after the first wakeup' mean? If that the top-waiter
setting it if it fails to acquire the lock due to steals?

> impact performance especially with a mixed reader/writer workload. With
> the same microbenchmark with short critical section and equal number of
> reader and writer threads (40/40), the reader/writer locking operation
> counts with the current patch were:
> 
>   40 readers, Iterations Min/Mean/Max = 1,793/1,794/1,796
>   40 writers, Iterations Min/Mean/Max = 1,793/34,956/86,081
> 
> By making waiter set handoff bit immediately after wakeup:
> 
>   40 readers, Iterations Min/Mean/Max = 43/44/46
>   40 writers, Iterations Min/Mean/Max = 43/1,263/3,191


