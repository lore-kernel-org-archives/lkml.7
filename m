Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EB5C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8458121848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfJBPRW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:17:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60240 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfJBPRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:17:21 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iFgNT-0005TD-62; Wed, 02 Oct 2019 17:17:19 +0200
Date:   Wed, 2 Oct 2019 17:17:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191002151718.eicbn4ahdanwuggh@linutronix.de>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191002150852.GB2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191002150852.GB2689@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-02 08:08:52 [-0700], Paul E. McKenney wrote:
> On Wed, Oct 02, 2019 at 01:22:53PM +0200, Sebastian Andrzej Siewior wrote:
> > This is a revert of commit
> >    a4244454df129 ("percpu-refcount: use RCU-sched insted of normal RCU")
> > 
> > which claims the only reason for using RCU-sched is
> >    "rcu_read_[un]lock() … are slightly more expensive than preempt_disable/enable()"
> > 
> > and
> >     "As the RCU critical sections are extremely short, using sched-RCU
> >     shouldn't have any latency implications."
> > 
> > The problem with using RCU-sched here is that it disables preemption and
> > the callback must not acquire any sleeping locks like spinlock_t on
> > PREEMPT_RT which is the case with some of the users.
> 
> Looks good in general, but changing to RCU-preempt does not change the
> fact that the callbacks execute with bh disabled.  There is a newish
> queue_rcu_work() that invokes a workqueue handler after a grace period.
> 
> Or am I missing your point here?

That is fine, no the RCU callback. The problem is that
percpu_ref_put_many() as of now does:

	rcu_read_lock_sched(): /* aka preempt_disable(); */
	if (__ref_is_percpu(ref, &percpu_count))
		this_cpu_sub(*percpu_count, nr);
	else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
		ref->release(ref);

and then the callback invoked via ref->release() acquires a spinlock_t
with disabled preemption.
 
> 							Thanx, Paul

Sebastian
