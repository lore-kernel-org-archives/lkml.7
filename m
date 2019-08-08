Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C024C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1441E2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfHHGwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:52:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55527 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbfHHGwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:52:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so1214619wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 23:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9sum2rKDKD80VbDxgEa5452kAOPQ1tWsrpFAsn0IRm0=;
        b=JYDWiDBu/SqsTrgDjWOGerCWBos+GAEvvJ106hBhj0ESFrDxDki0343ZIopy96zjmI
         Zp9TEOuybeuBbJf/O3twPKOM0Nj4SqxVX5kBxSz8E2pEWuSP5ytSdHE9xuO6PzcvVd+y
         dCu3XA7bPMH7eE/cOVTScvrpnQFgRybWp10zT4VwXFPiiiNV4EUrSP1IwN657YEaKTMn
         wjh8w2FbGUu6MFC1LSib0iYt/rvymo/F68iRGFQSfOqnleP/Xfa5GmJe7w6U1n3l21lN
         J2aecpn3ogmiRT9t4+A3b1gyhV/rTOt92tFlRVKJ29hQeloIRRWGe0Ha7oWKOWZT4MTt
         mRGw==
X-Gm-Message-State: APjAAAWltdL8TxaG/KSvuEu+K+r9eX+vvihtmyYzt7LwrLQVdTNf8ATg
        13p5Fl850bJ89ybJmrvGir24GQ==
X-Google-Smtp-Source: APXvYqxFiutx7k9CykMYMz1GaLlNS/gIE9xUd3wICV7FTJc0loQ4P+j3AutCV5eFBTrawmxR+DdnUw==
X-Received: by 2002:a1c:7a12:: with SMTP id v18mr2508262wmc.113.1565247148179;
        Wed, 07 Aug 2019 23:52:28 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id j17sm1576604wru.24.2019.08.07.23.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 23:52:27 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:52:25 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190808065225.GD29310@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On 07/08/19 18:31, Dietmar Eggemann wrote:
> On 7/26/19 4:54 PM, Peter Zijlstra wrote:
> > 
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> [...]
> 
> > @@ -889,6 +891,8 @@ static void update_curr(struct cfs_rq *c
> >  		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
> >  		cgroup_account_cputime(curtask, delta_exec);
> >  		account_group_exec_runtime(curtask, delta_exec);
> > +		if (curtask->server)
> > +			dl_server_update(curtask->server, delta_exec);
> >  	}
> 
> I get a lockdep_assert_held(&rq->lock) related warning in start_dl_timer()
> when running the full stack.
> 
> ...
> [    0.530216] root domain span: 0-5 (max cpu_capacity = 1024)
> [    0.538655] devtmpfs: initialized
> [    0.556485] update_curr: rq mismatch rq[0] != rq[4]
> [    0.561519] update_curr: rq mismatch rq[0] != rq[4]
> [    0.566497] update_curr: rq mismatch rq[0] != rq[4]
> [    0.571443] update_curr: rq mismatch rq[0] != rq[4]
> [    0.576762] update_curr: rq mismatch rq[2] != rq[4]
> [    0.581674] update_curr: rq mismatch rq[2] != rq[4]
> [    0.586569] ------------[ cut here ]------------
> [    0.591220] WARNING: CPU: 2 PID: 2 at kernel/sched/deadline.c:916 start_dl_timer+0x160/0x178
> [    0.599686] Modules linked in:
> [    0.602756] CPU: 2 PID: 2 Comm: kthreadd Tainted: G        W         5.3.0-rc3-00013-ga33cf033cc99-dirty #64
> [    0.612620] Hardware name: ARM Juno development board (r0) (DT)
> [    0.618560] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    0.623369] pc : start_dl_timer+0x160/0x178
> [    0.627572] lr : start_dl_timer+0x160/0x178
> [    0.631768] sp : ffff000010013cb0
> ...
> [    0.715075] Call trace:
> [    0.717531]  start_dl_timer+0x160/0x178
> [    0.721382]  update_curr_dl_se+0x108/0x208
> [    0.725494]  dl_server_update+0x2c/0x38
> [    0.729348]  update_curr+0x1b4/0x3b8
> [    0.732934]  task_tick_fair+0x74/0xa88
> [    0.736698]  scheduler_tick+0x94/0x110
> [    0.740461]  update_process_times+0x48/0x60
> ...
> 
> Seems to be related to the fact that the rq can change:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4c14851a34c..5e3130a200ec 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -891,8 +891,17 @@ static void update_curr(struct cfs_rq *cfs_rq)
>                 trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
>                 cgroup_account_cputime(curtask, delta_exec);
>                 account_group_exec_runtime(curtask, delta_exec);
> -               if (curtask->server)
> +               if (curtask->server) {
> +                       struct rq *rq = rq_of(cfs_rq);
> +                       struct rq *rq2 = curtask->server->rq;
> +
> +                       if (rq != rq2) {
> +                               printk("update_curr: rq mismatch rq[%d] != rq[%d]\n",
> +                                      cpu_of(rq), cpu_of(rq2));
> +                       }
> +
>                         dl_server_update(curtask->server, delta_exec);
> +               }
>         }
> 
> ...

Yeah, I actually noticed the same. Some debugging seems to point to
early boot spawning of kthreads. I can reliably for example attribute
this mismatch to ksoftirqd(s). It looks like they can avoid the
dl_server assignment in pick_next_task_dl() and this breaks things.
Still need to figure out why this happens and how to fix it, though.

Best,

Juri
