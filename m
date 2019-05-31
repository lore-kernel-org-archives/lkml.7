Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E0EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63AC24499
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfEaNnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:43:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726512AbfEaNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:43:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VDWP2B003210
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:43:06 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2su51es1wc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:43:06 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 31 May 2019 14:43:05 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 May 2019 14:43:03 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4VDh2HH12320900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 13:43:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC731B205F;
        Fri, 31 May 2019 13:43:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B948DB2065;
        Fri, 31 May 2019 13:43:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 31 May 2019 13:43:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D0BDF16C35A1; Fri, 31 May 2019 06:43:03 -0700 (PDT)
Date:   Fri, 31 May 2019 06:43:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Reply-To: paulmck@linux.ibm.com
References: <20190527143932.GA10527@linux.ibm.com>
 <alpine.DEB.2.21.1905281300340.1859@nanos.tec.linutronix.de>
 <20190529181941.GZ28207@linux.ibm.com>
 <20190530125809.GA25376@linux.ibm.com>
 <20190531013639.GA32307@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531013639.GA32307@lerouge>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053113-0060-0000-0000-0000034A7A6E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011190; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01211238; UDB=6.00636430; IPR=6.00992274;
 MB=3.00027132; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-31 13:43:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053113-0061-0000-0000-00004990B2BE
Message-Id: <20190531134303.GK28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 03:36:40AM +0200, Frederic Weisbecker wrote:
> On Thu, May 30, 2019 at 05:58:09AM -0700, Paul E. McKenney wrote:
> >     It turns out that tick_broadcast_offline() was an innocent bystander.
> >     After all, interrupts are supposed to be disabled throughout
> >     take_cpu_down(), and therefore should have been disabled upon entry to
> >     tick_offline_cpu() and thus to tick_broadcast_offline().  This suggests
> >     that one of the CPU-hotplug notifiers was incorrectly enabling interrupts,
> >     and leaving them enabled on return.
> >     
> >     Some debugging code showed that the culprit was sched_cpu_dying().
> >     It had irqs enabled after return from sched_tick_stop().  Which in turn
> >     had irqs enabled after return from cancel_delayed_work_sync().  Which is a
> >     wrapper around __cancel_work_timer().  Which can sleep in the case where
> >     something else is concurrently trying to cancel the same delayed work,
> >     and as Thomas Gleixner pointed out on IRC, sleeping is a decidedly bad
> >     idea when you are invoked from take_cpu_down(), regardless of the state
> >     you leave interrupts in upon return.
> 
> Nice catch! Sorry for leaving that puzzle behind.

Heh!  I needed the break from trying to make RCU do unnatural acts.  ;-)

> >     Code inspection located no reason why the delayed work absolutely
> >     needed to be canceled from sched_tick_stop():  The work is not
> >     bound to the outgoing CPU by design, given that the whole point is
> >     to collect statistics without disturbing the outgoing CPU.
> >     
> >     This commit therefore simply drops the cancel_delayed_work_sync() from
> >     sched_tick_stop().  Instead, a new ->state field is added to the tick_work
> >     structure so that the delayed-work handler function sched_tick_remote()
> >     can avoid reposting itself.  A cpu_is_offline() check is also added to
> >     sched_tick_remote() to avoid mucking with the state of an offlined CPU
> >     (though it does appear safe to do so).
> 
> I can't guarantee that it is safe myself to call the tick of an offline
> CPU. Better have that check indeed.

No argument, especially given that this preserved the current behavior
exactly.

But it looked to me that all of the code was running on some other online
CPU and was accessing data that would be left around in good state on
the offline CPU.  And the current behavior won't account for activity
just prior to the CPU going offline until it comes back online (right?),
so there might be some incentive to let the last call to sched_tick_remote()
do the accounting.  Might not be a big deal, though.

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 102dfcf0a29a..9a10ee9afcbf 100644
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
> > +#define TICK_SCHED_REMOTE_IDLE		0
> 
> So it took me some time to understand that the IDLE state is the
> tick work that ackowledged OFFLINING and finally completes the
> offline process. Therefore perhaps we can rename it to
> TICK_SCHED_REMOTE_OFFLINE so that we instantly get the state
> machine scenario.

Good point, your name is much better.  Updated.

> > +#define TICK_SCHED_REMOTE_RUNNING	1
> > +#define TICK_SCHED_REMOTE_OFFLINING	2
> > +
> > +// State diagram for ->state:
> > +//
> > +//
> > +//      +----->IDLE-----------------------------+
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
> >  
> >  static struct tick_work __percpu *tick_work_cpu;
> >  
> >  static void sched_tick_remote(struct work_struct *work)
> >  {
> >  	struct delayed_work *dwork = to_delayed_work(work);
> > +	int os;
> >  	struct tick_work *twork = container_of(dwork, struct tick_work, work);
> >  	int cpu = twork->cpu;
> >  	struct rq *rq = cpu_rq(cpu);
> > @@ -3077,7 +3107,7 @@ static void sched_tick_remote(struct work_struct *work)
> >  
> >  	rq_lock_irq(rq, &rf);
> >  	curr = rq->curr;
> > -	if (is_idle_task(curr))
> > +	if (is_idle_task(curr) || cpu_is_offline(cpu))
> 
> Or we could simply check rq->online, while we have rq locked.

Which would have better cache locality as well.

Let's see...  This is cleared from the same sched_cpu_dying() that invokes
sched_tick_stop(), so that works.  Where is it set?  In set_rq_online(),
of course, which is invoked from sched_cpu_activate() which is assigned
to .startup.single, which sadly not the CPU-online counterpart to
sched_cpu_dying().  This would result in the workqueue being started
quite some time before its handler would allow itself to sample the state,
and would also thus be a deviation from earlier behavior.

In the immortal words of MS-DOS, "Are you sure?"

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
> > +		WARN_ON_ONCE(os == TICK_SCHED_REMOTE_IDLE);
> > +		if (os == TICK_SCHED_REMOTE_RUNNING)
> > +			break;
> > +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_IDLE) != os);
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
> > +		if (os == TICK_SCHED_REMOTE_RUNNING)
> 
> Is it possible to have RUNNING at this stage? sched_tick_start()
> shouldn't be called twice without a sched_tick_stop() in the middle.
> 
> In which case we should even warn if we meet that value here.

Good point, it now looks like this:

	if (os == WARN_ON_ONCE(TICK_SCHED_REMOTE_RUNNING))

Which, after an embarrassingly long time, turned into this:

	if (WARN_ON_ONCE(os == TICK_SCHED_REMOTE_RUNNING))

> > +			break;
> > +		// Either idle or offline for a short period
> > +	} while (cmpxchg(&twork->state, os, TICK_SCHED_REMOTE_RUNNING) != os);
> > +	if (os == TICK_SCHED_REMOTE_IDLE) {
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
> I ran the state machine for a few hours inside my head through FWEISBEC_TORTURE
> and I see no error message. Which is of course not a guarantee of anything but:

I know that feeling!

> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you, applied!

> Also, I believe that /* */ is the preferred comment style, FWIW ;-)

True enough, but "//" is permitted and allows me three more characters of
comment before wanting to do a line break.  ;-)

But it is your code, so if you want "/* */", just let me know and I will
switch to that style.

							Thanx, Paul

