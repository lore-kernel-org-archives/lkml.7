Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74222C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD5120673
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfJIJmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:42:32 -0400
Received: from foss.arm.com ([217.140.110.172]:58220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfJIJmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:42:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BDBB28;
        Wed,  9 Oct 2019 02:42:31 -0700 (PDT)
Received: from [10.1.196.133] (unknown [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669753F68E;
        Wed,  9 Oct 2019 02:42:30 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Handle resetting on timeout better
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191007125014.12595-1-steven.price@arm.com>
 <81430487-0aa0-8c93-653f-d7a608f3dbff@baylibre.com>
 <4fae2d1e-e399-9e2b-60dc-b8a78333845f@collabora.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f31bc3f1-bf51-d406-01a6-8bd29e5518b7@arm.com>
Date:   Wed, 9 Oct 2019 10:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4fae2d1e-e399-9e2b-60dc-b8a78333845f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 17:14, Tomeu Vizoso wrote:
> On 10/7/19 6:09 AM, Neil Armstrong wrote:
>> Hi Steven,
>>
>> On 07/10/2019 14:50, Steven Price wrote:
>>> Panfrost uses multiple schedulers (one for each slot, so 2 in reality),
>>> and on a timeout has to stop all the schedulers to safely perform a
>>> reset. However more than one scheduler can trigger a timeout at the same
>>> time. This race condition results in jobs being freed while they are
>>> still in use.
>>>
>>> When stopping other slots use cancel_delayed_work_sync() to ensure that
>>> any timeout started for that slot has completed. Also use
>>> mutex_trylock() to obtain reset_lock. This means that only one thread
>>> attempts the reset, the other threads will simply complete without doing
>>> anything (the first thread will wait for this in the call to
>>> cancel_delayed_work_sync()).
>>>
>>> While we're here and since the function is already dependent on
>>> sched_job not being NULL, let's remove the unnecessary checks, along
>>> with a commented out call to panfrost_core_dump() which has never
>>> existed in mainline.
>>>
>>
>> A Fixes: tags would be welcome here so it would be backported to v5.3
>>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>> This is a tidied up version of the patch orginally posted here:
>>> http://lkml.kernel.org/r/26ae2a4d-8df1-e8db-3060-41638ed63e2a%40arm.com
>>>
>>>   drivers/gpu/drm/panfrost/panfrost_job.c | 17 +++++++++++------
>>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c
>>> b/drivers/gpu/drm/panfrost/panfrost_job.c
>>> index a58551668d9a..dcc9a7603685 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>>> @@ -381,13 +381,19 @@ static void panfrost_job_timedout(struct
>>> drm_sched_job *sched_job)
>>>           job_read(pfdev, JS_TAIL_LO(js)),
>>>           sched_job);
>>>   -    mutex_lock(&pfdev->reset_lock);
>>> +    if (!mutex_trylock(&pfdev->reset_lock))
>>> +        return;
>>>   -    for (i = 0; i < NUM_JOB_SLOTS; i++)
>>> -        drm_sched_stop(&pfdev->js->queue[i].sched, sched_job);
>>> +    for (i = 0; i < NUM_JOB_SLOTS; i++) {
>>> +        struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
>>> +
>>> +        drm_sched_stop(sched, sched_job);
>>> +        if (js != i)
>>> +            /* Ensure any timeouts on other slots have finished */
>>> +            cancel_delayed_work_sync(&sched->work_tdr);
>>> +    }
>>>   -    if (sched_job)
>>> -        drm_sched_increase_karma(sched_job);
>>> +    drm_sched_increase_karma(sched_job);
>>
>> Indeed looks cleaner.
>>
>>>         spin_lock_irqsave(&pfdev->js->job_lock, flags);
>>>       for (i = 0; i < NUM_JOB_SLOTS; i++) {
>>> @@ -398,7 +404,6 @@ static void panfrost_job_timedout(struct
>>> drm_sched_job *sched_job)
>>>       }
>>>       spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
>>>   -    /* panfrost_core_dump(pfdev); */
>>
>> This should be cleaned in another patch !
> 
> Seems to me that this should be some kind of TODO, see
> etnaviv_core_dump() for the kind of things we could be doing.
> 
> Maybe we can delete this line and mention this in the TODO file?

Fair enough - I'll split this into a separate patch and add an entry to
the TODO file. kbase has a mechanism to "dump on job fault" [1],[2] so
we could do something similar.

Steve

[1]
https://gitlab.freedesktop.org/panfrost/mali_kbase/blob/master/driver/product/kernel/drivers/gpu/arm/midgard/backend/gpu/mali_kbase_debug_job_fault_backend.c

[2]
https://gitlab.freedesktop.org/panfrost/mali_kbase/blob/master/driver/product/kernel/drivers/gpu/arm/midgard/mali_kbase_debug_job_fault.c

> Cheers,
> 
> Tomeu
> 
>>>         panfrost_devfreq_record_transition(pfdev, js);
>>>       panfrost_device_reset(pfdev);
>>>
>>
>> Thanks,
>> Testing it right now with the last change removed (doesn't apply on
>> v5.3 with it),
>> results in a few hours... or minutes !
>>
>>
>> Neil
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

