Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA2DC3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215C920644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 17:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfHORYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:24:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732322AbfHORYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:24:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7FHNGW8124952;
        Thu, 15 Aug 2019 13:23:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udag0372p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 13:23:53 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7FHNJfj125170;
        Thu, 15 Aug 2019 13:23:52 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2udag0371n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 13:23:52 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7FHMt1Z006649;
        Thu, 15 Aug 2019 17:23:51 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2u9nj75kdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Aug 2019 17:23:51 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7FHNoxs49676724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 17:23:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6CF8B2065;
        Thu, 15 Aug 2019 17:23:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97BA4B2067;
        Thu, 15 Aug 2019 17:23:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Aug 2019 17:23:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5360516C1B23; Thu, 15 Aug 2019 10:23:51 -0700 (PDT)
Date:   Thu, 15 Aug 2019 10:23:51 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190815172351.GI28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190812210232.GA3648@lenoir>
 <20190812232316.GT28441@linux.ibm.com>
 <20190813123016.GA11455@lenoir>
 <20190813144809.GB28441@linux.ibm.com>
 <20190814175546.GB68498@google.com>
 <20190814220516.GY28441@linux.ibm.com>
 <20190815150735.GA12078@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815150735.GA12078@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:07:35AM -0400, Joel Fernandes wrote:
> On Wed, Aug 14, 2019 at 03:05:16PM -0700, Paul E. McKenney wrote:
> [snip]
> > > > > Arming a CPU timer could also be an alternative to tick_set_dep_cpu() for that.
> > > > > 
> > > > > What do you think?
> > > > 
> > > > Left to itself, RCU would take action only when a given nohz_full
> > > > in-kernel CPU was delaying a grace period, which is what the (lightly
> > > > tested) patch below is supposed to help with.  If that is all that is
> > > > needed, well and good!
> > > > 
> > > > But should we need long-running in-kernel nohz_full CPUs to turn on
> > > > their ticks when they are not blocking an RCU grace period, for example,
> > > > when RCU is idle, more will be needed.  To that point, isn't there some
> > > > sort of monitoring that checks up on nohz_full CPUs ever second or so?
> > > 
> > > Wouldn't such monitoring need to be more often than a second, given that
> > > rcu_urgent_qs and rcu_need_heavy_qs are configured typically to be sooner
> > > (200-300 jiffies on my system).
> > 
> > Either it would have to be more often than once per second, or RCU would
> > need to retain its more frequent checks.  But note that RCU isn't going
> > to check unless there is a grace period in progress.
> 
> Sure.
> 
> > > > If so, perhaps that monitoring could periodically invoke an RCU function
> > > > that I provide for deciding when to turn the tick on.  We would also need
> > > > to work out how to turn the tick off in a timely fashion once the CPU got
> > > > out of kernel mode, perhaps in rcu_user_enter() or rcu_nmi_exit_common().
> > > > 
> > > > If this would be called only every second or so, the separate grace-period
> > > > checking is still needed for its shorter timespan, though.
> > > > 
> > > > Thoughts?
> > > 
> > > Do you want me to test the below patch to see if it fixes the issue with my
> > > other test case (where I had a nohz full CPU holding up a grace period).
> > 
> > Please!
> 
> I tried the patch below, but it did not seem to make a difference to the
> issue I was seeing. My test tree is here in case you can spot anything I did
> not do right: https://github.com/joelagnel/linux-kernel/commits/rcu/nohz-test
> The main patch is here:
> https://github.com/joelagnel/linux-kernel/commit/4dc282b559d918a0be826936f997db0bdad7abb3

That is more aggressive that rcutorture's rcu_torture_fwd_prog_nr(), so
I am guessing that I need to up rcu_torture_fwd_prog_nr()'s game.  I am
currently testing that.

> On the trace output, I grep something like: egrep "(rcu_perf|cpu 3|3d)". I
> see a few ticks after 300ms, but then there are no more ticks and just a
> periodic resched_cpu() from rcu_implicit_dynticks_qs():
> 
> [   19.534107] rcu_perf-165    12.... 2276436us : rcu_perf_writer: Start of rcuperf test
> [   19.557968] rcu_pree-10      0d..1 2287973us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   20.136222] rcu_perf-165     3d.h. 2591894us : rcu_sched_clock_irq: sched-tick
> [   20.137185] rcu_perf-165     3d.h2 2591906us : rcu_sched_clock_irq: sched-tick
> [   20.138149] rcu_perf-165     3d.h. 2591911us : rcu_sched_clock_irq: sched-tick
> [   20.139106] rcu_perf-165     3d.h. 2591915us : rcu_sched_clock_irq: sched-tick
> [   20.140077] rcu_perf-165     3d.h. 2591919us : rcu_sched_clock_irq: sched-tick
> [   20.141041] rcu_perf-165     3d.h. 2591924us : rcu_sched_clock_irq: sched-tick
> [   20.142001] rcu_perf-165     3d.h. 2591928us : rcu_sched_clock_irq: sched-tick
> [   20.142961] rcu_perf-165     3d.h. 2591932us : rcu_sched_clock_irq: sched-tick
> [   20.143925] rcu_perf-165     3d.h. 2591936us : rcu_sched_clock_irq: sched-tick
> [   20.144885] rcu_perf-165     3d.h. 2591940us : rcu_sched_clock_irq: sched-tick
> [   20.145876] rcu_perf-165     3d.h. 2591945us : rcu_sched_clock_irq: sched-tick
> [   20.146835] rcu_perf-165     3d.h. 2591949us : rcu_sched_clock_irq: sched-tick
> [   20.147797] rcu_perf-165     3d.h. 2591953us : rcu_sched_clock_irq: sched-tick
> [   20.148759] rcu_perf-165     3d.h. 2591957us : rcu_sched_clock_irq: sched-tick
> [   20.151655] rcu_pree-10      0d..1 2591979us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   20.732938] rcu_pree-10      0d..1 2895960us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   21.318104] rcu_pree-10      0d..1 3199975us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   21.899908] rcu_pree-10      0d..1 3503964us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   22.481316] rcu_pree-10      0d..1 3807990us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   23.065623] rcu_pree-10      0d..1 4111990us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   23.650875] rcu_pree-10      0d..1 4415989us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   24.233999] rcu_pree-10      0d..1 4719978us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   24.818397] rcu_pree-10      0d..1 5023982us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   25.402633] rcu_pree-10      0d..1 5327981us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   25.984104] rcu_pree-10      0d..1 5631976us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   26.566100] rcu_pree-10      0d..1 5935982us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   27.144497] rcu_pree-10      0d..1 6239973us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   27.192661] rcu_perf-165     3d.h. 6276923us : rcu_sched_clock_irq: sched-tick
> [   27.705789] rcu_pree-10      0d..1 6541901us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   28.292155] rcu_pree-10      0d..1 6845974us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   28.874049] rcu_pree-10      0d..1 7149972us : rcu_implicit_dynticks_qs: Sending urgent resched to cpu 3
> [   29.112646] rcu_perf-165     3.... 7275951us : rcu_perf_writer: End of rcuperf test

That would be due to my own stupidity.  I forgot to clear ->rcu_forced_tick
in rcu_disable_tick_upon_qs() inside the "if" statement.  This of course
prevents rcu_nmi_exit_common() from ever re-enabling it.

Excellent catch!  Thank you for testing this!!!

> [snip]
> > > > @@ -2906,7 +2927,7 @@ void rcu_barrier(void)
> > > >  	/* Did someone else do our work for us? */
> > > >  	if (rcu_seq_done(&rcu_state.barrier_sequence, s)) {
> > > >  		rcu_barrier_trace(TPS("EarlyExit"), -1,
> > > > -				   rcu_state.barrier_sequence);
> > > > +				  rcu_state.barrier_sequence);
> > > >  		smp_mb(); /* caller's subsequent code after above check. */
> > > >  		mutex_unlock(&rcu_state.barrier_mutex);
> > > >  		return;
> > > > @@ -2938,11 +2959,11 @@ void rcu_barrier(void)
> > > >  			continue;
> > > >  		if (rcu_segcblist_n_cbs(&rdp->cblist)) {
> > > >  			rcu_barrier_trace(TPS("OnlineQ"), cpu,
> > > > -					   rcu_state.barrier_sequence);
> > > > +					  rcu_state.barrier_sequence);
> > > >  			smp_call_function_single(cpu, rcu_barrier_func, NULL, 1);
> > > >  		} else {
> > > >  			rcu_barrier_trace(TPS("OnlineNQ"), cpu,
> > > > -					   rcu_state.barrier_sequence);
> > > > +					  rcu_state.barrier_sequence);
> > > >  		}
> > > >  	}
> > > >  	put_online_cpus();
> > > > @@ -3168,6 +3189,7 @@ void rcu_cpu_starting(unsigned int cpu)
> > > >  	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> > > >  	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
> > > >  	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
> > > > +		rcu_disable_tick_upon_qs(rdp);
> > > >  		/* Report QS -after- changing ->qsmaskinitnext! */
> > > >  		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
> > > 
> > > Just curious about the existing code. If a CPU is just starting up (after
> > > bringing it online), how can RCU be waiting on it? I thought RCU would not be
> > > watching offline CPUs.
> > 
> > Well, neither grace periods nor CPU-hotplug operations are atomic,
> > and each can take significant time to complete.
> > 
> > So suppose we have a large system with multiple leaf rcu_node structures
> > (not that 17 CPUs is all that many these days, but please bear with me).
> > Suppose just after a new grace period initializes a given leaf rcu_node
> > structure, one of its CPUs goes offline (yes, that CPU would have to
> > have waited on a grace period, but that might have been the previous
> > grace period).  But before the FQS scan notices that RCU is waiting on
> > an offline CPU, the CPU comes back online.
> > 
> > That situation is exactly what the above code is intended to handle.
> 
> That makes sense!
> 
> > Without that code, RCU can give false-positive splats at various points
> > in its processing.  ("Wait!  How can a task be blocked waiting on a
> > grace period that hasn't even started yet???")
> 
> I did not fully understand the question in brackets though, a task can be on
> a different CPU though which has nothing to do with the CPU that's going
> offline/online so it could totally be waiting on a grace period right?
> 
> Also waiting on a grace period that hasn't even started is totally possible:
> 
>      GP1         GP2
> |<--------->|<-------->|
>      ^                 ^
>      |                 |____  task gets unblocked
> task blocks
> on synchronize_rcu
> but is waiting on
> GP2 which hasn't started
> 
> Or did I misunderstand the question?

There is a ->gp_tasks field in the leaf rcu_node structures that
references a list of tasks blocking the current grace period.  When there
is no grace period in progress (as is the case from the end of GP1 to
the beginning of GP2, the RCU code expects ->gp_tasks to be NULL.
Without the curiosity code you pointed out above, ->gp_tasks could
in fact end up being non-NULL when no grace period was in progress.

And did end up being non-NULL from time to time, initially every few
hundred hours of a particular rcutorture scenario.

							Thanx, Paul
