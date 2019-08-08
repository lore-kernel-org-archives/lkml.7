Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EAEC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166F72173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbfHHJpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:45:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46773 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732231AbfHHJpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:45:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so94240570wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 02:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7sXvTxeRYbxp0e9XZt2ilTAiAwyuUH/IptJSS1pmtk=;
        b=U4bue/3tuIdX49goWpExEveymbs6V4MTGePFvmNm7IU9nH3IyFK+24cas+0SA+4/JV
         FMBPB5ytPDA7YfArvVTJMmWb682EzRXKBe6+nzxL2L2rA1IV10BMSqkgnY2c6bunyW5n
         8BitPONpuepwerxnJuEEzcH34xZnodgETTSkWCkGtqww72tIFKZnsadz+dt0lDC5EBsK
         M7bfusQh8bKKmcRQ64S1/9ZAzo9aFchVjh6buny3z6XK61s1l4koU8V1eZ6L0maZkZom
         wODD1ccYqeQwdI0GRV7ghDbnkzI4A8zs3GbMt0TpEPDy/C4HzDtS5u1LI2pYhmLQ3Dmx
         WD5w==
X-Gm-Message-State: APjAAAUwqYukQ0bNX0nnpUBV4bIPxXBmBIVM4WufSfzMjlQxF8EiIcBX
        vRcj6e7iokxVqK5BdWwMHsru3w==
X-Google-Smtp-Source: APXvYqx51TKRvYEB/J40fr16xEQfSIO+rfadAdf58E+sJBUQb2hTjL8LFRHxEPRmLAavGO6jlAw40Q==
X-Received: by 2002:adf:e390:: with SMTP id e16mr7450920wrm.153.1565257549740;
        Thu, 08 Aug 2019 02:45:49 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id c15sm20285767wrb.80.2019.08.08.02.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 02:45:49 -0700 (PDT)
Date:   Thu, 8 Aug 2019 11:45:46 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190808094546.GJ29310@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
 <20190808075635.GB17205@worktop.programming.kicks-ass.net>
 <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
 <20190808084652.GG29310@localhost.localdomain>
 <99a8339d-8e06-bff8-284b-1829d0683a7a@arm.com>
 <20190808092744.GI29310@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808092744.GI29310@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/19 11:27, Juri Lelli wrote:
> On 08/08/19 10:57, Dietmar Eggemann wrote:
> > On 8/8/19 10:46 AM, Juri Lelli wrote:
> > > On 08/08/19 10:11, Dietmar Eggemann wrote:
> > >> On 8/8/19 9:56 AM, Peter Zijlstra wrote:
> > >>> On Wed, Aug 07, 2019 at 06:31:59PM +0200, Dietmar Eggemann wrote:
> > >>>> On 7/26/19 4:54 PM, Peter Zijlstra wrote:
> > >>>>>
> > >>>>>
> > >>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > >>>>
> > >>>> [...]
> > >>>>
> > >>>>> @@ -889,6 +891,8 @@ static void update_curr(struct cfs_rq *c
> > >>>>>  		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
> > >>>>>  		cgroup_account_cputime(curtask, delta_exec);
> > >>>>>  		account_group_exec_runtime(curtask, delta_exec);
> > >>>>> +		if (curtask->server)
> > >>>>> +			dl_server_update(curtask->server, delta_exec);
> > >>>>>  	}
> > >>>>
> > >>>> I get a lockdep_assert_held(&rq->lock) related warning in start_dl_timer()
> > >>>> when running the full stack.
> > >>>
> > >>> That would seem to imply a stale curtask->server value; the hunk below:
> > >>>
> > >>> --- a/kernel/sched/core.c
> > >>> +++ b/kernel/sched/core.c
> > >>> @@ -3756,8 +3756,11 @@ pick_next_task(struct rq *rq, struct tas
> > >>>
> > >>>         for_each_class(class) {
> > >>>                 p = class->pick_next_task(rq, NULL, NULL);
> > >>> -               if (p)
> > >>> +               if (p) {
> > >>> +                       if (p->sched_class == class && p->server)
> > >>> +                               p->server = NULL;
> > >>>                         return p;
> > >>> +               }
> > >>>         }
> > >>>
> > >>>
> > >>> Was supposed to clear p->server, but clearly something is going 'funny'.
> > >>
> > >> What about the fast path in pick_next_task()?
> > >>
> > >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > >> index bffe849b5a42..f1ea6ae16052 100644
> > >> --- a/kernel/sched/core.c
> > >> +++ b/kernel/sched/core.c
> > >> @@ -3742,6 +3742,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >>                 if (unlikely(!p))
> > >>                         p = idle_sched_class.pick_next_task(rq, prev, rf);
> > >>  
> > >> +               if (p->sched_class == &fair_sched_class && p->server)
> > >> +                       p->server = NULL;
> > >> +
> > > 
> > > Hummm, but then who sets it back to the correct server. AFAIU
> > > update_curr() needs a ->server to do the correct DL accounting?
> > 
> > Ah, OK, this would kill the whole functionality ;-)
> > 
> 
> I'm thinking we could use &rq->fair_server. It seems to pass the point
> we are discussing about, but then virt box becomes unresponsive (busy
> loops).

I'd like to take this last sentence back, I was able to run a few boot +
hackbench + shutdown cycles with the following applied (guess too much
debug printks around before).

--->8---
 kernel/sched/deadline.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3fe82b8f7825..d4a20072d4c0 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1312,6 +1312,10 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
+	if (!dl_server(dl_se)) {
+		dl_se->dl_server = 1;
+		setup_new_dl_entity(dl_se);
+	}
 	enqueue_dl_entity(dl_se, dl_se, ENQUEUE_WAKEUP);
 }
 
@@ -1324,12 +1328,9 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick)
 {
-	dl_se->dl_server = 1;
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
 	dl_se->server_pick = pick;
-
-	setup_new_dl_entity(dl_se);
 }
 
 /*
@@ -2829,6 +2830,7 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
+	dl_se->dl_server		= 0;
 }
 
 void init_dl_entity(struct sched_dl_entity *dl_se)

--->8---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7a161472decd..355cb1382aef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3783,6 +3783,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (unlikely(!p))
 			p = idle_sched_class.pick_next_task(rq, prev, rf);
 
+		if (p->sched_class == &fair_sched_class)
+			p->server = &rq->fair_server;
+
 		return p;
 	}
 
