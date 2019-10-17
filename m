Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE0FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA421928
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571281217;
	bh=dIlk87hzMnzxSsP3U+opZiSVL+pDY94vjhbNMGpswEY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ux1/tvKW+Ugb4c6G8/2pxj92u3Ko7ioQx5pX5uJrwq0Xg7OLa0jSQ6ddUoRXlDeQC
	 JuJPVlx7ejfETuOL7uqq10rrClImgwoaYZZDDTZ1i+ScFlXikmHd0qbu9UXmQNCayi
	 BAfVk8sdO+Gkkya25LQqI3VVOiVLro14NKYPwPOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404554AbfJQDAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392047AbfJQDAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:00:03 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD8B2082C;
        Thu, 17 Oct 2019 03:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571281202;
        bh=dIlk87hzMnzxSsP3U+opZiSVL+pDY94vjhbNMGpswEY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iA/ooYBLhI1FOzHufS48xeAVazXiTAnlPv+hYFLeuSuXDskBXjxUI9d69dF6lwt7z
         e0sgiR3nkgkM2fsryf0Y4moy9jhQ+2p2BE5S8zU7G3d5vP4ne5T0YJFyf9dnYJFInQ
         7iR4Wp0YAdGZ2PNvw2K68kTJRGQT836tLk6YpB3k=
Date:   Wed, 16 Oct 2019 20:00:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     20191015102402.1978-1-laijs@linux.alibaba.com,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 6/7] rcu: rename some CONFIG_PREEMPTION to
 CONFIG_PREEMPT_RCU
Message-ID: <20191017030000.GB2588@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015102850.2079-1-laijs@linux.alibaba.com>
 <20191015102850.2079-4-laijs@linux.alibaba.com>
 <20191016035407.GB2689@paulmck-ThinkPad-P72>
 <484d846f-8fbb-ccd2-d66a-a6b48d4a1df4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <484d846f-8fbb-ccd2-d66a-a6b48d4a1df4@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:26:23PM +0800, Lai Jiangshan wrote:
> 
> 
> On 2019/10/16 11:54 上午, Paul E. McKenney wrote:
> > On Tue, Oct 15, 2019 at 10:28:48AM +0000, Lai Jiangshan wrote:
> > > CONFIG_PREEMPTION and CONFIG_PREEMPT_RCU are always identical,
> > > but some code depends on CONFIG_PREEMPTION to access to
> > > rcu_preempt functionalitis. This patch changes CONFIG_PREEMPTION
> > > to CONFIG_PREEMPT_RCU in these cases.
> > > 
> > > Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > 
> > I believe that this does not cause problems with Sebastian's patch
> > "[PATCH 27/34] rcu: Use CONFIG_PREEMPTION where appropriate", but could
> > you please check?
> 
> I don't know for which commit the patch "[PATCH 27/34] rcu: Use
> CONFIG_PREEMPTION where appropriate" should be applied against
> after several tries. But I don't think there will be any conflicts
> which this patch by "eye" applying.

Well, git didn't see any either, so it is now applied for review and
testing.  Thank you!

							Thanx, Paul

> Thanks,
> Lai
> 
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >   kernel/rcu/tree.c       | 4 ++--
> > >   kernel/rcu/tree_stall.h | 6 +++---
> > >   2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 7db5ea06a9ed..81eb64fcf5ab 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1926,7 +1926,7 @@ rcu_report_unblock_qs_rnp(struct rcu_node *rnp, unsigned long flags)
> > >   	struct rcu_node *rnp_p;
> > >   	raw_lockdep_assert_held_rcu_node(rnp);
> > > -	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPTION)) ||
> > > +	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RCU)) ||
> > >   	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
> > >   	    rnp->qsmask != 0) {
> > >   		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > @@ -2294,7 +2294,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
> > >   		mask = 0;
> > >   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >   		if (rnp->qsmask == 0) {
> > > -			if (!IS_ENABLED(CONFIG_PREEMPTION) ||
> > > +			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
> > >   			    rcu_preempt_blocked_readers_cgp(rnp)) {
> > >   				/*
> > >   				 * No point in scanning bits because they
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index 0b75426ebb3e..55f9b84790d3 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -163,7 +163,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
> > >   //
> > >   // Printing RCU CPU stall warnings
> > > -#ifdef CONFIG_PREEMPTION
> > > +#ifdef CONFIG_PREEMPT_RCU
> > >   /*
> > >    * Dump detailed information for all tasks blocking the current RCU
> > > @@ -215,7 +215,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
> > >   	return ndetected;
> > >   }
> > > -#else /* #ifdef CONFIG_PREEMPTION */
> > > +#else /* #ifdef CONFIG_PREEMPT_RCU */
> > >   /*
> > >    * Because preemptible RCU does not exist, we never have to check for
> > > @@ -233,7 +233,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
> > >   {
> > >   	return 0;
> > >   }
> > > -#endif /* #else #ifdef CONFIG_PREEMPTION */
> > > +#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > >   /*
> > >    * Dump stacks of all tasks running on stalled CPUs.  First try using
> > > -- 
> > > 2.20.1
> > > 
