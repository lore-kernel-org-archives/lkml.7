Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E927CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7367A206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNkB25Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437818AbfJYIKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:10:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35634 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437404AbfJYIKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Sc47oM8963qpiXK5I7HTH3chzXQNmOfoNk1YmTZRUA=; b=DNkB25ZdI237ISuoSpzbiyMJX
        kzgXrCVKjcOAlRuqiwHbmyEQYY3gQ1wGpVApWN15N06kEQnRnnAD7g8uIkmB17+VAD8HnM0n107S8
        Lp0fGAfUpK4blN+BJM3WfT/d64+hKo4NmaRE5kDGTwcN+lDKFBV+ITTWCw3xVrxhzZhSS5c6GxAB/
        U7hG8wi23LfzwNnudOfHNzqWsRXVyBCXOBueGJw6TzsoL3mT39Kx5eEHkn+B62XHAHlYlSKNobmoX
        67RCA2wo+oWKu+6I7YTrvIY9Qxw8Wu1vwkc0uBbUc3SLaek6piFS7PoHIUPuo1ZxoTBjNGXYf4asE
        BCajCheyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNugB-0001Ql-R4; Fri, 25 Oct 2019 08:10:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 404503006E3;
        Fri, 25 Oct 2019 10:09:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 178B5201A6624; Fri, 25 Oct 2019 10:10:37 +0200 (CEST)
Date:   Fri, 25 Oct 2019 10:10:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -tip] locking/mutex: Complain upon api misuse wrt
 interrupt context
Message-ID: <20191025081037.GF4131@hirez.programming.kicks-ass.net>
References: <20191025033634.3330-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025033634.3330-1-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 08:36:34PM -0700, Davidlohr Bueso wrote:
> Sprinkle warning checks, under CONFIG_DEBUG_MUTEXES. While the mutex
> rules and semantics are explicitly documented, this allows to expose
> any abusers and robustifies the whole thing. While trylock and unlock
> are non-blocking, calling from irq context is still forbidden (lock
> must be within the same context as unlock).
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  kernel/locking/mutex.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 468a9b8422e3..7e9c316c646c 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -733,6 +733,9 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>   */
>  void __sched mutex_unlock(struct mutex *lock)
>  {
> +#ifdef CONFIG_DEBUG_MUTEXES
> +	WARN_ON(in_interrupt());
> +#endif
>  #ifndef CONFIG_DEBUG_LOCK_ALLOC
>  	if (__mutex_unlock_fast(lock))
>  		return;
> @@ -1413,6 +1416,7 @@ int __sched mutex_trylock(struct mutex *lock)
>  
>  #ifdef CONFIG_DEBUG_MUTEXES
>  	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
> +	WARN_ON(in_interrupt());
>  #endif
>  
>  	locked = __mutex_trylock(lock);


No real objection, but should not lockdep already complain about this?
__mutex_unlock_slowpath() takes ->wait_lock irq-unsafe, so then using it
from an IRQ should generate an insta IRQ inversion report.
