Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877C1C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F68C20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gP8UUQfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfHLNN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:13:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40899 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfHLNN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:13:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so49467864pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GZ0kjDqlsBXm1onlGJXcmPjGBoo61xvrnT83Ha327/w=;
        b=gP8UUQfHWVK6PCcZuCtgUQGLNb1xfd6VKrNkvy4mRHgk9halkk9WtevTsy8CrmrGJc
         8f/OSls2fO+e27Z+BFeMu4ZQ3qWb/YelAQDZM5eq+e3yOvW53/QDwykv+eangS1d98mk
         ZVssmiHwfBbBDFsY+PTe1XEIpIW7JcLyTa4Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZ0kjDqlsBXm1onlGJXcmPjGBoo61xvrnT83Ha327/w=;
        b=UmcOZzwg0pLHLGA6Iz+4Y+ErsG+ohjBT67iiq+AysItCF3cluSILcOAM9XVvc9AlLF
         h5Wv2/1M3L2bj11UJeK+usVAJQPMKBO2uVHVx6HpUMwEgM0E2yEO1/uji1xGojlvqWt0
         /gy3SEbqx9QuPb7Bq+vlb1AsKGAzuZ8tkhRXW3G2gAHUZB5m6aCwxq5quJRnGTOh4cFN
         NjcRwoToybKX+H3KiL0vj/kAvD+LN5dabuVTFf+l4XStJ9jMJLiRuWQ0QHF6wC8m4Am8
         J8GPLMVCkzFg9n0k9JHzOTV8wuYvdwW6oty2iAY8sONlqZd2glp5qAojOlo6u3dAV+IX
         u9ig==
X-Gm-Message-State: APjAAAXbpPhpASF4P0YzKtRDI76vztv9ftBYDjGWDsCXJ/XmWPdEh8ZT
        P+B8ZEFOKXv1rRSSuhK3bu6X7Q==
X-Google-Smtp-Source: APXvYqy6+6QzzZdWXIKiyMIq2T9hBQPZZNCte/r5azHG+eDPKEg76LyIZYFYP+2vYNMdHuJERhvlAQ==
X-Received: by 2002:a17:90a:9dca:: with SMTP id x10mr23688041pjv.100.1565615638117;
        Mon, 12 Aug 2019 06:13:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u16sm14628129pjb.2.2019.08.12.06.13.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 06:13:57 -0700 (PDT)
Date:   Mon, 12 Aug 2019 09:13:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190812131356.GD27552@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190810024232.GA183658@google.com>
 <20190810033814.GP28441@linux.ibm.com>
 <20190810042037.GA175783@google.com>
 <20190810182446.GT28441@linux.ibm.com>
 <20190811022658.GA177703@google.com>
 <20190811233504.GA28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811233504.GA28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 04:35:04PM -0700, Paul E. McKenney wrote:
> On Sat, Aug 10, 2019 at 10:26:58PM -0400, Joel Fernandes wrote:
> > On Sat, Aug 10, 2019 at 11:24:46AM -0700, Paul E. McKenney wrote:
> > > On Sat, Aug 10, 2019 at 12:20:37AM -0400, Joel Fernandes wrote:
> > > > On Fri, Aug 09, 2019 at 08:38:14PM -0700, Paul E. McKenney wrote:
> > > > > On Fri, Aug 09, 2019 at 10:42:32PM -0400, Joel Fernandes wrote:
> > > > > > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > > > [snip] 
> > > > > > > > > > @@ -3459,6 +3645,8 @@ void __init rcu_init(void)
> > > > > > > > > >  {
> > > > > > > > > >  	int cpu;
> > > > > > > > > >  
> > > > > > > > > > +	kfree_rcu_batch_init();
> > > > > > > > > 
> > > > > > > > > What happens if someone does a kfree_rcu() before this point?  It looks
> > > > > > > > > like it should work, but have you tested it?
> > > > > > > > > 
> > > > > > > > > >  	rcu_early_boot_tests();
> > > > > > > > > 
> > > > > > > > > For example, by testing it in rcu_early_boot_tests() and moving the
> > > > > > > > > call to kfree_rcu_batch_init() here.
> > > > > > > > 
> > > > > > > > I have not tried to do the kfree_rcu() this early. I will try it out.
> > > > > > > 
> > > > > > > Yeah, well, call_rcu() this early came as a surprise to me back in the
> > > > > > > day, so...  ;-)
> > > > > > 
> > > > > > I actually did get surprised as well!
> > > > > > 
> > > > > > It appears the timers are not fully initialized so the really early
> > > > > > kfree_rcu() call from rcu_init() does cause a splat about an initialized
> > > > > > timer spinlock (even though future kfree_rcu()s and the system are working
> > > > > > fine all the way into the torture tests).
> > > > > > 
> > > > > > I think to resolve this, we can just not do batching until early_initcall,
> > > > > > during which I have an initialization function which switches batching on.
> > > > > > >From that point it is safe.
> > > > > 
> > > > > Just go ahead and batch, but don't bother with the timer until
> > > > > after single-threaded boot is done.  For example, you could check
> > > > > rcu_scheduler_active similar to how sync_rcu_exp_select_cpus() does.
> > > > > (See kernel/rcu/tree_exp.h.)
> > > > 
> > > > Cool, that works nicely and I tested it. Actually I made it such that we
> > > > don't need to batch even, before the scheduler is up. I don't see any benefit
> > > > of that unless we can see a kfree_rcu() flood happening that early at boot
> > > > which seems highly doubtful as a real world case.
> > > 
> > > The benefit is removing the kfree_rcu() special cases from the innards
> > > of RCU, for example, in rcu_do_batch().  Another benefit is removing the
> > > current restriction on the position of the rcu_head structure within the
> > > enclosing data structure.
> > > 
> > > So it would be good to avoid the current kfree_rcu() special casing within
> > > RCU itself.
> > > 
> > > Or are you using some trick that avoids both the batching and the current
> > > kfree_rcu() special casing?
> > 
> > Oh. I see what you mean. Would it be Ok with you to have that be a follow up
> > patch?  I am not getting rid (yet) of the special casing in rcu_do_batch in
> > this patch, but can do that in another patch.
> 
> I am OK having that in another patch, and I will be looking over yours
> and Byungchul's two patches tomorrow.  If they look OK, I will queue them.

Ok, some of the code comments are stale as Byungchul pointed, allow me to fix
them and then you can look at v3 directly, to save you the time.

> However, I won't send them upstream without a follow-on patch that gets
> rid of the kfree_rcu() special casing within rcu_do_batch() and perhaps
> elsewhere.  This follow-on patch would of course also need to change rcuperf
> appropriately.

Sounds good.

> > For now I am just doing something like the following in kfree_call_rcu(). I
> > was almost about to hit send on the v1 and I have been testing this a lot so
> > I'll post it anyway; and we can discuss more about this point on that.
> > 
> > +void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +       unsigned long flags;
> > +       struct kfree_rcu_cpu *krcp;
> > +       bool monitor_todo;
> > +
> > +       /* kfree_call_rcu() batching requires timers to be up. If the scheduler
> > +        * is not yet up, just skip batching and do non-batched kfree_call_rcu().
> > +        */
> > +       if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING)
> > +               return kfree_call_rcu_nobatch(head, func);
> > +
> 
> As a stopgap until the follow-on patch, this looks fine.

Cool, thanks!

- Joel

