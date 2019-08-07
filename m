Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B0DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84AF216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 00:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="r+EYVTOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfHGADR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 20:03:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41865 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfHGADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 20:03:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so42397616pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 17:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mwKR58BU63y6JbUjcaWQOAFwTXbPvyt1Z0PFhzI7JG4=;
        b=r+EYVTOBKAgPJQXGq0HBZjk+p2fPPm06rA7BQGc+RAJKmXdCugNCqER087NT4EllE9
         u6PoGLxAm6TSXmRyTbzrC3MKGbsBG8cAAnMLpgmrQdgi3aFIZV7aDqeqRAjyPYQtwu1h
         0CuA403o65Vb3q2KfdNSuT6Ikb2n9rg7dwV3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mwKR58BU63y6JbUjcaWQOAFwTXbPvyt1Z0PFhzI7JG4=;
        b=snLTx+u/6U0vbOHWM5Pi08h9sfo7/lV0g3977cIkOlG5NXyoRwmDyTvQuVp5ULmFyf
         wkwwz6krn6P99uUwC6SeczwlEiqLcNbMcwNuf1zhopNh+lv0KazhgdRVij5ExNaUBCoZ
         TTI7f64DhDfIxsQopcjk0ZqtaKZma0lZkpfVkzuc4BBVmOoBcaWERIs9PwJeqV6ljh4j
         5YN7eT5D3RFx/SMlXvGPHJWQcgkQwGYNFPXrNl07S9lF6rije/JswOpkjWAEc5Po1hvf
         F6RZA8pOI2gIYIMhhVyGMUa4LkvW5v2OFN3ZNwIZ6hyfZQ26njjHDz9s2yjQ1yRnhKJZ
         1P2A==
X-Gm-Message-State: APjAAAX+Ft0As1F/a2TVCDSlX2n5QkNbmhNn//0POTuhC9elDH4x9ta9
        ZTq/S7zPLMVS8vWO6n8KSbSEtA==
X-Google-Smtp-Source: APXvYqxRGg/ZxRc2MyH1BiEyzRaShwXwJp+Qk5XuQ8jVW45n/8vNEI5e9U2UM8fCmL+8lcUp0r+CPw==
X-Received: by 2002:a65:6859:: with SMTP id q25mr5161042pgt.181.1565136196066;
        Tue, 06 Aug 2019 17:03:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g2sm145073047pfq.88.2019.08.06.17.03.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 17:03:14 -0700 (PDT)
Date:   Tue, 6 Aug 2019 20:03:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 02/14] rcu/nocb: Add bypass callback
 queueing
Message-ID: <20190807000313.GA161170@google.com>
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-2-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802151501.13069-2-paulmck@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:14:49AM -0700, Paul E. McKenney wrote:
> Use of the rcu_data structure's segmented ->cblist for no-CBs CPUs
> takes advantage of unrelated grace periods, thus reducing the memory
> footprint in the face of floods of call_rcu() invocations.  However,
> the ->cblist field is a more-complex rcu_segcblist structure which must
> be protected via locking.  Even though there are only three entities
> which can acquire this lock (the CPU invoking call_rcu(), the no-CBs
> grace-period kthread, and the no-CBs callbacks kthread), the contention
> on this lock is excessive under heavy stress.
> 
> This commit therefore greatly reduces contention by provisioning
> an rcu_cblist structure field named ->nocb_bypass within the
> rcu_data structure.  Each no-CBs CPU is permitted only a limited
> number of enqueues onto the ->cblist per jiffy, controlled by a new
> nocb_nobypass_lim_per_jiffy kernel boot parameter that defaults to
> about 16 enqueues per millisecond (16 * 1000 / HZ).  When that limit is
> exceeded, the CPU instead enqueues onto the new ->nocb_bypass.

Looks quite interesting. I am guessing the not-no-CB (regular) enqueues don't
need to use the same technique because both enqueues / callback execution are
happening on same CPU..

Still looking through patch but I understood the basic idea. Some nits below:

[snip]
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 2c3e9068671c..e4df86db8137 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -200,18 +200,26 @@ struct rcu_data {
>  	atomic_t nocb_lock_contended;	/* Contention experienced. */
>  	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
>  	struct timer_list nocb_timer;	/* Enforce finite deferral. */
> +	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
> +
> +	/* The following fields are used by call_rcu, hence own cacheline. */
> +	raw_spinlock_t nocb_bypass_lock ____cacheline_internodealigned_in_smp;
> +	struct rcu_cblist nocb_bypass;	/* Lock-contention-bypass CB list. */
> +	unsigned long nocb_bypass_first; /* Time (jiffies) of first enqueue. */
> +	unsigned long nocb_nobypass_last; /* Last ->cblist enqueue (jiffies). */
> +	int nocb_nobypass_count;	/* # ->cblist enqueues at ^^^ time. */

Can these and below fields be ifdef'd out if !CONFIG_RCU_NOCB_CPU so as to
keep the size of struct smaller for benefit of systems that don't use NOCB?


>  
>  	/* The following fields are used by GP kthread, hence own cacheline. */
>  	raw_spinlock_t nocb_gp_lock ____cacheline_internodealigned_in_smp;
> -	bool nocb_gp_sleep;
> -					/* Is the nocb GP thread asleep? */
> +	struct timer_list nocb_bypass_timer; /* Force nocb_bypass flush. */
> +	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */

And these too, I think.


>  	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
>  	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
>  	struct task_struct *nocb_cb_kthread;
>  	struct rcu_data *nocb_next_cb_rdp;
>  					/* Next rcu_data in wakeup chain. */
>  
> -	/* The following fields are used by CB kthread, hence new cachline. */
> +	/* The following fields are used by CB kthread, hence new cacheline. */
>  	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
>  					/* GP rdp takes GP-end wakeups. */
>  #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
[snip]
> +static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
> +{
> +	rcu_lockdep_assert_cblist_protected(rdp);
> +	if (!rcu_segcblist_is_offloaded(&rdp->cblist) ||
> +	    !rcu_nocb_bypass_trylock(rdp))
> +		return;
> +	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
> +}
> +
> +/*
> + * See whether it is appropriate to use the ->nocb_bypass list in order
> + * to control contention on ->nocb_lock.  A limited number of direct
> + * enqueues are permitted into ->cblist per jiffy.  If ->nocb_bypass
> + * is non-empty, further callbacks must be placed into ->nocb_bypass,
> + * otherwise rcu_barrier() breaks.  Use rcu_nocb_flush_bypass() to switch
> + * back to direct use of ->cblist.  However, ->nocb_bypass should not be
> + * used if ->cblist is empty, because otherwise callbacks can be stranded
> + * on ->nocb_bypass because we cannot count on the current CPU ever again
> + * invoking call_rcu().  The general rule is that if ->nocb_bypass is
> + * non-empty, the corresponding no-CBs grace-period kthread must not be
> + * in an indefinite sleep state.
> + *
> + * Finally, it is not permitted to use the bypass during early boot,
> + * as doing so would confuse the auto-initialization code.  Besides
> + * which, there is no point in worrying about lock contention while
> + * there is only one CPU in operation.
> + */
> +static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> +				bool *was_alldone, unsigned long flags)
> +{
> +	unsigned long c;
> +	unsigned long cur_gp_seq;
> +	unsigned long j = jiffies;
> +	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> +
> +	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
> +		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> +		return false; /* Not offloaded, no bypassing. */
> +	}
> +	lockdep_assert_irqs_disabled();
> +
> +	// Don't use ->nocb_bypass during early boot.

Very minor nit: comment style should be /* */

thanks,

 - Joel

[snip]

