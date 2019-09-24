Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2981C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958382168B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569341033;
	bh=WoXmQkQtjofuTNXBQTpYOdHbEC75k3E21PyCVIN1q38=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ee6L46JdadDgW0mzjaNzCWZGCdr9TKkg4S0b1NxCA46Rozx/rmgpfkUsy4p15Gkvv
	 3HFYkW59ynitdTT7Tk5cjkkqaJb2wm9v5KalAVk6vaG0lukdMtRf8rfIHD9dzH+2xr
	 nwyi8MVmgphGToq4B7ggF0VZgSkRzIouS7RzNl5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438098AbfIXQDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391013AbfIXQDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:03:52 -0400
Received: from paulmck-ThinkPad-P72 (unknown [170.225.9.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC34A214DA;
        Tue, 24 Sep 2019 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569341031;
        bh=WoXmQkQtjofuTNXBQTpYOdHbEC75k3E21PyCVIN1q38=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OZIVQjjU2b3/+JzjUfyjcAzZyDHaoWVrIpISe+YKpkIv6lRwZFSD+Pl/Bai4izCeM
         HQLxz9UvuHbRjbbF+IIXjOTbZxb7Emx7DQaQ1OQCLJMCB953/1EPCKH9lX6IHGUnTa
         GpCU7uEV2pNOiGmXtjR8Q95gTe4ZG1fgNhoeclv4=
Date:   Tue, 24 Sep 2019 09:03:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org,
        kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [rcu:dev.2019.09.23a 62/77] kernel/rcu/tree.c:2882
 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
Message-ID: <20190924160348.GF2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190924080510.GL20699@kadam>
 <CAEXW_YQYDom3AwWR1AUSCw5VvFzc6KrBH0KbuTvhkJ3OoxBfCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQYDom3AwWR1AUSCw5VvFzc6KrBH0KbuTvhkJ3OoxBfCg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:15:12AM -0400, Joel Fernandes wrote:
> On Tue, Sep 24, 2019 at 4:05 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.09.23a
> > head:   97de53b94582c208ee239178b208b8e8b9472585
> > commit: 39676bb72323718a9e7bab1ba9c4a68319a96f62 [62/77] rcu: Add support for debug_objects debugging for kfree_rcu()
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > smatch warnings:
> > kernel/rcu/tree.c:2882 kfree_call_rcu() warn: inconsistent returns 'irqsave:flags'.
> >   Locked on:   line 2867
> >   Unlocked on: line 2882
> >
> > git remote add rcu https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > git remote update rcu
> > git checkout 39676bb72323718a9e7bab1ba9c4a68319a96f62
> > vim +2882 kernel/rcu/tree.c
> >
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2850) void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2851) {
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2852)        unsigned long flags;
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2853)        struct kfree_rcu_cpu *krcp;
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2854)
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2855)        head->func = func;
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2856)
> > 87970ccf5a9125 Paul E. McKenney        2019-09-19  2857         local_irq_save(flags);  // For safely calling this_cpu_ptr().
> >                                                                 ^^^^^^^^^^^^^^^^^^^^^
> > IRQs disabled.
> >
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2858)        krcp = this_cpu_ptr(&krc);
> > ff8db005e371cb Paul E. McKenney        2019-09-19  2859         if (krcp->initialized)
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2860)                spin_lock(&krcp->lock);
> > 5f5046cc15d514 Joel Fernandes (Google  2019-08-05  2861)
> > 87970ccf5a9125 Paul E. McKenney        2019-09-19  2862         // Queue the object but don't yet schedule the batch.
> > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2863)        if (debug_rcu_head_queue(head)) {
> > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2864)                // Probable double kfree_rcu(), just leak.
> > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2865)                WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2866)                          __func__, head);
> > 39676bb7232371 Joel Fernandes (Google  2019-09-22  2867)                return;
> >
> > Need to re-enable before returning.
> 
> Right. At this point the system has a bug anyway since it is a
> double-free. But yes, no reason to introduce more bugs. Will fix.
> Thank you, Dan!

What Joel said!

As long as I am doing several other reports anyway...

How does the to-be-squashed patch below look?

							Thanx, Paul

------------------------------------------------------------------------

commit 39af4c08038a8a6a7b1c9804fdd2c1921d583222
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Sep 24 09:02:00 2019 -0700

    squash! rcu: Add support for debug_objects debugging for kfree_rcu()
    
    [ paulmck: Fix IRQ per kbuild test robot <lkp@intel.com> feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 921daa7..edb7539 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2870,7 +2870,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
-		return;
+		goto unlock_return;
 	}
 	head->func = func;
 	head->next = krcp->head;
@@ -2883,6 +2883,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	}
 
+unlock_return:
 	if (krcp->initialized)
 		spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
