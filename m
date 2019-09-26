Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB254C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD32222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfIZJli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:41:38 -0400
Received: from foss.arm.com ([217.140.110.172]:43662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbfIZJle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:41:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B89F1000;
        Thu, 26 Sep 2019 02:41:33 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 416943F67D;
        Thu, 26 Sep 2019 02:41:32 -0700 (PDT)
Subject: Re: [PATCH] drm: Don't free jobs in wait_event_interruptible()
To:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        Sharat Masetty <smasetty@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20190925151404.23222-1-steven.price@arm.com>
 <cc0b260c-059d-7f55-288e-c48f30eb84e3@amd.com>
 <078332cf-ef58-5f76-5c49-8034435f7bea@arm.com>
 <da04cf92-f4c7-e896-5070-4d2a9be273aa@amd.com>
 <e160d9ec-5ae3-9003-b38c-3027bce736f4@amd.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <14479a04-d4a2-9c55-7cbf-010d3111fa0b@arm.com>
Date:   Thu, 26 Sep 2019 10:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e160d9ec-5ae3-9003-b38c-3027bce736f4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2019 21:09, Grodzovsky, Andrey wrote:
> 
> On 9/25/19 12:07 PM, Andrey Grodzovsky wrote:
>> On 9/25/19 12:00 PM, Steven Price wrote:
>>
>>> On 25/09/2019 16:56, Grodzovsky, Andrey wrote:
>>>> On 9/25/19 11:14 AM, Steven Price wrote:
>>>>
>>>>> drm_sched_cleanup_jobs() attempts to free finished jobs, however 
>>>>> because
>>>>> it is called as the condition of wait_event_interruptible() it must 
>>>>> not
>>>>> sleep. Unfortunately some free callbacks (notably for Panfrost) do 
>>>>> sleep.
>>>>>
>>>>> Instead let's rename drm_sched_cleanup_jobs() to
>>>>> drm_sched_get_cleanup_job() and simply return a job for processing if
>>>>> there is one. The caller can then call the free_job() callback outside
>>>>> the wait_event_interruptible() where sleeping is possible before
>>>>> re-checking and returning to sleep if necessary.
>>>>>
>>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>>> ---
>>>>>    drivers/gpu/drm/scheduler/sched_main.c | 44 
>>>>> ++++++++++++++------------
>>>>>    1 file changed, 24 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>>>> index 9a0ee74d82dc..0ed4aaa4e6d1 100644
>>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>>> @@ -622,43 +622,41 @@ static void drm_sched_process_job(struct 
>>>>> dma_fence *f, struct dma_fence_cb *cb)
>>>>>    }
>>>>>       /**
>>>>> - * drm_sched_cleanup_jobs - destroy finished jobs
>>>>> + * drm_sched_get_cleanup_job - fetch the next finished job to be 
>>>>> destroyed
>>>>>     *
>>>>>     * @sched: scheduler instance
>>>>>     *
>>>>> - * Remove all finished jobs from the mirror list and destroy them.
>>>>> + * Returns the next finished job from the mirror list (if there is 
>>>>> one)
>>>>> + * ready for it to be destroyed.
>>>>>     */
>>>>> -static void drm_sched_cleanup_jobs(struct drm_gpu_scheduler *sched)
>>>>> +static struct drm_sched_job *
>>>>> +drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>>>>>    {
>>>>> +    struct drm_sched_job *job = NULL;
>>>>>        unsigned long flags;
>>>>>           /* Don't destroy jobs while the timeout worker is running */
>>>>>        if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>>>>>            !cancel_delayed_work(&sched->work_tdr))
>>>>> -        return;
>>>>> -
>>>>> -
>>>>> -    while (!list_empty(&sched->ring_mirror_list)) {
>>>>> -        struct drm_sched_job *job;
>>>>> +        return NULL;
>>>>>    -        job = list_first_entry(&sched->ring_mirror_list,
>>>>> +    job = list_first_entry_or_null(&sched->ring_mirror_list,
>>>>>                           struct drm_sched_job, node);
>>>>> -        if (!dma_fence_is_signaled(&job->s_fence->finished))
>>>>> -            break;
>>>>>    -        spin_lock_irqsave(&sched->job_list_lock, flags);
>>>>> +    spin_lock_irqsave(&sched->job_list_lock, flags);
>>>>> +
>>>>> +    if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>>>>>            /* remove job from ring_mirror_list */
>>>>>            list_del_init(&job->node);
>>>>> - spin_unlock_irqrestore(&sched->job_list_lock, flags);
>>>>> -
>>>>> -        sched->ops->free_job(job);
>>>>> +    } else {
>>>>> +        job = NULL;
>>>>> +        /* queue timeout for next job */
>>>>> +        drm_sched_start_timeout(sched);
>>>>>        }
>>>>>    -    /* queue timeout for next job */
>>>>> -    spin_lock_irqsave(&sched->job_list_lock, flags);
>>>>> -    drm_sched_start_timeout(sched);
>>>>>        spin_unlock_irqrestore(&sched->job_list_lock, flags);
>>>>>    +    return job;
>>>>>    }
>>>>>       /**
>>>>> @@ -698,12 +696,18 @@ static int drm_sched_main(void *param)
>>>>>            struct drm_sched_fence *s_fence;
>>>>>            struct drm_sched_job *sched_job;
>>>>>            struct dma_fence *fence;
>>>>> +        struct drm_sched_job *cleanup_job = NULL;
>>>>> wait_event_interruptible(sched->wake_up_worker,
>>>>> -                     (drm_sched_cleanup_jobs(sched),
>>>>> +                     (cleanup_job = 
>>>>> drm_sched_get_cleanup_job(sched)) ||
>>>>>                         (!drm_sched_blocked(sched) &&
>>>>>                          (entity = drm_sched_select_entity(sched))) ||
>>>>> -                     kthread_should_stop()));
>>>>> +                     kthread_should_stop());
>>>>
>>>> Can't we just call drm_sched_cleanup_jobs right here, remove all the
>>>> conditions in wait_event_interruptible (make it always true) and after
>>>> drm_sched_cleanup_jobs is called test for all those conditions and
>>>> return to sleep if they evaluate to false ? drm_sched_cleanup_jobs is
>>>> called unconditionally inside wait_event_interruptible anyway... 
>>>> This is
>>>> more of a question to Christian.
>>> Christian may know better than me, but I think those conditions need to
>>> be in wait_event_interruptible() to avoid race conditions. If we simply
>>> replace all the conditions with a literal "true" then
>>> wait_event_interruptible() will never actually sleep.
>>>
>>> Steve
>>
>> Yes you right, it won't work as I missed that condition is evaluated 
>> as first step in wait_event_interruptible before it sleeps.
>>
>> Andrey
> 
> Another idea  - what about still just relocating drm_sched_cleanup_jobs 
> to after wait_event_interruptible and also call it in drm_sched_fini so  
> for the case when it will not be called from drm_sched_main due to 
> conditions not evaluating to true  it eventually be called last time 
> from drm_sched_fini. I mean - the refactor looks ok to me but the code 
> becomes  somewhat confusing this way to grasp.
> 
> Andrey

That sounds similar to my first stab at this[1]. However Christian
pointed out that it is necessary to also free jobs even if there isn't a
new one to be scheduled. Otherwise it ends up with the jobs lying around
until something kicks it.

There is also the aspect of queueing the timeout for the next job - this
is the part that I don't actually understand, but removing it from the
wait_event_interruptible() invariable seems to cause problems. Hence
this approach which avoids changing this behaviour. But I welcome input
from anyone who understands this timeout mechanism!

Steve

[1]
https://lists.freedesktop.org/archives/dri-devel/2019-September/235346.html
