Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62921C46498
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43049216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfGEDxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 23:53:24 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:41455 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727116AbfGEDxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:53:23 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 5 Jul 2019 12:53:20 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.121 with ESMTP; 5 Jul 2019 12:53:20 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 5 Jul 2019 12:52:31 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH] rcuperf: Make rcuperf kernel test more robust for
 !expedited mode
Message-ID: <20190705035231.GA31088@X58A-UD3R>
References: <20190704043431.208689-1-joel@joelfernandes.org>
 <20190704174044.GK26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704174044.GK26519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 10:40:44AM -0700, Paul E. McKenney wrote:
> On Thu, Jul 04, 2019 at 12:34:30AM -0400, Joel Fernandes (Google) wrote:
> > It is possible that the rcuperf kernel test runs concurrently with init
> > starting up.  During this time, the system is running all grace periods
> > as expedited.  However, rcuperf can also be run for normal GP tests.
> > Right now, it depends on a holdoff time before starting the test to
> > ensure grace periods start later. This works fine with the default
> > holdoff time however it is not robust in situations where init takes
> > greater than the holdoff time to finish running. Or, as in my case:
> > 
> > I modified the rcuperf test locally to also run a thread that did
> > preempt disable/enable in a loop. This had the effect of slowing down
> > init. The end result was that the "batches:" counter in rcuperf was 0
> > causing a division by 0 error in the results. This counter was 0 because
> > only expedited GPs seem to happen, not normal ones which led to the
> > rcu_state.gp_seq counter remaining constant across grace periods which
> > unexpectedly happen to be expedited. The system was running expedited
> > RCU all the time because rcu_unexpedited_gp() would not have run yet
> > from init.  In other words, the test would concurrently with init
> > booting in expedited GP mode.
> > 
> > To fix this properly, let us check if system_state if SYSTEM_RUNNING
> > is set before starting the test. The system_state approximately aligns

Just minor typo..

To fix this properly, let us check if system_state if SYSTEM_RUNNING
is set before starting the test. ...

Should be

To fix this properly, let us check if system_state is set to
SYSTEM_RUNNING before starting the test. ...

Thanks,
Byungchul

> > with when rcu_unexpedited_gp() is called and works well in practice.
> > 
> > I also tried late_initcall however it is still too early to be
> > meaningful for this case.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Good catch, queued, thank you!
> 
> 							Thanx, Paul
> 
> > ---
> >  kernel/rcu/rcuperf.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index 4513807cd4c4..5a879d073c1c 100644
> > --- a/kernel/rcu/rcuperf.c
> > +++ b/kernel/rcu/rcuperf.c
> > @@ -375,6 +375,14 @@ rcu_perf_writer(void *arg)
> >  	if (holdoff)
> >  		schedule_timeout_uninterruptible(holdoff * HZ);
> >  
> > +	/*
> > +	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
> > +	 * so that RCU is not always expedited for normal GP tests.
> > +	 * The system_state test is approximate, but works well in practice.
> > +	 */
> > +	while (!gp_exp && system_state != SYSTEM_RUNNING)
> > +		schedule_timeout_uninterruptible(1);
> > +
> >  	t = ktime_get_mono_fast_ns();
> >  	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
> >  		t_rcu_perf_writer_started = t;
> > -- 
> > 2.22.0.410.gd8fdbe21b5-goog
> > 
