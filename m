Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD84C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C56E21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfIZSMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbfIZSMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:12:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05E9510C0954;
        Thu, 26 Sep 2019 18:12:03 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C72271001B05;
        Thu, 26 Sep 2019 18:12:01 +0000 (UTC)
Subject: Re: [PATCH] ipc/sem: Fix race between to-be-woken task and waker
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Davidlohr Bueso <dave@stgolabs.net>, manfred@colorfullife.com
References: <20190920155402.28996-1-longman@redhat.com>
 <20190926093410.GJ4553@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d16e4d82-8c5a-0663-8c00-32f4750f8a21@redhat.com>
Date:   Thu, 26 Sep 2019 14:12:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190926093410.GJ4553@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 26 Sep 2019 18:12:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 5:34 AM, Peter Zijlstra wrote:
> On Fri, Sep 20, 2019 at 11:54:02AM -0400, Waiman Long wrote:
>> While looking at a customr bug report about potential missed wakeup in
>> the system V semaphore code, I spot a potential problem.  The fact that
>> semaphore waiter stays in TASK_RUNNING state while checking queue status
>> may lead to missed wakeup if a spurious wakeup happens in the right
>> moment as try_to_wake_up() will do nothing if the task state isn't right.
>>
>> To eliminate this possibility, the task state is now reset to
>> TASK_INTERRUPTIBLE immediately after wakeup before checking the queue
>> status. This should eliminate the race condition on the interaction
>> between the queue status and the task state and fix the potential missed
>> wakeup problem.
> Bah, this code always makes my head hurt.
>
> Yes, AFAICT the pattern it uses has been broken since 0a2b9d4c7967,
> since that removed doing the actual wakeup from under the sem_lock(),
> which is what it relies on.

After having a second look at the code again, I probably misread the
code the first time around. In the sleeping path, there is a check of
queue.status and setting of task state both under the sem lock in the
sleeping path. So as long as setting of queue status is under lock, they
should synchronize properly.

It looks like queue status setting is under lock, but I can't use
lockdep to confirm that as the locking can be done by either the array
lock or in one of the spinlocks in the array. Are you aware of a way of
doing that?

Anyway, I do think we need to add some comment to clarify the situation
to avoid future confusion.

Cheers,
Longman

