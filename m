Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1157DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D392166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407508AbfHISkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:40:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbfHISkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:40:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79IR33c140935;
        Fri, 9 Aug 2019 14:39:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u9c4xd7h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 14:39:58 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x79ITB5W146749;
        Fri, 9 Aug 2019 14:39:58 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u9c4xd7gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 14:39:58 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x79IQ7xP012651;
        Fri, 9 Aug 2019 18:39:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 2u51w6e1am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 18:39:56 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x79Idutr42074496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Aug 2019 18:39:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59E46B2067;
        Fri,  9 Aug 2019 18:39:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AD96B2064;
        Fri,  9 Aug 2019 18:39:56 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  9 Aug 2019 18:39:56 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E665216C9A5F; Fri,  9 Aug 2019 11:39:57 -0700 (PDT)
Date:   Fri, 9 Aug 2019 11:39:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190809183957.GH28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190805080531.GH2349@hirez.programming.kicks-ass.net>
 <20190805145448.GI28441@linux.ibm.com>
 <20190805155024.GK2332@hirez.programming.kicks-ass.net>
 <20190805174800.GK28441@linux.ibm.com>
 <20190806180824.GA28448@linux.ibm.com>
 <20190807214131.GA15124@linux.ibm.com>
 <20190808203541.GA8160@linux.ibm.com>
 <20190808213012.GA28773@linux.ibm.com>
 <20190809165120.GA5668@linux.ibm.com>
 <20190809180721.GA255533@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809180721.GA255533@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 02:07:21PM -0400, Joel Fernandes wrote:
> On Fri, Aug 09, 2019 at 09:51:20AM -0700, Paul E. McKenney wrote:
> > > > > And of course I forgot to dump out the online CPUs, so I really had no
> > > > > idea whether or not all the CPUs were accounted for.  I added tracing
> > > > > to dump out the online CPUs at the beginning of __stop_cpus() and then
> > > > > reworked it a few times to get the problem to happen in reasonable time.
> > > > > Please see below for the resulting annotated trace.
> > > > > 
> > > > > I was primed to expect a lost IPI, perhaps due to yet another qemu bug,
> > > > > but all the migration threads are running within about 2 milliseconds.
> > > > > It is then almost two minutes(!) until the next trace message.
> > > > > 
> > > > > Looks like time to (very carefully!) instrument multi_cpu_stop().
> > > > > 
> > > > > Of course, if you have any ideas, please do not keep them a secret!
> > > > 
> > > > Functionally, multi_cpu_stop() is working fine, according to the trace
> > > > below (search for a line beginning with TAB).  But somehow CPU 2 took
> > > > almost three -minutes- to do one iteration of the loop.  The prime suspect
> > > > in that loop is cpu_relax() due to the hypervisor having an opportunity
> > > > to do something at that point.  The commentary below (again, search for
> > > > a line beginning with TAB) gives my analysis.
> > > > 
> > > > Of course, if I am correct, it should be possible to catch cpu_relax()
> > > > in the act.  That is the next step, give or take the Heisenbuggy nature
> > > > of this beast.
> > > > 
> > > > Another thing for me to try is to run longer with !NO_HZ_FULL, just in
> > > > case the earlier runs just got lucky.
> > > > 
> > > > Thoughts?
> > > 
> > > And it really can happen:
> > > 
> > > [ 1881.467922] migratio-33      4...1 1879530317us : stop_machine_yield: cpu_relax() took 756140 ms
> > > 
> > > The previous timestamp was 1123391100us, so the cpu_relax() is almost
> > > exactly the full delay.
> > > 
> > > But another instance stalled for many minutes without a ten-second
> > > cpu_relax().  So it is not just cpu_relax() causing trouble.  I could
> > > rationalize that vCPU preemption being at fault...
> > > 
> > > And my diagnostic patch is below, just in case I am doing something
> > > stupid with that.
> > 
> > I did a 12-hour run with the same configuration except for leaving out the
> > "nohz_full=1-7" kernel parameter without problems (aside from the RCU CPU
> > stall warnings due to the ftrace_dump() at the end of the run -- isn't
> > there some way to clear the ftrace buffer without actually printing it?).
> 
> I think if tracing_reset_all_online_cpus() is exposed, then calling that with
> the appropriate locks held can reset the ftrace ring buffer and clear the
> trace. Steve, is there a better way?

On the off-chance that it helps, here is my use case:

o	I have a race condition that becomes extremely unlikely if
	I leave tracing enabled at all times.

o	I therefore enable tracing at the beginning of a CPU-hotplug
	removal.

o	At the end of that CPU-hotplug removal, I disable tracing.

o	I can test whether the problem occurred without affecting its
	probability.  If it occurred, I want to dump only that portion
	of the trace buffer since enabling it above.  If the problem
	did not occur, I want to flush (not dump) the trace buffer.

o	I cannot reasonably just make the trace buffer small because
	the number of events in a given occurrence of the problem
	can vary widely.

							Thanx, Paul
