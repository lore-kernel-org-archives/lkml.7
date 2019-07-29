Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30487C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9DB2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfG2JZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:25:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41444 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfG2JZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:25:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so57791929wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 02:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t7Ljxs1sr+mBG3FK3SDP9+7VPp2LGRP4yoTIBN6DoFw=;
        b=UgGmIZZd9vmohlyaMa0uRas6bzxJAWIEEcxnvY5FaG3LM4U1O0iFarGrhM1Er7Iwk8
         3lQtTswQLzl6AOBftFXlTwS4sP1xPt8pq6T+7l8cj4sIzUWZd27g75tcehWXqNskhVF6
         Jp+ndpLv3HrJajy3kJyPTPAHQnOUUxp9EFR/tu3jAA5LcEzBtpucejPGzP0qxP82ufaA
         DY5xDLDrIjpkxNIUilKw+Ae0qogeQJY2oKxcu6iJ1gdSqRuieO4yxWcQ9d6tHHKfoPoY
         q/cRoxqeGkDRrChhf5azr2w3lrFB91n3Dla82+pl9TjSVWG+4nZsFVK8+yRFfqMpzRFm
         j7hg==
X-Gm-Message-State: APjAAAX7hkTAN6kvZlJiSavsCr9h0Wfdldoapgj/G7VxVQb1N7LGFqWT
        2+DQAcHrV5rtJ2tC70cAi9FPgQ==
X-Google-Smtp-Source: APXvYqy7MkKr+ZTqwO7kFcE4Z3A/IxNvxUF25RWjb2Hhy7aqr0zOTJoixXZ2Q+VNrXADTsirAuIGMA==
X-Received: by 2002:adf:e444:: with SMTP id t4mr19073195wrm.262.1564392322293;
        Mon, 29 Jul 2019 02:25:22 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id j16sm1882024wrp.62.2019.07.29.02.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 02:25:21 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:25:19 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 04/13] sched/{rt,deadline}: Fix set_next_task vs
 pick_next_task
Message-ID: <20190729092519.GR25636@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161357.579899041@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726161357.579899041@infradead.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/07/19 16:54, Peter Zijlstra wrote:
> Because pick_next_task() implies set_curr_task() and some of the
> details haven't matter too much, some of what _should_ be in
> set_curr_task() ended up in pick_next_task, correct this.
> 
> This prepares the way for a pick_next_task() variant that does not
> affect the current state; allowing remote picking.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/deadline.c |   23 ++++++++++++-----------
>  kernel/sched/rt.c       |   27 ++++++++++++++-------------
>  2 files changed, 26 insertions(+), 24 deletions(-)
> 
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1694,12 +1694,21 @@ static void start_hrtick_dl(struct rq *r
>  }
>  #endif
>  
> -static inline void set_next_task(struct rq *rq, struct task_struct *p)
> +static void set_next_task_dl(struct rq *rq, struct task_struct *p)
>  {
>  	p->se.exec_start = rq_clock_task(rq);
>  
>  	/* You can't push away the running task */
>  	dequeue_pushable_dl_task(rq, p);
> +
> +	if (hrtick_enabled(rq))
> +		start_hrtick_dl(rq, p);
> +
> +	if (rq->curr->sched_class != &dl_sched_class)
> +		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> +
> +	if (rq->curr != p)
> +		deadline_queue_push_tasks(rq);

It's a minor thing, but I was wondering why you added the check on curr.
deadline_queue_push_tasks() already checks if are there pushable tasks,
plus curr can still be of a different class at this point?

Thanks,

Juri
