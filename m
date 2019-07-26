Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A076BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7471922ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfGZNaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:30:11 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:45992 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfGZNaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:30:11 -0400
Received: from [151.41.39.6] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 141121803; Fri, 26 Jul 2019 15:30:09 +0200
Date:   Fri, 26 Jul 2019 15:30:02 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched/deadline: Fix double accounting of rq/running
 bw in push_dl_task()
Message-ID: <20190726153002.5e49c666@sweethome>
In-Reply-To: <20190726082756.5525-2-dietmar.eggemann@arm.com>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
        <20190726082756.5525-2-dietmar.eggemann@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 26 Jul 2019 09:27:52 +0100
Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
[...]
> @@ -2121,17 +2121,13 @@ static int push_dl_task(struct rq *rq)
>  	}
>  
>  	deactivate_task(rq, next_task, 0);
> -	sub_running_bw(&next_task->dl, &rq->dl);
> -	sub_rq_bw(&next_task->dl, &rq->dl);
>  	set_task_cpu(next_task, later_rq->cpu);
> -	add_rq_bw(&next_task->dl, &later_rq->dl);
>  
>  	/*
>  	 * Update the later_rq clock here, because the clock is used
>  	 * by the cpufreq_update_util() inside __add_running_bw().
>  	 */
>  	update_rq_clock(later_rq);
> -	add_running_bw(&next_task->dl, &later_rq->dl);

Looking at the code again and thinking a little bit more about this
issue, I suspect a similar change is needed in pull_dl_task() too, no?



			Luca
