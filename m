Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F08BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A1520685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uV2aFKlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfDYTdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:33:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55018 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfDYTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WyXpTCrU4d+dgwzOb7vYmIvJeSJqFiYdK4M0ESj+3Hk=; b=uV2aFKlJkhxf2XugKVO/hBQK8
        yxTiBudYHGnOIIHJJcNIX8XZBHjfQjWDpLAmBRwqaVbXi/nEJY+a8MQwF2LmWO3VaCl2guyT+EJrN
        GDgUdnZU7iWK564215ZOWWn6Y/Gybkdvddjr2UoClGB9Br5d3HI0OKHJVfyo+/0TFvpzqk/xX+6w6
        x0QvWG5mY/m7VdbzcdP2xAG63MaWLfDqsnYVk30gCbMUkceJ/8m8Pu4HENxgCxNfmtVMaaPL/AAef
        aTGXcYIz34EFSKMugE4ueQ8WexDWc/UyOwD8Xj65DKg/vY5zOGcrgQzCpmqFsY1P7OPOKQoVRCfw6
        iyW0oWzqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJk70-0001DQ-4f; Thu, 25 Apr 2019 19:32:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FC8920321925; Thu, 25 Apr 2019 21:32:47 +0200 (CEST)
Date:   Thu, 25 Apr 2019 21:32:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/28] locking/lockdep: Optimize irq usage check when
 marking lock usage bit
Message-ID: <20190425193247.GU12232@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-20-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424101934.51535-20-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:19:25PM +0800, Yuyang Du wrote:

After only a quick read of these next patches; this is the one that
worries me most.

You did mention Frederic's patches, but I'm not entirely sure you're
aware why he's doing them. He's preparing to split the softirq state
into one state per softirq vector.

See here:

  https://lkml.kernel.org/r/20190228171242.32144-14-frederic@kernel.org
  https://lkml.kernel.org/r/20190228171242.32144-15-frederic@kernel.org

IOW he's going to massively explode this storage.


> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 7c2fefa..0e209b8 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -72,6 +72,11 @@ struct lock_trace {
>  };
>  
>  #define LOCKSTAT_POINTS		4
> +/*
> + * For hardirq and softirq, each has one for irqsafe lock that reaches
> + * this lock and one for irqsafe-read lock that reaches this lock.
> + */
> +#define LOCK_IRQ_SAFE_LOCKS	4

This is going to be 2*(1+10) if I counted correctly.

>  /*
>   * The lock-class itself. The order of the structure members matters.
> @@ -114,6 +119,15 @@ struct lock_class {
>  	int				name_version;
>  	const char			*name;
>  
> +	/*
> +	 * irqsafe_lock indicates whether there is an IRQ safe lock
> +	 * reaches this lock_class in the dependency graph, and if so
> +	 * points to it; irqsafe_distance measures the distance from the
> +	 * IRQ safe locks, used for keeping the shortest.
> +	 */
> +	struct lock_class		*irqsafe_lock[LOCK_IRQ_SAFE_LOCKS];
> +	int				irqsafe_distance[LOCK_IRQ_SAFE_LOCKS];

Which makes this 264 additional bytes to struct lock_class, which is
immense, given that we're talking about 8192 instances of this, for a
total of over 2M of data.

> +
>  #ifdef CONFIG_LOCK_STAT
>  	unsigned long			contention_point[LOCKSTAT_POINTS];
>  	unsigned long			contending_point[LOCKSTAT_POINTS];
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 6e79bd6..a3138c9 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1101,6 +1101,7 @@ static bool is_dynamic_key(const struct lock_class_key *key)
>  	struct lockdep_subclass_key *key;
>  	struct hlist_head *hash_head;
>  	struct lock_class *class;
> +	int i;
>  
>  	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
>  
> @@ -1153,6 +1154,9 @@ static bool is_dynamic_key(const struct lock_class_key *key)
>  	WARN_ON_ONCE(!list_empty(&class->locks_before));
>  	WARN_ON_ONCE(!list_empty(&class->locks_after));
>  	class->name_version = count_matching_names(class);
> +	for (i = 0; i < ARRAY_SIZE(class->irqsafe_distance); i++)
> +		class->irqsafe_distance[i] = INT_MAX;
> +
>  	/*
>  	 * We use RCU's safe list-add method to make
>  	 * parallel walking of the hash-list safe:
> @@ -2896,6 +2900,10 @@ static void print_usage_bug_scenario(struct held_lock *lock)
>  	return 1;
>  }
>  
> +static DECLARE_BITMAP(lock_classes_hardirq_safe, MAX_LOCKDEP_KEYS);
> +static DECLARE_BITMAP(lock_classes_hardirq_safe_read, MAX_LOCKDEP_KEYS);
> +static DECLARE_BITMAP(lock_classes_softirq_safe, MAX_LOCKDEP_KEYS);
> +static DECLARE_BITMAP(lock_classes_softirq_safe_read, MAX_LOCKDEP_KEYS);

That will need being written like:

#define LOCKDEP_STATE(__STATE)								\
	static DECLARE_BITMAP(lock_classes_##__STATE##_safe, MAX_LOCKDEP_KEYS);		\
	static DECLARE_BITMAP(lock_classes_##__STATE##_safe_read, MAX_LOCKDEP_KEYS);
#include "lockdep_states.h"
#undef LOCKDEP_STATE

And will thereby generate 22 bitmaps, each being 1kb of storage.

>  /*
>   * print irq inversion bug:
> @@ -5001,6 +5009,12 @@ void __init lockdep_init(void)
>  		+ sizeof(lock_chains)
>  		+ sizeof(lock_chains_in_use)
>  		+ sizeof(chain_hlocks)
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +		+ sizeof(lock_classes_hardirq_safe)
> +		+ sizeof(lock_classes_hardirq_safe_read)
> +		+ sizeof(lock_classes_softirq_safe)
> +		+ sizeof(lock_classes_softirq_safe_read)

another macro generator here.

> +#endif
>  #endif
>  		) / 1024
>  		);

Now, I would normally not care too much about memory costs for a debug
feature, except there's architectures that need to keep their image size
small, see the comment that goes along with CONFIG_LOCKDEP_SMALL in
lockdep_internals.h.


