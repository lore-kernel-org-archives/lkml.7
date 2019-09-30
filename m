Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3907C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D050521855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbfI3NxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:53:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbfI3NxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:53:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC31E30833C1;
        Mon, 30 Sep 2019 13:53:13 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-104.rdu2.redhat.com [10.10.122.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22AED60A9D;
        Mon, 30 Sep 2019 13:53:12 +0000 (UTC)
Subject: Re: [PATCH] ipc/sem: Fix race between to-be-woken task and waker
To:     Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        1vier1@web.de
References: <20190920155402.28996-1-longman () redhat ! com>
 <d89b622a-2acf-b0a9-021d-c1c521a731f5@colorfullife.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <268f8125-1d60-a1fa-bfec-2c2763de3e55@redhat.com>
Date:   Mon, 30 Sep 2019 09:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d89b622a-2acf-b0a9-021d-c1c521a731f5@colorfullife.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 30 Sep 2019 13:53:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/19 6:24 AM, Manfred Spraul wrote:
> Hi Waiman,
>
> I have now written the mail 3 times:
> Twice I thought that I found a race, but during further analysis, it
> always turns out that the spin_lock() is sufficient.
>
> First, to avoid any obvious things: Until the series with e.g.
> 27d7be1801a4824e, there was a race inside sem_lock().
>
> Thus it was possible that multiple threads were operating on the same
> semaphore array, with obviously arbitrary impact.
>
I was saying that there was a race. It was just that my initial analysis
of the code seems to indicate a race was possible.


> On 9/20/19 5:54 PM, Waiman Long wrote:
>
>>   +        /*
>> +         * A spurious wakeup at the right moment can cause race
>> +         * between the to-be-woken task and the waker leading to
>> +         * missed wakeup. Setting state back to TASK_INTERRUPTIBLE
>> +         * before checking queue.status will ensure that the race
>> +         * won't happen.
>> +         *
>> +         *    CPU0                CPU1
>> +         *
>> +         *  <spurious wakeup>        wake_up_sem_queue_prepare():
>> +         *  state = TASK_INTERRUPTIBLE    status = error
>> +         *                try_to_wake_up():
>> +         *  smp_mb()              smp_mb()
>> +         *  if (status == -EINTR)      if (!(p->state & state))
>> +         *    schedule()            goto out
>> +         */
>> +        set_current_state(TASK_INTERRUPTIBLE);
>> +
>
> So the the hypothesis is that we have a race due to the optimization
> within try_to_wake_up():
> If the status is already TASK_RUNNING, then the wakeup is a nop.
>
> Correct?
>
> The waker wants to use:
>
>     lock();
>     set_conditions();
>     unlock();
>
> as the wake_q is a shared list, completely asynchroneously this will
> happen:
>
>     smp_mb(); //// ***1
>     if (current->state = TASK_INTERRUPTIBLE) current->state=TASK_RUNNING;
>
> The only guarantee is that this will happen after lock(), it may
> happen before set_conditions().
>
> The task that goes to sleep uses:
>
>     lock();
>     check_conditions();
>     __set_current_state();
>     unlock(); //// ***2
>     schedule();
>
> You propose to change that to:
>
>     lock();
>     set_current_state();
>     check_conditions();
>     unlock();
>     schedule();
>
> I don't see a race anymore, and I don't see how the proposed change
> will help.
> e.g.: __set_current_state() and smp_mb() have paired memory barriers
> ***1 and ***2 above. 

Now that I had taken a second look at it. I agreed that the current code
should be fine. My only comment is that we should probably add extra
comments to clarify the situation so that it won't get messed up in the
future.

Cheers,
Longman

