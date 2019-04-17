Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C40B206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VKrAuPHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfDQNS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:18:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57302 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQNS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fdyer6bfSm2SazDbbCKmrCzq19V6BKZwEybJOXAoor0=; b=VKrAuPHI8lbrwzhHRHu/aB7g4
        eIbJkJyaZpVhBKgp6K17Zlcjm+jTf5UvCwvGBHGmgZq3z/dkBRFgP5MRobo37UQ146kLCPDtKb9Sc
        F0OnsWxu30YienrGvw/UMHJPsXGRkmexT1sk9LsarUEpOQmD8D4IPDBp3p+SDA7nouXLHOBZXZiMf
        WIZ6EmHK2ilwf9RLXpZPRaS2LFFU7ij/HHDwgJ9eD9+h7581scno5LD6hE0k0vk4OgsfA/lVJofEq
        WSY/3aTQrmE6kFrbFZ8Zrz9DQhWU9PPvwALqV/lqIQD8L22tOD1jdJq9lLjX+XWfxbi8EoMhx5zI2
        MwjdOeLow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGkSY-0002mv-VE; Wed, 17 Apr 2019 13:18:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E30829B52F48; Wed, 17 Apr 2019 15:18:41 +0200 (CEST)
Date:   Wed, 17 Apr 2019 15:18:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 09/16] locking/rwsem: Ensure an RT task will not spin
 on reader
Message-ID: <20190417131841.GF4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-10-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413172259.2740-10-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 01:22:52PM -0400, Waiman Long wrote:
> An RT task can do optimistic spinning only if the lock holder is
> actually running. If the state of the lock holder isn't known, there
> is a possibility that high priority of the RT task may block forward
> progress of the lock holder if it happens to reside on the same CPU.
> This will lead to deadlock. So we have to make sure that an RT task
> will not spin on a reader-owned rwsem.
> 
> When the owner is temporarily set to NULL, it is more tricky to decide
> if an RT task should stop spinning as it may be a temporary state
> where another writer may have just stolen the lock which then failed
> the task's trylock attempt. So one more retry is allowed to make sure
> that the lock is not spinnable by an RT task.
> 
> When testing on a 8-socket IvyBridge-EX system, the one additional retry
> seems to improve locking performance of RT write locking threads under
> heavy contentions. The table below shows the locking rates (in kops/s)
> with various write locking threads before and after the patch.
> 
>     Locking threads     Pre-patch     Post-patch
>     ---------------     ---------     -----------
>             4             2,753          2,608
>             8             2,529          2,520
>            16             1,727          1,918
>            32             1,263          1,956
>            64               889          1,343
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem.c | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2d6850c3e77b..8e19b5141595 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -539,6 +539,8 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
>  static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  {
>  	bool taken = false;
> +	bool is_rt_task = rt_task(current);

Arguably this is wrong; a remote CPU could change the scheduling
atributes of this task while it is spinning. In practise I don't think
we do that without forcing a reschedule, but in theory we could if we
find the task is current anyway.

> +	int prev_owner_state = OWNER_NULL;
>  
>  	preempt_disable();
>  
> @@ -556,7 +558,12 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  	 *  2) readers own the lock as we can't determine if they are
>  	 *     actively running or not.
>  	 */
> -	while (rwsem_spin_on_owner(sem) & OWNER_SPINNABLE) {
> +	for (;;) {
> +		enum owner_state owner_state = rwsem_spin_on_owner(sem);
> +
> +		if (!(owner_state & OWNER_SPINNABLE))
> +			break;
> +
>  		/*
>  		 * Try to acquire the lock
>  		 */
> @@ -566,13 +573,28 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>  		}
>  
>  		/*
> -		 * When there's no owner, we might have preempted between the
> -		 * owner acquiring the lock and setting the owner field. If
> -		 * we're an RT task that will live-lock because we won't let
> -		 * the owner complete.
> +		 * An RT task cannot do optimistic spinning if it cannot
> +		 * be sure the lock holder is running or live-lock may
> +		 * happen if the current task and the lock holder happen
> +		 * to run in the same CPU.
> +		 *
> +		 * When there's no owner or is reader-owned, an RT task
> +		 * will stop spinning if the owner state is not a writer
> +		 * at the previous iteration of the loop. This allows the
> +		 * RT task to recheck if the task that steals the lock is
> +		 * a spinnable writer. If so, it can keeps on spinning.
> +		 *
> +		 * If the owner is a writer, the need_resched() check is
> +		 * done inside rwsem_spin_on_owner(). If the owner is not
> +		 * a writer, need_resched() check needs to be done here.
>  		 */
> -		if (!sem->owner && (need_resched() || rt_task(current)))
> -			break;
> +		if (owner_state != OWNER_WRITER) {
> +			if (need_resched())
> +				break;
> +			if (is_rt_task && (prev_owner_state != OWNER_WRITER))
> +				break;
> +		}
> +		prev_owner_state = owner_state;
>  
>  		/*
>  		 * The cpu_relax() call is a compiler barrier which forces

This patch confuses me mightily. I mean, I see what it does, but I can't
figure out why. The Changelog is just one big source of confusion.

If you want one extra trylock attempt, why make it conditional on RT,
why not something simple like this?

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -556,7 +556,7 @@ static bool rwsem_optimistic_spin(struct
 		 */
 		if (rwsem_try_write_lock_unqueued(sem)) {
 			taken = true;
-			break;
+			goto unlock;
 		}
 
 		/*
@@ -576,6 +576,11 @@ static bool rwsem_optimistic_spin(struct
 		 */
 		cpu_relax();
 	}
+
+	if (rwsem_try_write_lock_unqueued(sem))
+		taken = true;
+
+unlock:
 	osq_unlock(&sem->osq);
 done:
 	preempt_enable();
