Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0095C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ED9214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407349AbfHIR2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfHIR2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:28:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 858C13082B1F;
        Fri,  9 Aug 2019 17:28:41 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E18E600CC;
        Fri,  9 Aug 2019 17:28:40 +0000 (UTC)
Date:   Fri, 9 Aug 2019 13:28:38 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     vincent.guittot@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/fair: Use rq_lock/unlock in
 online_fair_sched_group
Message-ID: <20190809172837.GB18727@pauld.bos.csb>
References: <20190801133749.11033-1-pauld@redhat.com>
 <tip-6b8fd01b21f5f2701b407a7118f236ba4c41226d@git.kernel.org>
 <dfc8f652-ca98-e30a-546f-e6a2df36e33a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc8f652-ca98-e30a-546f-e6a2df36e33a@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 09 Aug 2019 17:28:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 06:21:22PM +0200 Dietmar Eggemann wrote:
> On 8/8/19 1:01 PM, tip-bot for Phil Auld wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 19c58599e967..d9407517dae9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10281,18 +10281,18 @@ err:
> >  void online_fair_sched_group(struct task_group *tg)
> >  {
> >  	struct sched_entity *se;
> > +	struct rq_flags rf;
> >  	struct rq *rq;
> >  	int i;
> >  
> >  	for_each_possible_cpu(i) {
> >  		rq = cpu_rq(i);
> >  		se = tg->se[i];
> > -
> > -		raw_spin_lock_irq(&rq->lock);
> > +		rq_lock(rq, &rf);
> >  		update_rq_clock(rq);
> >  		attach_entity_cfs_rq(se);
> >  		sync_throttle(tg, i);
> > -		raw_spin_unlock_irq(&rq->lock);
> > +		rq_unlock(rq, &rf);
> >  	}
> >  }
> 
> Shouldn't this be:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d9407517dae9..1054d2cf6aaa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10288,11 +10288,11 @@ void online_fair_sched_group(struct task_group
> *tg)
>         for_each_possible_cpu(i) {
>                 rq = cpu_rq(i);
>                 se = tg->se[i];
> -               rq_lock(rq, &rf);
> +               rq_lock_irq(rq, &rf);
>                 update_rq_clock(rq);
>                 attach_entity_cfs_rq(se);
>                 sync_throttle(tg, i);
> -               rq_unlock(rq, &rf);
> +               rq_unlock_irq(rq, &rf);
>         }
>  }
> 
> Currently, you should get a 'inconsistent lock state' warning with
> CONFIG_PROVE_LOCKING.

Yes, indeed. Sorry about that. Maybe it can be fixed in tip before 
it gets any farther?  Or do we need a new patch?


Cheers,
Phil

-- 
