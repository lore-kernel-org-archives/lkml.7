Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63289C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 17:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8A920848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 17:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfGMRls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 13:41:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727818AbfGMRls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 13:41:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6DHaqTc144642;
        Sat, 13 Jul 2019 13:41:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tqbu3ufye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 13:41:13 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6DHarsf144705;
        Sat, 13 Jul 2019 13:41:13 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tqbu3ufy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 13:41:13 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6DHe6TA021310;
        Sat, 13 Jul 2019 17:41:12 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2tq6x6krdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jul 2019 17:41:12 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6DHfBbV47907122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 17:41:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82188B2064;
        Sat, 13 Jul 2019 17:41:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B20EB205F;
        Sat, 13 Jul 2019 17:41:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.158.189])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 13 Jul 2019 17:41:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 16D0F16C196D; Sat, 13 Jul 2019 10:41:11 -0700 (PDT)
Date:   Sat, 13 Jul 2019 10:41:11 -0700
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
Message-ID: <20190713174111.GG26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
 <20190713151330.GE26519@linux.ibm.com>
 <20190713154257.GE133650@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713154257.GE133650@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907130215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 11:42:57AM -0400, Joel Fernandes wrote:
> On Sat, Jul 13, 2019 at 08:13:30AM -0700, Paul E. McKenney wrote:
> > On Sat, Jul 13, 2019 at 10:20:02AM -0400, Joel Fernandes wrote:
> > > On Sat, Jul 13, 2019 at 4:47 AM Byungchul Park
> > > <max.byungchul.park@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 12, 2019 at 9:51 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> > > > > > On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > > > > > > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > > > > > > period ever is recorded in rcu_state.gp_max. However it is not read from
> > > > > > > anywhere.
> > > > > > >
> > > > > > > Any idea why it was added but not used?
> > > > > > >
> > > > > > > I am interested in dumping this value just for fun, and seeing what I get.
> > > > > > >
> > > > > > > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > > > > > > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > > > > > > look like.
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > >       commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > > > > >       rcu: Remove debugfs tracing
> > > > > >
> > > > > > removed all debugfs tracing, gp_max also included.
> > > > > >
> > > > > > And you sounds great. And even looks not that hard to add it like,
> > > > > >
> > > > > > :)
> > > > > >
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index ad9dc86..86095ff 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> > > > > >       raw_spin_lock_irq_rcu_node(rnp);
> > > > > >       rcu_state.gp_end = jiffies;
> > > > > >       gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > > > > > -     if (gp_duration > rcu_state.gp_max)
> > > > > > +     if (gp_duration > rcu_state.gp_max) {
> > > > > >               rcu_state.gp_max = gp_duration;
> > > > > > +             trace_rcu_grace_period(something something);
> > > > > > +     }
> > > > >
> > > > > Yes, that makes sense. But I think it is much better off as a readable value
> > > > > from a virtual fs. The drawback of tracing for this sort of thing are:
> > > > >  - Tracing will only catch it if tracing is on
> > > > >  - Tracing data can be lost if too many events, then no one has a clue what
> > > > >    the max gp time is.
> > > > >  - The data is already available in rcu_state::gp_max so copying it into the
> > > > >    trace buffer seems a bit pointless IMHO
> > > > >  - It is a lot easier on ones eyes to process a single counter than process
> > > > >    heaps of traces.
> > > > >
> > > > > I think a minimal set of RCU counters exposed to /proc or /sys should not
> > > > > hurt and could do more good than not. The scheduler already does this for
> > > > > scheduler statistics. I have seen Peter complain a lot about new tracepoints
> > > > > but not much (or never) about new statistics.
> > > > >
> > > > > Tracing has its strengths but may not apply well here IMO. I think a counter
> > > > > like this could be useful for tuning of things like the jiffies_*_sched_qs,
> > > > > the stall timeouts and also any other RCU knobs. What do you think?
> > > >
> > > > I prefer proc/sys knob for it to tracepoint. Why I've considered it is just it
> > > > looks like undoing what Paul did at ae91aa0ad.
> > > >
> > > > I think you're rational enough. I just wondered how Paul think of it.
> > > 
> > > I believe at least initially, a set of statistics can be made
> > > available only when rcutorture or rcuperf module is loaded. That way
> > > they are purely only for debugging and nothing needs to be exposed to
> > > normal kernels distributed thus reducing testability concerns.
> > > 
> > > rcu_state::gp_max would be trivial to expose through this, but for
> > > other statistics that are more complicated - perhaps
> > > tracepoint_probe_register can be used to add hooks on to the
> > > tracepoints and generate statistics from them. Again the registration
> > > of the probe and the probe handler itself would all be in
> > > rcutorture/rcuperf test code and not a part of the kernel proper.
> > > Thoughts?
> > 
> > It still feels like you guys are hyperfocusing on this one particular
> > knob.  I instead need you to look at the interrelating knobs as a group.
> 
> Thanks for the hints, we'll do that.
> 
> > On the debugging side, suppose someone gives you an RCU bug report.
> > What information will you need?  How can you best get that information
> > without excessive numbers of over-and-back interactions with the guy
> > reporting the bug?  As part of this last question, what information is
> > normally supplied with the bug?  Alternatively, what information are
> > bug reporters normally expected to provide when asked?
> 
> I suppose I could dig out some of our Android bug reports of the past where
> there were RCU issues but if there's any fires you are currently fighting do
> send it our way as debugging homework ;-)

Evading the questions, are we?

OK, I can be flexible.  Suppose that you were getting RCU CPU stall
warnings featuring multi_cpu_stop() called from cpu_stopper_thread().
Of course, this really means that some other CPU/task is holding up
multi_cpu_stop() without also blocking the current grace period.

What is the best way to work out what is really holding things up?

							Thanx, Paul
