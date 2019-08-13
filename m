Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37710C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EECB20651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfHMFb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 01:31:28 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:34351 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMFb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:31:28 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 13 Aug 2019 14:31:25 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 13 Aug 2019 14:31:25 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 13 Aug 2019 14:29:54 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
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
Message-ID: <20190813052954.GA18373@X58A-UD3R>
References: <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <CANrsvRPU_u6oKpjZ1368Evto+1hGboNYeOuMdbdzaOfXhSO=5g@mail.gmail.com>
 <20190808180916.GP28441@linux.ibm.com>
 <20190811083626.GA9486@X58A-UD3R>
 <20190811084950.GB9486@X58A-UD3R>
 <20190811234939.GC28441@linux.ibm.com>
 <20190812101052.GA10478@X58A-UD3R>
 <20190812131234.GC27552@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812131234.GC27552@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 09:12:34AM -0400, Joel Fernandes wrote:
> On Mon, Aug 12, 2019 at 07:10:52PM +0900, Byungchul Park wrote:
> > On Sun, Aug 11, 2019 at 04:49:39PM -0700, Paul E. McKenney wrote:
> > > Maybe.  Note well that I said "potential issue".  When I checked a few
> > > years ago, none of the uses of rcu_barrier() cared about kfree_rcu().
> > > They cared instead about call_rcu() callbacks that accessed code or data
> > > that was going to disappear soon, for example, due to module unload or
> > > filesystem unmount.
> > > 
> > > So it -might- be that rcu_barrier() can stay as it is, but with changes
> > > as needed to documentation.
> 
> Right, we should update the docs. Byungchul, do you mind sending a patch that
> documents the rcu_barrier() behavior?

Are you trying to give me the chance? I feel thankful. It doens't matter
to try it at the moment though, I can't follow-up until September. I'd
better do that in Septamber or give it up this time.

Thanks,
Byungchul

> > > It also -might- be, maybe now or maybe some time in the future, that
> > > there will need to be a kfree_rcu_barrier() or some such.  But if so,
> > > let's not create it until it is needed.  For one thing, it is reasonably
> > > likely that something other than a kfree_rcu_barrier() would really
> > > be what was needed.  After all, the main point would be to make sure
> > > that the old memory really was freed before allocating new memory.
> > 
> > Now I fully understand what you meant thanks to you. Thank you for
> > explaining it in detail.
> > 
> > > But if the system had ample memory, why wait?  In that case you don't
> > > really need to wait for all the old memory to be freed, but rather for
> > > sufficient memory to be available for allocation.
> > 
> > Agree. Totally make sense.
> 
> Agreed, all makes sense.
> 
> thanks,
> 
>  - Joel
> 
> [snip]
