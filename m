Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA5CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D68821D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572879345;
	bh=qhFhtJ7kIs1LPobeI8yqIagmffHkLC//6dS3sSJVq14=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Hul1LVw/UlorBSwhbw7pHFvjmbnJAgfOGtesDdS/w9OZ8hlZkDmXxfGD6DOngHxCp
	 Wlvo3BBeHrLdVFwd/NoiUOaLX0u9bAAYRHsjQSMT3y17Kzc57o1gvtXJQjCT/hSwQB
	 VzIPs0m6SPtvoQEfswHUpzuPVqB6vQoigFylCp4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfKDOzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:55:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfKDOzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:55:43 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.216.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1739218BA;
        Mon,  4 Nov 2019 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572879342;
        bh=qhFhtJ7kIs1LPobeI8yqIagmffHkLC//6dS3sSJVq14=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wCsPQPmjOZZqBPnGPQF00rU5fT0vPfJpx/6Y/X33mBGjMGU10tiWg/yA17r0XfhS9
         Er53WkTQwjvLLtw1dkILFjJiGJ20ixK9csl70pc5eg4k2kRl89DLWbULLJDeljTfjK
         VSRRPFjfGdaB1paJFApRq16ecyTIuOTlvmjtFLrQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B64DE3520B56; Mon,  4 Nov 2019 06:55:39 -0800 (PST)
Date:   Mon, 4 Nov 2019 06:55:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20191104145539.GY20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-3-laijs@linux.alibaba.com>
 <20191103020150.GA23770@tardis>
 <7489f817-adaf-275b-b19d-18ad248b071f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7489f817-adaf-275b-b19d-18ad248b071f@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 01:01:21PM +0800, Lai Jiangshan wrote:
> 
> 
> On 2019/11/3 10:01 上午, Boqun Feng wrote:
> > Hi Jiangshan,
> > 
> > 
> > I haven't checked the correctness of this patch carefully, but..
> > 
> > 
> > On Sat, Nov 02, 2019 at 12:45:54PM +0000, Lai Jiangshan wrote:
> > > Don't need to set ->rcu_read_lock_nesting negative, irq-protected
> > > rcu_preempt_deferred_qs_irqrestore() doesn't expect
> > > ->rcu_read_lock_nesting to be negative to work, it even
> > > doesn't access to ->rcu_read_lock_nesting any more.
> > 
> > rcu_preempt_deferred_qs_irqrestore() will report RCU qs, and may
> > eventually call swake_up() or its friends to wake up, say, the gp
> > kthread, and the wake up functions could go into the scheduler code
> > path which might have RCU read-side critical section in it, IOW,
> > accessing ->rcu_read_lock_nesting.
> 
> Sure, thank you for pointing it out.
> 
> I should rewrite the changelog in next round. Like this:
> 
> rcu: cleanup rcu_preempt_deferred_qs()
> 
> IRQ-protected rcu_preempt_deferred_qs_irqrestore() itself doesn't
> expect ->rcu_read_lock_nesting to be negative to work.
> 
> There might be RCU read-side critical section in it (from wakeup()
> or so), 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
> will ensure that ->rcu_read_unlock_special is zero and these RCU
> read-side critical sections will not call rcu_read_unlock_special().
> 
> Thanks
> Lai
> 
> ===
> PS: Were 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
> not applied earlier, it will be protected by previous patch (patch1)
> in this series
> "rcu: use preempt_count to test whether scheduler locks is held"
> when rcu_read_unlock_special() is called.

This one in -rcu, you mean?

5c5d9065e4eb ("rcu: Clear ->rcu_read_unlock_special only once")

Some adjustment was needed due to my not applying the earlier patches
that assumed nested interrupts.  Please let me know if further adjustments
are needed.

							Thanx, Paul

> > Again, haven't checked closely, but this argument in the commit log
> > seems untrue.
> > 
> > Regards,
> > Boqun
> > 
> > > 
> > > It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
> > > may access to ->rcu_read_lock_nesting, but it is still safe
> > > since rcu_read_unlock_special() can protect itself from NMI.
> > > 
> > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > ---
> > >   kernel/rcu/tree_plugin.h | 5 -----
> > >   1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index aba5896d67e3..2fab8be2061f 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -552,16 +552,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> > >   static void rcu_preempt_deferred_qs(struct task_struct *t)
> > >   {
> > >   	unsigned long flags;
> > > -	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
> > >   	if (!rcu_preempt_need_deferred_qs(t))
> > >   		return;
> > > -	if (couldrecurse)
> > > -		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
> > >   	local_irq_save(flags);
> > >   	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > -	if (couldrecurse)
> > > -		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
> > >   }
> > >   /*
> > > -- 
> > > 2.20.1
> > > 
