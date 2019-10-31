Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD49CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CF62086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572548241;
	bh=atQgwlBQBSDutyoWJUcv5vkRPBLQF1Vzq04Vm6LQI7k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=GEXUFTVRC1qqWaNgh7RkDIcEbgluwc/8kxeXYxHUzyRJIJ/ICSmxG8Itw+eqzS8/G
	 wti4vqO03R2ofWmp0HMndOv7IKE++mBW22uHMNn0E0kAlFi7kC7p4/mYujjb9yq2dl
	 1ylGXNwyF7e1Hv+R2usxESwyQEUngDPj4nDdC6T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfJaS5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbfJaS5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:57:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5832080F;
        Thu, 31 Oct 2019 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572548238;
        bh=atQgwlBQBSDutyoWJUcv5vkRPBLQF1Vzq04Vm6LQI7k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cjcf/7O07YCyXuKXNzOhbJW4nq1AKDCe9lNASGA1eqkypJSttJJ6aYJ9teuX1J+uV
         VH0MqdYXVUEDbhlHz79fCVxNlSc08Po1/9BkgLzPQhjhBBRhdpYP9hgsx3eXXbGGVL
         qnWbLkjvUGA7kbdETqr0UwdoWDpD7uT88eHt2siQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6A6DE352105F; Thu, 31 Oct 2019 11:57:18 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:57:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 03/11] rcu: clean up rcu_preempt_deferred_qs_irqrestore()
Message-ID: <20191031185718.GY20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-4-laijs@linux.alibaba.com>
 <20191031135234.GQ20975@paulmck-ThinkPad-P72>
 <49c778ff-2187-26fb-1477-bdef6eaf298b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c778ff-2187-26fb-1477-bdef6eaf298b@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 11:25:11PM +0800, Lai Jiangshan wrote:
> 
> 
> On 2019/10/31 9:52 下午, Paul E. McKenney wrote:
> > On Thu, Oct 31, 2019 at 10:07:58AM +0000, Lai Jiangshan wrote:
> > > Remove several unneeded return.
> > > 
> > > It doesn't need to return earlier after every code block.
> > > The code protects itself and be safe to fall through because
> > > every code block has its own condition tests.
> > > 
> > > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > > ---
> > >   kernel/rcu/tree_plugin.h | 14 +-------------
> > >   1 file changed, 1 insertion(+), 13 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 59ef10da1e39..82595db04eec 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -439,19 +439,10 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> > >   	 * t->rcu_read_unlock_special cannot change.
> > >   	 */
> > >   	special = t->rcu_read_unlock_special;
> > > -	rdp = this_cpu_ptr(&rcu_data);
> > > -	if (!special.s && !rdp->exp_deferred_qs) {
> > > -		local_irq_restore(flags);
> > > -		return;
> > > -	}
> > 
> > The point of this check is the common case of this function being invoked
> > when both fields are zero, avoiding the below redundant store and all the
> > extra checks of subfields of special.
> > 
> > Or are you saying that current compilers figure all this out?
> 
> No.
> 
> So, I have to keep the first/above return branch.
> 
> Any reasons to keep the following 2 return branches?
> There is no redundant store and the load for the checks
> are hot in the cache if the condition for return is met.

And the code further down is not in a fastpath.  So, good point, it
should be find to remove the two early exits below.

							Thanx, Paul

> Thanks.
> Lai
> 
> > 
> > 							Thanx, Paul
> > 
> > >   	t->rcu_read_unlock_special.b.deferred_qs = false;
> > >   	if (special.b.need_qs) {
> > >   		rcu_qs();
> > >   		t->rcu_read_unlock_special.b.need_qs = false;
> > > -		if (!t->rcu_read_unlock_special.s && !rdp->exp_deferred_qs) {
> > > -			local_irq_restore(flags);
> > > -			return;
> > > -		}
> > >   	}
> > >   	/*
> > > @@ -460,12 +451,9 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> > >   	 * tasks are handled when removing the task from the
> > >   	 * blocked-tasks list below.
> > >   	 */
> > > +	rdp = this_cpu_ptr(&rcu_data);
> > >   	if (rdp->exp_deferred_qs) {
> > >   		rcu_report_exp_rdp(rdp);
> > > -		if (!t->rcu_read_unlock_special.s) {
> > > -			local_irq_restore(flags);
> > > -			return;
> > > -		}
> > >   	}
> > >   	/* Clean up if blocked during RCU read-side critical section. */
> > > -- 
> > > 2.20.1
> > > 
