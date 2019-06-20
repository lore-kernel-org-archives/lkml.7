Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D1EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4005120644
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFTQBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:01:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726551AbfFTQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:01:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KFvAn1049462;
        Thu, 20 Jun 2019 12:01:18 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8cg229yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 12:01:18 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5KFuWLG009842;
        Thu, 20 Jun 2019 16:01:17 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2t4ra72h3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jun 2019 16:01:17 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KG1H7V54460858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 16:01:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBC9BB2068;
        Thu, 20 Jun 2019 16:01:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8688B2071;
        Thu, 20 Jun 2019 16:01:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 16:01:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 72F2516C2FA6; Thu, 20 Jun 2019 09:01:18 -0700 (PDT)
Date:   Thu, 20 Jun 2019 09:01:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190620160118.GQ26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190619181903.GA14233@linux.ibm.com>
 <20190620121032.GU3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620121032.GU3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 02:10:32PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 19, 2019 at 11:19:03AM -0700, Paul E. McKenney wrote:
> > [ Hearing no objections and given no test failures in multiple weeks of
> >   rcutorture testing, I intend to submit this to the upcoming merge
> >   window.  Thoughts? ]
> 
> I can't remember seeing this before; but then, there's a ton of unread
> email in the inbox :-(

I have no idea whether or not you were on CC in the earlier thread.
But you are now!  ;-)

> > Some debugging code showed that the culprit was sched_cpu_dying().
> > It had irqs enabled after return from sched_tick_stop().  Which in turn
> > had irqs enabled after return from cancel_delayed_work_sync().  Which is a
> > wrapper around __cancel_work_timer().  Which can sleep in the case where
> > something else is concurrently trying to cancel the same delayed work,
> > and as Thomas Gleixner pointed out on IRC, sleeping is a decidedly bad
> > idea when you are invoked from take_cpu_down(), regardless of the state
> > you leave interrupts in upon return.
> > 
> > Code inspection located no reason why the delayed work absolutely
> > needed to be canceled from sched_tick_stop():  The work is not
> > bound to the outgoing CPU by design, given that the whole point is
> > to collect statistics without disturbing the outgoing CPU.
> > 
> > This commit therefore simply drops the cancel_delayed_work_sync() from
> > sched_tick_stop().  Instead, a new ->state field is added to the tick_work
> > structure so that the delayed-work handler function sched_tick_remote()
> > can avoid reposting itself.  A cpu_is_offline() check is also added to
> > sched_tick_remote() to avoid mucking with the state of an offlined CPU
> > (though it does appear safe to do so).  The sched_tick_start() and
> > sched_tick_stop() functions also update ->state, and sched_tick_start()
> > also schedules the delayed work if ->state indicates that it is not
> > already in flight.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 102dfcf0a29a..8409c83aa5fa 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3050,14 +3050,44 @@ void scheduler_tick(void)
> >  
> >  struct tick_work {
> >  	int			cpu;
> > +	int			state;
> >  	struct delayed_work	work;
> >  };
> > +// Values for ->state, see diagram below.
> > +#define TICK_SCHED_REMOTE_OFFLINE	0
> > +#define TICK_SCHED_REMOTE_RUNNING	1
> > +#define TICK_SCHED_REMOTE_OFFLINING	2
> 
> That seems a daft set of values; consider { RUNNING, OFFLINING, OFFLINE }
> and see below.

As in make it an enum?  I could do that.

> > +
> > +// State diagram for ->state:
> > +//
> > +//
> > +//      +----->OFFLINE--------------------------+
> > +//      |                                       |
> > +//      |                                       |
> > +//      |                                       | sched_tick_start()
> > +//      | sched_tick_remote()                   |
> > +//      |                                       |
> > +//      |                                       V
> > +//      |                        +---------->RUNNING
> > +//      |                        |              |
> > +//      |                        |              |
> > +//      |                        |              |
> > +//      |     sched_tick_start() |              | sched_tick_stop()
> > +//      |                        |              |
> > +//      |                        |              |
> > +//      |                        |              |
> > +//      +--------------------OFFLINING<---------+
> > +//
> > +//
> > +// Other transitions get WARN_ON_ONCE(), except that sched_tick_remote()
> > +// and sched_tick_start() are happy to leave the state in RUNNING.
> 
> Can we please stick to old skool C comments?

Your file, your rules!

> Also, I find it harder to read that needed, maybe a little something
> like so:
> 
> /*
>  *              OFFLINE
>  *               |   ^
>  *               |   | tick_remote()
>  *               |   |
>  *               +--OFFLINING
>  *               |   ^
>  *  tick_start() |   | tick_stop()
>  *               v   |
>  *              RUNNING
>  */

As in remove the leading "sched_" from the function names?  (The names
were already there, so I left them be.)

> >  static struct tick_work __percpu *tick_work_cpu;
> >  
> >  static void sched_tick_remote(struct work_struct *work)
> >  {
> >  	struct delayed_work *dwork = to_delayed_work(work);
> > +	int os;
> 
> this should go at the end, reverse xmas tree preference and all that.

Alphabetical by variable name for me, but your file, your rules!

> >  	struct tick_work *twork = container_of(dwork, struct tick_work, work);
> >  	int cpu = twork->cpu;
> >  	struct rq *rq = cpu_rq(cpu);
> > @@ -3077,7 +3107,7 @@ static void sched_tick_remote(struct work_struct *work)
> >  
> >  	rq_lock_irq(rq, &rf);
> >  	curr = rq->curr;
> > -	if (is_idle_task(curr))
> > +	if (is_idle_task(curr) || cpu_is_offline(cpu))
> >  		goto out_unlock;
> >  
> >  	update_rq_clock(rq);
> > @@ -3097,13 +3127,22 @@ static void sched_tick_remote(struct work_struct *work)
> >  	/*
> >  	 * Run the remote tick once per second (1Hz). This arbitrary
> >  	 * frequency is large enough to avoid overload but short enough
> > -	 * to keep scheduler internal stats reasonably up to date.
> > +	 * to keep scheduler internal stats reasonably up to date.  But
> > +	 * first update state to reflect hotplug activity if required.
> >  	 */
> > -	queue_delayed_work(system_unbound_wq, dwork, HZ);
> > +	do {
> > +		os = READ_ONCE(twork->state);
> > +		WARN_ON_ONCE(os == TICK_SCHED_REMOTE_OFFLINE);
> > +		if (os == TICK_SCHED_REMOTE_RUNNING)
> > +			break;
> > +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_OFFLINE) != os);
> > +	if (os == TICK_SCHED_REMOTE_RUNNING)
> > +		queue_delayed_work(system_unbound_wq, dwork, HZ);
> >  }
> >  
> >  static void sched_tick_start(int cpu)
> >  {
> > +	int os;
> >  	struct tick_work *twork;
> >  
> >  	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
> > @@ -3112,14 +3151,23 @@ static void sched_tick_start(int cpu)
> >  	WARN_ON_ONCE(!tick_work_cpu);
> >  
> >  	twork = per_cpu_ptr(tick_work_cpu, cpu);
> > -	twork->cpu = cpu;
> > -	INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
> > -	queue_delayed_work(system_unbound_wq, &twork->work, HZ);
> > +	do {
> > +		os = READ_ONCE(twork->state);
> > +		if (WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING))
> > +			break;
> > +		// Either idle or offline for a short period
> > +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_RUNNING) != os);
> > +	if (os == TICK_SCHED_REMOTE_OFFLINE) {
> > +		twork->cpu = cpu;
> > +		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
> > +		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
> > +	}
> >  }
> >  
> >  #ifdef CONFIG_HOTPLUG_CPU
> >  static void sched_tick_stop(int cpu)
> >  {
> > +	int os;
> >  	struct tick_work *twork;
> >  
> >  	if (housekeeping_cpu(cpu, HK_FLAG_TICK))
> > @@ -3128,7 +3176,13 @@ static void sched_tick_stop(int cpu)
> >  	WARN_ON_ONCE(!tick_work_cpu);
> >  
> >  	twork = per_cpu_ptr(tick_work_cpu, cpu);
> > -	cancel_delayed_work_sync(&twork->work);
> > +	// There cannot be competing actions, but don't rely on stop_machine.
> > +	do {
> > +		os = READ_ONCE(twork->state);
> > +		WARN_ON_ONCE(os != TICK_SCHED_REMOTE_RUNNING);
> > +		// Either idle or offline for a short period
> > +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_OFFLINING) != os);
> > +	// Don't cancel, as this would mess up the state machine.
> >  }
> >  #endif /* CONFIG_HOTPLUG_CPU */
> 
> While not wrong, it seems overly complicated; can't we do something
> like:
> 
> tick:

As in sched_tick_remote(), right?

> 	state = atomic_read(->state);
> 	if (state) {

You sure you don't want "if (state != RUNNING)"?  But I guess you need
to understand that RUNNING==0 to understand the atomic_inc_not_zero().

> 		WARN_ON_ONCE(state != OFFLINING);
> 		if (atomic_inc_not_zero(->state))

This assumes that there cannot be concurrent calls to sched_tick_remote(),
otherwise, you can end up with ->state==3.  Which is a situation that
my version does a WARN_ON_ONCE() for, so I guess the only difference is
that mine would be guaranteed to complain and yours would complain with
high probability.  So fair enough!

> 			return;
> 	}
> 	queue_delayed_work();
> 
> 
> stop:
> 	/*
> 	 * This is hotplug; even without stop-machine, there cannot be
> 	 * concurrency on offlining specific CPUs.
> 	 */
> 	state = atomic_read(->state);

There cannot be a sched_tick_stop() or sched_tick_stop(), but there really
can be a sched_tick_remote() right here in the absence of stop-machine,
can't there?  Or am I missing something other than stop-machine that
prevents this?

Now, you could argue that concurrency is safe: Either sched_tick_remote()
sees RUNNING and doesn't touch the value, or it sees offlining and
sched_tick_stop() makes no further changes, but I am not sure that
this qualifies as simpler...

> 	WARN_ON_ONCE(state != RUNNING);
> 	atomic_set(->state, OFFLINING);

Another option would be to use atomic_xchg() as below instead of the
atomic_read()/atomic_set() pair.  Would that work for you?

> start:
> 	state = atomic_xchg(->state, RUNNING);
> 	WARN_ON_ONCE(state == RUNNING);
> 	if (state == OFFLINE) {
> 		// ...
> 		queue_delayed_work();
> 	}

This one looks to be an improvement on mine regardless of the other two.

								Thanx, Paul
