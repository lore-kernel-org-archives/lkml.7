Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730ACA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4092087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572561928;
	bh=00Fdc8thqXGj6kRszA+RLXMcOzf9yGtAAI6L1ra85wI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PbF/MqXIGlbuq6jcUCMN7dHd+8fZi9adi625ciLGJSQXgbuAU4Z+scO+nSyzMkrhl
	 zkfqXtciEkAQh226exPCffjdtsRpVExiGh4Mt1WEDTsGPw1ka58ZS7+Z8G+XJm6CU+
	 OwhAjumV4YKmMp+/Z0bnDx2+uh5OzeJm+jVcP9cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfJaWp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbfJaWp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:45:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8373420873;
        Thu, 31 Oct 2019 22:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572561925;
        bh=00Fdc8thqXGj6kRszA+RLXMcOzf9yGtAAI6L1ra85wI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F+ZnROp2lHQK5sEUapK9m5fUFEmFA0VegA9vmRyH8qXCJakks/hSIPKzGa07xVZIX
         a5q2Z4fsyBn8AM1+v2myqXfb4DBk1EPU/GPRxlwyzoBMsivPj3fQHhzi/DJToe7gWu
         Pll7D8p7NYfpjDpeFLGbb0KxE27OT81Mre+csvl4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5D13C3520B06; Thu, 31 Oct 2019 15:45:25 -0700 (PDT)
Date:   Thu, 31 Oct 2019 15:45:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 04/11] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20191031224525.GC20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-5-laijs@linux.alibaba.com>
 <20191031141056.GR20975@paulmck-ThinkPad-P72>
 <1b5cf860-3d4a-954c-09ac-6383b38da4cf@linux.alibaba.com>
 <20191031150719.GU20975@paulmck-ThinkPad-P72>
 <9791cdcb-591d-224a-bef0-05eba773e65b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9791cdcb-591d-224a-bef0-05eba773e65b@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 02:33:19AM +0800, Lai Jiangshan wrote:
> 
> 
> On 2019/10/31 11:07 下午, Paul E. McKenney wrote:
> > On Thu, Oct 31, 2019 at 10:35:22PM +0800, Lai Jiangshan wrote:
> > > On 2019/10/31 10:10 下午, Paul E. McKenney wrote:
> > > > On Thu, Oct 31, 2019 at 10:07:59AM +0000, Lai Jiangshan wrote:
> > > > > Don't need to set ->rcu_read_lock_nesting negative, irq-protected
> > > > > rcu_preempt_deferred_qs_irqrestore() doesn't expect
> > > > > ->rcu_read_lock_nesting to be negative to work, it even
> > > > > doesn't access to ->rcu_read_lock_nesting any more.
> > > > > 
> > > > > It is true that NMI over rcu_preempt_deferred_qs_irqrestore()
> > > > > may access to ->rcu_read_lock_nesting, but it is still safe
> > > > > since rcu_read_unlock_special() can protect itself from NMI.
> > > > 
> > > > Hmmm...  Testing identified the need for this one.  But I will wait for
> > > > your responses on the earlier patches before going any further through
> > > > this series.
> > > 
> > > Hmmm... I was wrong, it should be after patch7 to avoid
> > > the scheduler deadlock.
> > 
> > I was wondering about that.  ;-)
> 
> This patch was split from the core patch(patch8: don't use negative
> ->rcu_read_lock_nesting).
> 
> When I reordered "fixing something" as patch1/2, I reordered
> it close to the patch of clean up rcu_preempt_deferred_qs_irqrestore
> caused this mistake.

OK.

> I will reorder it back later and "fixing something" is fixing
> nothing and I will drop patch 1/2. Could you continue to review
> further through this series please? Sorry for any mistakes.

I will take at least a quick look in the morning, which will be
about ten hours from now.

							Thanx, Paul

> Thanks
> Lai
> 
> > 							Thanx, Paul
> > 
> > > > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > > ---
> > > > >    kernel/rcu/tree_plugin.h | 5 -----
> > > > >    1 file changed, 5 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > index 82595db04eec..9fe8138ed3c3 100644
> > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > @@ -555,16 +555,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> > > > >    static void rcu_preempt_deferred_qs(struct task_struct *t)
> > > > >    {
> > > > >    	unsigned long flags;
> > > > > -	bool couldrecurse = t->rcu_read_lock_nesting >= 0;
> > > > >    	if (!rcu_preempt_need_deferred_qs(t))
> > > > >    		return;
> > > > > -	if (couldrecurse)
> > > > > -		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
> > > > >    	local_irq_save(flags);
> > > > >    	rcu_preempt_deferred_qs_irqrestore(t, flags);
> > > > > -	if (couldrecurse)
> > > > > -		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
> > > > >    }
> > > > >    /*
> > > > > -- 
> > > > > 2.20.1
> > > > > 
