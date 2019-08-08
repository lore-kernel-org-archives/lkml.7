Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC4C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3171217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403849AbfHHSJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:09:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727096AbfHHSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:09:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78I7JqT107920;
        Thu, 8 Aug 2019 14:09:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8rep0u4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 14:09:18 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x78I7xED109690;
        Thu, 8 Aug 2019 14:09:17 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u8rep0u46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 14:09:17 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x78I5qZ1030151;
        Thu, 8 Aug 2019 18:09:16 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2u51w78sa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 18:09:16 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x78I9F2938011232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 18:09:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE217B206A;
        Thu,  8 Aug 2019 18:09:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90155B2066;
        Thu,  8 Aug 2019 18:09:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Aug 2019 18:09:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C150716C5DA7; Thu,  8 Aug 2019 11:09:16 -0700 (PDT)
Date:   Thu, 8 Aug 2019 11:09:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <byungchul.park@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rao Shoaib <rao.shoaib@oracle.com>, kernel-team@android.com,
        kernel-team <kernel-team@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190808180916.GP28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <CANrsvRPU_u6oKpjZ1368Evto+1hGboNYeOuMdbdzaOfXhSO=5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrsvRPU_u6oKpjZ1368Evto+1hGboNYeOuMdbdzaOfXhSO=5g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:23:17PM +0900, Byungchul Park wrote:
> On Thu, Aug 8, 2019 at 9:56 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Aug 08, 2019 at 06:52:32PM +0900, Byungchul Park wrote:
> > > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > > > [ . . . ]
> > > > > > > +     for (; head; head = next) {
> > > > > > > +             next = head->next;
> > > > > > > +             head->next = NULL;
> > > > > > > +             __call_rcu(head, head->func, -1, 1);
> > > > > >
> > > > > > We need at least a cond_resched() here.  200,000 times through this loop
> > > > > > in a PREEMPT=n kernel might not always be pretty.  Except that this is
> > > > > > invoked directly from kfree_rcu() which might be invoked with interrupts
> > > > > > disabled, which precludes calls to cond_resched().  So the realtime guys
> > > > > > are not going to be at all happy with this loop.
> > > > >
> > > > > Ok, will add this here.
> > > > >
> > > > > > And this loop could be avoided entirely by having a third rcu_head list
> > > > > > in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
> > > > > > KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
> > > > > > should be OK, or at least more OK than queuing 200,000 callbacks with
> > > > > > interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
> > > > > > pointers can be used to reduce the probability of oversized batches.)
> > > > > > This would also mean that the equality comparisons with KFREE_MAX_BATCH
> > > > > > need to become greater-or-equal comparisons or some such.
> > > > >
> > > > > Yes, certainly we can do these kinds of improvements after this patch, and
> > > > > then add more tests to validate the improvements.
> > > >
> > > > Out of pity for people bisecting, we need this fixed up front.
> > > >
> > > > My suggestion is to just allow ->head to grow until ->head_free becomes
> > > > available.  That way you are looping with interrupts and preemption
> > > > enabled in workqueue context, which is much less damaging than doing so
> > > > with interrupts disabled, and possibly even from hard-irq context.
> > >
> > > Agree.
> > >
> > > Or after introducing another limit like KFREE_MAX_BATCH_FORCE(>=
> > > KFREE_MAX_BATCH):
> > >
> > > 1. Try to drain it on hitting KFREE_MAX_BATCH as it does.
> > >
> > >    On success: Same as now.
> > >    On fail: let ->head grow and drain if possible, until reaching to
> > >             KFREE_MAX_BATCH_FORCE.
> 
> I should've explain this in more detail. This actually mean:
> 
> On fail: Let ->head grow and queue rcu_work when ->head_free == NULL,
>          until reaching to _FORCE.
> 
> > > 3. On hitting KFREE_MAX_BATCH_FORCE, give up batching but handle one by
> > >    one from now on to prevent too many pending requests from being
> > >    queued for batching work.
> 
> This mean:
> 
> 3. On hitting KFREE_MAX_BATCH_FORCE, give up batching requests to be added
>    from now on but instead handle one by one to prevent too many
> pending requests
>    from being queued. Of course, the requests already having been
> queued in ->head
>    so far should be handled by rcu_work when it's possible which can
> be checked by
>    the monitor or kfree_rcu() inside every call.

But does this really help?  After all, the reason we have piled up a
large number of additional callbacks is likely because the grace period
is taking a long time, or because a huge number of callbacks has been
queued up.  Sure, these callbacks might get a head start on the following
grace period, but at the expense of still retaining the kfree_rcu()
special cases in rcu_do_batch().

Another potential issue is interaction with rcu_barrier().  Currently,
rcu_barrier() waits for memory passed to prior kfree_rcu() calls to be
freed.  This is useful to allow a large amount of memory be be completely
freed before allocating large amounts more memory.  With the earlier
version of the patch, an rcu_barrier() followed by a flush_workqueue().
But #3 above would reorder the objects so that this approach might not
wait for everything.

We should therefore just let the second list grow.  If experience shows
a need for callbacks to be sent up more quickly, it should be possible
to provide an additional list, so that two lists on a given CPU can both
be waiting for a grace period at the same time.

> > I also agree. But this _FORCE thing will still not solve the issue Paul is
> > raising which is doing this loop possibly in irq disabled / hardirq context.
> 
> I added more explanation above. What I suggested is a way to avoid not
> only heavy
> work within the irq-disabled region of a single kfree_rcu() but also
> too many requests
> to be queued into ->head.

But let's start simple, please!

> > We can't even cond_resched() here. In fact since _FORCE is larger, it will be
> > even worse. Consider a real-time system with a lot of memory, in this case
> > letting ->head grow large is Ok, but looping for long time in IRQ disabled
> > would not be Ok.
> 
> Please check the explanation above.
> 
> > But I could make it something like:
> > 1. Letting ->head grow if ->head_free busy
> > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> 
> This is exactly what Paul said. The problem with this is ->head can grow too
> much. That's why I suggested the above one.

It can grow quite large, but how do you know that limiting its size will
really help?  Sure, you have limited the size, but does that really do
anything for the larger problem of extreme kfree_rcu() rates on the one
hand and a desire for more efficient handling of kfree_rcu() on the other?

							Thanx, Paul

> > This would even improve performance, but will still risk going out of memory.
> >
> > Thoughts?
> >
> > thanks,
> >
> >  - Joel
> >
> > >
> > > This way, we can avoid both:
> > >
> > > 1. too many requests being queued and
> > > 2. __call_rcu() bunch of requests within a single kfree_rcu().
> > >
> > > Thanks,
> > > Byungchul
> > >
> > > >
> > > > But please feel free to come up with a better solution!
> > > >
> > > > [ . . . ]
> 
> 
> 
> -- 
> Thanks,
> Byungchul
> 
