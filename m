Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54655C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B108214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfHLKM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:12:27 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:45414 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727843AbfHLKM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:12:26 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 12 Aug 2019 19:12:22 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 12 Aug 2019 19:12:22 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 12 Aug 2019 19:10:52 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20190812101052.GA10478@X58A-UD3R>
References: <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <CANrsvRPU_u6oKpjZ1368Evto+1hGboNYeOuMdbdzaOfXhSO=5g@mail.gmail.com>
 <20190808180916.GP28441@linux.ibm.com>
 <20190811083626.GA9486@X58A-UD3R>
 <20190811084950.GB9486@X58A-UD3R>
 <20190811234939.GC28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811234939.GC28441@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 04:49:39PM -0700, Paul E. McKenney wrote:
> Maybe.  Note well that I said "potential issue".  When I checked a few
> years ago, none of the uses of rcu_barrier() cared about kfree_rcu().
> They cared instead about call_rcu() callbacks that accessed code or data
> that was going to disappear soon, for example, due to module unload or
> filesystem unmount.
> 
> So it -might- be that rcu_barrier() can stay as it is, but with changes
> as needed to documentation.
> 
> It also -might- be, maybe now or maybe some time in the future, that
> there will need to be a kfree_rcu_barrier() or some such.  But if so,
> let's not create it until it is needed.  For one thing, it is reasonably
> likely that something other than a kfree_rcu_barrier() would really
> be what was needed.  After all, the main point would be to make sure
> that the old memory really was freed before allocating new memory.

Now I fully understand what you meant thanks to you. Thank you for
explaining it in detail.

> But if the system had ample memory, why wait?  In that case you don't
> really need to wait for all the old memory to be freed, but rather for
> sufficient memory to be available for allocation.

Agree. Totally make sense.

Thanks,
Byungchul

> 
> 							Thanx, Paul
> 
> > Thanks,
> > Byungchul
> > 
> > > But now that we can see letting the list just grow works well, we don't
> > > have to consider this one at the moment. Let's consider this method
> > > again once we face the problem in the future by any chance.
> > > 
> > > > We should therefore just let the second list grow.  If experience shows
> > > > a need for callbacks to be sent up more quickly, it should be possible
> > > > to provide an additional list, so that two lists on a given CPU can both
> > > > be waiting for a grace period at the same time.
> > > 
> > > Or the third and fourth list might be needed in some system. But let's
> > > talk about it later too.
> > > 
> > > > > > I also agree. But this _FORCE thing will still not solve the issue Paul is
> > > > > > raising which is doing this loop possibly in irq disabled / hardirq context.
> > > > > 
> > > > > I added more explanation above. What I suggested is a way to avoid not
> > > > > only heavy
> > > > > work within the irq-disabled region of a single kfree_rcu() but also
> > > > > too many requests
> > > > > to be queued into ->head.
> > > > 
> > > > But let's start simple, please!
> > > 
> > > Yes. The simpler, the better.
> > > 
> > > > > > We can't even cond_resched() here. In fact since _FORCE is larger, it will be
> > > > > > even worse. Consider a real-time system with a lot of memory, in this case
> > > > > > letting ->head grow large is Ok, but looping for long time in IRQ disabled
> > > > > > would not be Ok.
> > > > > 
> > > > > Please check the explanation above.
> > > > > 
> > > > > > But I could make it something like:
> > > > > > 1. Letting ->head grow if ->head_free busy
> > > > > > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > > > > 
> > > > > This is exactly what Paul said. The problem with this is ->head can grow too
> > > > > much. That's why I suggested the above one.
> > > > 
> > > > It can grow quite large, but how do you know that limiting its size will
> > > > really help?  Sure, you have limited the size, but does that really do
> > > 
> > > To decide the size, we might have to refer to how much pressure on
> > > memory and RCU there are at that moment and adjust it on runtime.
> > > 
> > > > anything for the larger problem of extreme kfree_rcu() rates on the one
> > > > hand and a desire for more efficient handling of kfree_rcu() on the other?
> > > 
> > > Assuming current RCU logic handles extremly high rate well which is
> > > anyway true, my answer is *yes*, because batching anyway has pros and
> > > cons. One of major cons is there must be inevitable kfree_rcu() requests
> > > that not even request to RCU. By allowing only the size of batching, the
> > > situation can be mitigated.
> > > 
> > > I just answered to you. But again, let's talk about it later once we
> > > face the problem as you said.
> > > 
> > > Thanks,
> > > Byungchul
> > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > > This would even improve performance, but will still risk going out of memory.
> > > > > >
> > > > > > Thoughts?
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > >  - Joel
> > > > > >
> > > > > > >
> > > > > > > This way, we can avoid both:
> > > > > > >
> > > > > > > 1. too many requests being queued and
> > > > > > > 2. __call_rcu() bunch of requests within a single kfree_rcu().
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Byungchul
> > > > > > >
> > > > > > > >
> > > > > > > > But please feel free to come up with a better solution!
> > > > > > > >
> > > > > > > > [ . . . ]
> > > > > 
> > > > > 
> > > > > 
> > > > > -- 
> > > > > Thanks,
> > > > > Byungchul
> > > > > 
