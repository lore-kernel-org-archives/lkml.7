Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9645C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE4F214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573482761;
	bh=uOBJwAAU9b98RobCJhQjUC+inr+qF75fKXbGsXkWTr0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xlA+ZE6goG3xgZs7A6/JFmj1zHKgLfQgm6hb+oGiMAY3nOJpqhEthTSHlk0XuCEvu
	 j5+EcqvqC5NcjP6F0XWD2BTlgZb8sK6hVqHQh5YP3L/IbdOEYpSUEagrJcwXlrY9hM
	 ozQilupgAR0PvbZ7TOx5yS5FVlsKsNu+8lWNLYoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfKKOck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKKOck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:32:40 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144DA20818;
        Mon, 11 Nov 2019 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573482759;
        bh=uOBJwAAU9b98RobCJhQjUC+inr+qF75fKXbGsXkWTr0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oduLqXU7M7LOWTeBBYFkWzgllZMEyPAYWviXu7Pf/MAnbSRKfVMg2JWY8oVzV9SiW
         keEokT1PAf1XyMs5SxpsbvllYoVGgjpKlQzPOJxWxpAsA0QAyCpnNxAwk6lm1fEhnH
         MjOY1x8xSnaQXWXoef2poclnna8yn72FhcTEXIzA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A71C835227B6; Mon, 11 Nov 2019 06:32:38 -0800 (PST)
Date:   Mon, 11 Nov 2019 06:32:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20191111143238.GA13306@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-3-laijs@linux.alibaba.com>
 <20191103020150.GA23770@tardis>
 <7489f817-adaf-275b-b19d-18ad248b071f@linux.alibaba.com>
 <20191104145539.GY20975@paulmck-ThinkPad-P72>
 <e820852f-87ca-f974-2245-99833205e270@linux.alibaba.com>
 <20191105071911.GL20975@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191105071911.GL20975@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 11:19:11PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 05, 2019 at 10:09:15AM +0800, Lai Jiangshan wrote:
> > On 2019/11/4 10:55 下午, Paul E. McKenney wrote:
> > > On Sun, Nov 03, 2019 at 01:01:21PM +0800, Lai Jiangshan wrote:
> > > > 
> > > > 
> > > > On 2019/11/3 10:01 上午, Boqun Feng wrote:
> > > > > Hi Jiangshan,
> > > > > 
> > > > > 
> > > > > I haven't checked the correctness of this patch carefully, but..
> > > > > 
> > > > > 
> > > > > On Sat, Nov 02, 2019 at 12:45:54PM +0000, Lai Jiangshan wrote:
> > > > > > Don't need to set ->rcu_read_lock_nesting negative, irq-protected
> > > > > > rcu_preempt_deferred_qs_irqrestore() doesn't expect
> > > > > > ->rcu_read_lock_nesting to be negative to work, it even
> > > > > > doesn't access to ->rcu_read_lock_nesting any more.
> > > > > 
> > > > > rcu_preempt_deferred_qs_irqrestore() will report RCU qs, and may
> > > > > eventually call swake_up() or its friends to wake up, say, the gp
> > > > > kthread, and the wake up functions could go into the scheduler code
> > > > > path which might have RCU read-side critical section in it, IOW,
> > > > > accessing ->rcu_read_lock_nesting.
> > > > 
> > > > Sure, thank you for pointing it out.
> > > > 
> > > > I should rewrite the changelog in next round. Like this:
> > > > 
> > > > rcu: cleanup rcu_preempt_deferred_qs()
> > > > 
> > > > IRQ-protected rcu_preempt_deferred_qs_irqrestore() itself doesn't
> > > > expect ->rcu_read_lock_nesting to be negative to work.
> > > > 
> > > > There might be RCU read-side critical section in it (from wakeup()
> > > > or so), 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
> > > > will ensure that ->rcu_read_unlock_special is zero and these RCU
> > > > read-side critical sections will not call rcu_read_unlock_special().
> > > > 
> > > > Thanks
> > > > Lai
> > > > 
> > > > ===
> > > > PS: Were 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
> > > > not applied earlier, it will be protected by previous patch (patch1)
> > > > in this series
> > > > "rcu: use preempt_count to test whether scheduler locks is held"
> > > > when rcu_read_unlock_special() is called.
> > > 
> > > This one in -rcu, you mean?
> > > 
> > > 5c5d9065e4eb ("rcu: Clear ->rcu_read_unlock_special only once")
> > 
> > Yes, but the commit ID is floating in the tree.
> 
> Indeed, that part of -rcu is subject to rebase, and will continue
> to be until about v5.5-rc5 or thereabouts.
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html
> 
> My testing of your full stack should be complete by this coming Sunday
> morning, Pacific Time.

And you will be happy to hear that it ran the full time without errors.

Good show!!!

My next step is to look much more carefully at the remaining patches,
checking my first impressions.  This will take a few days.

							Thanx, Paul
