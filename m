Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9A9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970C020692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403996AbfIJLAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:00:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63309 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfIJLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:00:50 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x8AB0T1I098839;
        Tue, 10 Sep 2019 20:00:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Tue, 10 Sep 2019 20:00:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x8AB0O8v098813
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 10 Sep 2019 20:00:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH (resend)] mm,oom: Defer dump_tasks() output.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <1567159493-5232-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <7de2310d-afbd-e616-e83a-d75103b986c6@i-love.sakura.ne.jp>
 <20190909113627.GJ27159@dhcp22.suse.cz>
 <579a27d2-52fb-207e-9278-fc20a2154394@i-love.sakura.ne.jp>
 <20190909130435.GO27159@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5bbcd93f-aa42-6c62-897a-d7b94aacdb87@i-love.sakura.ne.jp>
Date:   Tue, 10 Sep 2019 20:00:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190909130435.GO27159@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/09 22:04, Michal Hocko wrote:
> On Mon 09-09-19 21:40:24, Tetsuo Handa wrote:
>> On 2019/09/09 20:36, Michal Hocko wrote:
>>> This is not an improvement. It detaches the oom report and tasks_dump
>>> for an arbitrary amount of time because the worder context might be
>>> stalled for an arbitrary time. Even long after the oom is resolved.
>>
>> A new worker thread is created if all existing worker threads are busy
>> because this patch solves OOM situation quickly when a new worker thread
>> cannot be created due to OOM situation.
>>
>> Also, if a worker thread cannot run due to CPU starvation, the same thing
>> applies to dump_tasks(). In other words, dump_tasks() cannot complete due
>> to CPU starvation, which results in more costly and serious consequences.
>> Being able to send SIGKILL and reclaim memory as soon as possible is
>> an improvement.
> 
> There might be zillion workers waiting to make a forward progress and
> you cannot expect any timing here. Just remember your own experiments
> with xfs and low memory conditions.

Even if there were zillion workers waiting to make a forward progress, the
worker for processing dump_tasks() output can make a forward progress. That's
how workqueue works. (If you still don't trust workqueue, I can update my patch
to use a kernel thread.) And if there were zillion workers waiting to make a
forward progress, completing the OOM killer quickly will be more important than
keep blocking zillion workers waiting for the OOM killer to solve OOM situation.
Preempting a thread calling out_of_memory() by zillion workers is a nightmare. ;-)

> 
>>> Not to mention that 1:1 (oom to tasks) information dumping is
>>> fundamentally broken. Any task might be on an oom list of different
>>> OOM contexts in different oom scopes (think of OOM happening in disjunct
>>> NUMA sets).
>>
>> I can't understand what you are talking about. This patch just defers
>> printk() from /proc/sys/vm/oom_dump_tasks != 0. Please look at the patch
>> carefully. If you are saying that it is bad that OOM victim candidates for
>> OOM domain B, C, D ... cannot be printed if printing of OOM victim candidates
>> for OOM domain A has not finished, I can update this patch to print them.
> 
> You would have to track each ongoing oom context separately.

I can update my patch to track each OOM context separately. But

>                                                              And not
> only those from different oom scopes because as a matter of fact a new
> OOM might trigger before the previous dump_tasks managed to be handled.

please be aware that we are already dropping OOM messages from different scopes
due to __ratelimit(&oom_rs). The difference is, given that __ratelimit(&oom_rs)
can work, nothing but which OOM messages will be dropped when cluster of OOM
events from multiple different scopes happened.

And "OOM events from multiple different scopes can trivially happen" is a
violation for commit dc56401fc9f25e8f ("mm: oom_kill: simplify OOM killer
locking") saying

    However, the OOM killer is a fairly cold error path, there is really no
    reason to optimize for highly performant and concurrent OOM kills.

where we will need "per an OOM scope locking mechanism" in order to avoid
deferring OOM killer event in current thread's OOM scope due to processing
OOM killer events in other threads' OOM scopes.

