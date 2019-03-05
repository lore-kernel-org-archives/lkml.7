Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B58A20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfCEBXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:23:07 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:24240 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEBXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:23:07 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x251N49j025692;
        Tue, 5 Mar 2019 10:23:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Tue, 05 Mar 2019 10:23:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x251N3QA025686;
        Tue, 5 Mar 2019 10:23:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x251N312025685;
        Tue, 5 Mar 2019 10:23:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201903050123.x251N312025685@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Date:   Tue, 05 Mar 2019 10:23:03 +0900
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp> <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
In-Reply-To: <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek wrote:
> On Mon 2019-03-04 20:40:37, Tetsuo Handa wrote:
> > On 2019/03/04 12:22, Sergey Senozhatsky wrote:
> > > On (02/23/19 13:42), Tetsuo Handa wrote:
> > > [..]
> > >> This patch tries to address "don't lockup the system" with minimal risk of
> > >> failing to "print out printk() messages", by allowing printk() callers to
> > >> tell printk() "store $body_text_lines lines into logbuf but start actual
> > >> printing after $trailer_text_line line is stored into logbuf". This patch
> > >> is different from existing printk_deferred(), for printk_deferred() is
> > >> intended for scheduler/timekeeping use only. Moreover, what this patch
> > >> wants to do is "do not try to print out printk() messages as soon as
> > >> possible", for accumulated stalling period cannot be decreased if
> > >> printk_deferred() from e.g. dump_tasks() from out_of_memory() immediately
> > >> prints out the messages. The point of this patch is to defer the stalling
> > >> duration to after leaving the critical section.
> > > 
> > > We can export printk deferred, I guess; but I'm not sure if it's going
> > > to be easy to switch OOM to printk_deferred - there are lots of direct
> > > printk callers: warn-s, dump_stacks, etc; it might even be simpler to
> > > start re-directing OOM printouts to printk_safe buffer.
> 
> Exactly. OOM calls many functions that are called also in other situations.
> The async messages are not pushed to the console unless someone calls
> a non-async printk.
> 
> How do you want to guarantee that the non-async printk will get called
> in all situations? The async printk() API is too error-prone.

I'm suggesting to use a non-async printk() for $trailer_text_line line. I think
that changing all printk() called from out_of_memory() to async is doable, if
the caller of out_of_memory() wakes up a dedicated kthread described below.

> 
> 
> > I confirmed that printk_deferred() is not suitable for this purpose, for
> > it suddenly stalls for seconds at random locations flushing pending output
> > accumulated by printk_deferred(). Stalling inside critical section (e.g.
> > RCU read lock held) is what I don't like.
> 
> I still do not see why your async printk should be significantly
> better than printk_deferred(). There is still a random victim
> that would be responsible to flush the messages.

I consider that a non-async printk() (or wake up a dedicated kthread) after
a series of async printk() is better than printk_deferred() because the caller
of a non-async printk() can control when to flush the messages.

> 
> It might increase the chance that it will get printed from
> normal context. But it also adds the risk that consoles
> will not get handled at all.

This "store now but print later" prefix does not decrease the chance of
failing to print, unless the messages are dropped due to out of logbuf space.
Out of logbuf space should be handled by how to keep enough interval between
calling an event that calls many printk().

We might need to tune the logic for judging which thread (console_owner
or console_waiter) should continue printing.

> 
> BTW: The comment above printk_deferred() is there for a reason.
>      It is a hack that should not be used widely.
> 
>      If you convert half printk() calls into a deferred/async
>      module, you will just get into another problems. For example,
>      not seeing the messages at all, more lost messages, random
>      victims would spend even more time with flushing to the console.
> 
>      And not. Handling all messages only from normal context
>      or from a dedicated kthread is not acceptable.

This "store now but print later" prefix does not offload to "only"
normal context or a dedicated kthread. Messages are handled by
console_owner or console_waiter. Given that the logic for judging which
thread (console_owner or console_waiter) should continue printing is
updated such that a dedicated kthread which does

	while (1) {
		wait_event();
		console_lock();
		console_unlock();
	}

will be used if the scheduler can run that kthread and that kthread can join
the judgement (and a caller which called a non-async() printk() will continue
printing if the scheduler cannot run that kthread or that kthread cannot join
the judgement for some reason).

> 
> 
> > > This is a bit of a strange issue, to be honest. If OOM prints too
> > > many messages then we might want to do some work on the OOM side.
> 
> To be honest, I am still not sure what messages we are talking about.
> Are the messages printed() from OOM killer code? Or are most of
> the messages about allocation failures?

I'm talking about the messages printed from out_of_memory().

> 
> Well, both sources of messages would deserve a revision/regulation
> if they cause such a big problem.

If the messages printed from warn_alloc() is problematic, you can propose
more drastic changes like "Remove __GFP_NOWARN and add __GFP_WARN_FAILURE"
(i.e. be silent unless explicitly be told to warn). Any !__GFP_DIRECT_RECLAIM
allocation has to be able to survive even if that allocation failed.

> 
> For example, I would stop printing allocation failures until
> the currently running OOM killer succeeds in freeing some memory.

We could serialize out_of_memory() and warn_alloc(), but since warn_alloc()
can be called from atomic context (e.g. GFP_ATOMIC from interrupt handler)
while out_of_memory() is always called from schedulable context (e.g.
GFP_KERNEL), we can't use oom_lock mutex.

Also, both nopage_rs in warn_alloc() and oom_rs in oom_kill_process() are not
working well. This is because ___ratelimit() function assumes that operations
to be ratelimited complete fast enough to be able to repeat many times within
a second. If one operation to be ratelimited takes many seconds (or even
minutes), ___ratelimit() becomes always true and can not ratelimit at all.

Using async printk() in out_of_memory() and warn_alloc() would allow such
serialization. And ratelimiting without using nopage_rs/oom_rs (e.g. monitor
how many printk() messages are waiting to be flushed) would allow moderate
output.

> It might print a message about that all further allocation
> failures will not get reported and then another message
> about the success...

Are you talking about allocation failure messages from console drivers
when called from printk() ?
