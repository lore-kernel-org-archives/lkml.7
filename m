Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4678AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9FF205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfCFSYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:24:33 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:34739 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfCFSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:24:33 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x26IOUAj061356;
        Thu, 7 Mar 2019 03:24:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Thu, 07 Mar 2019 03:24:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x26IOPSI061317
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 7 Mar 2019 03:24:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
 <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0fc95fee-8b6e-5ff0-9a91-9e0ea66028f3@i-love.sakura.ne.jp>
Date:   Thu, 7 Mar 2019 03:24:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/06 19:04, Petr Mladek wrote:
>> I'm suggesting to use a non-async printk() for $trailer_text_line line. I think
>> that changing all printk() called from out_of_memory() to async is doable, if
>> the caller of out_of_memory() wakes up a dedicated kthread described below.
> 
> This is error prone. The trailing printk is not guaranteed:
> 
>     + It might get lost by code refactoring.

Caller uses this async printk() with their own risk. This concern is same with
"buffering into on-stack 'char buf[80]' using snprintf() and forgetting to flush
it using printk()".

> 
>     + People would miss that it is needed when async printk is used
>       in a shared function, e.g. dump_stack().

I'm planning to allow async printk() for shared functions like dump_stack()
because there will be some $trailer_text_line line after such shared functions.
(By the way, for that reason, I expect that we won't do a tree-wide KERN_DEFAULT
removal so that callers can pass KERN_DEFAULT_ASYNC as an function argument to
such shared functions.)

> 
>     + People will not know that it is needed because they
>       are not familiar with the API. The would just use it
>       as part of a cargo cult programming or so.

Same with "buffering into on-stack buffer and forgetting to flush it" above.

I'm planning to allow any shared functions which can be called from e.g.
warn_alloc(), out_of_memory(), SysRq-t by allowing such shared functions
to accept loglevel argument.

> 
> For this reason, this API is a "no no no" from my side.
> 

There are two types of printk() data. One is "small/short messages but
partial/incomplete line (even if a few bytes) might be helpful" and
the other is "large/long messages but partial/incomplete line is hardly
helpful". The former uses "sync printk()s" and the latter uses "async
printk()s followed by a sync printk()". And this API is powerful for the
latter type which are called by for_each_*() pattern (e.g. dump_tasks()).

> 
> I am open to bring back discussions about a forced offload when
> a single task is blocked in console_unlock() for too long.

This is a matter of adding hints for judging which thread
(console_owner or console_waiter) should continue printing.

> 
> It might be configurable depending on the usecase. For example,
> real time kernel would be more aggressive with offloading.
> It might need to be completely disabled to debug certain
> type of problems, e.g. sudden death.
> 
> 
> But I would really like to avoid even more printk variants.
> They have many problems:
> 
>     + Only a handful of people would know how to use them right.

The caller of async printk() knows when/how to use async printk().

> 
>     + They are hard to maintain. Any incompatible printk() in the call
>       chain might break the intention.

There is no incompatible printk(). Only when to wake up a thread which
writes to consoles differs.

> 
>     + They are problematic in a shared code. Incompatible printk()
>       variants might be required/preferred according to the use case.

Again, there is no incompatible printk().

> 
>     + They might improve situation in one workload and make it
>       worse in another one.

Avoiding e.g. RCU stall / OOM stall by deferring write to consoles is
an improvement. Reducing the side effect of accumulated pending logs
is matters of "how we can try to offload to an idle thread (or utilize
idle CPUs) for writing to consoles" and "how we can try to ratelimit
appropriately".

To me, none of these concerns is a valid reason to keep "store now but
print later" prefix away.



> 
> 
>>> For example, I would stop printing allocation failures until
>>> the currently running OOM killer succeeds in freeing some memory.
>>
>> We could serialize out_of_memory() and warn_alloc(), but since warn_alloc()
>> can be called from atomic context (e.g. GFP_ATOMIC from interrupt handler)
>> while out_of_memory() is always called from schedulable context (e.g.
>> GFP_KERNEL), we can't use oom_lock mutex.
> 
> I did not mean serializing. I meant to avoid printing the warnings
> at all until OOM killer finishes its job.

But your ratelimit_reset() below requires serializing.

> 
> 
>> Also, both nopage_rs in warn_alloc() and oom_rs in oom_kill_process() are not
>> working well. This is because ___ratelimit() function assumes that operations
>> to be ratelimited complete fast enough to be able to repeat many times within
>> a second. If one operation to be ratelimited takes many seconds (or even
>> minutes), ___ratelimit() becomes always true and can not ratelimit at all.
> 
> The current ratelimiting is time driven. We might need an event
> driven variant. It might even be done with the current
> implementation if we add something like:
> 
> void ratelimit_reset(struct ratelimit_state *rs)
> {
> 	unsigned long flags;
> 
> 	raw_spin_irqsave(&rs->lock, flags);
> 
> 	rs->begin   = jiffies;
> 	rs->printed = 0;
> 
> 	raw_spin_unlock_irqrestore(&rs->lock, flags);
> }
> 
> We could call this when some event "solved" the problem.

This requires serialization among threads using "rs". I already
proposed ratelimit_reset() for memcg's OOM problem at
https://lkml.kernel.org/r/201810180246.w9I2koi3011358@www262.sakura.ne.jp
but it was not accepted.

> It means that it makes sense to enable the related
> ratelimited messages again because they would describe
> another problem.

___ratelimit() could also check number of not-yet-flushed
printk() records (e.g. log_next_seq - console_seq <= $some_threshold).

