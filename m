Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D1C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1BD2245A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569525880;
	bh=E1YCeUmb5/tx7z9tTtAC0Pzgfr8tPf871wRcfn36aro=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=elzA6RCHUN6TvfQxifa0Hg0LG+SccfGNf3R1SCex+1Ek1RNM6URmeT6+VTcjxF+fa
	 d28rE+UCvd0Wjp91XCJ+yBHNyCPwZQua1192vIqyG0SEodHJLDaoBoKBolSMppm+BS
	 xI+SEf9bFF+U12ReySWaKOxBuCXS1a0Jhf0wpits=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfIZTYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbfIZTYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:24:39 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300EA222C3;
        Thu, 26 Sep 2019 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569525878;
        bh=E1YCeUmb5/tx7z9tTtAC0Pzgfr8tPf871wRcfn36aro=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yAoIIeyPxXOS4OcMTTIFaYHqTTjvIggB/VQVWZ9FN5+LiFGDFd2V57uuTsDGiXb4u
         hZQ71txuoRPIjZI52bckkA1vXSf71dCslCUhcqLLjYznQgldSgx7DrEfMKfaT1zRZQ
         1eMvF84MraKI67E1XDwh2pm6eUr67s4zPUbZmO2M=
Date:   Thu, 26 Sep 2019 12:24:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org,
        kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [rcu:dev.2019.09.23a 62/77] kernel/rcu/tree.c:2882
 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
Message-ID: <20190926192436.GN2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190924080510.GL20699@kadam>
 <CAEXW_YQYDom3AwWR1AUSCw5VvFzc6KrBH0KbuTvhkJ3OoxBfCg@mail.gmail.com>
 <20190924160348.GF2689@paulmck-ThinkPad-P72>
 <20190926181954.GC99154@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926181954.GC99154@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 02:19:54PM -0400, Joel Fernandes wrote:
> On Tue, Sep 24, 2019 at 09:03:48AM -0700, Paul E. McKenney wrote:
> > On Tue, Sep 24, 2019 at 08:15:12AM -0400, Joel Fernandes wrote:
> > > On Tue, Sep 24, 2019 at 4:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.09.23a
> > > > head:   97de53b94582c208ee239178b208b8e8b9472585
> > > > commit: 39676bb72323718a9e7bab1ba9c4a68319a96f62 [62/77] rcu: Add support for debug_objects debugging for kfree_rcu()
> > > >
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > >
> > > > smatch warnings:
> > > > kernel/rcu/tree.c:2882 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
> > > >   Locked on:   line 2867
> > > >   Unlocked on: line 2882
> > > >
> > > > git remote add rcu https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > > git remote update rcu
> > > > git checkout 39676bb72323718a9e7bab1ba9c4a68319a96f62
> > > > vim +2882 kernel/rcu/tree.c
> > > >
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2850) void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2851) {
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2852)        unsigned long flags;
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2853)        struct kfree_rcu_cpu *krcp;
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2854)
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2855)        head->func = func;
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2856)
> > > > 87970ccf5a9125 Paul E. McKenney        2019-09-19  2857         local_irq_save(flags);  // For safely calling this_cpu_ptr().
> > > >                                                                 ^^^^^^^^^^^^^^^^^^^^^
> > > > IRQs disabled.
> > > >
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2858)        krcp = this_cpu_ptr(&krc);
> > > > ff8db005e371cb Paul E. McKenney        2019-09-19  2859         if (krcp->initialized)
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2860)                spin_lock(&krcp->lock);
> > > > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2861)
> > > > 87970ccf5a9125 Paul E. McKenney        2019-09-19  2862         // Queue the object but don't yet schedule the batch.
> > > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2863)        if (debug_rcu_head_queue(head)) {
> > > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2864)                // Probable double kfree_rcu(), just leak.
> > > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2865)                WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2866)                          __func__, head);
> > > > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2867)                return;
> > > >
> > > > Need to re-enable before returning.
> > > 
> > > Right. At this point the system has a bug anyway since it is a
> > > double-free. But yes, no reason to introduce more bugs. Will fix.
> > > Thank you, Dan!
> > 
> > What Joel said!
> > 
> > As long as I am doing several other reports anyway...
> > 
> > How does the to-be-squashed patch below look?
> 
> Hi Paul,
> 
> Sorry for the late reply due to the conference..
> 
> This patch looks Ok, the code in your tree though is slightly different mine
> I think because you reworked the kfree_rcu() code for working during early
> boot.

Yes, I did pull some of the changes earlier.

> After my talk tomorrow, I will go through your rcu/dev tree in detail to
> review the reworks you did in detail.

Sounds good, and best of everything with the talk!

> Let me know if you have the kfree_rcu() changes in a separate topic branch,
> as well. So it will make reviewing easier.

They will be, shortly after -rc1 comes out.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 39af4c08038a8a6a7b1c9804fdd2c1921d583222
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Sep 24 09:02:00 2019 -0700
> > 
> >     squash! rcu: Add support for debug_objects debugging for kfree_rcu()
> >     
> >     [ paulmck: Fix IRQ per kbuild test robot <lkp@intel.com> feedback. ]
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 921daa7..edb7539 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2870,7 +2870,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  		// Probable double kfree_rcu(), just leak.
> >  		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> >  			  __func__, head);
> > -		return;
> > +		goto unlock_return;
> >  	}
> >  	head->func = func;
> >  	head->next = krcp->head;
> > @@ -2883,6 +2883,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> >  	}
> >  
> > +unlock_return:
> >  	if (krcp->initialized)
> >  		spin_unlock(&krcp->lock);
> >  	local_irq_restore(flags);
