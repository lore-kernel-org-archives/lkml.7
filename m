Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDF1C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D31E21848
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TjO/6smU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfE0PPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:15:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41082 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0PPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x8YEUSs0VWayL9Nd4vTM3zWomPzr+SfoM35cTc7hwl8=; b=TjO/6smU6keeXgs6XWfSHKkn/
        RyGFCUscaykDuKu5DdcppZBmcsP1uYWnXWcjLzkgB4Vq7ZZLs+Ns6RrJFDJ8n9PENh9GEmNbBJld6
        Wg8FPTtTF1jwZATlPKeh0YZAeGmRYxLQCFBJ7JqP9RtvjHJvlbZ18vcka+blKZm0e9+yNKR2ZI0Jv
        54ZTnBrMdpmzeTDHgLigHodGO00pjtuBhZY/rqlDTyzugJ2i9v7ncFm/rc27ESt9Kk+HJnWwOuer7
        S7t+pPYZB1TX6fOv9cx0eg5MsWZO4FAw9ca2TF9prMQHTAc5m2q4QQS5zIlmlVpao1HAi0ZJZpZOQ
        vWcq5kZOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVHKi-0004X0-5C; Mon, 27 May 2019 15:14:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2204201E33E5; Mon, 27 May 2019 17:14:38 +0200 (CEST)
Date:   Mon, 27 May 2019 17:14:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Imre Deak <imre.deak@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/2] lockdep: Fix merging of hlocks with non-zero
 references
Message-ID: <20190527151438.GF2623@hirez.programming.kicks-ass.net>
References: <20190524201509.9199-1-imre.deak@intel.com>
 <20190524201509.9199-2-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524201509.9199-2-imre.deak@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:15:09PM +0300, Imre Deak wrote:
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 967352d32af1..9e2a4ab6c731 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3637,6 +3637,11 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
>  
>  static int __lock_is_held(const struct lockdep_map *lock, int read);
>  
> +static int hlock_reference(int reference)
> +{
> +	return reference ? : 1;
> +}
> +
>  /*
>   * This gets called for every mutex_lock*()/spin_lock*() operation.
>   * We maintain the dependency maps and validate the locking attempt:
> @@ -3702,17 +3707,15 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>  	if (depth) {
>  		hlock = curr->held_locks + depth - 1;
>  		if (hlock->class_idx == class_idx && nest_lock) {
> -			if (hlock->references) {
> -				/*
> -				 * Check: unsigned int references overflow.
> -				 */
> -				if (DEBUG_LOCKS_WARN_ON(hlock->references == UINT_MAX))

What tree is this against? Afaict this is still 12 bits ?!

> -					return 0;
> +			/*
> +			 * Check: unsigned int references overflow.
> +			 */
> +			if (DEBUG_LOCKS_WARN_ON(hlock_reference(hlock->references) >
> +						UINT_MAX - hlock_reference(references)))

Idem. Also very weird overflow check..

> +				return 0;
>  
> -				hlock->references++;
> -			} else {
> -				hlock->references = 2;
> -			}
> +			hlock->references = hlock_reference(hlock->references) +
> +					    hlock_reference(references);
>  
>  			return 2;
>  		}
> -- 
> 2.17.1
> 
