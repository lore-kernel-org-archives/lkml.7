Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF79C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D5422ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfGZKS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:18:27 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:54369 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZKS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:18:26 -0400
Received: from [151.41.39.6] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 141117354; Fri, 26 Jul 2019 12:18:24 +0200
Date:   Fri, 26 Jul 2019 12:18:19 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] sched/deadline: Use return value of SCHED_WARN_ON()
 in bw accounting
Message-ID: <20190726121819.32be6fb1@sweethome>
In-Reply-To: <20190726082756.5525-6-dietmar.eggemann@arm.com>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
        <20190726082756.5525-6-dietmar.eggemann@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Fri, 26 Jul 2019 09:27:56 +0100
Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

> To make the decision whether to set rq or running bw to 0 in underflow
> case use the return value of SCHED_WARN_ON() rather than an extra if
> condition.

I think I tried this at some point, but if I remember well this
solution does not work correctly when SCHED_DEBUG is not enabled.



			Luca


> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/deadline.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a9cb52ceb761..66c594b5507e 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -95,8 +95,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq
> *dl_rq) 
>  	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
>  	dl_rq->running_bw -= dl_bw;
> -	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
> -	if (dl_rq->running_bw > old)
> +	if (SCHED_WARN_ON(dl_rq->running_bw > old)) /* underflow */
>  		dl_rq->running_bw = 0;
>  	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
>  	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
> @@ -119,8 +118,7 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
>  
>  	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
>  	dl_rq->this_bw -= dl_bw;
> -	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
> -	if (dl_rq->this_bw > old)
> +	if (SCHED_WARN_ON(dl_rq->this_bw > old)) /* underflow */
>  		dl_rq->this_bw = 0;
>  	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
>  }

