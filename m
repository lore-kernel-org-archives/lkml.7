Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC83C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CA720679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfD1W1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 18:27:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726393AbfD1W1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 18:27:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3SMIbSH185994
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 18:26:58 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s5f35hy6p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 18:26:58 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 28 Apr 2019 23:26:57 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 28 Apr 2019 23:26:54 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3SMQr9B33751242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Apr 2019 22:26:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37638B2065;
        Sun, 28 Apr 2019 22:26:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B3E1B205F;
        Sun, 28 Apr 2019 22:26:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.36])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 28 Apr 2019 22:26:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B042216C0261; Sun, 28 Apr 2019 15:26:52 -0700 (PDT)
Date:   Sun, 28 Apr 2019 15:26:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rcu/sync: simplify the state machine
Reply-To: paulmck@linux.ibm.com
References: <20190425164054.GA21309@redhat.com>
 <20190425165055.GC21412@redhat.com>
 <20190427210230.GE3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427210230.GE3923@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042822-0052-0000-0000-000003B44554
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011013; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01195785; UDB=6.00627051; IPR=6.00976631;
 MB=3.00026638; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-28 22:26:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042822-0053-0000-0000-000060ADA7C0
Message-Id: <20190428222652.GA30908@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-28_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904280163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 02:02:30PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 25, 2019 at 06:50:55PM +0200, Oleg Nesterov wrote:
> > With this patch rcu_sync has a single state variable and the transition rules
> > become really simple:
> > 
> > 	GP_IDLE   - owned by the first rcu_sync_enter() which moves it to
> > 
> > 	GP_ENTER  - owned by rcu-callback which moves it to
> > 
> > 	GP_PASSED - owned by the last rcu_sync_exit() which moves it to
> > 
> > 	GP_EXIT   - and this is the only "nontrivial" state.
> > 
> > 		rcu-callback moves it back to GP_IDLE unless another enter()
> > 		comes before a GP pass.
> > 
> > 		If rcu-callback is invoked before the next rcu_sync_exit() it
> > 		must see gp_count incremented by that enter() and set GP_PASSED.
> > 
> > 		Otherwise, if the next rcu_sync_exit() wins the race, it will
> > 		move it to
> > 
> > 	GP_REPLAY - owned by rcu-callback which moves it to GP_EXIT
> > 
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> 
> Queued and passing initial tests, thank you!  It may be a day or two
> before it shows up on -rcu, but it will get there!

And it still looks good after review, so I have pushed it.  I did add
READ_ONCE() and WRITE_ONCE() to unprotected uses of ->gp_state, but
please let me know if I messed anything up.

							Thanx, Paul

> > ---
> >  include/linux/rcu_sync.h |   2 -
> >  kernel/rcu/sync.c        | 165 +++++++++++++++++++++++++++--------------------
> >  2 files changed, 95 insertions(+), 72 deletions(-)
> > 
> > diff --git a/include/linux/rcu_sync.h b/include/linux/rcu_sync.h
> > index e7ae221..3156a14 100644
> > --- a/include/linux/rcu_sync.h
> > +++ b/include/linux/rcu_sync.h
> > @@ -19,7 +19,6 @@ struct rcu_sync {
> >  	int			gp_count;
> >  	wait_queue_head_t	gp_wait;
> >  
> > -	int			cb_state;
> >  	struct rcu_head		cb_head;
> >  };
> >  
> > @@ -47,7 +46,6 @@ extern void rcu_sync_dtor(struct rcu_sync *);
> >  		.gp_state = 0,						\
> >  		.gp_count = 0,						\
> >  		.gp_wait = __WAIT_QUEUE_HEAD_INITIALIZER(name.gp_wait),	\
> > -		.cb_state = 0,						\
> >  	}
> >  
> >  #define	DEFINE_RCU_SYNC(name)	\
> > diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> > index ee427e1..d9f80fc 100644
> > --- a/kernel/rcu/sync.c
> > +++ b/kernel/rcu/sync.c
> > @@ -10,15 +10,13 @@
> >  #include <linux/rcu_sync.h>
> >  #include <linux/sched.h>
> >  
> > -enum { GP_IDLE = 0, GP_PENDING, GP_PASSED };
> > -enum { CB_IDLE = 0, CB_PENDING, CB_REPLAY };
> > +enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT, GP_REPLAY };
> >  
> >  #define	rss_lock	gp_wait.lock
> >  
> >  /**
> >   * rcu_sync_init() - Initialize an rcu_sync structure
> >   * @rsp: Pointer to rcu_sync structure to be initialized
> > - * @type: Flavor of RCU with which to synchronize rcu_sync structure
> >   */
> >  void rcu_sync_init(struct rcu_sync *rsp)
> >  {
> > @@ -41,56 +39,26 @@ void rcu_sync_enter_start(struct rcu_sync *rsp)
> >  	rsp->gp_state = GP_PASSED;
> >  }
> >  
> > -/**
> > - * rcu_sync_enter() - Force readers onto slowpath
> > - * @rsp: Pointer to rcu_sync structure to use for synchronization
> > - *
> > - * This function is used by updaters who need readers to make use of
> > - * a slowpath during the update.  After this function returns, all
> > - * subsequent calls to rcu_sync_is_idle() will return false, which
> > - * tells readers to stay off their fastpaths.  A later call to
> > - * rcu_sync_exit() re-enables reader slowpaths.
> > - *
> > - * When called in isolation, rcu_sync_enter() must wait for a grace
> > - * period, however, closely spaced calls to rcu_sync_enter() can
> > - * optimize away the grace-period wait via a state machine implemented
> > - * by rcu_sync_enter(), rcu_sync_exit(), and rcu_sync_func().
> > - */
> > -void rcu_sync_enter(struct rcu_sync *rsp)
> > -{
> > -	bool need_wait, need_sync;
> >  
> > -	spin_lock_irq(&rsp->rss_lock);
> > -	need_wait = rsp->gp_count++;
> > -	need_sync = rsp->gp_state == GP_IDLE;
> > -	if (need_sync)
> > -		rsp->gp_state = GP_PENDING;
> > -	spin_unlock_irq(&rsp->rss_lock);
> > +static void rcu_sync_func(struct rcu_head *rcu);
> >  
> > -	WARN_ON_ONCE(need_wait && need_sync);
> > -	if (need_sync) {
> > -		synchronize_rcu();
> > -		rsp->gp_state = GP_PASSED;
> > -		wake_up_all(&rsp->gp_wait);
> > -	} else if (need_wait) {
> > -		wait_event(rsp->gp_wait, rsp->gp_state == GP_PASSED);
> > -	} else {
> > -		/*
> > -		 * Possible when there's a pending CB from a rcu_sync_exit().
> > -		 * Nobody has yet been allowed the 'fast' path and thus we can
> > -		 * avoid doing any sync(). The callback will get 'dropped'.
> > -		 */
> > -		WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
> > -	}
> > +static void rcu_sync_call(struct rcu_sync *rsp)
> > +{
> > +	call_rcu(&rsp->cb_head, rcu_sync_func);
> >  }
> >  
> >  /**
> >   * rcu_sync_func() - Callback function managing reader access to fastpath
> >   * @rhp: Pointer to rcu_head in rcu_sync structure to use for synchronization
> >   *
> > - * This function is passed to one of the call_rcu() functions by
> > + * This function is passed to call_rcu() function by rcu_sync_enter() and
> >   * rcu_sync_exit(), so that it is invoked after a grace period following the
> > - * that invocation of rcu_sync_exit().  It takes action based on events that
> > + * that invocation of enter/exit.
> > + *
> > + * If it is called by rcu_sync_enter() it signals that all the readers were
> > + * switched onto slow path.
> > + *
> > + * If it is called by rcu_sync_exit() it takes action based on events that
> >   * have taken place in the meantime, so that closely spaced rcu_sync_enter()
> >   * and rcu_sync_exit() pairs need not wait for a grace period.
> >   *
> > @@ -102,40 +70,93 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> >   * rcu_sync_exit().  Otherwise, set all state back to idle so that readers
> >   * can again use their fastpaths.
> >   */
> > -static void rcu_sync_func(struct rcu_head *rhp)
> > +static void rcu_sync_func(struct rcu_head *rcu)
> >  {
> > -	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
> > +	struct rcu_sync *rsp = container_of(rcu, struct rcu_sync, cb_head);
> >  	unsigned long flags;
> >  
> > -	WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
> > -	WARN_ON_ONCE(rsp->cb_state == CB_IDLE);
> > +	WARN_ON_ONCE(rsp->gp_state == GP_IDLE);
> > +	WARN_ON_ONCE(rsp->gp_state == GP_PASSED);
> >  
> >  	spin_lock_irqsave(&rsp->rss_lock, flags);
> >  	if (rsp->gp_count) {
> >  		/*
> > -		 * A new rcu_sync_begin() has happened; drop the callback.
> > +		 * We're at least a GP after the GP_IDLE->GP_ENTER transition.
> >  		 */
> > -		rsp->cb_state = CB_IDLE;
> > -	} else if (rsp->cb_state == CB_REPLAY) {
> > +		rsp->gp_state = GP_PASSED;
> > +		wake_up_locked(&rsp->gp_wait);
> > +	} else if (rsp->gp_state == GP_REPLAY) {
> >  		/*
> > -		 * A new rcu_sync_exit() has happened; requeue the callback
> > -		 * to catch a later GP.
> > +		 * A new rcu_sync_exit() has happened; requeue the callback to
> > +		 * catch a later GP.
> >  		 */
> > -		rsp->cb_state = CB_PENDING;
> > -		call_rcu(&rsp->cb_head, rcu_sync_func);
> > +		rsp->gp_state = GP_EXIT;
> > +		rcu_sync_call(rsp);
> >  	} else {
> >  		/*
> > -		 * We're at least a GP after rcu_sync_exit(); eveybody will now
> > -		 * have observed the write side critical section. Let 'em rip!.
> > +		 * We're at least a GP after the last rcu_sync_exit(); eveybody
> > +		 * will now have observed the write side critical section.
> > +		 * Let 'em rip!.
> >  		 */
> > -		rsp->cb_state = CB_IDLE;
> >  		rsp->gp_state = GP_IDLE;
> >  	}
> >  	spin_unlock_irqrestore(&rsp->rss_lock, flags);
> >  }
> >  
> >  /**
> > - * rcu_sync_exit() - Allow readers back onto fast patch after grace period
> > + * rcu_sync_enter() - Force readers onto slowpath
> > + * @rsp: Pointer to rcu_sync structure to use for synchronization
> > + *
> > + * This function is used by updaters who need readers to make use of
> > + * a slowpath during the update.  After this function returns, all
> > + * subsequent calls to rcu_sync_is_idle() will return false, which
> > + * tells readers to stay off their fastpaths.  A later call to
> > + * rcu_sync_exit() re-enables reader slowpaths.
> > + *
> > + * When called in isolation, rcu_sync_enter() must wait for a grace
> > + * period, however, closely spaced calls to rcu_sync_enter() can
> > + * optimize away the grace-period wait via a state machine implemented
> > + * by rcu_sync_enter(), rcu_sync_exit(), and rcu_sync_func().
> > + */
> > +void rcu_sync_enter(struct rcu_sync *rsp)
> > +{
> > +	int gp_state;
> > +
> > +	spin_lock_irq(&rsp->rss_lock);
> > +	gp_state = rsp->gp_state;
> > +	if (gp_state == GP_IDLE) {
> > +		rsp->gp_state = GP_ENTER;
> > +		WARN_ON_ONCE(rsp->gp_count);
> > +		/*
> > +		 * Note that we could simply do rcu_sync_call(rsp) here and
> > +		 * avoid the "if (gp_state == GP_IDLE)" block below.
> > +		 *
> > +		 * However, synchronize_rcu() can be faster if rcu_expedited
> > +		 * or rcu_blocking_is_gp() is true.
> > +		 *
> > +		 * Another reason is that we can't wait for rcu callback if
> > +		 * we are called at early boot time but this shouldn't happen.
> > +		 */
> > +	}
> > +	rsp->gp_count++;
> > +	spin_unlock_irq(&rsp->rss_lock);
> > +
> > +	if (gp_state == GP_IDLE) {
> > +		/*
> > +		 * See the comment above, this simply does the "synchronous"
> > +		 * call_rcu(rcu_sync_func) which does GP_ENTER -> GP_PASSED.
> > +		 */
> > +		synchronize_rcu();
> > +		rcu_sync_func(&rsp->cb_head);
> > +		/* Not really needed, wait_event() would see GP_PASSED. */
> > +		return;
> > +	}
> > +
> > +	wait_event(rsp->gp_wait, rsp->gp_state >= GP_PASSED);
> > +}
> > +
> > +/**
> > + * rcu_sync_exit() - Allow readers back onto fast path after grace period
> >   * @rsp: Pointer to rcu_sync structure to use for synchronization
> >   *
> >   * This function is used by updaters who have completed, and can therefore
> > @@ -146,13 +167,16 @@ static void rcu_sync_func(struct rcu_head *rhp)
> >   */
> >  void rcu_sync_exit(struct rcu_sync *rsp)
> >  {
> > +	WARN_ON_ONCE(rsp->gp_state == GP_IDLE);
> > +	WARN_ON_ONCE(rsp->gp_count == 0);
> > +
> >  	spin_lock_irq(&rsp->rss_lock);
> >  	if (!--rsp->gp_count) {
> > -		if (rsp->cb_state == CB_IDLE) {
> > -			rsp->cb_state = CB_PENDING;
> > -			call_rcu(&rsp->cb_head, rcu_sync_func);
> > -		} else if (rsp->cb_state == CB_PENDING) {
> > -			rsp->cb_state = CB_REPLAY;
> > +		if (rsp->gp_state == GP_PASSED) {
> > +			rsp->gp_state = GP_EXIT;
> > +			rcu_sync_call(rsp);
> > +		} else if (rsp->gp_state == GP_EXIT) {
> > +			rsp->gp_state = GP_REPLAY;
> >  		}
> >  	}
> >  	spin_unlock_irq(&rsp->rss_lock);
> > @@ -164,18 +188,19 @@ void rcu_sync_exit(struct rcu_sync *rsp)
> >   */
> >  void rcu_sync_dtor(struct rcu_sync *rsp)
> >  {
> > -	int cb_state;
> > +	int gp_state;
> >  
> >  	WARN_ON_ONCE(rsp->gp_count);
> > +	WARN_ON_ONCE(rsp->gp_state == GP_PASSED);
> >  
> >  	spin_lock_irq(&rsp->rss_lock);
> > -	if (rsp->cb_state == CB_REPLAY)
> > -		rsp->cb_state = CB_PENDING;
> > -	cb_state = rsp->cb_state;
> > +	if (rsp->gp_state == GP_REPLAY)
> > +		rsp->gp_state = GP_EXIT;
> > +	gp_state = rsp->gp_state;
> >  	spin_unlock_irq(&rsp->rss_lock);
> >  
> > -	if (cb_state != CB_IDLE) {
> > +	if (gp_state != GP_IDLE) {
> >  		rcu_barrier();
> > -		WARN_ON_ONCE(rsp->cb_state != CB_IDLE);
> > +		WARN_ON_ONCE(rsp->gp_state != GP_IDLE);
> >  	}
> >  }
> > -- 
> > 2.5.0
> > 
> > 

