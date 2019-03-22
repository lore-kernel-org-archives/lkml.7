Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8365E218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfCVOci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:32:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33076 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfCVOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:32:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so2635452wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 07:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TiXP7H9vYn4usOzHAK8b18260nNkrHJ6IayMSlpmKL0=;
        b=AdYVUXEechBawVYdrSJTxpyVuY745ZrpUDucDWOo9RXfyc0m4eda6sW40KfwmPlqvW
         HCdnD523zhTlccqTnfRqnakm/kp+lNTuz0n7zvqNkjYiuITcEyaxfM3Lk/4WO9cMfuVj
         HrI4z1Stk/BmTJ2oWKNfeqWiIgbVEcx/3NTFJ5My8L5/OKeOeiB0QgEJ937Oqm0K7ZIy
         k+pnp8+rckfd4ukItwJ/syufYckFGZwJgv91mL5cYkM9KUOVciolt2AoJ5+fy9OwSWEu
         sQ46kAN8S2n/vwRF/IjsZF0xUweq/WRMpsdyMeesTse22ir/+TiUzrIS68iIMBgQ6XlZ
         Rm9w==
X-Gm-Message-State: APjAAAWYoNJMSPc494+EYR/TOohxpL9REwIufGHSd7DuMZU9RPzHmqN+
        UsMAxCDcj8iYPtkANu+RZpeIiQ==
X-Google-Smtp-Source: APXvYqzm5y2Npad1HgoXOYHIWusJ6OJ+9f4iwWZyZCaWLGkaTKJol8yT9Ht6M9CsH4L/wOBK/c3zVQ==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr6510350wrn.120.1553265155420;
        Fri, 22 Mar 2019 07:32:35 -0700 (PDT)
Received: from localhost.localdomain ([151.15.240.16])
        by smtp.gmail.com with ESMTPSA id d16sm7204019wru.49.2019.03.22.07.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 07:32:34 -0700 (PDT)
Date:   Fri, 22 Mar 2019 15:32:32 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARN ON at kernel/sched/deadline.c task_non_contending
Message-ID: <20190322143232.GI8775@localhost.localdomain>
References: <dfb46874-3657-71c6-e068-9413ffe3f82e@huawei.com>
 <20190313154948.773427d6@luca64>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313154948.773427d6@luca64>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/03/19 15:49, luca abeni wrote:
> Hi,
> 
> (I added Juri in cc)
> 
> On Tue, 12 Mar 2019 10:03:12 +0800
> "chengjian (D)" <cj.chengjian@huawei.com> wrote:
> [...]
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 31c050a0d0ce..d73cb033a06d 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -252,7 +252,6 @@ static void task_non_contending(struct
> > task_struct *p) if (dl_entity_is_special(dl_se))
> >                  return;
> > 
> > -       WARN_ON(hrtimer_active(&dl_se->inactive_timer));
> >          WARN_ON(dl_se->dl_non_contending);
> > 
> >          zerolag_time = dl_se->deadline -
> > @@ -287,7 +286,9 @@ static void task_non_contending(struct
> > task_struct *p) }
> > 
> >          dl_se->dl_non_contending = 1;
> > -       get_task_struct(p);
> > +
> > +       if (!hrtimer_active(&dl_se->inactive_timer));
> > +               get_task_struct(p);
> >          hrtimer_start(timer, ns_to_ktime(zerolag_time),
> > HRTIMER_MODE_REL); }
> 
> After looking at the patch a little bit more and running some tests,
> I suspect this solution might be racy:
> when the timer is already active, (and hrtimer_start() fails), it
> relies on its handler to decrease the running bw (by setting
> dl_non_contending to 1)... But inactive_task_timer() might have
> already checked dl_non_contending, finding it equal to 0 (so, it
> ends up doing nothing and the running bw is not decreased).
> 
> 
> So, I would prefer a different solution. I think this patch should work:
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 6a73e41a2016..43901fa3f269 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -252,7 +252,6 @@ static void task_non_contending(struct task_struct *p)
>  	if (dl_entity_is_special(dl_se))
>  		return;
>  
> -	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
>  	WARN_ON(dl_se->dl_non_contending);
>  
>  	zerolag_time = dl_se->deadline -
> @@ -269,7 +268,7 @@ static void task_non_contending(struct task_struct *p)
>  	 * If the "0-lag time" already passed, decrease the active
>  	 * utilization now, instead of starting a timer
>  	 */
> -	if (zerolag_time < 0) {
> +	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
>  		if (dl_task(p))
>  			sub_running_bw(dl_se, dl_rq);
>  		if (!dl_task(p) || p->state == TASK_DEAD) {
> 
> 
> The idea is that if the timer is active, we leave dl_non_contending set to
> 0 (so that the timer handler does nothing), and we immediately decrease the
> running bw.
> I think this is OK, because this situation can happen only if the task
> blocks, wakes up while the timer handler is running, and then immediately
> blocks again - while the timer handler is still running. So, the "zero lag
> time" cannot be too much in the future.

And if we get here and the handler is running it means that the handler
is spinning on rq->lock waiting the dequeue to release it. So, this
looks safe to me as well.

BTW, I could reproduce with Steve's deadline_test [1], and this seems to
fix it.

Would you mind sending out a proper patch Luca?

Thanks!

- Juri

1 - https://goo.gl/fVbRSu
