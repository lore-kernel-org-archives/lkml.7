Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD5FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FAD2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbfHHUfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:35:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732327AbfHHUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:35:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78KSgTV024897
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 16:35:47 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8th08yev-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 16:35:47 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 8 Aug 2019 21:35:46 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 21:35:40 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78KZeqq51642642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 20:35:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01553B2064;
        Thu,  8 Aug 2019 20:35:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF778B205F;
        Thu,  8 Aug 2019 20:35:39 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 20:35:39 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 11C7116C8EB1; Thu,  8 Aug 2019 13:35:41 -0700 (PDT)
Date:   Thu, 8 Aug 2019 13:35:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Reply-To: paulmck@linux.ibm.com
References: <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190804144317.GF2349@hirez.programming.kicks-ass.net>
 <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
 <20190805080531.GH2349@hirez.programming.kicks-ass.net>
 <20190805145448.GI28441@linux.ibm.com>
 <20190805155024.GK2332@hirez.programming.kicks-ass.net>
 <20190805174800.GK28441@linux.ibm.com>
 <20190806180824.GA28448@linux.ibm.com>
 <20190807214131.GA15124@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807214131.GA15124@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080820-0072-0000-0000-000004514D52
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011571; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243996; UDB=6.00656280; IPR=6.01025475;
 MB=3.00028097; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-08 20:35:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080820-0073-0000-0000-00004CC255EA
Message-Id: <20190808203541.GA8160@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 02:41:31PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 06, 2019 at 11:08:24AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 05, 2019 at 10:48:00AM -0700, Paul E. McKenney wrote:
> > > On Mon, Aug 05, 2019 at 05:50:24PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Aug 05, 2019 at 07:54:48AM -0700, Paul E. McKenney wrote:
> > > > 
> > > > > > Right; so clearly we're not understanding what's happening. That seems
> > > > > > like a requirement for actually doing a patch.
> > > > > 
> > > > > Almost but not quite.  It is a requirement for a patch *that* *is*
> > > > > *supposed* *to* *be* *a* *fix*.  If you are trying to prohibit me from
> > > > > writing experimental patches, please feel free to take a long walk on
> > > > > a short pier.
> > > > > 
> > > > > Understood???
> > > > 
> > > > Ah, my bad, I thought you were actually proposing this as an actual
> > > > patch. I now see that is my bad, I'd overlooked the RFC part.
> > > 
> > > No problem!
> > > 
> > > And of course adding tracing decreases the frequency and duration of
> > > the multi_cpu_stop().  Re-running with shorter-duration triggering.  ;-)
> > 
> > And I did eventually get a good trace.  If I am interpreting this trace
> > correctly, the torture_-135 task didn't get around to attempting to wake
> > up all of the CPUs.  I will try again, but this time with the sched_switch
> > trace event enabled.
> > 
> > As a side note, enabling ftrace from the command line seems to interact
> > badly with turning tracing off and on in the kernel, so I eventually
> > resorted to trace_printk() in the functions of interest.  The trace
> > output is below, followed by the current diagnostic patch.  Please note
> > that I am -not- using the desperation hammer-the-scheduler patches.
> > 
> > More as I learn more!
> 
> And of course I forgot to dump out the online CPUs, so I really had no
> idea whether or not all the CPUs were accounted for.  I added tracing
> to dump out the online CPUs at the beginning of __stop_cpus() and then
> reworked it a few times to get the problem to happen in reasonable time.
> Please see below for the resulting annotated trace.
> 
> I was primed to expect a lost IPI, perhaps due to yet another qemu bug,
> but all the migration threads are running within about 2 milliseconds.
> It is then almost two minutes(!) until the next trace message.
> 
> Looks like time to (very carefully!) instrument multi_cpu_stop().
> 
> Of course, if you have any ideas, please do not keep them a secret!

Functionally, multi_cpu_stop() is working fine, according to the trace
below (search for a line beginning with TAB).  But somehow CPU 2 took
almost three -minutes- to do one iteration of the loop.  The prime suspect
in that loop is cpu_relax() due to the hypervisor having an opportunity
to do something at that point.  The commentary below (again, search for
a line beginning with TAB) gives my analysis.

Of course, if I am correct, it should be possible to catch cpu_relax()
in the act.  That is the next step, give or take the Heisenbuggy nature
of this beast.

Another thing for me to try is to run longer with !NO_HZ_FULL, just in
case the earlier runs just got lucky.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

[ 1564.195213] Unregister pv shared memory for cpu 6
[ 1731.578001] rcu: INFO: rcu_sched self-detected stall on CPU
...
[ 1731.632619] torture_-135     0.... 1562233456us : __stop_cpus: CPUs 0-2,6-7 online
[ 1731.632619] torture_-135     0.... 1562233457us : queue_stop_cpus_work: entered
[ 1731.632619] torture_-135     0.... 1562233457us : cpu_stop_queue_work: entered for CPU 0
[ 1731.632619] torture_-135     0.... 1562233458us : wake_up_q: entered
[ 1731.632619] torture_-135     0.... 1562233458us : wake_up_process: entered
[ 1731.632619] torture_-135     0.... 1562233458us : try_to_wake_up: entered
[ 1731.632619] torture_-135     0d... 1562233458us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] torture_-135     0d... 1562233459us : ttwu_do_activate.isra.108: entered
[ 1731.632619] torture_-135     0d... 1562233459us : activate_task: entered
[ 1731.632619] torture_-135     0d... 1562233459us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] torture_-135     0d... 1562233459us : check_preempt_curr: entered
[ 1731.632619] torture_-135     0d... 1562233459us : resched_curr: entered
[ 1731.632619] torture_-135     0.N.. 1562233460us : cpu_stop_queue_work: entered for CPU 1
[ 1731.632619] torture_-135     0.N.. 1562233460us : wake_up_q: entered
[ 1731.632619] torture_-135     0.N.. 1562233460us : wake_up_process: entered
[ 1731.632619] torture_-135     0.N.. 1562233460us : try_to_wake_up: entered
[ 1731.632619] torture_-135     0dN.. 1562233461us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] torture_-135     0dN.. 1562233478us : try_to_wake_up: ttwu_queue_remote entered, CPU 1
[ 1731.632619] torture_-135     0.N.. 1562233488us : cpu_stop_queue_work: entered for CPU 2
[ 1731.632619] torture_-135     0.N.. 1562233488us : wake_up_q: entered
[ 1731.632619] torture_-135     0.N.. 1562233488us : wake_up_process: entered
[ 1731.632619] torture_-135     0.N.. 1562233488us : try_to_wake_up: entered
[ 1731.632619] torture_-135     0dN.. 1562233489us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] torture_-135     0dN.. 1562233489us : try_to_wake_up: ttwu_queue_remote entered, CPU 2
[ 1731.632619]   <idle>-0       1d... 1562233493us : scheduler_ipi: entered
[ 1731.632619]   <idle>-0       1d.h. 1562233495us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       1d.h. 1562233495us : sched_ttwu_pending: non-NULL llist
[ 1731.632619]   <idle>-0       1d.h. 1562233495us : ttwu_do_activate.isra.108: entered
[ 1731.632619]   <idle>-0       1d.h. 1562233495us : activate_task: entered
[ 1731.632619]   <idle>-0       1d.h. 1562233496us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619]   <idle>-0       1d.h. 1562233496us : check_preempt_curr: entered
[ 1731.632619]   <idle>-0       1d.h. 1562233496us : resched_curr: entered
[ 1731.632619] torture_-135     0.N.. 1562233498us : cpu_stop_queue_work: entered for CPU 6
[ 1731.632619] torture_-135     0.N.. 1562233498us : wake_up_q: entered
[ 1731.632619] torture_-135     0.N.. 1562233499us : wake_up_process: entered
[ 1731.632619] torture_-135     0.N.. 1562233499us : try_to_wake_up: entered
[ 1731.632619] torture_-135     0dN.. 1562233499us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] torture_-135     0dN.. 1562233499us : try_to_wake_up: ttwu_queue_remote entered, CPU 6
[ 1731.632619] torture_-135     0.N.. 1562233509us : cpu_stop_queue_work: entered for CPU 7
[ 1731.632619] torture_-135     0.N.. 1562233509us : wake_up_q: entered
[ 1731.632619] torture_-135     0.N.. 1562233509us : wake_up_process: entered
[ 1731.632619] torture_-135     0.N.. 1562233509us : try_to_wake_up: entered
[ 1731.632619] torture_-135     0dN.. 1562233510us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] torture_-135     0dN.. 1562233510us : try_to_wake_up: ttwu_queue_remote entered, CPU 7
[ 1731.632619]   <idle>-0       2d... 1562233515us : scheduler_ipi: entered
[ 1731.632619]   <idle>-0       2d.h. 1562233517us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       2d.h. 1562233517us : sched_ttwu_pending: non-NULL llist
[ 1731.632619]   <idle>-0       2d.h. 1562233518us : ttwu_do_activate.isra.108: entered
[ 1731.632619]   <idle>-0       2d.h. 1562233519us : activate_task: entered
[ 1731.632619]   <idle>-0       2d.h. 1562233519us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619]   <idle>-0       2d.h. 1562233519us : check_preempt_curr: entered
[ 1731.632619]   <idle>-0       2d.h. 1562233519us : resched_curr: entered
[ 1731.632619] torture_-135     0d... 1562233520us : sched_switch: prev_comm=torture_onoff prev_pid=135 prev_prio=120 prev_state=D ==> next_comm=migration/0 next_pid=11 next_prio=0
[ 1731.632619] rcu_tort-128     7d... 1562233520us : scheduler_ipi: entered
[ 1731.632619] rcu_tort-128     7d.h. 1562233521us : sched_ttwu_pending: entered
[ 1731.632619] rcu_tort-128     7d.h. 1562233521us : sched_ttwu_pending: non-NULL llist
[ 1731.632619] rcu_tort-128     7d.h. 1562233521us : ttwu_do_activate.isra.108: entered
[ 1731.632619] rcu_tort-128     7d.h. 1562233521us : activate_task: entered
[ 1731.632619] migratio-11      0...1 1562233521us : multi_cpu_stop: curstate = 1, ack = 5
[ 1731.632619] rcu_tort-128     7d.h. 1562233521us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] rcu_tort-128     7d.h. 1562233523us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-128     7d.h. 1562233524us : resched_curr: entered
[ 1731.632619] rcu_tort-128     7d... 1562233532us : sched_switch: prev_comm=rcu_torture_rea prev_pid=128 prev_prio=139 prev_state=R+ ==> next_comm=migration/7 next_pid=52 next_prio=0
[ 1731.632619] migratio-52      7...1 1562233535us : multi_cpu_stop: curstate = 1, ack = 4
[ 1731.632619]   <idle>-0       1dNs. 1562233552us : activate_task: entered
[ 1731.632619]   <idle>-0       2.N.. 1562233553us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       1dNs. 1562233553us : check_preempt_curr: entered
[ 1731.632619]   <idle>-0       2d... 1562233554us : sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=migration/2 next_pid=21 next_prio=0
[ 1731.632619]   <idle>-0       1dNs. 1562233554us : resched_curr: entered
[ 1731.632619]   <idle>-0       1.N.. 1562233554us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       1d... 1562233555us : sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=migration/1 next_pid=14 next_prio=0
[ 1731.632619] migratio-21      2...1 1562233556us : multi_cpu_stop: curstate = 1, ack = 3
[ 1731.632619] migratio-14      1...1 1562233556us : multi_cpu_stop: curstate = 1, ack = 2
[ 1731.632619] migratio-11      0..s1 1562234528us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1562234528us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1562234529us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1562234529us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1562234529us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1562234529us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1562234530us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0..s1 1562235527us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1562235527us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1562235528us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1562235528us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1562235528us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1562235528us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1562235529us : check_preempt_curr: entered
[ 1731.632619]   <idle>-0       6d... 1562235529us : scheduler_ipi: entered
[ 1731.632619]   <idle>-0       6d.h. 1562249376us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       6d.h. 1562249377us : sched_ttwu_pending: non-NULL llist
[ 1731.632619]   <idle>-0       6d.h. 1562249377us : ttwu_do_activate.isra.108: entered
[ 1731.632619]   <idle>-0       6d.h. 1562249377us : activate_task: entered
[ 1731.632619]   <idle>-0       6d.h. 1562249378us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619]   <idle>-0       6d.h. 1562249378us : check_preempt_curr: entered
[ 1731.632619]   <idle>-0       6d.h. 1562249378us : resched_curr: entered
[ 1731.632619]   <idle>-0       6.N.. 1562249472us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       6d... 1562249480us : sched_switch: prev_comm=swapper/6 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=migration/6 next_pid=46 next_prio=0
[ 1731.632619] migratio-46      6...1 1562249502us : multi_cpu_stop: curstate = 1, ack = 1
[ 1731.632619] migratio-14      1...1 1562249503us : multi_cpu_stop: curstate = 2, ack = 5
[ 1731.632619] migratio-52      7...1 1562249503us : multi_cpu_stop: curstate = 2, ack = 5
[ 1731.632619] migratio-11      0...1 1562249504us : multi_cpu_stop: curstate = 2, ack = 3
[ 1731.632619] migratio-46      6...1 1562249505us : multi_cpu_stop: curstate = 2, ack = 2
	Almost three -minutes- delay.  CPU 2 was just fine 16ms earlier:
	2...1 1562233556us : multi_cpu_stop: curstate = 1, ack = 3
	"curstate = 1" above corresponds to MULTI_STOP_PREPARE.
	"curstate = 2" below corresponds to MULTI_STOP_DISABLE_IRQ
	So what did that CPU need to execute in the meantime?
	o	ack_state(), which does an atomic_dec_and_test(), an
		atomic_set(), an smp_wmb(), and a WRITE_ONCE().
	o	rcu_momentary_dyntick_idle(), which does a
		raw_cpu_write(), an atomic_add_return(),
		integer comparison for a WARN_ON_ONCE() and call to
		rcu_preempt_deferred_qs(), which in this configuration
		is an empty function.
	o	stop_machine_yield(), which does a cpu_relax(), which might
		pass control to the hupervisor.
	o	Multiple passes through a loop doing READ_ONCE(msdata->state)
		(paranoia on my part), a couple of comparisons, an
		rcu_momentary_dyntick_idle(), and a stop_machine_yield().
	o	We don't call the function msdata->fn(msdata->data)
		because that doesn't happen until after we get to
		MULTI_STOP_RUN, which is after MULTI_STOP_DISABLE_IRQ.
	o	This would be easy to blame on the hypervisor, but then
		why is this behavior restricted to CONFIG_NO_HZ_FULL
		guest-OS kernels with lots of nohz_full CPUs?  I suppose
		maybe the guest's scheduling-clock interrupt attempts
		might be having an effect, but...
[ 1731.632619] migratio-21      2...1 1729613677us : multi_cpu_stop: curstate = 2, ack = 1
[ 1731.632619] migratio-21      2d..1 1729613680us : multi_cpu_stop: curstate = 3, ack = 5
[ 1731.632619] migratio-46      6d..1 1729613680us : multi_cpu_stop: curstate = 3, ack = 5
[ 1731.632619] migratio-14      1d..1 1729613680us : multi_cpu_stop: curstate = 3, ack = 5
[ 1731.632619] migratio-52      7d..1 1729613680us : multi_cpu_stop: curstate = 3, ack = 4
[ 1731.632619] migratio-11      0d..1 1729613680us : multi_cpu_stop: curstate = 3, ack = 4
[ 1731.632619] migratio-46      6d..1 1729613680us : sched_ttwu_pending: entered
[ 1731.632619] migratio-14      1d..1 1729613680us : multi_cpu_stop: curstate = 4, ack = 5
[ 1731.632619] migratio-46      6d..1 1729613680us : multi_cpu_stop: curstate = 4, ack = 5
[ 1731.632619] migratio-52      7d..1 1729613680us : multi_cpu_stop: curstate = 4, ack = 5
[ 1731.632619] migratio-21      2d..1 1729614637us : multi_cpu_stop: curstate = 4, ack = 5
[ 1731.632619] migratio-14      1d... 1729614817us : sched_switch: prev_comm=migration/1 prev_pid=14 prev_prio=0 prev_state=S ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
[ 1731.632619] migratio-52      7d... 1729614820us : sched_switch: prev_comm=migration/7 prev_pid=52 prev_prio=0 prev_state=S ==> next_comm=rcu_torture_rea next_pid=129 next_prio=139
[ 1731.632619] rcu_tort-129     7d... 1729614828us : sched_switch: prev_comm=rcu_torture_rea prev_pid=129 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=128 next_prio=139
[ 1731.632619] rcu_tort-128     7d... 1729614833us : sched_switch: prev_comm=rcu_torture_rea prev_pid=128 prev_prio=139 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
[ 1731.632619] rcu_tort-124     1d... 1729614834us : activate_task: entered
[ 1731.632619] rcu_tort-124     1d... 1729614836us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729614836us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729614836us : activate_task: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729614837us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729614837us : activate_task: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729614837us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729614837us : activate_task: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729614838us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729614839us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_wri next_pid=119 next_prio=120
[ 1731.632619] migratio-11      0d..1 1729614839us : multi_cpu_stop: curstate = 4, ack = 1
[ 1731.632619] migratio-11      0d.h1 1729614974us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.h1 1729614974us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.h1 1729614976us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.h1 1729614977us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.h1 1729614977us : activate_task: entered
[ 1731.632619] migratio-11      0d.h1 1729614978us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.h1 1729614979us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0..s1 1729614988us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1729614989us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729614990us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729614991us : try_to_wake_up: ttwu_queue_remote entered, CPU 7
[ 1731.632619] migratio-11      0..s1 1729615008us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1729615008us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615009us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615010us : try_to_wake_up: ttwu_queue_remote entered, CPU 7
[ 1731.632619] migratio-11      0..s1 1729615010us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1729615010us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615011us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615011us : try_to_wake_up: ttwu_queue_remote entered, CPU 1
[ 1731.632619] rcu_tort-119     1d... 1729615025us : scheduler_ipi: entered
[ 1731.632619] rcu_tort-119     1d.h. 1729615026us : sched_ttwu_pending: entered
[ 1731.632619] rcu_tort-119     1d.h. 1729615026us : sched_ttwu_pending: non-NULL llist
[ 1731.632619] rcu_tort-119     1d.h. 1729615026us : ttwu_do_activate.isra.108: entered
[ 1731.632619] rcu_tort-119     1d.h. 1729615027us : activate_task: entered
[ 1731.632619] rcu_tort-119     1d.h. 1729615028us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] rcu_tort-119     1d.h. 1729615028us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0d.s1 1729615029us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615029us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615030us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615030us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1729615030us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1729615031us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1729615031us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0d.s1 1729615032us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615032us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0..s1 1729615033us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1729615033us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615034us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615034us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1729615034us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1729615035us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1729615035us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0..s1 1729615036us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1729615036us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615038us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615038us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1729615038us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1729615039us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1729615039us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0d.s1 1729615040us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615040us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615042us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615042us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0..s1 1729615043us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1729615043us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615044us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615044us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1729615044us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1729615045us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1729615045us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0..s1 1729615046us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1729615046us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615046us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615047us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1729615047us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1729615047us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1729615047us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0..s1 1729615048us : wake_up_process: entered
[ 1731.632619] migratio-11      0..s1 1729615049us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615050us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615050us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1729615051us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1729615051us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1729615051us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0d.s1 1729615057us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615057us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615057us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-11      0d.s1 1729615058us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-11      0d.s1 1729615058us : activate_task: entered
[ 1731.632619] migratio-11      0d.s1 1729615058us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-11      0d.s1 1729615059us : check_preempt_curr: entered
[ 1731.632619] migratio-11      0d.s1 1729615060us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615060us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615061us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615061us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615094us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615094us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615095us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615095us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615096us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615096us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d.s1 1729615097us : wake_up_process: entered
[ 1731.632619] migratio-11      0d.s1 1729615097us : try_to_wake_up: entered
[ 1731.632619] migratio-11      0d... 1729615103us : sched_switch: prev_comm=migration/0 prev_pid=11 prev_prio=0 prev_state=S ==> next_comm=rcu_sched next_pid=10 next_prio=120
[ 1731.632619] rcu_sche-10      0d... 1729615108us : sched_switch: prev_comm=rcu_sched prev_pid=10 prev_prio=120 prev_state=I ==> next_comm=init next_pid=1 next_prio=120
[ 1731.632619] rcu_tort-119     1d... 1729615678us : sched_switch: prev_comm=rcu_torture_wri prev_pid=119 prev_prio=120 prev_state=S ==> next_comm=rcu_torture_rea next_pid=125 next_prio=139
[ 1731.632619] rcu_tort-125     1d... 1729615683us : sched_switch: prev_comm=rcu_torture_rea prev_pid=125 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
[ 1731.632619]   <idle>-0       7d... 1729615886us : scheduler_ipi: entered
[ 1731.632619]   <idle>-0       7d.h. 1729616090us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       7d.h. 1729616090us : sched_ttwu_pending: non-NULL llist
[ 1731.632619]   <idle>-0       7d.h. 1729616091us : ttwu_do_activate.isra.108: entered
[ 1731.632619]   <idle>-0       7d.h. 1729616091us : activate_task: entered
[ 1731.632619]   <idle>-0       7d.h. 1729616092us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619]   <idle>-0       7d.h. 1729616093us : check_preempt_curr: entered
[ 1731.632619]   <idle>-0       7d.h. 1729616093us : resched_curr: entered
[ 1731.632619]   <idle>-0       7dNh. 1729616094us : ttwu_do_activate.isra.108: entered
[ 1731.632619]   <idle>-0       7dNh. 1729616094us : activate_task: entered
[ 1731.632619]   <idle>-0       7dNh. 1729616095us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619]   <idle>-0       7dNh. 1729616095us : check_preempt_curr: entered
[ 1731.632619]   <idle>-0       7dNh. 1729616117us : resched_curr: entered
[ 1731.632619]   <idle>-0       7.N.. 1729616153us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       7d... 1729616155us : sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_torture_rea next_pid=129 next_prio=139
[ 1731.632619] rcu_tort-129     7d... 1729616159us : sched_switch: prev_comm=rcu_torture_rea prev_pid=129 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=128 next_prio=139
[ 1731.632619]     init-1       0d... 1729616201us : sched_switch: prev_comm=init prev_pid=1 prev_prio=120 prev_state=S ==> next_comm=kworker/u16:5 next_pid=162 next_prio=120
[ 1731.632619] kworker/-162     0d... 1729616207us : wake_up_process: entered
[ 1731.632619] kworker/-162     0d... 1729616207us : try_to_wake_up: entered
[ 1731.632619] kworker/-162     0d... 1729616208us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] kworker/-162     0d... 1729616209us : ttwu_do_activate.isra.108: entered
[ 1731.632619] kworker/-162     0d... 1729616209us : activate_task: entered
[ 1731.632619] kworker/-162     0d... 1729616211us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] kworker/-162     0d... 1729616211us : check_preempt_curr: entered
[ 1731.632619] kworker/-162     0d... 1729616213us : wake_up_process: entered
[ 1731.632619] kworker/-162     0d... 1729616214us : try_to_wake_up: entered
[ 1731.632619] kworker/-162     0d... 1729616215us : wake_up_process: entered
[ 1731.632619] kworker/-162     0d... 1729616215us : try_to_wake_up: entered
[ 1731.632619] rcu_tort-124     1d.H. 1729618001us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729618015us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=127 next_prio=139
[ 1731.632619] rcu_tort-127     1d... 1729618022us : sched_switch: prev_comm=rcu_torture_rea prev_pid=127 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=126 next_prio=139
[ 1731.632619] rcu_tort-126     1d.h. 1729620527us : resched_curr: entered
[ 1731.632619] rcu_tort-126     1d... 1729620533us : sched_switch: prev_comm=rcu_torture_rea prev_pid=126 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
[ 1731.632619] rcu_tort-124     1d.h. 1729623526us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729623532us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=126 next_prio=139
[ 1731.632619] rcu_tort-126     1d.h. 1729626526us : resched_curr: entered
[ 1731.632619] rcu_tort-126     1d... 1729626534us : sched_switch: prev_comm=rcu_torture_rea prev_pid=126 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
[ 1731.632619] rcu_tort-124     1d.h. 1729629526us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729629719us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=126 next_prio=139
[ 1731.632619] rcu_tort-126     1d.h. 1729632524us : resched_curr: entered
[ 1731.632619] rcu_tort-126     1d... 1729632677us : sched_switch: prev_comm=rcu_torture_rea prev_pid=126 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
[ 1731.632619] rcu_tort-124     1d.h. 1729635526us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729635533us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=126 next_prio=139
[ 1731.632619] rcu_tort-126     1d.h. 1729638531us : resched_curr: entered
[ 1731.632619] rcu_tort-126     1d... 1729638541us : sched_switch: prev_comm=rcu_torture_rea prev_pid=126 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
[ 1731.632619] rcu_tort-124     1d.h. 1729641526us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729641534us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=126 next_prio=139
[ 1731.632619] rcu_tort-126     1d.h. 1729644526us : resched_curr: entered
[ 1731.632619] rcu_tort-126     1d... 1729644622us : sched_switch: prev_comm=rcu_torture_rea prev_pid=126 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
[ 1731.632619] rcu_tort-124     1d.h. 1729647528us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729647534us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=R+ ==> next_comm=rcu_torture_rea next_pid=126 next_prio=139
[ 1731.632619] rcu_tort-126     1d... 1729647662us : sched_switch: prev_comm=rcu_torture_rea prev_pid=126 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
[ 1731.632619] kworker/-162     0d.h. 1729647665us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729647674us : activate_task: entered
[ 1731.632619] rcu_tort-124     1d... 1729647675us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729647675us : activate_task: entered
[ 1731.632619] rcu_tort-124     1d... 1729647675us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729647676us : resched_curr: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729647676us : activate_task: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729647676us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729647676us : activate_task: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729647677us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729647677us : activate_task: entered
[ 1731.632619] rcu_tort-124     1dN.. 1729647677us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-124     1d... 1729647679us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=S ==> next_comm=torture_stutter next_pid=133 next_prio=120
[ 1731.632619] torture_-133     1d... 1729647682us : sched_switch: prev_comm=torture_stutter prev_pid=133 prev_prio=120 prev_state=S ==> next_comm=rcu_torture_fwd next_pid=136 next_prio=139
[ 1731.632619] kworker/-162     0.Ns. 1729647684us : wake_up_process: entered
[ 1731.632619] kworker/-162     0.Ns. 1729647685us : try_to_wake_up: entered
[ 1731.632619] kworker/-162     0dNs. 1729647688us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] kworker/-162     0dNs. 1729647690us : try_to_wake_up: ttwu_queue_remote entered, CPU 1
[ 1731.632619] rcu_tort-128     7d... 1729647690us : sched_switch: prev_comm=rcu_torture_rea prev_pid=128 prev_prio=139 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
[ 1731.632619] kworker/-162     0.Ns. 1729647707us : wake_up_process: entered
[ 1731.632619] kworker/-162     0.Ns. 1729647707us : try_to_wake_up: entered
[ 1731.632619] rcu_tort-136     1d... 1729647709us : scheduler_ipi: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647709us : sched_ttwu_pending: entered
[ 1731.632619] kworker/-162     0dNs. 1729647709us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647709us : sched_ttwu_pending: non-NULL llist
[ 1731.632619] rcu_tort-136     1d.h. 1729647710us : ttwu_do_activate.isra.108: entered
[ 1731.632619] kworker/-162     0dNs. 1729647710us : try_to_wake_up: ttwu_queue_remote entered, CPU 1
[ 1731.632619] rcu_tort-136     1d.h. 1729647710us : activate_task: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647711us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647711us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-136     1.... 1729647714us : wake_up_process: entered
[ 1731.632619] rcu_tort-136     1.... 1729647714us : try_to_wake_up: entered
[ 1731.632619] rcu_tort-136     1d... 1729647716us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] rcu_tort-136     1d... 1729647716us : try_to_wake_up: ttwu_queue_remote entered, CPU 2
[ 1731.632619] kworker/-162     0.Ns. 1729647723us : wake_up_process: entered
[ 1731.632619] kworker/-162     0.Ns. 1729647723us : try_to_wake_up: entered
[ 1731.632619] kworker/-162     0dNs. 1729647724us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] kworker/-162     0dNs. 1729647724us : ttwu_do_activate.isra.108: entered
[ 1731.632619] kworker/-162     0dNs. 1729647725us : activate_task: entered
[ 1731.632619] kworker/-162     0dNs. 1729647726us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] kworker/-162     0dNs. 1729647726us : check_preempt_curr: entered
[ 1731.632619] kworker/-162     0.Ns. 1729647727us : wake_up_process: entered
[ 1731.632619] kworker/-162     0.Ns. 1729647727us : try_to_wake_up: entered
[ 1731.632619] kworker/-162     0dNs. 1729647728us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] kworker/-162     0dNs. 1729647729us : try_to_wake_up: ttwu_queue_remote entered, CPU 1
[ 1731.632619] rcu_tort-136     1d... 1729647730us : scheduler_ipi: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647730us : sched_ttwu_pending: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647730us : sched_ttwu_pending: non-NULL llist
[ 1731.632619] rcu_tort-136     1d.h. 1729647731us : ttwu_do_activate.isra.108: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647731us : activate_task: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647731us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647732us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-136     1d.h. 1729647732us : resched_curr: entered
[ 1731.632619] rcu_tort-136     1dNh. 1729647732us : ttwu_do_activate.isra.108: entered
[ 1731.632619] rcu_tort-136     1dNh. 1729647732us : activate_task: entered
[ 1731.632619] rcu_tort-136     1dNh. 1729647733us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] kworker/-162     0d... 1729647733us : sched_switch: prev_comm=kworker/u16:5 prev_pid=162 prev_prio=120 prev_state=R+ ==> next_comm=kworker/0:3 next_pid=171 next_prio=120
[ 1731.632619] rcu_tort-136     1dNh. 1729647733us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-136     1d... 1729647734us : sched_switch: prev_comm=rcu_torture_fwd prev_pid=136 prev_prio=139 prev_state=D ==> next_comm=rcu_torture_wri next_pid=119 next_prio=120
[ 1731.632619] kworker/-171     0d... 1729647752us : sched_switch: prev_comm=kworker/0:3 prev_pid=171 prev_prio=120 prev_state=I ==> next_comm=kworker/u16:4 next_pid=161 next_prio=120
[ 1731.632619] kworker/-161     0d... 1729647754us : sched_switch: prev_comm=kworker/u16:4 prev_pid=161 prev_prio=120 prev_state=I ==> next_comm=rcu_sched next_pid=10 next_prio=120
[ 1731.632619] rcu_tort-119     1d... 1729648207us : sched_switch: prev_comm=rcu_torture_wri prev_pid=119 prev_prio=120 prev_state=D ==> next_comm=rcu_torture_sta next_pid=131 next_prio=120
[ 1731.632619] rcu_sche-10      0d... 1729648662us : resched_curr: entered
[ 1731.632619] rcu_sche-10      0..s. 1729650719us : wake_up_process: entered
[ 1731.632619] rcu_sche-10      0..s. 1729650719us : try_to_wake_up: entered
[ 1731.632619] rcu_sche-10      0d.s. 1729650720us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-21      2dNs1 1729650720us : scheduler_ipi: entered
[ 1731.632619] rcu_sche-10      0d.s. 1729650721us : try_to_wake_up: ttwu_queue_remote entered, CPU 7
[ 1731.632619] migratio-21      2dNH1 1729650721us : sched_ttwu_pending: entered
[ 1731.632619] migratio-21      2dNH1 1729650721us : sched_ttwu_pending: non-NULL llist
[ 1731.632619] migratio-21      2dNH1 1729650721us : ttwu_do_activate.isra.108: entered
[ 1731.632619] migratio-21      2dNH1 1729650722us : activate_task: entered
[ 1731.632619] migratio-21      2dNH1 1729650723us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] migratio-21      2dNH1 1729650723us : check_preempt_curr: entered
[ 1731.632619] rcu_sche-10      0..s. 1729650734us : wake_up_process: entered
[ 1731.632619] rcu_sche-10      0..s. 1729650735us : try_to_wake_up: entered
[ 1731.632619] rcu_sche-10      0d.s. 1729650735us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] rcu_sche-10      0d.s. 1729650736us : try_to_wake_up: ttwu_queue_remote entered, CPU 1
[ 1731.632619]   <idle>-0       7d... 1729650736us : scheduler_ipi: entered
[ 1731.632619] rcu_sche-10      0..s. 1729650747us : wake_up_process: entered
[ 1731.632619] rcu_sche-10      0..s. 1729650747us : try_to_wake_up: entered
[ 1731.632619] rcu_sche-10      0d.s. 1729650748us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] rcu_sche-10      0d.s. 1729650748us : try_to_wake_up: ttwu_queue_remote entered, CPU 1
[ 1731.632619]   <idle>-0       7d.h. 1729650749us : sched_ttwu_pending: entered
[ 1731.632619]   <idle>-0       7d.h. 1729650749us : sched_ttwu_pending: non-NULL llist
[ 1731.632619]   <idle>-0       7d.h. 1729650750us : ttwu_do_activate.isra.108: entered
[ 1731.632619]   <idle>-0       7d.h. 1729650750us : activate_task: entered
[ 1731.632619] rcu_sche-10      0d... 1729650754us : sched_switch: prev_comm=rcu_sched prev_pid=10 prev_prio=120 prev_state=I ==> next_comm=kworker/u16:5 next_pid=162 next_prio=120
[ 1731.632619]   <idle>-0       7d.h. 1729650755us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619]   <idle>-0       7d.h. 1729650755us : check_preempt_curr: entered
[ 1731.632619]   <idle>-0       7d.h. 1729650755us : resched_curr: entered
[ 1731.632619] migratio-21      2dNs1 1729650758us : wake_up_process: entered
[ 1731.632619] migratio-21      2dNs1 1729650758us : try_to_wake_up: entered
[ 1731.632619] migratio-21      2dNs1 1729650759us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-21      2dNs1 1729650759us : try_to_wake_up: ttwu_queue_remote entered, CPU 0
[ 1731.632619] kworker/-162     0d... 1729650763us : activate_task: entered
[ 1731.632619] kworker/-162     0d... 1729650764us : check_preempt_curr: entered
[ 1731.632619] kworker/-162     0d... 1729650765us : activate_task: entered
[ 1731.632619] kworker/-162     0d... 1729650765us : check_preempt_curr: entered
[ 1731.632619] kworker/-162     0d... 1729650765us : activate_task: entered
[ 1731.632619] kworker/-162     0d... 1729650766us : check_preempt_curr: entered
[ 1731.632619] migratio-21      2dN.1 1729650770us : try_to_wake_up: entered
[ 1731.632619] kworker/-162     0d... 1729650770us : sched_switch: prev_comm=kworker/u16:5 prev_pid=162 prev_prio=120 prev_state=I ==> next_comm=rcu_torture_rea next_pid=125 next_prio=139
[ 1731.632619] migratio-21      2dN.1 1729650771us : try_to_wake_up: ttwu_queue entered
[ 1731.632619] migratio-21      2dN.1 1729650771us : try_to_wake_up: ttwu_queue_remote entered, CPU 0
[ 1731.632619] migratio-21      2d... 1729650774us : sched_switch: prev_comm=migration/2 prev_pid=21 prev_prio=0 prev_state=S ==> next_comm=rcuog/1 next_pid=18 next_prio=120
[ 1731.632619] rcu_tort-125     0d... 1729650775us : scheduler_ipi: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650775us : sched_ttwu_pending: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650775us : sched_ttwu_pending: non-NULL llist
[ 1731.632619] rcu_tort-125     0d.h. 1729650776us : ttwu_do_activate.isra.108: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650777us : activate_task: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650778us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650778us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650779us : ttwu_do_activate.isra.108: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650779us : activate_task: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650779us : ttwu_do_wakeup.isra.107: entered
[ 1731.632619] rcu_tort-125     0d.h. 1729650779us : check_preempt_curr: entered
[ 1731.632619] rcu_tort-125     0d... 1729650783us : sched_switch: prev_comm=rcu_torture_rea prev_pid=125 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=127 next_prio=139
[ 1731.632619]  rcuog/1-18      2d... 1729650783us : sched_switch: prev_comm=rcuog/1 prev_pid=18 prev_prio=120 prev_state=S ==> next_comm=swapper/2 next_pid=0 next_prio=120
[ 1731.632619] rcu_tort-127     0d... 1729650786us : sched_switch: prev_comm=rcu_torture_rea prev_pid=127 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=130 next_prio=139
[ 1731.632619] rcu_tort-130     0d... 1729650789us : sched_switch: prev_comm=rcu_torture_rea prev_pid=130 prev_prio=139 prev_state=S ==> next_comm=torture_onoff next_pid=135 next_prio=120
[ 1731.632619] ---------------------------------
[ 1795.802039] smpboot: CPU 6 is now offline

