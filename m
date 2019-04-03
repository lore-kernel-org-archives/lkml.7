Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FA8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886DC206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDCRdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:33:08 -0400
Received: from foss.arm.com ([217.140.101.70]:45670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfDCRdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:33:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04B980D;
        Wed,  3 Apr 2019 10:33:07 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798193F68F;
        Wed,  3 Apr 2019 10:33:06 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:33:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        shenghui <shhuiw@foxmail.com>
Subject: Re: [PATCH] locking/lockdep: Zap lock classes even with lock
 debugging disabled
Message-ID: <20190403173304.GI17500@fuggles.cambridge.arm.com>
References: <20190326195912.43316-1-bvanassche@acm.org>
 <20190403124410.GE16362@fuggles.cambridge.arm.com>
 <1554306482.118779.198.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554306482.118779.198.camel@acm.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 08:48:02AM -0700, Bart Van Assche wrote:
> On Wed, 2019-04-03 at 13:44 +0100, Will Deacon wrote:
> > On Tue, Mar 26, 2019 at 12:59:12PM -0700, Bart Van Assche wrote:
> > > Commit a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer
> > > in use") changed the behavior of lockdep_free_key_range() from
> > > unconditionally zapping lock classes into only zapping lock classes if
> > > debug_lock == true. Since the new behavior can cause cat /proc/lockdep to
> > > crash due to a NULL pointer dereference, restore the pre-v5.1 behavior.
> > 
> > Can you elaborate on this NULL dereference please, and why this patch fixes
> > it?
> 
> Not zapping lock classes if debug_lock == false leaves dangling pointers in
> several lockdep datastructures, e.g. lock_class::name in the all_lock_classes
> list. The shell command "cat /proc/lockdep" causes the kernel to iterate the
> all_lock_classes list. Hence the "unable to handle kernel paging request"
> issue that Shenghui encountered by running cat /proc/lockdep. Please let me
> know if you would like me to repost this patch with a more detailed
> description.

That would help me, at least (maybe with the crash log). Thanks.

> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: shenghui <shhuiw@foxmail.com>
> > > Reported-by: shenghui <shhuiw@foxmail.com>
> > > Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use") # v5.1-rc1.
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > ---
> > >  kernel/locking/lockdep.c | 23 ++++++-----------------
> > >  1 file changed, 6 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > index 34cdcbedda49..70480e4f8f5d 100644
> > > --- a/kernel/locking/lockdep.c
> > > +++ b/kernel/locking/lockdep.c
> > > @@ -4689,8 +4689,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
> > >  		return;
> > >  
> > >  	raw_local_irq_save(flags);
> > > -	if (!graph_lock())
> > > -		goto out_irq;
> > > +	arch_spin_lock(&lockdep_lock);
> > 
> > This also throws out the recursion counting. Is that ok?
> 
> I think that that's OK. My understanding is that lockdep keeps track of
> recursion to avoid that lockdep_lock is locked recursively. However, none
> of the functions modified by this patch are called with that lock held.

Might be worth adding a comment to that effect, so people don't change that
in future.

Will
