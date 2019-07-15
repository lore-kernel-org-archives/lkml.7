Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA4C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259662086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfGOUJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:09:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729793AbfGOUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:09:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FK7nOw017252;
        Mon, 15 Jul 2019 16:09:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2trw8kg5n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jul 2019 16:09:03 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6FK93io021161;
        Mon, 15 Jul 2019 16:09:03 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2trw8kg5mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jul 2019 16:09:03 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6FK56fD017550;
        Mon, 15 Jul 2019 20:09:02 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 2tq6x5ssvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jul 2019 20:09:02 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FK91Zb51314950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 20:09:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B69D0B2065;
        Mon, 15 Jul 2019 20:09:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 767E8B2064;
        Mon, 15 Jul 2019 20:09:01 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.187.221])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jul 2019 20:09:01 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2796216C8F40; Mon, 15 Jul 2019 13:09:01 -0700 (PDT)
Date:   Mon, 15 Jul 2019 13:09:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190715200901.GW26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
 <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com>
 <CANrsvRNK=+SKHJNLmwNjp2tnjacJpqwFVQH9aRCj2E1L10GHDQ@mail.gmail.com>
 <20190714135610.GJ26519@linux.ibm.com>
 <20190715173924.GA2494@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715173924.GA2494@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 01:39:24PM -0400, Joel Fernandes wrote:
> On Sun, Jul 14, 2019 at 06:56:10AM -0700, Paul E. McKenney wrote:
> [snip]
> > > > > > > > > >
> > > > > > > > > >       commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > > > > > > > > >       rcu: Remove debugfs tracing
> > > > > > > > > >
> > > > > > > > > > removed all debugfs tracing, gp_max also included.
> > > > > > > > > >
> > > > > > > > > > And you sounds great. And even looks not that hard to add it like,
> > > > > > > > > >
> > > > > > > > > > :)
> > > > > > > > > >
> > > > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > > > index ad9dc86..86095ff 100644
> > > > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > > > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> > > > > > > > > >       raw_spin_lock_irq_rcu_node(rnp);
> > > > > > > > > >       rcu_state.gp_end = jiffies;
> > > > > > > > > >       gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > > > > > > > > > -     if (gp_duration > rcu_state.gp_max)
> > > > > > > > > > +     if (gp_duration > rcu_state.gp_max) {
> > > > > > > > > >               rcu_state.gp_max = gp_duration;
> > > > > > > > > > +             trace_rcu_grace_period(something something);
> > > > > > > > > > +     }
> > > > > > > > >
> > > > > > > > > Yes, that makes sense. But I think it is much better off as a readable value
> > > > > > > > > from a virtual fs. The drawback of tracing for this sort of thing are:
> > > > > > > > >  - Tracing will only catch it if tracing is on
> > > > > > > > >  - Tracing data can be lost if too many events, then no one has a clue what
> > > > > > > > >    the max gp time is.
> > > > > > > > >  - The data is already available in rcu_state::gp_max so copying it into the
> > > > > > > > >    trace buffer seems a bit pointless IMHO
> > > > > > > > >  - It is a lot easier on ones eyes to process a single counter than process
> > > > > > > > >    heaps of traces.
> > > > > > > > >
> > > > > > > > > I think a minimal set of RCU counters exposed to /proc or /sys should not
> > > > > > > > > hurt and could do more good than not. The scheduler already does this for
> > > > > > > > > scheduler statistics. I have seen Peter complain a lot about new tracepoints
> > > > > > > > > but not much (or never) about new statistics.
> > > > > > > > >
> > > > > > > > > Tracing has its strengths but may not apply well here IMO. I think a counter
> > > > > > > > > like this could be useful for tuning of things like the jiffies_*_sched_qs,
> > > > > > > > > the stall timeouts and also any other RCU knobs. What do you think?
> > > > > > > >
> > > > > > > > I prefer proc/sys knob for it to tracepoint. Why I've considered it is just it
> > > > > > > > looks like undoing what Paul did at ae91aa0ad.
> > > > > > > >
> > > > > > > > I think you're rational enough. I just wondered how Paul think of it.
> > > > > > >
> > > > > > > I believe at least initially, a set of statistics can be made
> > > > > > > available only when rcutorture or rcuperf module is loaded. That way
> > > > > > > they are purely only for debugging and nothing needs to be exposed to
> > > > > > > normal kernels distributed thus reducing testability concerns.
> > > > > > >
> > > > > > > rcu_state::gp_max would be trivial to expose through this, but for
> > > > > > > other statistics that are more complicated - perhaps
> > > > > > > tracepoint_probe_register can be used to add hooks on to the
> > > > > > > tracepoints and generate statistics from them. Again the registration
> > > > > > > of the probe and the probe handler itself would all be in
> > > > > > > rcutorture/rcuperf test code and not a part of the kernel proper.
> > > > > > > Thoughts?
> > > > > >
> > > > > > It still feels like you guys are hyperfocusing on this one particular
> > > > > > knob.  I instead need you to look at the interrelating knobs as a group.
> > > > >
> > > > > Thanks for the hints, we'll do that.
> > > > >
> > > > > > On the debugging side, suppose someone gives you an RCU bug report.
> > > > > > What information will you need?  How can you best get that information
> > > > > > without excessive numbers of over-and-back interactions with the guy
> > > > > > reporting the bug?  As part of this last question, what information is
> > > > > > normally supplied with the bug?  Alternatively, what information are
> > > > > > bug reporters normally expected to provide when asked?
> > > > >
> > > > > I suppose I could dig out some of our Android bug reports of the past where
> > > > > there were RCU issues but if there's any fires you are currently fighting do
> > > > > send it our way as debugging homework ;-)
> > > >
> > > > Evading the questions, are we?
> 
> Sorry if I sounded like evading, I was just saying that it would be nice to
> work on some specific issue or bug report and then figure out what is needed
> from there, instead of trying to predict what data is useful. Of course, I
> think predicting and dumping data is also useful, but I was just wondering if
> you had some specific issue in mind that we could work off of (you did
> mention the CPU stopper below so thank you!)

No worries, and fair enough!

> > > > OK, I can be flexible.  Suppose that you were getting RCU CPU stall
> > > > warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
> > > > Of course, this really means that some other CPU/task is holding up
> > > > multi_cpu_stop() without also blocking the current grace period.
> > > >
> > > > What is the best way to work out what is really holding things up?
> > > 
> > > Either the stopper preempted another being in a critical section and
> > > has something wrong itself in case of PREEMPT or mechanisms for
> > > urgent control doesn't work correctly.
> > > 
> > > I don't know what exactly you intended but I would check things like
> > > (1) irq disable / eqs / tick / scheduler events and (2) whether special
> > > handling for each level of qs urgency has started correctly. For that
> > > purpose all the history of those events would be more useful.
> 
> Agreed, these are all good.

Just to reiterate -- it would be good if multi_cpu_stop() could
automatically dump out useful information when it has been delayed too
long, where "too long" is probably a bit shorter than the RCU CPU stall
warning timeout.  Useful information would include the stack of the task
impeding multi_cpu_stop().

> > > And with thinking it more, we could come up with a good way to
> > > make use of those data to identify what the problem is. Do I catch
> > > the point correctly? If so, me and Joel can start to work on it.
> > > Otherwise, please correct me.
> > 
> > I believe you are on the right track.  In short, it would be great if
> > the kernel would automatically dump out the needed information when
> > cpu_stopper gets stalled, sort of like RCU does (much of the time,
> > anyway) in its CPU stall warnings.  Given a patch that did this, I would
> > be quite happy to help advocate for it!
> 
> In case you have a LKML link to a thread or bug report to this specific
> cpu_stopper issue, please do pass it along.

I hope to have an rcutorture-based repeat-by in a few days, give or take.
(Famous last words!)

> Happy to work on this with Byungchul, thanks,

Thank you both!

							Thanx, Paul
