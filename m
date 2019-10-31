Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5316CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89796208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572534442;
	bh=4U/ETnIzLhw19X4wyTeVNcJAT/xQDEsJ+bOoWVhUIU8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=eGxaqS60lusD4HInyDMf+4d03LRUZaSio9oYYIeAtFOsbLFBumemGiel4U1SSmeDh
	 Z+CtSdK1MabKHweWlmZd8hHoImv6VrJsYROIw7aQZdXd1l7NKhd1oKHB/vgRb9FasA
	 ihvf2uXD+/7I1ZHJRuEO5S04iJ4NJBXAYTgQZigk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfJaPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfJaPHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:07:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E472083E;
        Thu, 31 Oct 2019 15:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572534440;
        bh=4U/ETnIzLhw19X4wyTeVNcJAT/xQDEsJ+bOoWVhUIU8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xeGBtlkuHRQz83nm/iwqpVgdCBKqcyiuyA/p1N3/cqYMDB6cU8e1hFK9PJloi9F3Q
         jgO9+sNUcxddj2oYTBA73U/VDu5cvJ2UNrEUH4FVkfO548Lef1RVM0EIzlD0KakmC6
         DQQCW4ldi3SnAF0FfGDxDIUyaSzuEn1eRwLkUIOc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EF2913520744; Thu, 31 Oct 2019 08:07:19 -0700 (PDT)
Date:   Thu, 31 Oct 2019 08:07:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 04/11] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20191031150719.GU20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-5-laijs@linux.alibaba.com>
 <20191031141056.GR20975@paulmck-ThinkPad-P72>
 <1b5cf860-3d4a-954c-09ac-6383b38da4cf@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b5cf860-3d4a-954c-09ac-6383b38da4cf@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:35:22PM +0800, Lai Jiangshan wrote:
> On 2019/10/31 10:10 下午, Paul E. McKenney wrote:
> > On Thu, Oct 31, 2019 at 10:07:59AM +0000, Lai Jiangshan wrote:
> > > Don't need to set ->rcu_read_lock_nesting negative, irq-protected
> > > rcu_preempt_deferred_qs_irqrestore() doesn't expect
> > > ->rcu_read_lock_nesting to be negative to work, it even
> > > doesn't access to ->rcu_read_lock_nesting any more.
> > > 
> > > It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
> > > may access to ->rcu_read_lock_nesting, but it is still safe
> > > since rcu_read_unlock_special() can protect itself from NMI.
> > 
> > Hmmm...  Testing identified the need for this one.  But I will wait for
> > your responses on the earlier patches before going any further through
> > this series.
> 
> Hmmm... I was wrong, it should be after patch7 to avoid
> the scheduler deadlock.

I was wondering about that.  ;-)

							Thanx, Paul

> > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > ---
> > >   kernel/rcu/tree_plugin.h | 5 -----
> > >   1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 82595db04eec..9fe8138ed3c3 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -555,16 +555,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
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
