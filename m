Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD28DECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A342067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="wn6ZqUtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfJNSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:06:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34794 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbfJNSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:06:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so20805074wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=d8qguTNaXd9xxzskZ/Dz2SrzHXRZLxG/w2gsuCMt93M=;
        b=wn6ZqUtp45aInNmoFktexEPADp4TBr0iWmSKfbRi7fCYk1IuNRM9uh+WQ8yO+SM5W2
         ZdqrnCLF2d0qTbIqlPknJVP8Yk34WXE+KGIpeTb7/diwcHu8XcdBB96/24uGpDfPU7ik
         YuqjmiM+XnKmjw44IunG15FoHBcmHGQnPn2kpgvFUTJI3QIcdRsX4pmn4hpLAPX2TMrU
         Fp4Yyw9DtLgWteU4yHz3qLCvjxxqGph9JtoSxLAHnPX/O/b9lEte5L07eNUDS1obpipn
         /cHnBrqiy6r4opnAhatCdebunBzIcLBvrNQOsNnMC5KE5YLW+X6s4oMSIMXE8Hg2n83b
         zkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=d8qguTNaXd9xxzskZ/Dz2SrzHXRZLxG/w2gsuCMt93M=;
        b=uXpuZwSZ2kVuq4eyZSV6HVMk9F0PDzRSVatocGGqwXuPCmtxc4NZY19Oq8n8J/FkvJ
         MIhAT9PVi7Q+U/mS5hguwKkaSU7Xlmp4edOc4K4p4nKjpdtiKaQiRbrZIf+ovSrXQzEz
         Cwftir+RsEbqCYgS/nVihnp77rUkhlGzPplu7OZJsi5xGpZEPc8bT7hS9LmP+zge9Nfl
         49wEbPe0eqq2+ORosdg4FLec+NlSKpno09mBLKTukEVFTCtSQjxPs62U3Ef//zv2nCmQ
         qt0pvaUJMoycAXW2Le3m8SfNQ9+mzTMd7AxQ1tt98yjtt99RpwxNZlHHdAmRpUY2ZbYo
         +itg==
X-Gm-Message-State: APjAAAWtQ990eyLythPPPWjlWTmr1f8NnI4EaaM0g1wE16Cn4MqKehls
        Em0wktStMdizkYwazFttXsOPZg==
X-Google-Smtp-Source: APXvYqz2tD7rVwm4Mxl2WDgKpvhyJXoU3WYSHvcRkx8K+zPUSp8bUBjZzi666/4MKX+H5GO1Ne5Bvw==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr13793254wrj.268.1571076404973;
        Mon, 14 Oct 2019 11:06:44 -0700 (PDT)
Received: from linux.fritz.box (p200300D997049C00EA2FE58343581C38.dip0.t-ipconnect.de. [2003:d9:9704:9c00:ea2f:e583:4358:1c38])
        by smtp.googlemail.com with ESMTPSA id q19sm38062085wra.89.2019.10.14.11.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 11:06:44 -0700 (PDT)
Subject: Re: [PATCH 3/6] ipc/mqueue.c: Update/document memory barriers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20191012054958.3624-1-manfred@colorfullife.com>
 <20191012054958.3624-4-manfred@colorfullife.com>
 <20191014125911.GF2328@hirez.programming.kicks-ass.net>
 <20191014135832.GO2359@hirez.programming.kicks-ass.net>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <575dbddb-355c-f667-92ca-d39b893c5ab1@colorfullife.com>
Date:   Mon, 14 Oct 2019 20:06:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014135832.GO2359@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/14/19 3:58 PM, Peter Zijlstra wrote:
> On Mon, Oct 14, 2019 at 02:59:11PM +0200, Peter Zijlstra wrote:
>> On Sat, Oct 12, 2019 at 07:49:55AM +0200, Manfred Spraul wrote:
>>
>>>   	for (;;) {
>>> +		/* memory barrier not required, we hold info->lock */
>>>   		__set_current_state(TASK_INTERRUPTIBLE);
>>>   
>>>   		spin_unlock(&info->lock);
>>>   		time = schedule_hrtimeout_range_clock(timeout, 0,
>>>   			HRTIMER_MODE_ABS, CLOCK_REALTIME);
>>>   
>>> +		if (READ_ONCE(ewp->state) == STATE_READY) {
>>> +			/*
>>> +			 * Pairs, together with READ_ONCE(), with
>>> +			 * the barrier in __pipelined_op().
>>> +			 */
>>> +			smp_acquire__after_ctrl_dep();
>>>   			retval = 0;
>>>   			goto out;
>>>   		}
>>>   		spin_lock(&info->lock);
>>> +
>>> +		/* we hold info->lock, so no memory barrier required */
>>> +		if (READ_ONCE(ewp->state) == STATE_READY) {
>>>   			retval = 0;
>>>   			goto out_unlock;
>>>   		}
>>> @@ -925,14 +933,12 @@ static inline void __pipelined_op(struct wake_q_head *wake_q,
>>>   	list_del(&this->list);
>>>   	wake_q_add(wake_q, this->task);
>>>   	/*
>>> +	 * The barrier is required to ensure that the refcount increase
>>> +	 * inside wake_q_add() is completed before the state is updated.
>> fails to explain *why* this is important.
>>
>>> +	 *
>>> +	 * The barrier pairs with READ_ONCE()+smp_mb__after_ctrl_dep().
>>>   	 */
>>> +        smp_store_release(&this->state, STATE_READY);
>> You retained the whitespace damage.
>>
>> And I'm terribly confused by this code, probably due to the lack of
>> 'why' as per the above. What is this trying to do?
>>
>> Are we worried about something like:
>>
>> 	A			B				C
>>
>>
>> 				wq_sleep()
>> 				  schedule_...();
>>
>> 								/* spuriuos wakeup */
>> 								wake_up_process(B)
>>
>> 	wake_q_add(A)
>> 	  if (cmpxchg()) // success
>>
>> 	->state = STATE_READY (reordered)
>>
>> 				  if (READ_ONCE() == STATE_READY)
>> 				    goto out;
>>
>> 				exit();
>>
>>
>> 	    get_task_struct() // UaF
>>
>>
>> Can we put the exact and full race in the comment please?

Yes, I'll do that. Actually, two threads are sufficient:

A                    B

WRITE_ONCE(wait.state, STATE_NONE);
schedule_hrtimeout()

                       wake_q_add(A)
                       if (cmpxchg()) // success
                       ->state = STATE_READY (reordered)

<timeout returns>
if (wait.state == STATE_READY) return;
sysret to user space
sys_exit()

                       get_task_struct() // UaF


> Like Davidlohr already suggested, elsewhere we write it like so:
>
>
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -930,15 +930,10 @@ static inline void __pipelined_op(struct
>   				  struct mqueue_inode_info *info,
>   				  struct ext_wait_queue *this)
>   {
> +	get_task_struct(this->task);
>   	list_del(&this->list);
> -	wake_q_add(wake_q, this->task);
> -	/*
> -	 * The barrier is required to ensure that the refcount increase
> -	 * inside wake_q_add() is completed before the state is updated.
> -	 *
> -	 * The barrier pairs with READ_ONCE()+smp_mb__after_ctrl_dep().
> -	 */
> -        smp_store_release(&this->state, STATE_READY);
> +	smp_store_release(&this->state, STATE_READY);
> +	wake_q_add_safe(wake_q, this->task);
>   }
>   
>   /* pipelined_send() - send a message directly to the task waiting in

Much better, I'll rewrite it and then resend the series.

--

     Manfred

