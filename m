Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494E9C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254C720B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440443AbfIWTYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:24:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:54494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440392AbfIWTYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:24:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F23CAD72;
        Mon, 23 Sep 2019 19:23:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Sep 2019 21:23:57 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jason Baron <jbaron@akamai.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] epoll: simplify ep_poll_safewake() for
 CONFIG_DEBUG_LOCK_ALLOC
In-Reply-To: <a07adc0e-590e-623c-3c80-e28af39bd19c@akamai.com>
References: <1567628549-11501-1-git-send-email-jbaron@akamai.com>
 <a07adc0e-590e-623c-3c80-e28af39bd19c@akamai.com>
Message-ID: <1b26e25fcc0e6c54cbdb9e66dade17db@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-23 17:43, Jason Baron wrote:
> On 9/4/19 4:22 PM, Jason Baron wrote:
>> Currently, ep_poll_safewake() in the CONFIG_DEBUG_LOCK_ALLOC case uses
>> ep_call_nested() in order to pass the correct subclass argument to
>> spin_lock_irqsave_nested(). However, ep_call_nested() adds unnecessary
>> checks for epoll depth and loops that are already verified when doing
>> EPOLL_CTL_ADD. This mirrors a conversion that was done for
>> !CONFIG_DEBUG_LOCK_ALLOC in: commit 37b5e5212a44 ("epoll: remove
>> ep_call_nested() from ep_eventpoll_poll()")
>> 
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Roman Penyaev <rpenyaev@suse.de>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Eric Wong <normalperson@yhbt.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>  fs/eventpoll.c | 36 +++++++++++++-----------------------
>>  1 file changed, 13 insertions(+), 23 deletions(-)
>> 
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index d7f1f50..a9b2737 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -551,28 +551,23 @@ static int ep_call_nested(struct nested_calls 
>> *ncalls,
>>   */
>>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>> 
>> -static struct nested_calls poll_safewake_ncalls;
>> -
>> -static int ep_poll_wakeup_proc(void *priv, void *cookie, int 
>> call_nests)
>> -{
>> -	unsigned long flags;
>> -	wait_queue_head_t *wqueue = (wait_queue_head_t *)cookie;
>> -
>> -	spin_lock_irqsave_nested(&wqueue->lock, flags, call_nests + 1);
>> -	wake_up_locked_poll(wqueue, EPOLLIN);
>> -	spin_unlock_irqrestore(&wqueue->lock, flags);
>> -
>> -	return 0;
>> -}
>> +static DEFINE_PER_CPU(int, wakeup_nest);
>> 
>>  static void ep_poll_safewake(wait_queue_head_t *wq)
>>  {
>> -	int this_cpu = get_cpu();
>> -
>> -	ep_call_nested(&poll_safewake_ncalls,
>> -		       ep_poll_wakeup_proc, NULL, wq, (void *) (long) this_cpu);
>> +	unsigned long flags;
>> +	int subclass;
>> 
>> -	put_cpu();
>> +	local_irq_save(flags);
>> +	preempt_disable();
>> +	subclass = __this_cpu_read(wakeup_nest);
>> +	spin_lock_nested(&wq->lock, subclass + 1);
>> +	__this_cpu_inc(wakeup_nest);
>> +	wake_up_locked_poll(wq, POLLIN);
>> +	__this_cpu_dec(wakeup_nest);
>> +	spin_unlock(&wq->lock);
>> +	local_irq_restore(flags);
>> +	preempt_enable();
>>  }

What if reduce number of lines with something as the following:

    int this_cpu = get_cpu();
    subclass = __this_cpu_inc_return(wakeup_nest);
    spin_lock_irqsave_nested(&wq->lock, flags, subclass);
    wake_up_locked_poll(wq, POLLIN);
    spin_unlock_irqrestore(&wq->lock, flags);
    __this_cpu_dec(wakeup_nest);
    put_cpu();

Other than that looks good to me.

Reviewed-by: Roman Penyaev <rpenyaev@suse.de>

--
Roman
