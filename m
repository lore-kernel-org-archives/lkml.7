Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E0C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0829A216B7
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfHEOzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:55:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbfHEOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:55:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75Eqj3R050951;
        Mon, 5 Aug 2019 10:54:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u6ne14fm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 10:54:49 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x75Es29c056802;
        Mon, 5 Aug 2019 10:54:49 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u6ne14fkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 10:54:49 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x75EsSgv007066;
        Mon, 5 Aug 2019 14:54:48 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2u51w6hfxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 14:54:48 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x75Esjgr41812444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Aug 2019 14:54:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D85F0B2064;
        Mon,  5 Aug 2019 14:54:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E52B2067;
        Mon,  5 Aug 2019 14:54:45 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  5 Aug 2019 14:54:45 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C9BEC16C4079; Mon,  5 Aug 2019 07:54:48 -0700 (PDT)
Date:   Mon, 5 Aug 2019 07:54:48 -0700
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
Message-ID: <20190805145448.GI28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-14-paulmck@linux.ibm.com>
 <20190804144317.GF2349@hirez.programming.kicks-ass.net>
 <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
 <20190805080531.GH2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805080531.GH2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:05:31AM +0200, Peter Zijlstra wrote:
> On Sun, Aug 04, 2019 at 11:41:59AM -0700, Paul E. McKenney wrote:
> > On Sun, Aug 04, 2019 at 04:48:35PM +0200, Peter Zijlstra wrote:
> > > On Sun, Aug 04, 2019 at 04:43:17PM +0200, Peter Zijlstra wrote:
> > > > On Fri, Aug 02, 2019 at 08:15:01AM -0700, Paul E. McKenney wrote:
> > > > > The multi_cpu_stop() function relies on the scheduler to gain control from
> > > > > whatever is running on the various online CPUs, including any nohz_full
> > > > > CPUs running long loops in kernel-mode code.  Lack of the scheduler-clock
> > > > > interrupt on such CPUs can delay multi_cpu_stop() for several minutes
> > > > > and can also result in RCU CPU stall warnings.  This commit therefore
> > > > > causes multi_cpu_stop() to enable the scheduler-clock interrupt on all
> > > > > online CPUs.
> > > > 
> > > > This sounds wrong; should we be fixing sched_can_stop_tick() instead to
> > > > return false when the stop task is runnable?
> > 
> > Agreed.  However, it is proving surprisingly hard to come up with a
> > code sequence that has the effect of rcu_nocb without nohz_full.
> > And rcu_nocb works just fine.  With nohz_full also in place, I am
> > decreasing the failure rate, but it still fails, perhaps a few times
> > per hour of TREE04 rcutorture on an eight-CPU system.  (My 12-CPU
> > system stubbornly refuses to fail.  Good thing I kept the eight-CPU
> > system around, I guess.)
> > 
> > When I arrive at some sequence of actions that actually work reliably,
> > then by all means let's put it somewhere in the NO_HZ_FULL machinery!
> 
> I'm confused; what are you arguing? The patch as proposed is just wrong,
> it needs to go.

Eventually, sure.  But one dragon at a time.  Right now that dragon is
"what is required to get multi_cpu_stop() to work in a timely fashioon".
The "where does that code really go" dragon comes later.

> > > And even without that; I don't understand how we're not instantly
> > > preempted the moment we enqueue the stop task.
> > 
> > There is no preemption because CONFIG_PREEMPT=n for the scenarios still
> 
> That doesn't make sense; even with CONFIG_PREEMPT=n we set
> TIF_NEED_RESCHED. We'll just not react to it as promptly (only explicit
> rescheduling points and return to userspace). Enabling the tick will not
> make any difference what so ever.
> 
> Tick based preemption will not 'fix' the lack of wakeup preemption. If
> the stop task wakeup didn't set TIF_NEED_RESCHED, the OTHER/CFS tick
> will not either.

Seems logical except for the fact that multi_cpu_stop() really is taking
in excess of five minutes on a regular basis.

> > having trouble.  Yes, there are cond_resched() calls, but they don't do
> > anything unless the appropriate flags are set, which won't always happen
> > without the tick, apparently.  Or without -something- that isn't always
> > happening as it should.
> 
> Right; so clearly we're not understanding what's happening. That seems
> like a requirement for actually doing a patch.

Almost but not quite.  It is a requirement for a patch *that* *is*
*supposed* *to* *be* *a* *fix*.  If you are trying to prohibit me from
writing experimental patches, please feel free to take a long walk on
a short pier.

Understood???

> > > Any enqueue, should go through check_preempt_curr() which will be an
> > > instant resched_curr() when we just woke the stop class.
> > 
> > I did try hitting all of the CPUs with resched_cpu().  Ten times on each
> > CPU with a ten-jiffy wait between each.  This might have decreased the
> > probability of excessively long CPU-stopper waits by a factor of two or
> > three, but it did not eliminate the excessively long waits.
> > 
> > What else should I try?
> > 
> > For example, are there any diagnostics I could collect, say from within
> > the CPU stopper when things are taking too long?  I see CPU-stopper
> > delays in excess of five -minutes-, so this is anything but subtle.
> 
> Catch the whole thing in a function trace?
> 
> The chain that should instantly set TIF_NEED_RESCHED:
> 
>   stop_machine()
>     stop_machine_cpuslocked()
>       stop_cpus()
>         __stop_cpus()
>           queue_stop_cpus_work()
>             cpu_stop_queue_work()
> 	      wake_up_q()
> 	        wake_up_process()
> 
> 
>   wake_up_process()
>     try_to_wake_up()
>       ttwu_queue()
>         ttwu_queue_remote()
> 	  <- scheduler_ipi()
> 	    sched_ttwu_pending()
> 	      ttwu_do_activate()
> 
>         ttwu_do_activate()
> 	  activate_task()
> 	  ttwu_do_wakeup()
> 	    check_preempt_curr()
> 	      resched_curr()
> 
> You could frob some tracing into __stop_cpus(), before
> wait_for_completion(), at that point all the CPUs in @cpumask should
> either be running the stop task or have TIF_NEED_RESCHED set.

Thank you, this should be quite helpful.

							Thanx, Paul
