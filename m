Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B8BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D475420659
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfJGQON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:14:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59936 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:14:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id BF4A528F0B1
Subject: Re: [PATCH] drm/panfrost: Handle resetting on timeout better
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191007125014.12595-1-steven.price@arm.com>
 <81430487-0aa0-8c93-653f-d7a608f3dbff@baylibre.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <4fae2d1e-e399-9e2b-60dc-b8a78333845f@collabora.com>
Date:   Mon, 7 Oct 2019 09:14:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <81430487-0aa0-8c93-653f-d7a608f3dbff@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/19 6:09 AM, Neil Armstrong wrote:
> Hi Steven,
> 
> On 07/10/2019 14:50, Steven Price wrote:
>> Panfrost uses multiple schedulers (one for each slot, so 2 in reality),
>> and on a timeout has to stop all the schedulers to safely perform a
>> reset. However more than one scheduler can trigger a timeout at the same
>> time. This race condition results in jobs being freed while they are
>> still in use.
>>
>> When stopping other slots use cancel_delayed_work_sync() to ensure that
>> any timeout started for that slot has completed. Also use
>> mutex_trylock() to obtain reset_lock. This means that only one thread
>> attempts the reset, the other threads will simply complete without doing
>> anything (the first thread will wait for this in the call to
>> cancel_delayed_work_sync()).
>>
>> While we're here and since the function is already dependent on
>> sched_job not being NULL, let's remove the unnecessary checks, along
>> with a commented out call to panfrost_core_dump() which has never
>> existed in mainline.
>>
> 
> A Fixes: tags would be welcome here so it would be backported to v5.3
> 
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> This is a tidied up version of the patch orginally posted here:
>> http://lkml.kernel.org/r/26ae2a4d-8df1-e8db-3060-41638ed63e2a%40arm.com
>>
>>   drivers/gpu/drm/panfrost/panfrost_job.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
>> index a58551668d9a..dcc9a7603685 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>> @@ -381,13 +381,19 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
>>   		job_read(pfdev, JS_TAIL_LO(js)),
>>   		sched_job);
>>   
>> -	mutex_lock(&pfdev->reset_lock);
>> +	if (!mutex_trylock(&pfdev->reset_lock))
>> +		return;
>>   
>> -	for (i = 0; i < NUM_JOB_SLOTS; i++)
>> -		drm_sched_stop(&pfdev->js->queue[i].sched, sched_job);
>> +	for (i = 0; i < NUM_JOB_SLOTS; i++) {
>> +		struct drm_gpu_scheduler *sched = &pfdev->js->queue[i].sched;
>> +
>> +		drm_sched_stop(sched, sched_job);
>> +		if (js != i)
>> +			/* Ensure any timeouts on other slots have finished */
>> +			cancel_delayed_work_sync(&sched->work_tdr);
>> +	}
>>   
>> -	if (sched_job)
>> -		drm_sched_increase_karma(sched_job);
>> +	drm_sched_increase_karma(sched_job);
> 
> Indeed looks cleaner.
> 
>>   
>>   	spin_lock_irqsave(&pfdev->js->job_lock, flags);
>>   	for (i = 0; i < NUM_JOB_SLOTS; i++) {
>> @@ -398,7 +404,6 @@ static void panfrost_job_timedout(struct drm_sched_job *sched_job)
>>   	}
>>   	spin_unlock_irqrestore(&pfdev->js->job_lock, flags);
>>   
>> -	/* panfrost_core_dump(pfdev); */
> 
> This should be cleaned in another patch !

Seems to me that this should be some kind of TODO, see 
etnaviv_core_dump() for the kind of things we could be doing.

Maybe we can delete this line and mention this in the TODO file?

Cheers,

Tomeu

>>   
>>   	panfrost_devfreq_record_transition(pfdev, js);
>>   	panfrost_device_reset(pfdev);
>>
> 
> Thanks,
> Testing it right now with the last change removed (doesn't apply on v5.3 with it),
> results in a few hours... or minutes !
> 
> 
> Neil
> 
