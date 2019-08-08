Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D82C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD8F217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfHHIq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:46:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33864 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbfHHIq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:46:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so94096054wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+nwCR321Fw3F7ZHJYZbloauI2zuYmZr88zjTNkWmUU=;
        b=LgSJ20cAT6EMerCEuprKXi7iRhRGBEujjr9VHoOCBm21mf10WylLDNmNg2+Zs+SZ6B
         Y913Sjm1aeYAoJNjl+AS9GPrdylaq2MINi6ic+avieX6dUlCrD/SGXzdWvKt6BGTTaPC
         8gKYLk3EhMwnCqs5cEQqsHQlu8dVoVBWzCQ+6pTFz0t7Mg3E7SOEFy4+eZ6MKEUEh4eP
         4tYx/5zmWX4FKdQQwKo2vBUEs4zb3+EIjVa4+sBE3j9oISLHsHdSVSh+z7AXiA//FCiM
         SOZv1kfv9304u8cm8hBpOk6N6dttxN5rfrpHVLyAbYMd1mASyOXZZ894H3W1wmxJnWZn
         xLlg==
X-Gm-Message-State: APjAAAWlhzxupFciWENTL6JBXwd/f34U1y25+KYERvNbSMalzxn12eKi
        Mi3cmPggWHyoNoGiHQTZo9l5JQ==
X-Google-Smtp-Source: APXvYqyBt+WdhlWEt3znn6hUHzN/Gq+9HthenRLR5HcaMpMEZqciUAFNTCbSKINw/qEd75FnkCokVA==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr16394221wru.310.1565254015829;
        Thu, 08 Aug 2019 01:46:55 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id j16sm49857668wrp.62.2019.08.08.01.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 01:46:54 -0700 (PDT)
Date:   Thu, 8 Aug 2019 10:46:52 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190808084652.GG29310@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
 <20190808075635.GB17205@worktop.programming.kicks-ass.net>
 <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/19 10:11, Dietmar Eggemann wrote:
> On 8/8/19 9:56 AM, Peter Zijlstra wrote:
> > On Wed, Aug 07, 2019 at 06:31:59PM +0200, Dietmar Eggemann wrote:
> >> On 7/26/19 4:54 PM, Peter Zijlstra wrote:
> >>>
> >>>
> >>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>
> >> [...]
> >>
> >>> @@ -889,6 +891,8 @@ static void update_curr(struct cfs_rq *c
> >>>  		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
> >>>  		cgroup_account_cputime(curtask, delta_exec);
> >>>  		account_group_exec_runtime(curtask, delta_exec);
> >>> +		if (curtask->server)
> >>> +			dl_server_update(curtask->server, delta_exec);
> >>>  	}
> >>
> >> I get a lockdep_assert_held(&rq->lock) related warning in start_dl_timer()
> >> when running the full stack.
> > 
> > That would seem to imply a stale curtask->server value; the hunk below:
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3756,8 +3756,11 @@ pick_next_task(struct rq *rq, struct tas
> > 
> >         for_each_class(class) {
> >                 p = class->pick_next_task(rq, NULL, NULL);
> > -               if (p)
> > +               if (p) {
> > +                       if (p->sched_class == class && p->server)
> > +                               p->server = NULL;
> >                         return p;
> > +               }
> >         }
> > 
> > 
> > Was supposed to clear p->server, but clearly something is going 'funny'.
> 
> What about the fast path in pick_next_task()?
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bffe849b5a42..f1ea6ae16052 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3742,6 +3742,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                 if (unlikely(!p))
>                         p = idle_sched_class.pick_next_task(rq, prev, rf);
>  
> +               if (p->sched_class == &fair_sched_class && p->server)
> +                       p->server = NULL;
> +

Hummm, but then who sets it back to the correct server. AFAIU
update_curr() needs a ->server to do the correct DL accounting?
