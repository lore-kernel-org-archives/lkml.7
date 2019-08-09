Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD69C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A34214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407441AbfHIQwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:52:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfHIQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:52:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79Glbk5010243;
        Fri, 9 Aug 2019 12:51:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u9c4x9bfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 12:51:21 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x79GmKHt013029;
        Fri, 9 Aug 2019 12:51:20 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u9c4x9bf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 12:51:20 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x79GnX88016163;
        Fri, 9 Aug 2019 16:51:19 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2u51w7fdv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 16:51:19 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x79GpIUv52232612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Aug 2019 16:51:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC20EB2064;
        Fri,  9 Aug 2019 16:51:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85255B205F;
        Fri,  9 Aug 2019 16:51:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  9 Aug 2019 16:51:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2AEAD16C35AF; Fri,  9 Aug 2019 09:51:20 -0700 (PDT)
Date:   Fri, 9 Aug 2019 09:51:20 -0700
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
Message-ID: <20190809165120.GA5668@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190804144835.GB2386@hirez.programming.kicks-ass.net>
 <20190804184159.GC28441@linux.ibm.com>
 <20190805080531.GH2349@hirez.programming.kicks-ass.net>
 <20190805145448.GI28441@linux.ibm.com>
 <20190805155024.GK2332@hirez.programming.kicks-ass.net>
 <20190805174800.GK28441@linux.ibm.com>
 <20190806180824.GA28448@linux.ibm.com>
 <20190807214131.GA15124@linux.ibm.com>
 <20190808203541.GA8160@linux.ibm.com>
 <20190808213012.GA28773@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808213012.GA28773@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:30:12PM -0700, Paul E. McKenney wrote:
> On Thu, Aug 08, 2019 at 01:35:41PM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 07, 2019 at 02:41:31PM -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 06, 2019 at 11:08:24AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Aug 05, 2019 at 10:48:00AM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Aug 05, 2019 at 05:50:24PM +0200, Peter Zijlstra wrote:
> > > > > > On Mon, Aug 05, 2019 at 07:54:48AM -0700, Paul E. McKenney wrote:
> > > > > > 
> > > > > > > > Right; so clearly we're not understanding what's happening. That seems
> > > > > > > > like a requirement for actually doing a patch.
> > > > > > > 
> > > > > > > Almost but not quite.  It is a requirement for a patch *that* *is*
> > > > > > > *supposed* *to* *be* *a* *fix*.  If you are trying to prohibit me from
> > > > > > > writing experimental patches, please feel free to take a long walk on
> > > > > > > a short pier.
> > > > > > > 
> > > > > > > Understood???
> > > > > > 
> > > > > > Ah, my bad, I thought you were actually proposing this as an actual
> > > > > > patch. I now see that is my bad, I'd overlooked the RFC part.
> > > > > 
> > > > > No problem!
> > > > > 
> > > > > And of course adding tracing decreases the frequency and duration of
> > > > > the multi_cpu_stop().  Re-running with shorter-duration triggering.  ;-)
> > > > 
> > > > And I did eventually get a good trace.  If I am interpreting this trace
> > > > correctly, the torture_-135 task didn't get around to attempting to wake
> > > > up all of the CPUs.  I will try again, but this time with the sched_switch
> > > > trace event enabled.
> > > > 
> > > > As a side note, enabling ftrace from the command line seems to interact
> > > > badly with turning tracing off and on in the kernel, so I eventually
> > > > resorted to trace_printk() in the functions of interest.  The trace
> > > > output is below, followed by the current diagnostic patch.  Please note
> > > > that I am -not- using the desperation hammer-the-scheduler patches.
> > > > 
> > > > More as I learn more!
> > > 
> > > And of course I forgot to dump out the online CPUs, so I really had no
> > > idea whether or not all the CPUs were accounted for.  I added tracing
> > > to dump out the online CPUs at the beginning of __stop_cpus() and then
> > > reworked it a few times to get the problem to happen in reasonable time.
> > > Please see below for the resulting annotated trace.
> > > 
> > > I was primed to expect a lost IPI, perhaps due to yet another qemu bug,
> > > but all the migration threads are running within about 2 milliseconds.
> > > It is then almost two minutes(!) until the next trace message.
> > > 
> > > Looks like time to (very carefully!) instrument multi_cpu_stop().
> > > 
> > > Of course, if you have any ideas, please do not keep them a secret!
> > 
> > Functionally, multi_cpu_stop() is working fine, according to the trace
> > below (search for a line beginning with TAB).  But somehow CPU 2 took
> > almost three -minutes- to do one iteration of the loop.  The prime suspect
> > in that loop is cpu_relax() due to the hypervisor having an opportunity
> > to do something at that point.  The commentary below (again, search for
> > a line beginning with TAB) gives my analysis.
> > 
> > Of course, if I am correct, it should be possible to catch cpu_relax()
> > in the act.  That is the next step, give or take the Heisenbuggy nature
> > of this beast.
> > 
> > Another thing for me to try is to run longer with !NO_HZ_FULL, just in
> > case the earlier runs just got lucky.
> > 
> > Thoughts?
> 
> And it really can happen:
> 
> [ 1881.467922] migratio-33      4...1 1879530317us : stop_machine_yield: cpu_relax() took 756140 ms
> 
> The previous timestamp was 1123391100us, so the cpu_relax() is almost
> exactly the full delay.
> 
> But another instance stalled for many minutes without a ten-second
> cpu_relax().  So it is not just cpu_relax() causing trouble.  I could
> rationalize that vCPU preemption being at fault...
> 
> And my diagnostic patch is below, just in case I am doing something
> stupid with that.

I did a 12-hour run with the same configuration except for leaving out the
"nohz_full=1-7" kernel parameter without problems (aside from the RCU CPU
stall warnings due to the ftrace_dump() at the end of the run -- isn't
there some way to clear the ftrace buffer without actually printing it?).

My next step is to do an over-the-weekend run with the same configuration,
then a similar run with more recent kernel and qemu but with the
"nohz_full=1-7".  If both of those pass, I will consider this to be a
KVM/qemu bug that has since been fixed.

							Thanx, Paul
