Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4F4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 04:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B22520872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 04:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="oymOPry8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfI0E7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 00:59:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42228 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfI0E7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 00:59:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so1099996wrw.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7o+HFvKSNQ5oJ5tFqhVjK+U9JWFrtSKKUcXzUhEqHhs=;
        b=oymOPry8JuBH0d6tp74kJY5KqOT/efHAxxVgcOqznNkj3/sPSqUY9uc7Rm/JnFbV3T
         yVXt8Wgn16t6CDD8H/af+HvG2QgLesNxmFlKCvOWLURgDvkVdihi7E9hcXBMV2nLtG8i
         vobXqaMSVzP0J9t1Xq0qhRhNHg9HWitmTp/7xa16nmuQbNfjV089vVgrzEOW4C2YhfUN
         SJd8oMPTXCQhaCiYOoFR5Gv9MXLYy+bQIwqHNfM2UWVnzLPUfl9Yr+KD/f2UBw6na42Z
         dkIbPfrVcBKv0ZqiDeKgteYeLL/uqyCNzxgfE16qbszVDHQ8Fy5v02T1whzWGjH3+1OX
         2cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7o+HFvKSNQ5oJ5tFqhVjK+U9JWFrtSKKUcXzUhEqHhs=;
        b=ZmZeacvs6aDJcZmdKyXsDJA+144lPujxkXX/+XhGqKhAnvoyCLZSRKHu48VXZnaTeW
         FiBAvyGFTdzYrX6ajP1glzHlBS7ES8Jz9Q+1KdgI0TWP2YuZUOSStCu8QABdJ5BOFHPE
         lsRZHJ5oMTJ8D2FZgVo9xce16bRTquzue7VK1yWHJvTF9zkzIDwcCyW9dcREdsEZuopH
         SQr4cxnOPUDd+Z6O/QeyfZeV6C+hyzq51j4xN3ZjXUwDzoKz+j/D5xFwCa3E63tqc94N
         3O9hTbuBODkSgC39NgExtZGK9ocedCjdl7kJW92PuujRMgaZvZjiL0b0gxol+xz+qSSA
         NowA==
X-Gm-Message-State: APjAAAUnUE5MOOc89QDcB5FHJKSN1Gn9UlOsHF/N3oEc52+a3UbL05Yh
        lLddmaaIYioS+mf910Nh2EuRxw==
X-Google-Smtp-Source: APXvYqz0GikICQtmXCafvpDv4lL4zE8uWbmys0sWmzqfeMz1L3Oux8DwhOPXBdK5sFbuxmg8SGAJGA==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr1227882wro.127.1569560344968;
        Thu, 26 Sep 2019 21:59:04 -0700 (PDT)
Received: from linux.fritz.box (p200300D99708FF00061B60AEAF03373A.dip0.t-ipconnect.de. [2003:d9:9708:ff00:61b:60ae:af03:373a])
        by smtp.googlemail.com with ESMTPSA id r20sm1479204wrg.61.2019.09.26.21.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 21:59:04 -0700 (PDT)
Subject: Re: [PATCH] ipc/sem: Fix race between to-be-woken task and waker
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <20190920155402.28996-1-longman@redhat.com>
 <20190926093410.GJ4553@hirez.programming.kicks-ass.net>
 <d16e4d82-8c5a-0663-8c00-32f4750f8a21@redhat.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <6a65bfcc-661a-5ca5-86d6-0b4614f6aeea@colorfullife.com>
Date:   Fri, 27 Sep 2019 06:59:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d16e4d82-8c5a-0663-8c00-32f4750f8a21@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 9/26/19 8:12 PM, Waiman Long wrote:
> On 9/26/19 5:34 AM, Peter Zijlstra wrote:
>> On Fri, Sep 20, 2019 at 11:54:02AM -0400, Waiman Long wrote:
>>> While looking at a customr bug report about potential missed wakeup in
>>> the system V semaphore code, I spot a potential problem.  The fact that
>>> semaphore waiter stays in TASK_RUNNING state while checking queue status
>>> may lead to missed wakeup if a spurious wakeup happens in the right
>>> moment as try_to_wake_up() will do nothing if the task state isn't right.
>>>
>>> To eliminate this possibility, the task state is now reset to
>>> TASK_INTERRUPTIBLE immediately after wakeup before checking the queue
>>> status. This should eliminate the race condition on the interaction
>>> between the queue status and the task state and fix the potential missed
>>> wakeup problem.
You are obviously right, there is a huge race condition.
>> Bah, this code always makes my head hurt.
>>
>> Yes, AFAICT the pattern it uses has been broken since 0a2b9d4c7967,
>> since that removed doing the actual wakeup from under the sem_lock(),
>> which is what it relies on.

Correct - I've overlooked that.

First, theory:

setting queue->status, reading queue->status, setting 
current->state=TASK_INTERRUPTIBLE are all under the correct spinlock.

(there is an opportunistic read of queue->status without locks, but it 
is retried when the lock got acquired)

setting current->state=RUNNING is outside of any lock.

So as far as current->state is concerned, the lock doesn't exist. And if 
the lock doesn't exist, we must follow the rules applicable for 
set_current_state().

I'll try to check the code this week.

And we should check the remaining wake-queue users, the logic is 
everywhere identical.

> After having a second look at the code again, I probably misread the
> code the first time around. In the sleeping path, there is a check of
> queue.status and setting of task state both under the sem lock in the
> sleeping path. So as long as setting of queue status is under lock, they
> should synchronize properly.
>
> It looks like queue status setting is under lock, but I can't use
> lockdep to confirm that as the locking can be done by either the array
> lock or in one of the spinlocks in the array. Are you aware of a way of
> doing that?

For testing? Have you considered just always using the global lock?

(untested):

--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -370,7 +370,7 @@ static inline int sem_lock(struct sem_array *sma, 
struct sembuf *sops,
         struct sem *sem;
         int idx;

-       if (nsops != 1) {
+       if (nsops != 1 || 1) {
                 /* Complex operation - acquire a full lock */
                 ipc_lock_object(&sma->sem_perm);


> Anyway, I do think we need to add some comment to clarify the situation
> to avoid future confusion.

Around line 190 is the comment that explains locking & memory ordering.

I have only documented the content of sem_undo and sem_array, but 
neither queue nor current->state :-(


--

     Manfred


