Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351DFC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00C6217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389590AbfHGVlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:41:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388825AbfHGVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:41:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77LbKkd030175
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 17:41:38 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u84wf4dmg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:41:37 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 7 Aug 2019 22:41:37 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 7 Aug 2019 22:41:32 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x77LfUhC50332098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Aug 2019 21:41:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E012DB2067;
        Wed,  7 Aug 2019 21:41:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 957E1B2066;
        Wed,  7 Aug 2019 21:41:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  7 Aug 2019 21:41:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8158116C5FFB; Wed,  7 Aug 2019 14:41:31 -0700 (PDT)
Date:   Wed, 7 Aug 2019 14:41:31 -0700
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
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190804144317.GF2349@hirez.programming.kicks-ass.net>
 <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
 <20190805080531.GH2349@hirez.programming.kicks-ass.net>
 <20190805145448.GI28441@linux.ibm.com>
 <20190805155024.GK2332@hirez.programming.kicks-ass.net>
 <20190805174800.GK28441@linux.ibm.com>
 <20190806180824.GA28448@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806180824.GA28448@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080721-0064-0000-0000-00000406A863
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011568; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243550; UDB=6.00656008; IPR=6.01025019;
 MB=3.00028085; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-07 21:41:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080721-0065-0000-0000-00003E95FED9
Message-Id: <20190807214131.GA15124@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:08:24AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 05, 2019 at 10:48:00AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 05, 2019 at 05:50:24PM +0200, Peter Zijlstra wrote:
> > > On Mon, Aug 05, 2019 at 07:54:48AM -0700, Paul E. McKenney wrote:
> > > 
> > > > > Right; so clearly we're not understanding what's happening. That seems
> > > > > like a requirement for actually doing a patch.
> > > > 
> > > > Almost but not quite.  It is a requirement for a patch *that* *is*
> > > > *supposed* *to* *be* *a* *fix*.  If you are trying to prohibit me from
> > > > writing experimental patches, please feel free to take a long walk on
> > > > a short pier.
> > > > 
> > > > Understood???
> > > 
> > > Ah, my bad, I thought you were actually proposing this as an actual
> > > patch. I now see that is my bad, I'd overlooked the RFC part.
> > 
> > No problem!
> > 
> > And of course adding tracing decreases the frequency and duration of
> > the multi_cpu_stop().  Re-running with shorter-duration triggering.  ;-)
> 
> And I did eventually get a good trace.  If I am interpreting this trace
> correctly, the torture_-135 task didn't get around to attempting to wake
> up all of the CPUs.  I will try again, but this time with the sched_switch
> trace event enabled.
> 
> As a side note, enabling ftrace from the command line seems to interact
> badly with turning tracing off and on in the kernel, so I eventually
> resorted to trace_printk() in the functions of interest.  The trace
> output is below, followed by the current diagnostic patch.  Please note
> that I am -not- using the desperation hammer-the-scheduler patches.
> 
> More as I learn more!

And of course I forgot to dump out the online CPUs, so I really had no
idea whether or not all the CPUs were accounted for.  I added tracing
to dump out the online CPUs at the beginning of __stop_cpus() and then
reworked it a few times to get the problem to happen in reasonable time.
Please see below for the resulting annotated trace.

I was primed to expect a lost IPI, perhaps due to yet another qemu bug,
but all the migration threads are running within about 2 milliseconds.
It is then almost two minutes(!) until the next trace message.

Looks like time to (very carefully!) instrument multi_cpu_stop().

Of course, if you have any ideas, please do not keep them a secret!

							Thanx, Paul

------------------------------------------------------------------------

This trace is taken after an RCU CPU stall warning following the start
of CPU 4 going offline:

[ 2579.977765] Unregister pv shared memory for cpu 4

Here is the trace, trimming out the part from earlier CPU-hotplug operations:

[ 2813.040289] torture_-135     0.... 2578022804us : __stop_cpus: CPUs 0-7 online
	All eight CPUs are online.
[ 2813.040289] torture_-135     0.... 2578022805us : queue_stop_cpus_work: entered
[ 2813.040289] torture_-135     0.... 2578022805us : cpu_stop_queue_work: entered for CPU 0
[ 2813.040289] torture_-135     0.... 2578022806us : wake_up_q: entered
[ 2813.040289] torture_-135     0.... 2578022806us : wake_up_process: entered
[ 2813.040289] torture_-135     0.... 2578022806us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0d... 2578022806us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0d... 2578022807us : ttwu_do_activate.isra.108: entered
[ 2813.040289] torture_-135     0d... 2578022807us : activate_task: entered
[ 2813.040289] torture_-135     0d... 2578022807us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] torture_-135     0d... 2578022807us : check_preempt_curr: entered
[ 2813.040289] torture_-135     0d... 2578022807us : resched_curr: entered
[ 2813.040289] torture_-135     0.N.. 2578022808us : cpu_stop_queue_work: entered for CPU 1
[ 2813.040289] torture_-135     0.N.. 2578022809us : wake_up_q: entered
[ 2813.040289] torture_-135     0.N.. 2578022809us : wake_up_process: entered
[ 2813.040289] torture_-135     0.N.. 2578022809us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022809us : try_to_wake_up: entered
	Note: trace_printk() is confused by inlining.
[ 2813.040289] torture_-135     0dN.. 2578022810us : try_to_wake_up: entered, CPU 1
	So the above is really ttwu_queue_remote().
	We are running on CPU 0, so presumably don't need to IPI it.
	We have IPIed CPU 1.
[ 2813.040289] torture_-135     0.N.. 2578022819us : cpu_stop_queue_work: entered for CPU 2
[ 2813.040289] torture_-135     0.N.. 2578022820us : wake_up_q: entered
[ 2813.040289] torture_-135     0.N.. 2578022820us : wake_up_process: entered
[ 2813.040289] torture_-135     0.N.. 2578022820us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022820us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022821us : try_to_wake_up: entered, CPU 2
	We have IPIed CPUs 1-2.
[ 2813.040289] rcu_tort-129     1d... 2578022821us : scheduler_ipi: entered
	CPU 1 got its IPI, so CPUs 1-2 IPIed and CPU 1 received IPI.
[ 2813.040289] rcu_tort-129     1d.h. 2578022821us : sched_ttwu_pending: entered
[ 2813.040289] rcu_tort-129     1d.h. 2578022821us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] rcu_tort-129     1d.h. 2578022821us : ttwu_do_activate.isra.108: entered
[ 2813.040289] rcu_tort-129     1d.h. 2578022821us : activate_task: entered
[ 2813.040289] rcu_tort-129     1d.h. 2578022821us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] rcu_tort-129     1d.h. 2578022821us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-129     1d.h. 2578022821us : resched_curr: entered
[ 2813.040289] rcu_tort-129     1d... 2578022821us : sched_switch: prev_comm=rcu_torture_rea prev_pid=129 prev_prio=139 prev_state=R+ ==> next_comm=migration/1 next_pid=14 next_prio=0
	CPU 1 has switched to its migration kthread.
[ 2813.040289] torture_-135     0.N.. 2578022830us : cpu_stop_queue_work: entered for CPU 3
[ 2813.040289] torture_-135     0.N.. 2578022831us : wake_up_q: entered
[ 2813.040289] torture_-135     0.N.. 2578022831us : wake_up_process: entered
[ 2813.040289] torture_-135     0.N.. 2578022831us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022831us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022832us : try_to_wake_up: entered, CPU 3
	We have IPIed CPUs 1-3.
[ 2813.040289] rcu_tort-126     2d... 2578022832us : scheduler_ipi: entered
	CPU 2 got its IPI, so CPUs 1-3 IPIed and CPUs 1-2 received IPI.
[ 2813.040289] rcu_tort-126     2d.h. 2578022832us : sched_ttwu_pending: entered
[ 2813.040289] rcu_tort-126     2d.h. 2578022832us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] rcu_tort-126     2d.h. 2578022832us : ttwu_do_activate.isra.108: entered
[ 2813.040289] rcu_tort-126     2d.h. 2578022832us : activate_task: entered
[ 2813.040289] rcu_tort-126     2d.h. 2578022832us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] rcu_tort-126     2d.h. 2578022832us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-126     2d.h. 2578022832us : resched_curr: entered
[ 2813.040289] torture_-135     0.N.. 2578022841us : cpu_stop_queue_work: entered for CPU 4
[ 2813.040289] torture_-135     0.N.. 2578022841us : wake_up_q: entered
[ 2813.040289] torture_-135     0.N.. 2578022841us : wake_up_process: entered
[ 2813.040289] torture_-135     0.N.. 2578022841us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022842us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022842us : try_to_wake_up: entered, CPU 4
	We have IPIed CPUs 1-4.
[ 2813.040289] rcu_tort-128     3d... 2578022842us : scheduler_ipi: entered
	CPU 3 got its IPI, so CPUs 1-4 IPIed and CPUs 1-3 received IPI.
[ 2813.040289] rcu_tort-128     3d.h. 2578022842us : sched_ttwu_pending: entered
[ 2813.040289] rcu_tort-128     3d.h. 2578022842us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] rcu_tort-128     3d.h. 2578022842us : ttwu_do_activate.isra.108: entered
[ 2813.040289] rcu_tort-128     3d.h. 2578022842us : activate_task: entered
[ 2813.040289] rcu_tort-128     3d.h. 2578022842us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] rcu_tort-128     3d.h. 2578022842us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-128     3d.h. 2578022842us : resched_curr: entered
[ 2813.040289] torture_-135     0.N.. 2578022853us : cpu_stop_queue_work: entered for CPU 5
[ 2813.040289] torture_-135     0.N.. 2578022853us : wake_up_q: entered
[ 2813.040289] torture_-135     0.N.. 2578022853us : wake_up_process: entered
[ 2813.040289] torture_-135     0.N.. 2578022854us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022854us : try_to_wake_up: entered
[ 2813.040289] torture_-135     0dN.. 2578022856us : try_to_wake_up: entered, CPU 5
	We have IPIed CPUs 1-5.
[ 2813.040289]   <idle>-0       4d... 2578022863us : scheduler_ipi: entered
	CPU 4 got its IPI, so CPUs 1-5 IPIed and CPUs 1-4 received IPI.
[ 2813.040289]   <idle>-0       4d.h. 2578022865us : sched_ttwu_pending: entered
[ 2813.040289]   <idle>-0       4d.h. 2578022865us : sched_ttwu_pending: non-NULL llist
[ 2813.040289]   <idle>-0       4d.h. 2578022866us : ttwu_do_activate.isra.108: entered
[ 2813.040289]   <idle>-0       4d.h. 2578022866us : activate_task: entered
[ 2813.040289]   <idle>-0       4d.h. 2578022867us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] rcu_tort-126     2d... 2578022867us : sched_switch: prev_comm=rcu_torture_rea prev_pid=126 prev_prio=139 prev_state=R+ ==> next_comm=migration/2 next_pid=21 next_prio=0
	CPUs 1-2 have switched to their migration kthreads.
[ 2813.040289]   <idle>-0       4d.h. 2578022868us : check_preempt_curr: entered
[ 2813.040289]   <idle>-0       4d.h. 2578022868us : resched_curr: entered
[ 2813.040289] torture_-135     0.N.. 2578022872us : cpu_stop_queue_work: entered for CPU 6
[ 2813.040289] torture_-135     0.N.. 2578022873us : wake_up_q: entered
[ 2813.040289] torture_-135     0.N.. 2578022873us : wake_up_process: entered
[ 2813.040289] torture_-135     0.N.. 2578022874us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-125     5d... 2578022874us : scheduler_ipi: entered
	CPU 5 got its IPI, so CPUs 1-5 IPIed and CPUs 1-5 received IPI.
[ 2813.040289] rcu_tort-125     5d.h. 2578022874us : sched_ttwu_pending: entered
[ 2813.040289] rcu_tort-125     5d.h. 2578022875us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] rcu_tort-125     5d.h. 2578022875us : ttwu_do_activate.isra.108: entered
[ 2813.040289] rcu_tort-125     5d.h. 2578022875us : activate_task: entered
[ 2813.040289] rcu_tort-125     5d.h. 2578022877us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] rcu_tort-125     5d.h. 2578022877us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-125     5d.h. 2578022877us : resched_curr: entered
[ 2813.040289] rcu_tort-128     3d... 2578022877us : sched_switch: prev_comm=rcu_torture_rea prev_pid=128 prev_prio=139 prev_state=R+ ==> next_comm=migration/3 next_pid=27 next_prio=0
	CPUs 1-3 have switched to their migration kthreads.
[ 2813.040289]   <idle>-0       4.N.. 2578022912us : sched_ttwu_pending: entered
[ 2813.040289] torture_-135     0dN.. 2578022914us : try_to_wake_up: entered
[ 2813.040289]   <idle>-0       4d... 2578022914us : sched_switch: prev_comm=swapper/4 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=migration/4 next_pid=33 next_prio=0
	CPUs 1-4 have switched to their migration kthreads.
[ 2813.040289] torture_-135     0dN.. 2578022915us : try_to_wake_up: entered, CPU 6
	We have IPIed CPUs 1-6.
[ 2813.040289] rcu_tort-125     5d... 2578022926us : sched_switch: prev_comm=rcu_torture_rea prev_pid=125 prev_prio=139 prev_state=R+ ==> next_comm=migration/5 next_pid=40 next_prio=0
	CPUs 1-5 have switched to their migration kthreads.
[ 2813.040289] rcu_tort-136     6d... 2578022926us : scheduler_ipi: entered
	CPU 6 got its IPI, so CPUs 1-6 IPIed and CPUs 1-6 received IPI.
[ 2813.040289] torture_-135     0.N.. 2578022929us : cpu_stop_queue_work: entered for CPU 7
[ 2813.040289] torture_-135     0.N.. 2578022930us : wake_up_q: entered
[ 2813.040289] torture_-135     0.N.. 2578022930us : wake_up_process: entered
[ 2813.040289] torture_-135     0.N.. 2578022930us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-136     6d.h. 2578022930us : sched_ttwu_pending: entered
[ 2813.040289] torture_-135     0dN.. 2578022930us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-136     6d.h. 2578022930us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] rcu_tort-136     6d.h. 2578022930us : ttwu_do_activate.isra.108: entered
[ 2813.040289] torture_-135     0dN.. 2578022931us : try_to_wake_up: entered, CPU 7
	We have IPIed CPUs 1-7.
[ 2813.040289] rcu_tort-136     6d.h. 2578022931us : activate_task: entered
[ 2813.040289] rcu_tort-136     6d.h. 2578022931us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] rcu_tort-136     6d.h. 2578022931us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-136     6d.h. 2578022931us : resched_curr: entered
[ 2813.040289] torture_-135     0d... 2578022951us : sched_switch: prev_comm=torture_onoff prev_pid=135 prev_prio=120 prev_state=D ==> next_comm=migration/0 next_pid=11 next_prio=0
	CPUs 0-5 have switched to their migration kthreads.
[ 2813.040289] rcu_tort-136     6d... 2578022951us : sched_switch: prev_comm=rcu_torture_fwd prev_pid=136 prev_prio=139 prev_state=R+ ==> next_comm=migration/6 next_pid=46 next_prio=0
	CPUs 0-6 have switched to their migration kthreads.
[ 2813.040289] migratio-46      6d.s1 2578023060us : wake_up_process: entered
[ 2813.040289] migratio-46      6d.s1 2578023060us : try_to_wake_up: entered
[ 2813.040289] migratio-46      6d.s1 2578023060us : try_to_wake_up: entered
[ 2813.040289] migratio-46      6d.s1 2578023061us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-46      6d.s1 2578023061us : activate_task: entered
[ 2813.040289] migratio-46      6d.s1 2578023062us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-46      6d.s1 2578023062us : check_preempt_curr: entered
[ 2813.040289]   <idle>-0       7d... 2578023758us : scheduler_ipi: entered
	CPU 7 got its IPI, so CPUs 1-7 IPIed and CPUs 1-7 received IPI.
[ 2813.040289]   <idle>-0       7d.h. 2578025037us : sched_ttwu_pending: entered
[ 2813.040289]   <idle>-0       7d.h. 2578025038us : sched_ttwu_pending: non-NULL llist
[ 2813.040289]   <idle>-0       7d.h. 2578025038us : ttwu_do_activate.isra.108: entered
[ 2813.040289]   <idle>-0       7d.h. 2578025038us : activate_task: entered
[ 2813.040289]   <idle>-0       7d.h. 2578025043us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289]   <idle>-0       7d.h. 2578025043us : check_preempt_curr: entered
[ 2813.040289]   <idle>-0       7d.h. 2578025043us : resched_curr: entered
[ 2813.040289]   <idle>-0       7.N.. 2578025107us : sched_ttwu_pending: entered
[ 2813.040289]   <idle>-0       7d... 2578025132us : sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=migration/7 next_pid=52 next_prio=0
	CPUs 0-7 have all switched to their migration kthreads.  So we
	should be done, but we clearly are not.  Almost two minutes later:
[ 2813.040289] migratio-33      4d..1 2689243033us : sched_ttwu_pending: entered
[ 2813.040289] migratio-11      0d.h1 2689243195us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.h1 2689243196us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.h1 2689243198us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.h1 2689243201us : try_to_wake_up: entered, CPU 5
[ 2813.040289] migratio-40      5d... 2689243204us : sched_switch: prev_comm=migration/5 prev_pid=40 prev_prio=0 prev_state=S ==> next_comm=rcu_torture_rea next_pid=125 next_prio=139
	CPU 5 switches from its migration kthread.
[ 2813.040289] migratio-46      6d... 2689243222us : sched_switch: prev_comm=migration/6 prev_pid=46 prev_prio=0 prev_state=S ==> next_comm=kworker/6:1 next_pid=175 next_prio=120
	CPU 6 switches from its migration kthread.
[ 2813.040289] migratio-21      2d.s1 2689243222us : activate_task: entered
[ 2813.040289] migratio-21      2d.s1 2689243225us : check_preempt_curr: entered
[ 2813.040289] migratio-27      3d.s1 2689243226us : activate_task: entered
[ 2813.040289] rcu_tort-125     5d... 2689243227us : scheduler_ipi: entered
[ 2813.040289] rcu_tort-125     5d.h. 2689243228us : sched_ttwu_pending: entered
[ 2813.040289] migratio-27      3d.s1 2689243228us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-125     5d.h. 2689243228us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] migratio-27      3d.s1 2689243229us : activate_task: entered
[ 2813.040289] rcu_tort-125     5d.h. 2689243229us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-11      0..s1 2689243229us : wake_up_process: entered
[ 2813.040289] rcu_tort-125     5d.h. 2689243229us : activate_task: entered
[ 2813.040289] migratio-27      3d.s1 2689243229us : check_preempt_curr: entered
[ 2813.040289] migratio-11      0..s1 2689243229us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243230us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243231us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-11      0d.s1 2689243231us : activate_task: entered
[ 2813.040289] migratio-21      2d... 2689243232us : sched_switch: prev_comm=migration/2 prev_pid=21 prev_prio=0 prev_state=S ==> next_comm=rcu_torture_rea next_pid=126 next_prio=139
	CPU 2 switches from its migration kthread.
[ 2813.040289] migratio-11      0d.s1 2689243232us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] rcu_tort-125     5d.h. 2689243232us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-11      0d.s1 2689243232us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-125     5d.h. 2689243232us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-125     5d.h. 2689243233us : resched_curr: entered
[ 2813.040289] migratio-11      0..s1 2689243234us : wake_up_process: entered
[ 2813.040289] migratio-11      0..s1 2689243234us : try_to_wake_up: entered
[ 2813.040289] migratio-27      3d... 2689243234us : sched_switch: prev_comm=migration/3 prev_pid=27 prev_prio=0 prev_state=S ==> next_comm=rcu_torture_fak next_pid=122 next_prio=139
	CPU 3 switches from its migration kthread.
[ 2813.040289] migratio-11      0d.s1 2689243235us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243235us : ttwu_do_activate.isra.108: entered
[ 2813.040289] kworker/-175     6d... 2689243235us : sched_switch: prev_comm=kworker/6:1 prev_pid=175 prev_prio=120 prev_state=I ==> next_comm=rcu_torture_fwd next_pid=136 next_prio=139
	CPU 6 switches yet again.
[ 2813.040289] migratio-11      0d.s1 2689243235us : activate_task: entered
[ 2813.040289] migratio-11      0d.s1 2689243236us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-11      0d.s1 2689243237us : check_preempt_curr: entered
[ 2813.040289] migratio-11      0d.s1 2689243239us : wake_up_process: entered
[ 2813.040289] rcu_tort-126     2d... 2689243240us : sched_switch: prev_comm=rcu_torture_rea prev_pid=126 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=124 next_prio=139
	CPU 2 switches yet again.
[ 2813.040289] migratio-11      0d.s1 2689243240us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243240us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243240us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-11      0d.s1 2689243240us : activate_task: entered
[ 2813.040289] migratio-11      0d.s1 2689243241us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-11      0d.s1 2689243241us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-125     5d... 2689243242us : sched_switch: prev_comm=rcu_torture_rea prev_pid=125 prev_prio=139 prev_state=S ==> next_comm=init next_pid=1 next_prio=120
	CPU 5 switches yet again.
[ 2813.040289] migratio-11      0d.s1 2689243242us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243243us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243243us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243243us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243244us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243244us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-124     2d... 2689243244us : sched_switch: prev_comm=rcu_torture_rea prev_pid=124 prev_prio=139 prev_state=S ==> next_comm=swapper/2 next_pid=0 next_prio=120
	CPU 2 switches yet again.
[ 2813.040289] migratio-11      0d.s1 2689243245us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243245us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243245us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243246us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243246us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243246us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0..s1 2689243247us : wake_up_process: entered
[ 2813.040289] migratio-11      0..s1 2689243247us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243248us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243248us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-11      0d.s1 2689243249us : activate_task: entered
[ 2813.040289] migratio-11      0d.s1 2689243249us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-11      0d.s1 2689243249us : check_preempt_curr: entered
[ 2813.040289] migratio-11      0d.s1 2689243251us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243251us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243251us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243252us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-11      0d.s1 2689243252us : activate_task: entered
[ 2813.040289] migratio-11      0d.s1 2689243252us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-11      0d.s1 2689243253us : check_preempt_curr: entered
[ 2813.040289] migratio-11      0d.s1 2689243263us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243263us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243264us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243264us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0..s1 2689243265us : wake_up_process: entered
[ 2813.040289] migratio-11      0..s1 2689243265us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243266us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243266us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-11      0d.s1 2689243266us : activate_task: entered
[ 2813.040289] migratio-11      0d.s1 2689243268us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-11      0d.s1 2689243268us : check_preempt_curr: entered
[ 2813.040289] migratio-11      0..s1 2689243269us : wake_up_process: entered
[ 2813.040289] migratio-11      0..s1 2689243269us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243270us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243270us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-11      0d.s1 2689243270us : activate_task: entered
[ 2813.040289] migratio-11      0d.s1 2689243271us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-11      0d.s1 2689243272us : check_preempt_curr: entered
[ 2813.040289] migratio-52      7d... 2689243291us : sched_switch: prev_comm=migration/7 prev_pid=52 prev_prio=0 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
	CPU 7 switches from its migration kthread.
[ 2813.040289] migratio-11      0d.s1 2689243315us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243315us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243316us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243316us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243316us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243317us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d.s1 2689243317us : wake_up_process: entered
[ 2813.040289] migratio-11      0d.s1 2689243318us : try_to_wake_up: entered
[ 2813.040289] migratio-11      0d... 2689243323us : sched_switch: prev_comm=migration/0 prev_pid=11 prev_prio=0 prev_state=S ==> next_comm=kworker/0:3 next_pid=171 next_prio=120
	CPU 0 switches from its migration kthread.
[ 2813.040289] kworker/-171     0d... 2689243327us : try_to_wake_up: entered
[ 2813.040289] kworker/-171     0d... 2689243327us : try_to_wake_up: entered
[ 2813.040289] kworker/-171     0d... 2689243328us : try_to_wake_up: entered, CPU 5
[ 2813.040289]     init-1       5d... 2689243343us : scheduler_ipi: entered
[ 2813.040289]     init-1       5d.h. 2689243344us : sched_ttwu_pending: entered
[ 2813.040289]     init-1       5d.h. 2689243344us : sched_ttwu_pending: non-NULL llist
[ 2813.040289]     init-1       5d.h. 2689243351us : ttwu_do_activate.isra.108: entered
[ 2813.040289]     init-1       5d.h. 2689243351us : activate_task: entered
[ 2813.040289]     init-1       5d.h. 2689243353us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289]     init-1       5d.h. 2689243353us : check_preempt_curr: entered
[ 2813.040289] kworker/-171     0d... 2689243362us : sched_switch: prev_comm=kworker/0:3 prev_pid=171 prev_prio=120 prev_state=I ==> next_comm=rcu_sched next_pid=10 next_prio=120
	CPU 0 switches again.
[ 2813.040289] rcu_sche-10      0d... 2689243365us : try_to_wake_up: entered
[ 2813.040289] rcu_sche-10      0d... 2689243366us : try_to_wake_up: entered
[ 2813.040289] rcu_sche-10      0d... 2689243366us : try_to_wake_up: entered, CPU 5
[ 2813.040289] rcu_sche-10      0d... 2689243379us : sched_switch: prev_comm=rcu_sched prev_pid=10 prev_prio=120 prev_state=I ==> next_comm=rcu_torture_fak next_pid=123 next_prio=139
	CPU 0 switches again.
[ 2813.040289]     init-1       5d... 2689243380us : scheduler_ipi: entered
[ 2813.040289]     init-1       5d.h. 2689243380us : sched_ttwu_pending: entered
[ 2813.040289]     init-1       5d.h. 2689243380us : sched_ttwu_pending: non-NULL llist
[ 2813.040289]     init-1       5d.h. 2689243380us : ttwu_do_activate.isra.108: entered
[ 2813.040289]     init-1       5d.h. 2689243381us : activate_task: entered
[ 2813.040289]     init-1       5d.h. 2689243382us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289]     init-1       5d.h. 2689243382us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-123     0d... 2689243509us : sched_switch: prev_comm=rcu_torture_fak prev_pid=123 prev_prio=139 prev_state=D ==> next_comm=kworker/u16:0 next_pid=181 next_prio=120
	CPU 0 switches again.
[ 2813.040289] kworker/-181     0d... 2689243510us : wake_up_process: entered
[ 2813.040289] kworker/-181     0d... 2689243510us : try_to_wake_up: entered
[ 2813.040289] kworker/-181     0d... 2689243510us : try_to_wake_up: entered
[ 2813.040289] kworker/-181     0d... 2689243511us : ttwu_do_activate.isra.108: entered
[ 2813.040289] kworker/-181     0d... 2689243511us : activate_task: entered
[ 2813.040289] kworker/-181     0d... 2689243512us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] kworker/-181     0d... 2689243512us : check_preempt_curr: entered
[ 2813.040289] kworker/-181     0d... 2689243513us : wake_up_process: entered
[ 2813.040289] kworker/-181     0d... 2689243513us : try_to_wake_up: entered
[ 2813.040289] kworker/-181     0d... 2689243513us : wake_up_process: entered
[ 2813.040289] kworker/-181     0d... 2689243513us : try_to_wake_up: entered
[ 2813.040289] kworker/-181     0d... 2689243514us : wake_up_process: entered
[ 2813.040289] kworker/-181     0d... 2689243514us : try_to_wake_up: entered
[ 2813.040289] kworker/-181     0d... 2689243514us : wake_up_process: entered
[ 2813.040289] kworker/-181     0d... 2689243514us : try_to_wake_up: entered
[ 2813.040289] kworker/-181     0d... 2689243515us : wake_up_process: entered
[ 2813.040289] kworker/-181     0d... 2689243515us : try_to_wake_up: entered
[ 2813.040289] kworker/-181     0d... 2689243516us : sched_switch: prev_comm=kworker/u16:0 prev_pid=181 prev_prio=120 prev_state=I ==> next_comm=torture_shuffle next_pid=132 next_prio=120
	CPU 0 switches again.
[ 2813.040289] torture_-132     0.... 2689243518us : wake_up_q: entered
[ 2813.040289] torture_-132     0d... 2689243519us : sched_switch: prev_comm=torture_shuffle prev_pid=132 prev_prio=120 prev_state=D ==> next_comm=kworker/0:1 next_pid=183 next_prio=120
	CPU 0 switches again.
[ 2813.040289] kworker/-183     0d... 2689243521us : sched_switch: prev_comm=kworker/0:1 prev_pid=183 prev_prio=120 prev_state=I ==> next_comm=rcu_torture_sta next_pid=131 next_prio=120
	CPU 0 switches again.
[ 2813.040289] rcu_tort-131     0d... 2689243559us : sched_switch: prev_comm=rcu_torture_sta prev_pid=131 prev_prio=120 prev_state=S ==> next_comm=torture_stutter next_pid=133 next_prio=120
	CPU 0 switches again.
[ 2813.040289] torture_-133     0d... 2689243561us : sched_switch: prev_comm=torture_stutter prev_pid=133 prev_prio=120 prev_state=S ==> next_comm=kworker/u16:4 next_pid=161 next_prio=120
[ 2813.040289] kworker/-161     0d... 2689243566us : activate_task: entered
[ 2813.040289] kworker/-161     0d... 2689243567us : check_preempt_curr: entered
[ 2813.040289] kworker/-161     0d... 2689243568us : sched_switch: prev_comm=kworker/u16:4 prev_pid=161 prev_prio=120 prev_state=I ==> next_comm=rcu_torture_rea next_pid=130 next_prio=139
	CPU 0 switches again.
[ 2813.040289] rcu_tort-130     0d... 2689243571us : activate_task: entered
[ 2813.040289] rcu_tort-130     0d... 2689243572us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-130     0d... 2689243572us : activate_task: entered
[ 2813.040289] rcu_tort-130     0d... 2689243572us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-130     0d... 2689243573us : sched_switch: prev_comm=rcu_torture_rea prev_pid=130 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=127 next_prio=139
	CPU 0 switches again.
[ 2813.040289] rcu_tort-127     0d... 2689243585us : sched_switch: prev_comm=rcu_torture_rea prev_pid=127 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=128 next_prio=139
	CPU 0 switches again.
[ 2813.040289] rcu_tort-128     0d... 2689243588us : activate_task: entered
[ 2813.040289] rcu_tort-128     0d... 2689243588us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-128     0d... 2689243588us : sched_switch: prev_comm=rcu_torture_rea prev_pid=128 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=129 next_prio=139
	CPU 0 switches again.
[ 2813.040289] rcu_tort-129     0d... 2689243591us : sched_switch: prev_comm=rcu_torture_rea prev_pid=129 prev_prio=139 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
	CPU 0 switches again.
[ 2813.040289] rcu_tort-122     3.... 2689243707us : wake_up_process: entered
[ 2813.040289] rcu_tort-122     3.... 2689243707us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-122     3d... 2689243711us : sched_switch: prev_comm=rcu_torture_fak prev_pid=122 prev_prio=139 prev_state=D ==> next_comm=swapper/3 next_pid=0 next_prio=120
	CPU 3 switches again.
[ 2813.040289]   <idle>-0       0d... 2689244073us : wake_up_process: entered
[ 2813.040289]   <idle>-0       0d... 2689244074us : try_to_wake_up: entered
[ 2813.040289]   <idle>-0       0d... 2689244074us : try_to_wake_up: entered
[ 2813.040289]   <idle>-0       0d... 2689244074us : ttwu_do_activate.isra.108: entered
[ 2813.040289]   <idle>-0       0d... 2689244075us : activate_task: entered
[ 2813.040289]   <idle>-0       0d... 2689244076us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289]   <idle>-0       0d... 2689244076us : check_preempt_curr: entered
[ 2813.040289]   <idle>-0       0d... 2689244076us : resched_curr: entered
[ 2813.040289]   <idle>-0       0.N.. 2689244087us : sched_ttwu_pending: entered
[ 2813.040289]   <idle>-0       0d... 2689244088us : sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=9 next_prio=120
	CPU 0 switches again.
[ 2813.040289]     init-1       5d... 2689244336us : sched_switch: prev_comm=init prev_pid=1 prev_prio=120 prev_state=S ==> next_comm=rcu_torture_fak next_pid=120 next_prio=139
	CPU 5 switches again.
[ 2813.040289] rcu_tort-120     5.... 2689244344us : wake_up_q: entered
[ 2813.040289] rcu_tort-120     5.... 2689244344us : wake_up_process: entered
[ 2813.040289] rcu_tort-120     5.... 2689244344us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-120     5d... 2689244345us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-120     5d... 2689244346us : try_to_wake_up: entered, CPU 0
[ 2813.040289] rcu_tort-120     5d... 2689244359us : sched_switch: prev_comm=rcu_torture_fak prev_pid=120 prev_prio=139 prev_state=S ==> next_comm=rcuog/1 next_pid=18 next_prio=120
	CPU 5 switches again.
[ 2813.040289]  rcuog/1-18      5d... 2689244361us : wake_up_process: entered
[ 2813.040289]  rcuog/1-18      5d... 2689244362us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689244362us : scheduler_ipi: entered
[ 2813.040289]  rcuog/1-18      5d... 2689244362us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244362us : sched_ttwu_pending: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244363us : sched_ttwu_pending: non-NULL llist
[ 2813.040289]  rcuog/1-18      5d... 2689244363us : try_to_wake_up: entered, CPU 0
[ 2813.040289] ksoftirq-9       0d.H. 2689244363us : ttwu_do_activate.isra.108: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244363us : activate_task: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244365us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244365us : check_preempt_curr: entered
[ 2813.040289]  rcuog/1-18      5d... 2689244375us : sched_switch: prev_comm=rcuog/1 prev_pid=18 prev_prio=120 prev_state=S ==> next_comm=swapper/5 next_pid=0 next_prio=120
	CPU 5 switches again.
[ 2813.040289] ksoftirq-9       0d.s. 2689244386us : scheduler_ipi: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244386us : sched_ttwu_pending: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244387us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] ksoftirq-9       0d.H. 2689244387us : ttwu_do_activate.isra.108: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244387us : activate_task: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244388us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689244388us : check_preempt_curr: entered
[ 2813.040289] ksoftirq-9       0..s. 2689245078us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689245078us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245079us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245079us : ttwu_do_activate.isra.108: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245080us : activate_task: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245080us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245080us : check_preempt_curr: entered
[ 2813.040289] ksoftirq-9       0..s. 2689245081us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689245081us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245081us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245082us : ttwu_do_activate.isra.108: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245082us : activate_task: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245082us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245083us : check_preempt_curr: entered
[ 2813.040289] ksoftirq-9       0..s. 2689245083us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689245083us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245084us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245084us : ttwu_do_activate.isra.108: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245084us : activate_task: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245084us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245085us : check_preempt_curr: entered
[ 2813.040289] ksoftirq-9       0..s. 2689245085us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689245085us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245086us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245086us : ttwu_do_activate.isra.108: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245086us : activate_task: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245087us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689245087us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-136     6.... 2689245087us : wake_up_process: entered
[ 2813.040289] rcu_tort-136     6.... 2689245087us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-136     6d... 2689245087us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-136     6d... 2689245087us : try_to_wake_up: entered, CPU 0
[ 2813.040289] ksoftirq-9       0d.s. 2689245639us : scheduler_ipi: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245639us : sched_ttwu_pending: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245639us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] ksoftirq-9       0d.H. 2689245639us : ttwu_do_activate.isra.108: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245640us : activate_task: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245640us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245640us : check_preempt_curr: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245640us : resched_curr: entered
[ 2813.040289] rcu_tort-136     6d... 2689245640us : activate_task: entered
[ 2813.040289] rcu_tort-136     6d... 2689245640us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-136     6d... 2689245640us : activate_task: entered
[ 2813.040289] rcu_tort-136     6d... 2689245640us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-136     6d... 2689245640us : resched_curr: entered
[ 2813.040289] rcu_tort-136     6dN.. 2689245640us : activate_task: entered
[ 2813.040289] rcu_tort-136     6dN.. 2689245640us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-136     6d... 2689245640us : sched_switch: prev_comm=rcu_torture_fwd prev_pid=136 prev_prio=139 prev_state=D ==> next_comm=rcuos/2 next_pid=25 next_prio=120
	CPU 6 switches again.
[ 2813.040289] ksoftirq-9       0d... 2689245654us : sched_switch: prev_comm=ksoftirqd/0 prev_pid=9 prev_prio=120 prev_state=R+ ==> next_comm=rcuog/4 next_pid=37 next_prio=120
	CPU 0 switches again.
[ 2813.040289]  rcuog/4-37      0d... 2689245658us : sched_switch: prev_comm=rcuog/4 prev_pid=37 prev_prio=120 prev_state=S ==> next_comm=ksoftirqd/0 next_pid=9 next_prio=120
	CPU 0 switches again.
[ 2813.040289]  rcuos/2-25      6d... 2689245658us : try_to_wake_up: entered
[ 2813.040289]  rcuos/2-25      6d... 2689245658us : try_to_wake_up: entered
[ 2813.040289]  rcuos/2-25      6d... 2689245658us : try_to_wake_up: entered, CPU 2
[ 2813.040289]  rcuos/2-25      6d... 2689245658us : sched_switch: prev_comm=rcuos/2 prev_pid=25 prev_prio=120 prev_state=S ==> next_comm=rcu_torture_fak next_pid=123 next_prio=139
	CPU 6 switches again.
[ 2813.040289] rcu_tort-123     6d... 2689245658us : wake_up_process: entered
[ 2813.040289] rcu_tort-123     6d... 2689245658us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-123     6d... 2689245658us : try_to_wake_up: entered
[ 2813.040289] rcu_tort-123     6d... 2689245658us : try_to_wake_up: entered, CPU 0
[ 2813.040289] rcu_tort-123     6d... 2689245658us : sched_switch: prev_comm=rcu_torture_fak prev_pid=123 prev_prio=139 prev_state=D ==> next_comm=rcu_torture_rea next_pid=129 next_prio=139
	CPU 6 switches again.
[ 2813.040289] rcu_tort-129     6d... 2689245658us : activate_task: entered
[ 2813.040289] rcu_tort-129     6d... 2689245658us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-129     6d... 2689245658us : sched_switch: prev_comm=rcu_torture_rea prev_pid=129 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=128 next_prio=139
	CPU 6 switches again.
[ 2813.040289] ksoftirq-9       0d.s. 2689245781us : scheduler_ipi: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245781us : sched_ttwu_pending: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245781us : sched_ttwu_pending: non-NULL llist
[ 2813.040289] ksoftirq-9       0d.H. 2689245781us : ttwu_do_activate.isra.108: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245782us : activate_task: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245782us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245782us : check_preempt_curr: entered
[ 2813.040289] ksoftirq-9       0d.H. 2689245783us : resched_curr: entered
[ 2813.040289] rcu_tort-128     6d... 2689245783us : activate_task: entered
[ 2813.040289] rcu_tort-128     6d... 2689245783us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-128     6d... 2689245783us : sched_switch: prev_comm=rcu_torture_rea prev_pid=128 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=127 next_prio=139
	CPU 6 switches again.
[ 2813.040289] rcu_tort-127     6d... 2689245783us : activate_task: entered
[ 2813.040289] rcu_tort-127     6d... 2689245783us : check_preempt_curr: entered
[ 2813.040289] rcu_tort-127     6d... 2689245783us : sched_switch: prev_comm=rcu_torture_rea prev_pid=127 prev_prio=139 prev_state=S ==> next_comm=rcu_torture_rea next_pid=130 next_prio=139
	CPU 6 switches again.
[ 2813.040289] rcu_tort-130     6d... 2689245783us : sched_switch: prev_comm=rcu_torture_rea prev_pid=130 prev_prio=139 prev_state=S ==> next_comm=swapper/6 next_pid=0 next_prio=120
	CPU 6 switches again.
[ 2813.040289] ksoftirq-9       0d... 2689245805us : sched_switch: prev_comm=ksoftirqd/0 prev_pid=9 prev_prio=120 prev_state=R+ ==> next_comm=kworker/0:1 next_pid=183 next_prio=120
	CPU 0 switches again.
[ 2813.040289]   <idle>-0       2d... 2689245805us : scheduler_ipi: entered
[ 2813.040289]   <idle>-0       2d.h. 2689246047us : sched_ttwu_pending: entered
[ 2813.040289]   <idle>-0       2d.h. 2689246047us : sched_ttwu_pending: non-NULL llist
[ 2813.040289]   <idle>-0       2d.h. 2689246048us : ttwu_do_activate.isra.108: entered
[ 2813.040289]   <idle>-0       2d.h. 2689246048us : activate_task: entered
[ 2813.040289]   <idle>-0       2d.h. 2689246050us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289]   <idle>-0       2d.h. 2689246050us : check_preempt_curr: entered
[ 2813.040289]   <idle>-0       2d.h. 2689246050us : resched_curr: entered
[ 2813.040289]   <idle>-0       2.N.. 2689246090us : sched_ttwu_pending: entered
[ 2813.040289]   <idle>-0       2d... 2689246091us : sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_torture_wri next_pid=119 next_prio=120
	CPU 2 switches again.
[ 2813.040289] rcu_tort-119     2d... 2689246096us : sched_switch: prev_comm=rcu_torture_wri prev_pid=119 prev_prio=120 prev_state=S ==> next_comm=swapper/2 next_pid=0 next_prio=120
	CPU 2 switches again.
[ 2813.040289] kworker/-183     0d.h. 2689280510us : resched_curr: entered
[ 2813.040289] kworker/-183     0dNh. 2689285096us : resched_curr: entered
[ 2813.040289] kworker/-183     0dN.. 2689285103us : wake_up_process: entered
[ 2813.040289] kworker/-183     0dN.. 2689285103us : try_to_wake_up: entered
[ 2813.040289] kworker/-183     0dN.. 2689285104us : try_to_wake_up: entered
[ 2813.040289] kworker/-183     0dN.. 2689285105us : ttwu_do_activate.isra.108: entered
[ 2813.040289] kworker/-183     0dN.. 2689285105us : activate_task: entered
[ 2813.040289] kworker/-183     0dN.. 2689285106us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] kworker/-183     0dN.. 2689285106us : check_preempt_curr: entered
[ 2813.040289] kworker/-183     0d... 2689285109us : sched_switch: prev_comm=kworker/0:1 prev_pid=183 prev_prio=120 prev_state=D ==> next_comm=kworker/0:3 next_pid=171 next_prio=120
	CPU 0 switches again.
[ 2813.040289] kworker/-171     0d... 2689285121us : try_to_wake_up: entered
[ 2813.040289] kworker/-171     0d... 2689285121us : try_to_wake_up: entered
[ 2813.040289] kworker/-171     0d... 2689285122us : ttwu_do_activate.isra.108: entered
[ 2813.040289] kworker/-171     0d... 2689285122us : activate_task: entered
[ 2813.040289] kworker/-171     0d... 2689285122us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] kworker/-171     0d... 2689285122us : check_preempt_curr: entered
[ 2813.040289] kworker/-171     0d... 2689285123us : sched_switch: prev_comm=kworker/0:3 prev_pid=171 prev_prio=120 prev_state=I ==> next_comm=ksoftirqd/0 next_pid=9 next_prio=120
	CPU 0 switches again.
[ 2813.040289] ksoftirq-9       0..s. 2689285125us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689285126us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285126us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285127us : try_to_wake_up: entered, CPU 5
[ 2813.040289] ksoftirq-9       0..s. 2689285138us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689285138us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285138us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285138us : try_to_wake_up: entered, CPU 6
[ 2813.040289] migratio-14      1dN.1 2689285146us : try_to_wake_up: entered
[ 2813.040289] migratio-14      1dN.1 2689285148us : try_to_wake_up: entered
[ 2813.040289] migratio-14      1dN.1 2689285148us : ttwu_do_activate.isra.108: entered
[ 2813.040289] migratio-14      1dN.1 2689285148us : activate_task: entered
[ 2813.040289] migratio-14      1dN.1 2689285149us : ttwu_do_wakeup.isra.107: entered
[ 2813.040289] migratio-14      1dN.1 2689285149us : check_preempt_curr: entered
[ 2813.040289] ksoftirq-9       0..s. 2689285150us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689285150us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285150us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285151us : try_to_wake_up: entered, CPU 6
[ 2813.040289] ksoftirq-9       0..s. 2689285151us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689285151us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285152us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285152us : try_to_wake_up: entered, CPU 6
[ 2813.040289] ksoftirq-9       0..s. 2689285152us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689285152us : try_to_wake_up: entered
[ 2813.040289] migratio-14      1d... 2689285153us : sched_switch: prev_comm=migration/1 prev_pid=14 prev_prio=0 prev_state=S ==> next_comm=torture_onoff next_pid=135 next_prio=120
	CPU 1 switches from its migration kthread.
[ 2813.040289] ksoftirq-9       0d.s. 2689285153us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285153us : try_to_wake_up: entered, CPU 6
[ 2813.040289] ksoftirq-9       0..s. 2689285153us : wake_up_process: entered
[ 2813.040289] ksoftirq-9       0..s. 2689285153us : try_to_wake_up: entered
[ 2813.040289] ksoftirq-9       0d.s. 2689285154us : try_to_wake_up: entered
[ 2813.040289] ---------------------------------

And finally, the trace ends and CPU 4 is announced as being offline:

[ 2813.040289] smpboot: CPU 4 is now offline

