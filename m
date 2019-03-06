Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7439BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D90A20657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfCFKEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:04:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:42928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfCFKEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:04:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E28FAFCC;
        Wed,  6 Mar 2019 10:04:05 +0000 (UTC)
Date:   Wed, 6 Mar 2019 11:04:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903050123.x251N312025685@www262.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-03-05 10:23:03, Tetsuo Handa wrote:
> Petr Mladek wrote:
> > On Mon 2019-03-04 20:40:37, Tetsuo Handa wrote:
> > > On 2019/03/04 12:22, Sergey Senozhatsky wrote:
> > > > On (02/23/19 13:42), Tetsuo Handa wrote:
> > > > [..]
> > > >> This patch tries to address "don't lockup the system" with minimal risk of
> > > >> failing to "print out printk() messages", by allowing printk() callers to
> > > >> tell printk() "store $body_text_lines lines into logbuf but start actual
> > > >> printing after $trailer_text_line line is stored into logbuf". This patch
> > > >> is different from existing printk_deferred(), for printk_deferred() is
> > > >> intended for scheduler/timekeeping use only. Moreover, what this patch
> > > >> wants to do is "do not try to print out printk() messages as soon as
> > > >> possible", for accumulated stalling period cannot be decreased if
> > > >> printk_deferred() from e.g. dump_tasks() from out_of_memory() immediately
> > > >> prints out the messages. The point of this patch is to defer the stalling
> > > >> duration to after leaving the critical section.
> > > > 
> > > > We can export printk deferred, I guess; but I'm not sure if it's going
> > > > to be easy to switch OOM to printk_deferred - there are lots of direct
> > > > printk callers: warn-s, dump_stacks, etc; it might even be simpler to
> > > > start re-directing OOM printouts to printk_safe buffer.
> > 
> > Exactly. OOM calls many functions that are called also in other situations.
> > The async messages are not pushed to the console unless someone calls
> > a non-async printk.
> > 
> > How do you want to guarantee that the non-async printk will get called
> > in all situations? The async printk() API is too error-prone.
> 
> I'm suggesting to use a non-async printk() for $trailer_text_line line. I think
> that changing all printk() called from out_of_memory() to async is doable, if
> the caller of out_of_memory() wakes up a dedicated kthread described below.

This is error prone. The trailing printk is not guaranteed:

    + It might get lost by code refactoring.

    + People would miss that it is needed when async printk is used
      in a shared function, e.g. dump_stack().

    + People will not know that it is needed because they
      are not familiar with the API. The would just use it
      as part of a cargo cult programming or so.

For this reason, this API is a "no no no" from my side.


I am open to bring back discussions about a forced offload when
a single task is blocked in console_unlock() for too long.

It might be configurable depending on the usecase. For example,
real time kernel would be more aggressive with offloading.
It might need to be completely disabled to debug certain
type of problems, e.g. sudden death.


But I would really like to avoid even more printk variants.
They have many problems:

    + Only a handful of people would know how to use them right.

    + They are hard to maintain. Any incompatible printk() in the call
      chain might break the intention.

    + They are problematic in a shared code. Incompatible printk()
      variants might be required/preferred according to the use case.

    + They might improve situation in one workload and make it
      worse in another one.


> > For example, I would stop printing allocation failures until
> > the currently running OOM killer succeeds in freeing some memory.
> 
> We could serialize out_of_memory() and warn_alloc(), but since warn_alloc()
> can be called from atomic context (e.g. GFP_ATOMIC from interrupt handler)
> while out_of_memory() is always called from schedulable context (e.g.
> GFP_KERNEL), we can't use oom_lock mutex.

I did not mean serializing. I meant to avoid printing the warnings
at all until OOM killer finishes its job.


> Also, both nopage_rs in warn_alloc() and oom_rs in oom_kill_process() are not
> working well. This is because ___ratelimit() function assumes that operations
> to be ratelimited complete fast enough to be able to repeat many times within
> a second. If one operation to be ratelimited takes many seconds (or even
> minutes), ___ratelimit() becomes always true and can not ratelimit at all.

The current ratelimiting is time driven. We might need an event
driven variant. It might even be done with the current
implementation if we add something like:

void ratelimit_reset(struct ratelimit_state *rs)
{
	unsigned long flags;

	raw_spin_irqsave(&rs->lock, flags);

	rs->begin   = jiffies;
	rs->printed = 0;

	raw_spin_unlock_irqrestore(&rs->lock, flags);
}

We could call this when some event "solved" the problem.
It means that it makes sense to enable the related
ratelimited messages again because they would describe
another problem.

Best Regards,
Petr
