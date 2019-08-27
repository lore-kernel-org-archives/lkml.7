Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B5EC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59DE217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566866931;
	bh=wB7AxMp/jZy8yjufir8xSmQbF50O1Y8jtZXIu45kNUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zc0uaxXHHcD/hqNkPvMABHaFPtdFEqHEVQVzXpPFWWwXsrfaLWTCARtY2kdlcxrxm
	 URIX4NaOw3ROm8daZiIS2eBb4aSO+5P4k7uSx7ZuLHl7xcUr/yDWtQK7loNnv7JRzO
	 CsObsVOrf+m26DRQBXm7ZkNz2u2sFmGkSueVScUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfH0Asv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfH0Asu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:48:50 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623A720850;
        Tue, 27 Aug 2019 00:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566866929;
        bh=wB7AxMp/jZy8yjufir8xSmQbF50O1Y8jtZXIu45kNUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VthWOUvwPJVT89ph9UoBS6gU/kLE/ZCg4/JkOR5243LisP6Ojo/RQiyLlVBVoCA8Z
         bQ96tICSoJUxoyPLLuisNAfiiEjfLPB52dwS90ZUPHDyyvxstiCvGuILdwAurkdavc
         USMw81YYyNC3uH2UaG/gc0BCvMrnK4SBlbrw9r64=
Date:   Tue, 27 Aug 2019 02:48:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [patch V2 38/38] posix-cpu-timers: Utilize timerqueue for storage
Message-ID: <20190827004846.GM14309@lenoir>
References: <20190821190847.665673890@linutronix.de>
 <20190821192922.835676817@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821192922.835676817@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:09:25PM +0200, Thomas Gleixner wrote:
>  /**
> @@ -92,14 +130,10 @@ struct posix_cputimers {
>  
>  static inline void posix_cputimers_init(struct posix_cputimers *pct)
>  {
> -	pct->timers_active = 0;
> -	pct->expiry_active = 0;

No more need to initialize these?

> +	memset(pct->bases, 0, sizeof(pct->bases));
>  	pct->bases[0].nextevt = U64_MAX;
>  	pct->bases[1].nextevt = U64_MAX;
>  	pct->bases[2].nextevt = U64_MAX;
> -	INIT_LIST_HEAD(&pct->bases[0].cpu_timers);
> -	INIT_LIST_HEAD(&pct->bases[1].cpu_timers);
> -	INIT_LIST_HEAD(&pct->bases[2].cpu_timers);
>  }

[...]

> @@ -393,15 +395,15 @@ static int posix_cpu_timer_del(struct k_
>  	sighand = lock_task_sighand(p, &flags);
>  	if (unlikely(sighand == NULL)) {
>  		/*
> -		 * We raced with the reaping of the task.
> -		 * The deletion should have cleared us off the list.
> +		 * This raced with the reaping of the task. The exit cleanup
> +		 * should have removed this timer from the timer queue.
>  		 */
> -		WARN_ON_ONCE(!list_empty(&timer->it.cpu.entry));
> +		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));

Should we clear ctmr->head upon cleanup_timerqueue() ?

Thanks.


>  	} else {
>  		if (timer->it.cpu.firing)
>  			ret = TIMER_RETRY;
>  		else
> -			list_del(&timer->it.cpu.entry);
> +			cpu_timer_dequeue(ctmr);
>  
>  		unlock_task_sighand(p, &flags);
>  	}
> @@ -412,12 +414,12 @@ static int posix_cpu_timer_del(struct k_
>  	return ret;
>  }
>  
> -static void cleanup_timers_list(struct list_head *head)
> +static void cleanup_timerqueue(struct timerqueue_head *head)
>  {
> -	struct cpu_timer_list *timer, *next;
> +	struct timerqueue_node *node;
>  
> -	list_for_each_entry_safe(timer, next, head, entry)
> -		list_del_init(&timer->entry);
> +	while ((node = timerqueue_getnext(head)))
> +		timerqueue_del(head, node);
>  }

