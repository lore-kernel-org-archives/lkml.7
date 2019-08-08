Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEE621479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfHHJyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:54:01 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:35911 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730777AbfHHJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:54:01 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 8 Aug 2019 18:53:58 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 8 Aug 2019 18:53:58 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 8 Aug 2019 18:52:32 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190808095232.GA30401@X58A-UD3R>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807175215.GE28441@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 07, 2019 at 05:45:04AM -0400, Joel Fernandes wrote:
> > On Tue, Aug 06, 2019 at 04:56:31PM -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> 
> [ . . . ]
> 
> > > > +	for (; head; head = next) {
> > > > +		next = head->next;
> > > > +		head->next = NULL;
> > > > +		__call_rcu(head, head->func, -1, 1);
> > > 
> > > We need at least a cond_resched() here.  200,000 times through this loop
> > > in a PREEMPT=n kernel might not always be pretty.  Except that this is
> > > invoked directly from kfree_rcu() which might be invoked with interrupts
> > > disabled, which precludes calls to cond_resched().  So the realtime guys
> > > are not going to be at all happy with this loop.
> > 
> > Ok, will add this here.
> > 
> > > And this loop could be avoided entirely by having a third rcu_head list
> > > in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
> > > KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
> > > should be OK, or at least more OK than queuing 200,000 callbacks with
> > > interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
> > > pointers can be used to reduce the probability of oversized batches.)
> > > This would also mean that the equality comparisons with KFREE_MAX_BATCH
> > > need to become greater-or-equal comparisons or some such.
> > 
> > Yes, certainly we can do these kinds of improvements after this patch, and
> > then add more tests to validate the improvements.
> 
> Out of pity for people bisecting, we need this fixed up front.
> 
> My suggestion is to just allow ->head to grow until ->head_free becomes
> available.  That way you are looping with interrupts and preemption
> enabled in workqueue context, which is much less damaging than doing so
> with interrupts disabled, and possibly even from hard-irq context.

Agree.

Or after introducing another limit like KFREE_MAX_BATCH_FORCE(>=
KFREE_MAX_BATCH):

1. Try to drain it on hitting KFREE_MAX_BATCH as it does.

   On success: Same as now.
   On fail: let ->head grow and drain if possible, until reaching to
            KFREE_MAX_BATCH_FORCE.

3. On hitting KFREE_MAX_BATCH_FORCE, give up batching but handle one by
   one from now on to prevent too many pending requests from being
   queued for batching work.

This way, we can avoid both:

1. too many requests being queued and
2. __call_rcu() bunch of requests within a single kfree_rcu().

Thanks,
Byungchul

> 
> But please feel free to come up with a better solution!
> 
> [ . . . ]
> 
> > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > >  {
> > > >  	int cpu;
> > > >  
> > > > +	kfree_rcu_batch_init();
> > > 
> > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > like it should work, but have you tested it?
> > > 
> > > >  	rcu_early_boot_tests();
> > > 
> > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > call to kfree_rcu_batch_init() here.
> > 
> > I have not tried to do the kfree_rcu() this early. I will try it out.
> 
> Yeah, well, call_rcu() this early came as a surprise to me back in the
> day, so...  ;-)
> 
> 							Thanx, Paul
