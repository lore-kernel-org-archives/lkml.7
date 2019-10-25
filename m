Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81430CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42720578
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438920AbfJYK05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:26:57 -0400
Received: from foss.arm.com ([217.140.110.172]:38710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438821AbfJYK05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:26:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 243FA1FB;
        Fri, 25 Oct 2019 03:26:56 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D430F3F6C4;
        Fri, 25 Oct 2019 03:26:54 -0700 (PDT)
Subject: Re: [RESEND PATCH v4] drm: Don't free jobs in
 wait_event_interruptible()
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     Sharat Masetty <smasetty@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Erico Nunes <nunes.erico@gmail.com>
References: <20191024162424.38548-1-steven.price@arm.com>
 <02be6c7e-eda9-2a5b-f553-8d82fcd84b47@amd.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <fdaebd89-ddc5-83da-687e-acf295007f31@arm.com>
Date:   Fri, 25 Oct 2019 11:26:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <02be6c7e-eda9-2a5b-f553-8d82fcd84b47@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2019 10:49, Koenig, Christian wrote:
> Am 24.10.19 um 18:24 schrieb Steven Price:
>> drm_sched_cleanup_jobs() attempts to free finished jobs, however because
>> it is called as the condition of wait_event_interruptible() it must not
>> sleep. Unfortuantly some free callbacks (notibly for Panfrost) do sleep.
>>
>> Instead let's rename drm_sched_cleanup_jobs() to
>> drm_sched_get_cleanup_job() and simply return a job for processing if
>> there is one. The caller can then call the free_job() callback outside
>> the wait_event_interruptible() where sleeping is possible before
>> re-checking and returning to sleep if necessary.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> Previous posting: https://lore.kernel.org/lkml/20190926141630.14258-1-steven.price@arm.com/
>>
>>   drivers/gpu/drm/scheduler/sched_main.c | 45 +++++++++++++++-----------
>>   1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index 9a0ee74d82dc..148468447ba9 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -622,43 +622,41 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
>>   }
>>   
>>   /**
>> - * drm_sched_cleanup_jobs - destroy finished jobs
>> + * drm_sched_get_cleanup_job - fetch the next finished job to be destroyed
>>    *
>>    * @sched: scheduler instance
>>    *
>> - * Remove all finished jobs from the mirror list and destroy them.
>> + * Returns the next finished job from the mirror list (if there is one)
>> + * ready for it to be destroyed.
>>    */
>> -static void drm_sched_cleanup_jobs(struct drm_gpu_scheduler *sched)
>> +static struct drm_sched_job *
>> +drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>>   {
>> +	struct drm_sched_job *job = NULL;
> 
> Please don't initialize job here.

Good spot, will fix.

>>   	unsigned long flags;
>>   
>>   	/* Don't destroy jobs while the timeout worker is running */
>>   	if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>>   	    !cancel_delayed_work(&sched->work_tdr))
>> -		return;
>> -
>> +		return NULL;
>>   
>> -	while (!list_empty(&sched->ring_mirror_list)) {
>> -		struct drm_sched_job *job;
>> +	spin_lock_irqsave(&sched->job_list_lock, flags);
>>   
>> -		job = list_first_entry(&sched->ring_mirror_list,
>> +	job = list_first_entry_or_null(&sched->ring_mirror_list,
>>   				       struct drm_sched_job, node);
>> -		if (!dma_fence_is_signaled(&job->s_fence->finished))
>> -			break;
>>   
>> -		spin_lock_irqsave(&sched->job_list_lock, flags);
>> +	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>>   		/* remove job from ring_mirror_list */
>>   		list_del_init(&job->node);
>> -		spin_unlock_irqrestore(&sched->job_list_lock, flags);
>> -
>> -		sched->ops->free_job(job);
>> +	} else {
>> +		job = NULL;
>> +		/* queue timeout for next job */
>> +		drm_sched_start_timeout(sched);
>>   	}
>>   
>> -	/* queue timeout for next job */
>> -	spin_lock_irqsave(&sched->job_list_lock, flags);
>> -	drm_sched_start_timeout(sched);
>>   	spin_unlock_irqrestore(&sched->job_list_lock, flags);
>>   
>> +	return job;
>>   }
>>   
>>   /**
>> @@ -698,12 +696,21 @@ static int drm_sched_main(void *param)
>>   		struct drm_sched_fence *s_fence;
>>   		struct drm_sched_job *sched_job;
>>   		struct dma_fence *fence;
>> +		struct drm_sched_job *cleanup_job = NULL;
>>   
>>   		wait_event_interruptible(sched->wake_up_worker,
>> -					 (drm_sched_cleanup_jobs(sched),
>> +					 (cleanup_job = drm_sched_get_cleanup_job(sched)) ||
>>   					 (!drm_sched_blocked(sched) &&
>>   					  (entity = drm_sched_select_entity(sched))) ||
>> -					 kthread_should_stop()));
>> +					 kthread_should_stop());
>> +
>> +		while (cleanup_job) {
> 
> Better make this just "if (cleanup_job)"... to make sure that we stop 
> immediately when the thread should stop.

Ok, no problem. Note that this is a change in behaviour (previously
drm_sched_cleanup_jobs() was called *before* checking
kthread_should_stop()). But I can't see the harm.

Steve

> Apart from that looks good to me now,
> Christian.
> 
>> +			sched->ops->free_job(cleanup_job);
>> +			/* queue timeout for next job */
>> +			drm_sched_start_timeout(sched);
>> +
>> +			cleanup_job = drm_sched_get_cleanup_job(sched);
>> +		}
>>   
>>   		if (!entity)
>>   			continue;
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

