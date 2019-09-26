Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFC7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57FD222C6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfIZP77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:59:59 -0400
Received: from foss.arm.com ([217.140.110.172]:53714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfIZP76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:59:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7AB428;
        Thu, 26 Sep 2019 08:59:57 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70FA43F534;
        Thu, 26 Sep 2019 08:59:56 -0700 (PDT)
Subject: Re: [PATCH v4] drm: Don't free jobs in wait_event_interruptible()
To:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20190926141630.14258-1-steven.price@arm.com>
 <b457a269-4aa9-7e3b-283e-b4920455e396@amd.com>
 <48214f02-e853-015f-55cc-397c7b06cb5d@arm.com>
 <b4713fe7-80d4-4706-206e-f4786a70e70b@amd.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d13b3648-c7a5-1ef9-20c4-c327b15f1e4a@arm.com>
Date:   Thu, 26 Sep 2019 16:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b4713fe7-80d4-4706-206e-f4786a70e70b@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2019 16:48, Grodzovsky, Andrey wrote:
> 
> On 9/26/19 11:23 AM, Steven Price wrote:
>> On 26/09/2019 16:14, Grodzovsky, Andrey wrote:
>>> On 9/26/19 10:16 AM, Steven Price wrote:
>>>> drm_sched_cleanup_jobs() attempts to free finished jobs, however because
>>>> it is called as the condition of wait_event_interruptible() it must not
>>>> sleep. Unfortuantly some free callbacks (notibly for Panfrost) do sleep.
>>>>
>>>> Instead let's rename drm_sched_cleanup_jobs() to
>>>> drm_sched_get_cleanup_job() and simply return a job for processing if
>>>> there is one. The caller can then call the free_job() callback outside
>>>> the wait_event_interruptible() where sleeping is possible before
>>>> re-checking and returning to sleep if necessary.
>>>>
>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>> ---
>>>> Changes from v3:
>>>>    * drm_sched_main() re-arms the timeout for the next job after calling
>>>>      free_job()
>>>>
>>>>    drivers/gpu/drm/scheduler/sched_main.c | 45 +++++++++++++++-----------
>>>>    1 file changed, 26 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>>> index 9a0ee74d82dc..148468447ba9 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>> @@ -622,43 +622,41 @@ static void drm_sched_process_job(struct dma_fence *f, struct dma_fence_cb *cb)
>>>>    }
>>>>    
>>>>    /**
>>>> - * drm_sched_cleanup_jobs - destroy finished jobs
>>>> + * drm_sched_get_cleanup_job - fetch the next finished job to be destroyed
>>>>     *
>>>>     * @sched: scheduler instance
>>>>     *
>>>> - * Remove all finished jobs from the mirror list and destroy them.
>>>> + * Returns the next finished job from the mirror list (if there is one)
>>>> + * ready for it to be destroyed.
>>>>     */
>>>> -static void drm_sched_cleanup_jobs(struct drm_gpu_scheduler *sched)
>>>> +static struct drm_sched_job *
>>>> +drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>>>>    {
>>>> +	struct drm_sched_job *job = NULL;
>>>>    	unsigned long flags;
>>>>    
>>>>    	/* Don't destroy jobs while the timeout worker is running */
>>>>    	if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>>>>    	    !cancel_delayed_work(&sched->work_tdr))
>>>> -		return;
>>>> -
>>>> +		return NULL;
>>>>    
>>>> -	while (!list_empty(&sched->ring_mirror_list)) {
>>>> -		struct drm_sched_job *job;
>>>> +	spin_lock_irqsave(&sched->job_list_lock, flags);
>>>>    
>>>> -		job = list_first_entry(&sched->ring_mirror_list,
>>>> +	job = list_first_entry_or_null(&sched->ring_mirror_list,
>>>>    				       struct drm_sched_job, node);
>>>> -		if (!dma_fence_is_signaled(&job->s_fence->finished))
>>>> -			break;
>>>>    
>>>> -		spin_lock_irqsave(&sched->job_list_lock, flags);
>>>> +	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>>>>    		/* remove job from ring_mirror_list */
>>>>    		list_del_init(&job->node);
>>>> -		spin_unlock_irqrestore(&sched->job_list_lock, flags);
>>>> -
>>>> -		sched->ops->free_job(job);
>>>> +	} else {
>>>> +		job = NULL;
>>>> +		/* queue timeout for next job */
>>>> +		drm_sched_start_timeout(sched);
>>>>    	}
>>>>    
>>>> -	/* queue timeout for next job */
>>>> -	spin_lock_irqsave(&sched->job_list_lock, flags);
>>>> -	drm_sched_start_timeout(sched);
>>>>    	spin_unlock_irqrestore(&sched->job_list_lock, flags);
>>>>    
>>>> +	return job;
>>>>    }
>>>>    
>>>>    /**
>>>> @@ -698,12 +696,21 @@ static int drm_sched_main(void *param)
>>>>    		struct drm_sched_fence *s_fence;
>>>>    		struct drm_sched_job *sched_job;
>>>>    		struct dma_fence *fence;
>>>> +		struct drm_sched_job *cleanup_job = NULL;
>>>>    
>>>>    		wait_event_interruptible(sched->wake_up_worker,
>>>> -					 (drm_sched_cleanup_jobs(sched),
>>>> +					 (cleanup_job = drm_sched_get_cleanup_job(sched)) ||
>>>>    					 (!drm_sched_blocked(sched) &&
>>>>    					  (entity = drm_sched_select_entity(sched))) ||
>>>> -					 kthread_should_stop()));
>>>> +					 kthread_should_stop());
>>>> +
>>>> +		while (cleanup_job) {
>>>> +			sched->ops->free_job(cleanup_job);
>>>> +			/* queue timeout for next job */
>>>> +			drm_sched_start_timeout(sched);
>>>> +
>>>> +			cleanup_job = drm_sched_get_cleanup_job(sched);
>>>> +		}
>>>
>>> Why drm_sched_start_timeout is called both here and inside
>>> drm_sched_get_cleanup_job ? And also why call it multiple times in the
>>> loop instead of only once after the loop is done  ?
>> Christian pointed out to be that the first thing
>> drm_sched_get_cleanup_job does is call cancel_delayed_work(), and if
>> that returns false then it bails out with a NULL return. So to actually
>> get another job (if one exists) the timeout has to be restarted.
> 
> 
> For this case where timeout work already in progress note that 
> drm_sched_job_timedout restarts the timeout in it's end so it should be 
> ok to restart the timeout unconditionally inside 
> drm_sched_get_cleanup_job as it was done before.

I may have misinterpreted Christian[1], but I interpreted the below as
meaning that he'd prefer the caller (drm_sched_main()) to handle the
drm_sched_start_timeout() in this case:

On 26/09/2019 14:50, Koenig, Christian wrote:
>> Alternatively the caller could manually re-arm the timeout after
>> handling the job free.
> 
> I don't see anything that could go wrong immediately, but that is 
> probably the cleaner approach.

[1]
https://lore.kernel.org/lkml/d9b23ef8-f784-0bce-c34a-fa02002db1ea@amd.com/

I wasn't entirely sure if it was safe to leave the timeout running while
the job free was going on which would be the case if
drm_sched_get_cleanup_job() re-armed unconditionally.

>>
>> It's also necessary to restart the timeout in the case where the return
>> is NULL which is handled in the function itself.
>>
>> TBH I'm not sure whether this while loop is worth it - it may be better
>> to replace it with simply:
>>
>> 	if (cleanup_job) {
>> 		sched->ops->free_job(cleanup_job);
>> 		/* queue timeout for next job */
>> 		drm_sched_start_timeout(sched);
>> 	}
>>
>> The outer loop would then handle the next call to
>> drm_sched_get_cleanup_job() as necessary.
> 
> 
> What outer loop ?

There's a loop round the code in drm_sched_main():

	while (!kthread_should_stop()) {
		[...]
		wait_event_interruptible(...)

		while (cleanup_job) {...}

		if (!entity)
			continue;

		[...]
	}

So after handling the cleanup_job case, the outer loop will loop back
round to the wait_event_interruptible() call. One other concern is
whether it's possible for the thread to be signalled to stop before the
clean up has been completed. The while loop I added ensures that all
jobs are actually cleaned up before kthread_should_stop() is checked.

Steve
