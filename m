Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745AAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322742075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbfHFSIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:08:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726783AbfHFSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:08:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76I2PNd132741
        for <linux-kernel@vger.kernel.org>; Tue, 6 Aug 2019 14:08:31 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u7eb2rgvf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:08:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 6 Aug 2019 19:08:30 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 6 Aug 2019 19:08:24 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x76I8NuM43843910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Aug 2019 18:08:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0693B206E;
        Tue,  6 Aug 2019 18:08:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E2F6B205F;
        Tue,  6 Aug 2019 18:08:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  6 Aug 2019 18:08:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 32C1A16C17E8; Tue,  6 Aug 2019 11:08:24 -0700 (PDT)
Date:   Tue, 6 Aug 2019 11:08:24 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805174800.GK28441@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19080618-0060-0000-0000-000003699552
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011561; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243004; UDB=6.00655680; IPR=6.01024468;
 MB=3.00028068; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-06 18:08:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080618-0061-0000-0000-00004A739DF1
Message-Id: <20190806180824.GA28448@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:48:00AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 05, 2019 at 05:50:24PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 05, 2019 at 07:54:48AM -0700, Paul E. McKenney wrote:
> > 
> > > > Right; so clearly we're not understanding what's happening. That seems
> > > > like a requirement for actually doing a patch.
> > > 
> > > Almost but not quite.  It is a requirement for a patch *that* *is*
> > > *supposed* *to* *be* *a* *fix*.  If you are trying to prohibit me from
> > > writing experimental patches, please feel free to take a long walk on
> > > a short pier.
> > > 
> > > Understood???
> > 
> > Ah, my bad, I thought you were actually proposing this as an actual
> > patch. I now see that is my bad, I'd overlooked the RFC part.
> 
> No problem!
> 
> And of course adding tracing decreases the frequency and duration of
> the multi_cpu_stop().  Re-running with shorter-duration triggering.  ;-)

And I did eventually get a good trace.  If I am interpreting this trace
correctly, the torture_-135 task didn't get around to attempting to wake
up all of the CPUs.  I will try again, but this time with the sched_switch
trace event enabled.

As a side note, enabling ftrace from the command line seems to interact
badly with turning tracing off and on in the kernel, so I eventually
resorted to trace_printk() in the functions of interest.  The trace
output is below, followed by the current diagnostic patch.  Please note
that I am -not- using the desperation hammer-the-scheduler patches.

More as I learn more!

							Thanx, Paul

------------------------------------------------------------------------

[  280.918596] torture_-135     0.... 163481679us : __stop_cpus: __stop_cpus entered
[  280.918596] torture_-135     0.... 163481680us : queue_stop_cpus_work: queue_stop_cpus_work entered
[  280.918596] torture_-135     0.... 163481681us : cpu_stop_queue_work: cpu_stop_queue_work entered
[  280.918596] torture_-135     0.... 163481681us : wake_up_q: wake_up_q entered
[  280.918596] torture_-135     0.... 163481682us : wake_up_process: wake_up_process entered
[  280.918596] torture_-135     0.... 163481682us : try_to_wake_up: try_to_wake_up entered
[  280.918596] torture_-135     0d... 163481682us : try_to_wake_up: ttwu_queue entered
[  280.918596] torture_-135     0d... 163481682us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] torture_-135     0d... 163481682us : activate_task: activate_task entered
[  280.918596] torture_-135     0d... 163481683us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] torture_-135     0d... 163481683us : check_preempt_curr: check_preempt_curr entered
[  280.918596] torture_-135     0d... 163481683us : resched_curr: resched_curr entered
[  280.918596] torture_-135     0.N.. 163481684us : cpu_stop_queue_work: cpu_stop_queue_work entered
[  280.918596] torture_-135     0.N.. 163481684us : wake_up_q: wake_up_q entered
[  280.918596] torture_-135     0.N.. 163481684us : wake_up_process: wake_up_process entered
[  280.918596] torture_-135     0.N.. 163481685us : try_to_wake_up: try_to_wake_up entered
[  280.918596] torture_-135     0dN.. 163481685us : try_to_wake_up: ttwu_queue entered
[  280.918596] torture_-135     0dN.. 163481685us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596] torture_-135     0.N.. 163481695us : cpu_stop_queue_work: cpu_stop_queue_work entered
[  280.918596]   <idle>-0       1d... 163481700us : scheduler_ipi: scheduler_ipi entered
[  280.918596]   <idle>-0       1d.h. 163481702us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596]   <idle>-0       1d.h. 163481702us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596]   <idle>-0       1d.h. 163481702us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596]   <idle>-0       1d.h. 163481703us : activate_task: activate_task entered
[  280.918596]   <idle>-0       1d.h. 163481703us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596]   <idle>-0       1d.h. 163481703us : check_preempt_curr: check_preempt_curr entered
[  280.918596]   <idle>-0       1d.h. 163481707us : resched_curr: resched_curr entered
[  280.918596] torture_-135     0.N.. 163481713us : wake_up_q: wake_up_q entered
[  280.918596] torture_-135     0.N.. 163481713us : wake_up_process: wake_up_process entered
[  280.918596] torture_-135     0.N.. 163481713us : try_to_wake_up: try_to_wake_up entered
[  280.918596] torture_-135     0dN.. 163481713us : try_to_wake_up: ttwu_queue entered
[  280.918596] torture_-135     0dN.. 163481714us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596] torture_-135     0.N.. 163481722us : cpu_stop_queue_work: cpu_stop_queue_work entered
[  280.918596] torture_-135     0.N.. 163481723us : wake_up_q: wake_up_q entered
[  280.918596] torture_-135     0.N.. 163481723us : wake_up_process: wake_up_process entered
[  280.918596] torture_-135     0.N.. 163481723us : try_to_wake_up: try_to_wake_up entered
[  280.918596] torture_-135     0dN.. 163481723us : try_to_wake_up: ttwu_queue entered
[  280.918596] torture_-135     0dN.. 163481724us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596]   <idle>-0       1.N.. 163481730us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] torture_-135     0.N.. 163481732us : cpu_stop_queue_work: cpu_stop_queue_work entered
[  280.918596] torture_-135     0.N.. 163481732us : wake_up_q: wake_up_q entered
[  280.918596] torture_-135     0.N.. 163481732us : wake_up_process: wake_up_process entered
[  280.918596] torture_-135     0.N.. 163481733us : try_to_wake_up: try_to_wake_up entered
[  280.918596] torture_-135     0dN.. 163481733us : try_to_wake_up: ttwu_queue entered
[  280.918596] rcu_tort-130     3d... 163481733us : scheduler_ipi: scheduler_ipi entered
[  280.918596] torture_-135     0dN.. 163481733us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596] rcu_tort-130     3d.h. 163481734us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] rcu_tort-130     3d.h. 163481734us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596] rcu_tort-130     3d.h. 163481735us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] rcu_tort-130     3d.h. 163481735us : activate_task: activate_task entered
[  280.918596] rcu_tort-130     3d.h. 163481735us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] rcu_tort-130     3d.h. 163481735us : check_preempt_curr: check_preempt_curr entered
[  280.918596] rcu_tort-130     3d.h. 163481735us : resched_curr: resched_curr entered
[  280.918596] torture_-135     0.N.. 163481742us : cpu_stop_queue_work: cpu_stop_queue_work entered
[  280.918596] torture_-135     0.N.. 163481742us : wake_up_q: wake_up_q entered
[  280.918596] torture_-135     0.N.. 163481742us : wake_up_process: wake_up_process entered
[  280.918596] torture_-135     0.N.. 163481742us : try_to_wake_up: try_to_wake_up entered
[  280.918596] torture_-135     0dN.. 163481743us : try_to_wake_up: ttwu_queue entered
[  280.918596] torture_-135     0dN.. 163481743us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596] rcu_tort-128     4d... 163481743us : scheduler_ipi: scheduler_ipi entered
[  280.918596] rcu_tort-124     2d... 163481746us : scheduler_ipi: scheduler_ipi entered
[  280.918596] rcu_tort-128     4d.h. 163481746us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] rcu_tort-128     4d.h. 163481746us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596] rcu_tort-124     2d.h. 163481747us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] rcu_tort-128     4d.h. 163481747us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] rcu_tort-124     2d.h. 163481747us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596] rcu_tort-124     2d.h. 163481747us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] rcu_tort-128     4d.h. 163481747us : activate_task: activate_task entered
[  280.918596] rcu_tort-124     2d.h. 163481748us : activate_task: activate_task entered
[  280.918596] rcu_tort-128     4d.h. 163481748us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] rcu_tort-124     2d.h. 163481748us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] rcu_tort-128     4d.h. 163481748us : check_preempt_curr: check_preempt_curr entered
[  280.918596] rcu_tort-124     2d.h. 163481748us : check_preempt_curr: check_preempt_curr entered
[  280.918596] rcu_tort-128     4d.h. 163481748us : resched_curr: resched_curr entered
[  280.918596] rcu_tort-124     2d.h. 163481749us : resched_curr: resched_curr entered
[  280.918596] torture_-135     0.N.. 163481752us : cpu_stop_queue_work: cpu_stop_queue_work entered
[  280.918596] torture_-135     0.N.. 163481753us : wake_up_q: wake_up_q entered
[  280.918596] torture_-135     0.N.. 163481753us : wake_up_process: wake_up_process entered
[  280.918596] torture_-135     0.N.. 163481753us : try_to_wake_up: try_to_wake_up entered
[  280.918596] torture_-135     0dN.. 163481753us : try_to_wake_up: ttwu_queue entered
[  280.918596] torture_-135     0dN.. 163481753us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596]   <idle>-0       5d... 163481772us : scheduler_ipi: scheduler_ipi entered
[  280.918596]   <idle>-0       5d.h. 163481773us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596]   <idle>-0       5d.h. 163481774us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596]   <idle>-0       5d.h. 163481774us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596]   <idle>-0       5d.h. 163481775us : activate_task: activate_task entered
[  280.918596]   <idle>-0       5d.h. 163481776us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596]   <idle>-0       5d.h. 163481776us : check_preempt_curr: check_preempt_curr entered
[  280.918596]   <idle>-0       5d.h. 163481776us : resched_curr: resched_curr entered
[  280.918596]   <idle>-0       5.N.. 163481808us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] migratio-11      0..s1 163481828us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0..s1 163481829us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 163481829us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.s1 163481829us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596] migratio-14      1d..1 163481869us : scheduler_ipi: scheduler_ipi entered
[  280.918596] migratio-14      1d.h1 163481870us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] migratio-14      1d.h1 163481870us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596] migratio-14      1d.h1 163481871us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-14      1d.h1 163481890us : activate_task: activate_task entered
[  280.918596] migratio-14      1d.h1 163481891us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-14      1d.h1 163481892us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0..s1 163483828us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0..s1 163483828us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 163483828us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.s1 163483829us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-11      0d.s1 163483829us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.s1 163483829us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-11      0d.s1 163483829us : check_preempt_curr: check_preempt_curr entered
[  280.918596]   <idle>-0       7d... 163483829us : scheduler_ipi: scheduler_ipi entered
[  280.918596]   <idle>-0       7d.h. 163486880us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596]   <idle>-0       7d.h. 163486881us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596]   <idle>-0       7d.h. 163486885us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596]   <idle>-0       7d.h. 163486885us : activate_task: activate_task entered
[  280.918596]   <idle>-0       7d.h. 163486885us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596]   <idle>-0       7d.h. 163486886us : check_preempt_curr: check_preempt_curr entered
[  280.918596]   <idle>-0       7d.h. 163486889us : resched_curr: resched_curr entered
[  280.918596]   <idle>-0       7.N.. 163486937us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] migratio-40      5d..1 278818221us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] migratio-11      0d.h1 278818380us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.h1 278818382us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.h1 278818384us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.h1 278818384us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596] rcu_tort-123     3d... 278818385us : wake_up_process: wake_up_process entered
[  280.918596] rcu_tort-123     3d... 278818386us : try_to_wake_up: try_to_wake_up entered
[  280.918596] rcu_tort-123     3d... 278818387us : try_to_wake_up: ttwu_queue entered
[  280.918596] rcu_tort-123     3d... 278818387us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596] migratio-33      4d.s1 278818403us : activate_task: activate_task entered
[  280.918596] migratio-33      4d.s1 278818405us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0d.s1 278818416us : scheduler_ipi: scheduler_ipi entered
[  280.918596] migratio-11      0d.H1 278818417us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] migratio-11      0d.H1 278818417us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596] migratio-11      0d.H1 278818418us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-11      0d.H1 278818421us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.H1 278818423us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-11      0d.H1 278818423us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0..s1 278818425us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0..s1 278818426us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818427us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.s1 278818427us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-11      0d.s1 278818427us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.s1 278818428us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-11      0d.s1 278818428us : check_preempt_curr: check_preempt_curr entered
[  280.918596] rcu_tort-124     2d... 278818429us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.s1 278818430us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818431us : try_to_wake_up: try_to_wake_up entered
[  280.918596] rcu_tort-124     2d... 278818431us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0d.s1 278818431us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.s1 278818432us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-11      0d.s1 278818432us : activate_task: activate_task entered
[  280.918596] rcu_tort-124     2d... 278818432us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.s1 278818432us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-11      0d.s1 278818433us : check_preempt_curr: check_preempt_curr entered
[  280.918596] rcu_tort-124     2d... 278818434us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0d.s1 278818434us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818434us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818435us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818435us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818436us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818436us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818438us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818438us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818439us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818440us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0..s1 278818441us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0..s1 278818441us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818441us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.s1 278818442us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-11      0d.s1 278818442us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.s1 278818443us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-11      0d.s1 278818443us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0..s1 278818444us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0..s1 278818444us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818445us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.s1 278818445us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-11      0d.s1 278818446us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.s1 278818446us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-11      0d.s1 278818447us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0..s1 278818449us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0..s1 278818449us : try_to_wake_up: try_to_wake_up entered
[  280.918596] rcu_tort-126     2d... 278818451us : activate_task: activate_task entered
[  280.918596] rcu_tort-126     2d... 278818452us : check_preempt_curr: check_preempt_curr entered
[  280.918596] rcu_tort-126     2d... 278818452us : resched_curr: resched_curr entered
[  280.918596] rcu_tort-126     2dN.. 278818453us : activate_task: activate_task entered
[  280.918596] rcu_tort-126     2dN.. 278818454us : check_preempt_curr: check_preempt_curr entered
[  280.918596] rcu_tort-126     2dN.. 278818454us : activate_task: activate_task entered
[  280.918596] rcu_tort-126     2dN.. 278818455us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0d.s1 278818466us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.s1 278818466us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-11      0d.s1 278818467us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.s1 278818467us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-11      0d.s1 278818468us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0d.s1 278818469us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818469us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0..s1 278818481us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0..s1 278818481us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818482us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-11      0d.s1 278818483us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-11      0d.s1 278818483us : activate_task: activate_task entered
[  280.918596] migratio-11      0d.s1 278818484us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-11      0d.s1 278818484us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-11      0d.s1 278818485us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818485us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818487us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818487us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818488us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818488us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818489us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818490us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818491us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818491us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818492us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818492us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818493us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818493us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-11      0d.s1 278818494us : wake_up_process: wake_up_process entered
[  280.918596] migratio-11      0d.s1 278818495us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-62      0d... 278818512us : wake_up_process: wake_up_process entered
[  280.918596] kworker/-62      0d... 278818512us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-62      0d... 278818513us : try_to_wake_up: ttwu_queue entered
[  280.918596] kworker/-62      0d... 278818514us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] kworker/-62      0d... 278818514us : activate_task: activate_task entered
[  280.918596] kworker/-62      0d... 278818515us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] kworker/-62      0d... 278818516us : check_preempt_curr: check_preempt_curr entered
[  280.918596] kworker/-161     0d... 278818518us : wake_up_process: wake_up_process entered
[  280.918596] kworker/-161     0d... 278818519us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-161     0d... 278818519us : try_to_wake_up: ttwu_queue entered
[  280.918596] kworker/-161     0d... 278818519us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] kworker/-161     0d... 278818520us : activate_task: activate_task entered
[  280.918596] kworker/-161     0d... 278818520us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] kworker/-161     0d... 278818521us : check_preempt_curr: check_preempt_curr entered
[  280.918596] kworker/-161     0d... 278818522us : wake_up_process: wake_up_process entered
[  280.918596] kworker/-161     0d... 278818522us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-161     0d... 278818523us : wake_up_process: wake_up_process entered
[  280.918596] kworker/-161     0d... 278818523us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-161     0d... 278818524us : wake_up_process: wake_up_process entered
[  280.918596] kworker/-161     0d... 278818524us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-161     0d... 278818526us : wake_up_process: wake_up_process entered
[  280.918596] kworker/-161     0d... 278818526us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-177     0.... 278818628us : wake_up_q: wake_up_q entered
[  280.918596] kworker/-177     0d... 278818629us : wake_up_process: wake_up_process entered
[  280.918596] kworker/-177     0d... 278818629us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-177     0d... 278818630us : try_to_wake_up: ttwu_queue entered
[  280.918596] kworker/-177     0d... 278818630us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] kworker/-177     0d... 278818631us : activate_task: activate_task entered
[  280.918596] kworker/-177     0d... 278818632us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] kworker/-177     0d... 278818632us : check_preempt_curr: check_preempt_curr entered
[  280.918596] rcu_tort-131     2d.s. 278821050us : wake_up_process: wake_up_process entered
[  280.918596] rcu_tort-131     2d.s. 278821051us : try_to_wake_up: try_to_wake_up entered
[  280.918596] rcu_tort-131     2d.s. 278821052us : try_to_wake_up: ttwu_queue entered
[  280.918596] rcu_tort-131     2d.s. 278821052us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] rcu_tort-131     2d.s. 278821052us : activate_task: activate_task entered
[  280.918596] rcu_tort-131     2d.s. 278821053us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] rcu_tort-131     2d.s. 278821054us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-14      1dNs1 278821054us : scheduler_ipi: scheduler_ipi entered
[  280.918596] migratio-14      1dNH1 278821055us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] migratio-14      1dNH1 278821055us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596] migratio-14      1dNH1 278821056us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] migratio-14      1dNH1 278821056us : activate_task: activate_task entered
[  280.918596] migratio-14      1dNH1 278821058us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] migratio-14      1dNH1 278821058us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-14      1dNs1 278821070us : activate_task: activate_task entered
[  280.918596] migratio-14      1dNs1 278821070us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-14      1dNs1 278821071us : activate_task: activate_task entered
[  280.918596] migratio-14      1dNs1 278821071us : check_preempt_curr: check_preempt_curr entered
[  280.918596] migratio-14      1dN.1 278821073us : try_to_wake_up: try_to_wake_up entered
[  280.918596] migratio-14      1dN.1 278821074us : try_to_wake_up: ttwu_queue entered
[  280.918596] migratio-14      1dN.1 278821075us : try_to_wake_up: ttwu_queue_remote entered
[  280.918596] kworker/-178     0d... 278821153us : scheduler_ipi: scheduler_ipi entered
[  280.918596] kworker/-178     0d.h. 278821154us : sched_ttwu_pending: sched_ttwu_pending entered
[  280.918596] kworker/-178     0d.h. 278821154us : sched_ttwu_pending: sched_ttwu_pending non-NULL llist
[  280.918596] kworker/-178     0d.h. 278821155us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] kworker/-178     0d.h. 278821155us : activate_task: activate_task entered
[  280.918596] kworker/-178     0d.h. 278821157us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] kworker/-178     0d.h. 278821157us : check_preempt_curr: check_preempt_curr entered
[  280.918596] kworker/-178     0d... 278821174us : try_to_wake_up: try_to_wake_up entered
[  280.918596] kworker/-178     0d... 278821175us : try_to_wake_up: ttwu_queue entered
[  280.918596] kworker/-178     0d... 278821175us : ttwu_do_activate.isra.108: ttwu_do_activate entered
[  280.918596] kworker/-178     0d... 278821176us : activate_task: activate_task entered
[  280.918596] kworker/-178     0d... 278821176us : ttwu_do_wakeup.isra.107: ttwu_do_wakeup entered
[  280.918596] kworker/-178     0d... 278821177us : check_preempt_curr: check_preempt_curr entered

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ce00b442ced0..1a50ed258ef0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3569,6 +3569,7 @@ void __init rcu_init(void)
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
 	srcu_init();
+	tracing_off();
 }
 
 #include "tree_stall.h"
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0b22e55cebe8..6949ae27fae5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -479,6 +479,7 @@ void wake_up_q(struct wake_q_head *head)
 {
 	struct wake_q_node *node = head->first;
 
+	trace_printk("%s entered\n", __func__);
 	while (node != WAKE_Q_TAIL) {
 		struct task_struct *task;
 
@@ -509,6 +510,7 @@ void resched_curr(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	int cpu;
 
+	trace_printk("%s entered\n", __func__);
 	lockdep_assert_held(&rq->lock);
 
 	if (test_tsk_need_resched(curr))
@@ -1197,6 +1199,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	trace_printk("%s entered\n", __func__);
 	if (task_contributes_to_load(p))
 		rq->nr_uninterruptible--;
 
@@ -1298,6 +1301,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
 	const struct sched_class *class;
 
+	trace_printk("%s entered\n", __func__);
 	if (p->sched_class == rq->curr->sched_class) {
 		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
 	} else {
@@ -2097,6 +2101,7 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 			   struct rq_flags *rf)
 {
+	trace_printk("%s entered\n", __func__);
 	check_preempt_curr(rq, p, wake_flags);
 	p->state = TASK_RUNNING;
 	trace_sched_wakeup(p);
@@ -2132,6 +2137,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 {
 	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
 
+	trace_printk("%s entered\n", __func__);
 	lockdep_assert_held(&rq->lock);
 
 #ifdef CONFIG_SMP
@@ -2178,9 +2184,11 @@ void sched_ttwu_pending(void)
 	struct task_struct *p, *t;
 	struct rq_flags rf;
 
+	trace_printk("%s entered\n", __func__);
 	if (!llist)
 		return;
 
+	trace_printk("%s non-NULL llist\n", __func__);
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
@@ -2192,6 +2200,7 @@ void sched_ttwu_pending(void)
 
 void scheduler_ipi(void)
 {
+	trace_printk("%s entered\n", __func__);
 	/*
 	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
 	 * TIF_NEED_RESCHED remotely (for the first time) will also send
@@ -2232,6 +2241,7 @@ static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
+	trace_printk("%s entered\n", __func__);
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
@@ -2277,6 +2287,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	trace_printk("%s entered\n", __func__);
 #if defined(CONFIG_SMP)
 	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
@@ -2399,6 +2410,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	unsigned long flags;
 	int cpu, success = 0;
 
+	trace_printk("%s entered\n", __func__);
 	preempt_disable();
 	if (p == current) {
 		/*
@@ -2545,6 +2557,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 int wake_up_process(struct task_struct *p)
 {
+	trace_printk("%s entered\n", __func__);
 	return try_to_wake_up(p, TASK_NORMAL, 0);
 }
 EXPORT_SYMBOL(wake_up_process);
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 5c2b2f90fae1..d3441acabc80 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -80,6 +80,7 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	unsigned long flags;
 	bool enabled;
 
+	trace_printk("%s entered\n", __func__);
 	preempt_disable();
 	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
@@ -382,6 +383,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 	 * preempted by a stopper which might wait for other stoppers
 	 * to enter @fn which can lead to deadlock.
 	 */
+	trace_printk("%s entered\n", __func__);
 	preempt_disable();
 	stop_cpus_in_progress = true;
 	for_each_cpu(cpu, cpumask) {
@@ -402,11 +404,17 @@ static int __stop_cpus(const struct cpumask *cpumask,
 		       cpu_stop_fn_t fn, void *arg)
 {
 	struct cpu_stop_done done;
+	unsigned long j = jiffies;
 
+	tracing_on();
+	trace_printk("%s entered\n", __func__);
 	cpu_stop_init_done(&done, cpumask_weight(cpumask));
 	if (!queue_stop_cpus_work(cpumask, fn, arg, &done))
 		return -ENOENT;
 	wait_for_completion(&done.completion);
+	tracing_off();
+	if (time_after(jiffies, j + HZ * 20))
+		ftrace_dump(DUMP_ALL);
 	return done.ret;
 }
 
@@ -442,6 +450,7 @@ int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg)
 {
 	int ret;
 
+	trace_printk("%s entered\n", __func__);
 	/* static works are used, process one request at a time */
 	mutex_lock(&stop_cpus_mutex);
 	ret = __stop_cpus(cpumask, fn, arg);
@@ -599,6 +608,7 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data,
 		.active_cpus = cpus,
 	};
 
+	trace_printk("%s: entered\n", __func__);
 	lockdep_assert_cpus_held();
 
 	if (!stop_machine_initialized) {

