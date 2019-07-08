Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA80C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BED62173C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YeE5GLvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390884AbfGHRcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:32:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41872 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGHRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:32:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so17435950qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5i23biFPaaClT+2YPtfGiJqdORmGJZQXfEIOpkruCM=;
        b=YeE5GLvrxk9F6qsx8E7MawSPEl0P3yddIUo31CDYN8O7gXlJe1icMcaQU5zMVrTzvm
         /U5pa7NbAoAtFW4Xo5V289QJ6NGhnc37eaQ5ICSNVpZNnZ13/E5EtdKe88dNNQE19K1Y
         A5pvv4FKg1n4vvyH1JIOKX6XEpCbzOX9ZUf1OYpxo/suQipyDUkz3XRRrZRT7W/gW5hs
         N4/00LLBFjtWO4U7ztgRFKYs5FW7oztkdqLjOIE9yqyF2oaETEZHwtkbwMNCVYTTqVjz
         E2DRwyRf5P+evjJRO9AwaMtuahW26svt0cS9Efb6J9oswxgBHL3w6otxfAaVWojECE2B
         LNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5i23biFPaaClT+2YPtfGiJqdORmGJZQXfEIOpkruCM=;
        b=g72/TTuifaLptbhIjxK9uUDxq0Xym+6XEaZRchl8//H5gsw12jcHVE8GZ9AL6mPNHw
         9jtvFueUwn6tSpQQeJ7R6uX0uuOOx6bqBEkvyHhS36KZBbh69Ad7Lc5B+wDbH7hogAVK
         halqdP5Ix+/xa2f0QTtafZ833bzQcaHl+C6/cZmfogLl1FMnz3b6Kqom2d/+lL7B+G+k
         7WCqCxWF7bbYrgHHN+8zG6TSr5OilBsvqmbkhJqkXksaHfVtNONNjksY2OWWPVDvW3GP
         cgHcEA56UzC+itjEg0zIhUyOaKct53BvahgMPVswjAbz3S7tTdwKj6LSaIgKH06bIxLN
         qIhQ==
X-Gm-Message-State: APjAAAUQstk//MUVbIv/pB7NBxN2KNec++KiaR4DHfaiZI7etL9Bvyi9
        Lw59y4hCqLJ1irB502avWEij4Q==
X-Google-Smtp-Source: APXvYqyJxn1CpbuBd4JAE+dV+WTu/9u/IVzMib+Gv/BdKvSz+aMjpE1WhCra6Irv/rQmBHCCJNFQZw==
X-Received: by 2002:a0c:b999:: with SMTP id v25mr16306526qvf.36.1562607154067;
        Mon, 08 Jul 2019 10:32:34 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m5sm6931577qkb.117.2019.07.08.10.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 10:32:33 -0700 (PDT)
Message-ID: <1562607152.8510.5.camel@lca.pw>
Subject: Re: [PATCH] locking/lockdep: Fix lock IRQ usage initialization bug
From:   Qian Cai <cai@lca.pw>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 08 Jul 2019 13:32:32 -0400
In-Reply-To: <20190610055258.6424-1-duyuyang@gmail.com>
References: <20190610055258.6424-1-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I saw Ingo send a pull request to Linus for 5.3 [1] includes the offensive
commit "locking/lockdep: Consolidate lock usage bit initialization" but did not
include this patch.

[1] https://lore.kernel.org/lkml/20190708093516.GA57558@gmail.com/

On Mon, 2019-06-10 at 13:52 +0800, Yuyang Du wrote:
> The commit:
> 
>   091806515124b20 ("locking/lockdep: Consolidate lock usage bit
> initialization")
> 
> misses marking LOCK_USED flag at IRQ usage initialization when
> CONFIG_TRACE_IRQFLAGS
> or CONFIG_PROVE_LOCKING is not defined. Fix it.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> ---
>  kernel/locking/lockdep.c | 110 +++++++++++++++++++++++-----------------------
> -
>  1 file changed, 53 insertions(+), 57 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 48a840a..c3db987 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3460,9 +3460,61 @@ void trace_softirqs_off(unsigned long ip)
>  		debug_atomic_inc(redundant_softirqs_off);
>  }
>  
> +static inline unsigned int task_irq_context(struct task_struct *task)
> +{
> +	return 2 * !!task->hardirq_context + !!task->softirq_context;
> +}
> +
> +static int separate_irq_context(struct task_struct *curr,
> +		struct held_lock *hlock)
> +{
> +	unsigned int depth = curr->lockdep_depth;
> +
> +	/*
> +	 * Keep track of points where we cross into an interrupt context:
> +	 */
> +	if (depth) {
> +		struct held_lock *prev_hlock;
> +
> +		prev_hlock = curr->held_locks + depth-1;
> +		/*
> +		 * If we cross into another context, reset the
> +		 * hash key (this also prevents the checking and the
> +		 * adding of the dependency to 'prev'):
> +		 */
> +		if (prev_hlock->irq_context != hlock->irq_context)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
> +
> +static inline
> +int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
> +		enum lock_usage_bit new_bit)
> +{
> +	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
> +	return 1;
> +}
> +
> +static inline unsigned int task_irq_context(struct task_struct *task)
> +{
> +	return 0;
> +}
> +
> +static inline int separate_irq_context(struct task_struct *curr,
> +		struct held_lock *hlock)
> +{
> +	return 0;
> +}
> +
> +#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
> +
>  static int
>  mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
>  {
> +#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
>  	if (!check)
>  		goto lock_used;
>  
> @@ -3510,6 +3562,7 @@ void trace_softirqs_off(unsigned long ip)
>  	}
>  
>  lock_used:
> +#endif
>  	/* mark it as used: */
>  	if (!mark_lock(curr, hlock, LOCK_USED))
>  		return 0;
> @@ -3517,63 +3570,6 @@ void trace_softirqs_off(unsigned long ip)
>  	return 1;
>  }
>  
> -static inline unsigned int task_irq_context(struct task_struct *task)
> -{
> -	return 2 * !!task->hardirq_context + !!task->softirq_context;
> -}
> -
> -static int separate_irq_context(struct task_struct *curr,
> -		struct held_lock *hlock)
> -{
> -	unsigned int depth = curr->lockdep_depth;
> -
> -	/*
> -	 * Keep track of points where we cross into an interrupt context:
> -	 */
> -	if (depth) {
> -		struct held_lock *prev_hlock;
> -
> -		prev_hlock = curr->held_locks + depth-1;
> -		/*
> -		 * If we cross into another context, reset the
> -		 * hash key (this also prevents the checking and the
> -		 * adding of the dependency to 'prev'):
> -		 */
> -		if (prev_hlock->irq_context != hlock->irq_context)
> -			return 1;
> -	}
> -	return 0;
> -}
> -
> -#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
> -
> -static inline
> -int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
> -		enum lock_usage_bit new_bit)
> -{
> -	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
> -	return 1;
> -}
> -
> -static inline int
> -mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
> -{
> -	return 1;
> -}
> -
> -static inline unsigned int task_irq_context(struct task_struct *task)
> -{
> -	return 0;
> -}
> -
> -static inline int separate_irq_context(struct task_struct *curr,
> -		struct held_lock *hlock)
> -{
> -	return 0;
> -}
> -
> -#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
> -
>  /*
>   * Mark a lock with a usage bit, and validate the state transition:
>   */
