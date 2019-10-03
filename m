Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07348C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBEF20873
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570110304;
	bh=dEF07+o0YwK6wPqO3j1cYpwxNmDA/nwjOQy2BUMZGaQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XR3OpjdY98UqX1VDCs8x3uj5fjQZCT+GaTLGJNQKY6Q0o5CeWhhAKcqTWmCy+GIMa
	 f7b6htupIirQn11DPG4Ce+Jy0NXlLASguFHx/j6gEr6BX6dsghUu9+62Hp2l6aE+xM
	 502B9TPzrYqiKLEwPrfTZs3TWusEZs+JHoEBMY/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfJCNpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfJCNpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:45:03 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBB720830;
        Thu,  3 Oct 2019 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570110303;
        bh=dEF07+o0YwK6wPqO3j1cYpwxNmDA/nwjOQy2BUMZGaQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UAXmq1Lpl5mzkFv3ggg4LAQfmbSW4kWk7Kn6igCfIK8YGBeSR4VLCkmhuO0M6oIiD
         hqlEA2oXr+Bac0fcHHj98DdHveyGviMF+LLVp/lOgZbz2WTkFTgR6kRKzRKWloiTfW
         RuS6dVmytuQy1V8w6S4Df5vK7Ck1WpNm0lrebj/I=
Date:   Thu, 3 Oct 2019 06:45:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 4/8] rcu: Ensure that ->rcu_urgent_qs is set
 before resched IPI
Message-ID: <20191003134501.GP2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
 <20191003013305.12854-4-paulmck@kernel.org>
 <20191003074319.2df342dd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003074319.2df342dd@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 07:43:19AM -0400, Steven Rostedt wrote:
> On Wed,  2 Oct 2019 18:33:01 -0700
> paulmck@kernel.org wrote:
> 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > The RCU-specific resched_cpu() function sends a resched IPI to the
> > specified CPU, which can be used to force the tick on for a given
> > nohz_full CPU.  This is needed when this nohz_full CPU is looping in the
> > kernel while blocking the current grace period.  However, for the tick
> > to actually be forced on in all cases, that CPU's rcu_data structure's
> > ->rcu_urgent_qs flag must be set beforehand.  This commit therefore  
> > causes rcu_implicit_dynticks_qs() to set this flag prior to invoking
> > resched_cpu() on a holdout nohz_full CPU.
> 
> Should this be marked for stable?

Not unless and until people are actually running into this.  NO_HZ_FULL
has left the tick off for in-kernel loops on nohz_full CPUs for almost
ten years now, and as far as I know, without complaint.

So from what I am seeing, the risk of backporting far exceeds the benefit.

							Thanx, Paul

> -- Steve
> 
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  kernel/rcu/tree.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8110514..0d83b19 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1073,6 +1073,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> >  	if (tick_nohz_full_cpu(rdp->cpu) &&
> >  		   time_after(jiffies,
> >  			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
> > +		WRITE_ONCE(*ruqp, true);
> >  		resched_cpu(rdp->cpu);
> >  		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> >  	}
> 
