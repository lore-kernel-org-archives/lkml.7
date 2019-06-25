Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10BAC4646B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B6F2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561423389;
	bh=qj5i57JAwdvtRUu3tXXvC5SbPBVOp5TOwUDHMMZ2hgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pMoJXmWZHAxnbMiu9+vnvrdohLN6pVj4/cSmG8nrrHix9Fh2w1K6wsl+Xk+a3i0UC
	 RqkbH4fjTr9fEEJaYn0X3GOFq7LbLzSQmqzL7zX2F35AHES6jQwn7w6PTN+aui7nqV
	 m6UFK9ba1GVvMeIViyltl6uzlM6H4YArN8B/boHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfFYAnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbfFYAnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:43:04 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C77206DD;
        Tue, 25 Jun 2019 00:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561423383;
        bh=qj5i57JAwdvtRUu3tXXvC5SbPBVOp5TOwUDHMMZ2hgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBhO+1b2f0WHMAKT8TKAOnoLPzkuOWXDgbmqu/5oZ2NjG9uNhkAQ8+OLk9gKbAX2c
         ezXbqAO4gHbmNr+/RXMUUisfTF1Pjol8VQTITbQS4WlZk4ijDUM2VLa4kOS60535rN
         Il/B3vBn2eHltFAL/rQk7D/3nfueHVsSWNHwFi6U=
Date:   Tue, 25 Jun 2019 02:43:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190625004300.GB17497@lerouge>
References: <20190620221336.GZ26519@linux.ibm.com>
 <20190621105503.GI3436@hirez.programming.kicks-ass.net>
 <20190621121630.GE26519@linux.ibm.com>
 <20190621122927.GV3402@hirez.programming.kicks-ass.net>
 <20190621133414.GF26519@linux.ibm.com>
 <20190621174104.GA7519@linux.ibm.com>
 <20190621175027.GA23260@linux.ibm.com>
 <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624234422.GP26519@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 04:44:22PM -0700, Paul E. McKenney wrote:
> On Tue, Jun 25, 2019 at 01:12:23AM +0200, Frederic Weisbecker wrote:
> > On Fri, Jun 21, 2019 at 04:46:02PM -0700, Paul E. McKenney wrote:
> > > @@ -3097,13 +3126,21 @@ static void sched_tick_remote(struct work_struct *work)
> > >  	/*
> > >  	 * Run the remote tick once per second (1Hz). This arbitrary
> > >  	 * frequency is large enough to avoid overload but short enough
> > > -	 * to keep scheduler internal stats reasonably up to date.
> > > +	 * to keep scheduler internal stats reasonably up to date.  But
> > > +	 * first update state to reflect hotplug activity if required.
> > >  	 */
> > > +	os = atomic_read(&twork->state);
> > > +	if (os) {
> > > +		WARN_ON_ONCE(os != TICK_SCHED_REMOTE_OFFLINING);
> > > +		if (atomic_inc_not_zero(&twork->state))
> > > +			return;
> > 
> > Using inc makes me a bit nervous here. If we do so, we should somewhow
> > make sure that we never exceed a value higher than TICK_SCHED_REMOTE_OFFLINE
> > by accident.
> > 
> > atomic_xchg() is probably a bit costlier but also safer as it allows
> > us to check both the old and the new value. That path shouldn't be critically fast
> > after all.
> 
> It would need to be cmpxchg() to avoid messing with the state if
> the state were somehow TICK_SCHED_REMOTE_RUNNING, right?

Ah indeed! Nevermind, let's keep things as they are then.

> > > +	}
> > >  	queue_delayed_work(system_unbound_wq, dwork, HZ);
> > >  }
> > >  
> > >  static void sched_tick_start(int cpu)
> > >  {
> > > +	int os;
> > >  	struct tick_work *twork;
> > >  
> > >  	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
> > > @@ -3112,15 +3149,20 @@ static void sched_tick_start(int cpu)
> > >  	WARN_ON_ONCE(!tick_work_cpu);
> > >  
> > >  	twork = per_cpu_ptr(tick_work_cpu, cpu);
> > > -	twork->cpu = cpu;
> > > -	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
> > > -	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
> > > +	os = atomic_xchg(&twork->state, TICK_SCHED_REMOTE_RUNNING);
> > > +	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING);
> > 
> > See if we use atomic_inc(), we would need to also WARN(os > TICK_SCHED_REMOTE_OFFLINE).
> 
> How about if I put that WARN() between the atomic_inc_not_zero() and
> the return, presumably also adding braces?

Yeah, unfortunately there is no atomic_add_not_zero_return().
I guess we can live with a check using atomic_read(). In the best
case it returns the fresh increment, otherwise it should be REMOTE_RUNNING.

In any case the (os > TICK_SCHED_REMOTE_OFFLINE) check applies.

Thanks.
