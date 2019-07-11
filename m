Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84580C74A51
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B17F21537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562838393;
	bh=YDxLY65LWfdhY1Rf8aeyHgh6DOHb50JODzLfH8zx7Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1DFvtEZlv84a6foXzpyJRL54BVH3nipxvuLiqRD+WrnrFhM+FL7H2cgQvr2O+xPH2
	 IxBMgm6V8e2gJ4kc3ewjKVw7k14ehSOPKkWqrZIJ11Ikc2kO384ETb+2XBycayT49y
	 E2UZ+OmqPGyBMg5uh1Lw364/4CBRJoFdVS2B9gBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGKJqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfGKJqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:46:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2196C20872;
        Thu, 11 Jul 2019 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562838391;
        bh=YDxLY65LWfdhY1Rf8aeyHgh6DOHb50JODzLfH8zx7Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPL7D0vn4dmTOe/pHmvtrAgLr3M+wMUEnl4hev7nmIwvivk2J4ECpaR76V/L6WmuW
         74o4AMFn3Y9lu2MQ4c8kw0nBSDA9gc5jDZuK3h5vMJLPPD6KyQAjwBwkDIXETq78nI
         rwqsjpYk0EesSx9VywXB5UkSu3K7eXZoxTmSm2hk=
Date:   Thu, 11 Jul 2019 10:46:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, tglx@linutronix.de
Subject: Re: [PATCH] locking/mutex: Test for initialized mutex
Message-ID: <20190711094626.snph3c5mgs62q2ps@willie-the-truck>
References: <20190703092125.lsdf4gpsh2plhavb@linutronix.de>
 <20190710165053.cjt7qs7kx5fwu3d4@willie-the-truck>
 <20190710191549.thhdy62uebawbuwh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710191549.thhdy62uebawbuwh@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 09:15:49PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-10 17:50:54 [+0100], Will Deacon wrote:
> > On Wed, Jul 03, 2019 at 11:21:26AM +0200, Sebastian Andrzej Siewior wrote:
> > > An uninitialized/ zeroed mutex will go unnoticed because there is no
> > > check for it. There is a magic check in the unlock's slowpath path which
> > > might go unnoticed if the unlock happens in the fastpath.
> > > 
> > > Add a ->magic check early in the mutex_lock() and mutex_trylock() path.
> > > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > > Nothing screamed during uninitialized usage of init_mm's context->lock
> > >   https://git.kernel.org/tip/32232b350d7cd93cdc65fe5a453e6a40b539e9f9
> > > 
> > >  kernel/locking/mutex.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > > index 0c601ae072b3f..fb1f6f1e1cc61 100644
> > > --- a/kernel/locking/mutex.c
> > > +++ b/kernel/locking/mutex.c
> > > @@ -908,6 +908,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> > >  
> > >  	might_sleep();
> > >  
> > > +#ifdef CONFIG_DEBUG_MUTEXES
> > > +	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
> > > +#endif
> > 
> > Why do we need to check this so early, or could we move it into
> > debug_mutex_lock_common() instead?
> 
> debug_mutex_lock_common() is too late. A few lines later, before
> "preempt_disable()" would be possible. After that, there is
> __mutex_trylock() which would succeed so you don't catch the
> uninitialized case. By the time you get to debug_mutex_lock_common() you
> need contention and then acquire ->wait_lock which should complain about
> missing magic.

Right you are; thanks for the explanation. I don't see a better approach
than what you've done, so:

Acked-by: Will Deacon <will@kernel.org>

Will
