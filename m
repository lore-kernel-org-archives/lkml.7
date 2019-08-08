Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58853C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355292186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfHHJ1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:27:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38985 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfHHJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:27:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so1677383wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 02:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+wAOarceN6JsDV9dX8Bi8ro/VvYkzelKra0BqUp7fk=;
        b=k79BVL0RLZuNPDDfl1d/Hmjwe1STALtAk0BZfEZnF5hamR8MFLRg1uqcevpxgqP+Xh
         f9gCRAhHUPUErwfKa+m3OVnSh2+e7ncX1H6z3sImuJvROgAk0tt6/UM5ki10CtNFjx/u
         5HInzyOuZb/Sa1nAwIBCCDn/9TQrURRfPHmoTjbeBYZcOv82QU7uXHVEyC3sGLwMaKsA
         QRzel/dF8mKKDOgiAIoHgfR81pYtOtyXjnJbVYXrXNKvNJ1ZEqLXjIu8ur9ocDRw75be
         wJyqFQV7Yhnkdt1VOZWRVdBRcV3eJAEzcj8hLkLP+MEUq0hbL5Seg60ypiMLA6+SNdrS
         Q5mg==
X-Gm-Message-State: APjAAAWAc5Fz4Oc3NntYdTQ13sGLzgx1isceLSLuBpQmemh13jL4IT4+
        OV1FoMob9sN9xRA987/2SbLvN99W1l0=
X-Google-Smtp-Source: APXvYqwQdsbKOEE/PwWPci5LuNpGGpEsb0wwQP/KJOMVuD3lmgo5CC655/acl5e9fAwDuJ0Hx+fUDA==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr3395947wmj.31.1565256467228;
        Thu, 08 Aug 2019 02:27:47 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id k9sm29251813wrd.46.2019.08.08.02.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 02:27:46 -0700 (PDT)
Date:   Thu, 8 Aug 2019 11:27:44 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190808092744.GI29310@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
 <20190808075635.GB17205@worktop.programming.kicks-ass.net>
 <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
 <20190808084652.GG29310@localhost.localdomain>
 <99a8339d-8e06-bff8-284b-1829d0683a7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a8339d-8e06-bff8-284b-1829d0683a7a@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/19 10:57, Dietmar Eggemann wrote:
> On 8/8/19 10:46 AM, Juri Lelli wrote:
> > On 08/08/19 10:11, Dietmar Eggemann wrote:
> >> On 8/8/19 9:56 AM, Peter Zijlstra wrote:
> >>> On Wed, Aug 07, 2019 at 06:31:59PM +0200, Dietmar Eggemann wrote:
> >>>> On 7/26/19 4:54 PM, Peter Zijlstra wrote:
> >>>>>
> >>>>>
> >>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>>>
> >>>> [...]
> >>>>
> >>>>> @@ -889,6 +891,8 @@ static void update_curr(struct cfs_rq *c
> >>>>>  		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
> >>>>>  		cgroup_account_cputime(curtask, delta_exec);
> >>>>>  		account_group_exec_runtime(curtask, delta_exec);
> >>>>> +		if (curtask->server)
> >>>>> +			dl_server_update(curtask->server, delta_exec);
> >>>>>  	}
> >>>>
> >>>> I get a lockdep_assert_held(&rq->lock) related warning in start_dl_timer()
> >>>> when running the full stack.
> >>>
> >>> That would seem to imply a stale curtask->server value; the hunk below:
> >>>
> >>> --- a/kernel/sched/core.c
> >>> +++ b/kernel/sched/core.c
> >>> @@ -3756,8 +3756,11 @@ pick_next_task(struct rq *rq, struct tas
> >>>
> >>>         for_each_class(class) {
> >>>                 p = class->pick_next_task(rq, NULL, NULL);
> >>> -               if (p)
> >>> +               if (p) {
> >>> +                       if (p->sched_class == class && p->server)
> >>> +                               p->server = NULL;
> >>>                         return p;
> >>> +               }
> >>>         }
> >>>
> >>>
> >>> Was supposed to clear p->server, but clearly something is going 'funny'.
> >>
> >> What about the fast path in pick_next_task()?
> >>
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index bffe849b5a42..f1ea6ae16052 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -3742,6 +3742,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >>                 if (unlikely(!p))
> >>                         p = idle_sched_class.pick_next_task(rq, prev, rf);
> >>  
> >> +               if (p->sched_class == &fair_sched_class && p->server)
> >> +                       p->server = NULL;
> >> +
> > 
> > Hummm, but then who sets it back to the correct server. AFAIU
> > update_curr() needs a ->server to do the correct DL accounting?
> 
> Ah, OK, this would kill the whole functionality ;-)
> 

I'm thinking we could use &rq->fair_server. It seems to pass the point
we are discussing about, but then virt box becomes unresponsive (busy
loops).
