Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11942C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56E02133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570028936;
	bh=qbPWmyCPvtsnR+1ncID0EgxGK3ePvJHtZflqOCtXPMI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=q3GSMGKrVSo3hHlk0xVBu0g0nE4qH+TC25PYqjSiev541irNueGFu4D1lX4eQXUKF
	 SiYQ/yLRy9PR7m9nPaP04PHIrVJ1CpPi2oAnRPDzPaAbV3xMxJZKoWf7nknGSVMF2t
	 uDFut7hcuLXmnEwCE4encVPo1B87ad3U8K44O6ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfJBPI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfJBPIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:08:55 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED4921920;
        Wed,  2 Oct 2019 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570028934;
        bh=qbPWmyCPvtsnR+1ncID0EgxGK3ePvJHtZflqOCtXPMI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RYBL2yvgV4QC7U/vvBz4qRUTzGLC54uFVBYCOI4yYJI9IF6oXD9c1MXPkM2S99+c9
         G/GUOkEnsejSoJY+tCHOUOwyYMNSdE4VxszoNv8RI1Gchm5pZ9U2sTx0yzAHYnxax4
         8mwq2lkgKGKUS8Y39QI5JqNCVW/OBNtVQI7or/1E=
Date:   Wed, 2 Oct 2019 08:08:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191002150852.GB2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 01:22:53PM +0200, Sebastian Andrzej Siewior wrote:
> This is a revert of commit
>    a4244454df129 ("percpu-refcount: use RCU-sched insted of normal RCU")
> 
> which claims the only reason for using RCU-sched is
>    "rcu_read_[un]lock() … are slightly more expensive than preempt_disable/enable()"
> 
> and
>     "As the RCU critical sections are extremely short, using sched-RCU
>     shouldn't have any latency implications."
> 
> The problem with using RCU-sched here is that it disables preemption and
> the callback must not acquire any sleeping locks like spinlock_t on
> PREEMPT_RT which is the case with some of the users.

Looks good in general, but changing to RCU-preempt does not change the
fact that the callbacks execute with bh disabled.  There is a newish
queue_rcu_work() that invokes a workqueue handler after a grace period.

Or am I missing your point here?

							Thanx, Paul

> Using rcu_read_lock() on PREEMPTION=n kernels is not any different
> compared to rcu_read_lock_sched(). On PREEMPTION=y kernels there are
> already performance issues due to additional preemption points.
> Looking at the code, the rcu_read_lock() is just an increment and unlock
> is almost just a decrement unless there is something special to do. Both
> are functions while disabling preemption is inlined.
> Doing a small benchmark, the minimal amount of time required was mostly
> the same. The average time required was higher due to the higher MAX
> value (which could be preemption). With DEBUG_PREEMPT=y it is
> rcu_read_lock_sched() that takes a little longer due to the additional
> debug code.
> 
> Convert back to normal RCU.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> Benchmark https://breakpoint.cc/percpu_test.patch
> 
>  include/linux/percpu-refcount.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index 7aef0abc194a2..390031e816dcd 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -186,14 +186,14 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>  {
>  	unsigned long __percpu *percpu_count;
>  
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_add(*percpu_count, nr);
>  	else
>  		atomic_long_add(nr, &ref->count);
>  
> -	rcu_read_unlock_sched();
> +	rcu_read_unlock();
>  }
>  
>  /**
> @@ -223,7 +223,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  	unsigned long __percpu *percpu_count;
>  	bool ret;
>  
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count)) {
>  		this_cpu_inc(*percpu_count);
> @@ -232,7 +232,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  		ret = atomic_long_inc_not_zero(&ref->count);
>  	}
>  
> -	rcu_read_unlock_sched();
> +	rcu_read_unlock();
>  
>  	return ret;
>  }
> @@ -257,7 +257,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
>  	unsigned long __percpu *percpu_count;
>  	bool ret = false;
>  
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count)) {
>  		this_cpu_inc(*percpu_count);
> @@ -266,7 +266,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
>  		ret = atomic_long_inc_not_zero(&ref->count);
>  	}
>  
> -	rcu_read_unlock_sched();
> +	rcu_read_unlock();
>  
>  	return ret;
>  }
> @@ -285,14 +285,14 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
>  {
>  	unsigned long __percpu *percpu_count;
>  
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_sub(*percpu_count, nr);
>  	else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
>  		ref->release(ref);
>  
> -	rcu_read_unlock_sched();
> +	rcu_read_unlock();
>  }
>  
>  /**
> -- 
> 2.23.0
> 
