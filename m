Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89026C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2B6206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k9Tvz2zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfG2QsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:48:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48632 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfG2QsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CdO+v4oZa9EnLCDZTQ85n/ETA6xyqhDMpjwT2xbLmSc=; b=k9Tvz2zRatSYev2i6zfTRqEix
        l781VEZOt+0DIkqBi9YQpJdYaI0hrv47KEUUPj+i6JvAansBYoAf5NNjA/s7kroc3OEsxRQVLO5Hp
        qReCDt27Aq/iIw7P/lEaXd3QlVqbB4t+ur0LdTOGrOWTMa+9BZrEiCqlC+i2DCTGGXTLKWBxuJdML
        BO9m4coWzwx7urw1TDVphaTOazhYENrLjOSWXZsxYv6X9Mic11mAW0/Kbn8JNW6YnEuYQCdCHW09Y
        +AdyNN4axtYb1MMSTfNW1FfDY6YCVVdU+f4VbDVKahyotsj87025ZgZTC5cS4uLzfQ5G8DtaiwLyf
        7UIlOZCfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs8oY-0004Fa-5W; Mon, 29 Jul 2019 16:47:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D64FC20C7FF00; Mon, 29 Jul 2019 18:47:55 +0200 (CEST)
Date:   Mon, 29 Jul 2019 18:47:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] sched/deadline: Use __sub_running_bw() throughout
 dl_change_utilization()
Message-ID: <20190729164755.GM31398@hirez.programming.kicks-ass.net>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726082756.5525-4-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 09:27:54AM +0100, Dietmar Eggemann wrote:
> dl_change_utilization() has a BUG_ON() to check that no schedutil
> kthread (sugov) is entering this function. So instead of calling
> sub_running_bw() which checks for the special entity related to a
> sugov thread, call the underlying function __sub_running_bw().
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 99d4c24a8637..1fa005f79307 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -164,7 +164,7 @@ void dl_change_utilization(struct task_struct *p, u64 new_bw)
>  
>  	rq = task_rq(p);
>  	if (p->dl.dl_non_contending) {
> -		sub_running_bw(&p->dl, &rq->dl);
> +		__sub_running_bw(p->dl.dl_bw, &rq->dl);
>  		p->dl.dl_non_contending = 0;
>  		/*
>  		 * If the timer handler is currently running and the

I'm confused; the only called of dl_change_utilization() is
sched_dl_overflow(), and that already checks FLAG_SUGOV and exits before
calling.

So how can this matter?
