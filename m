Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97618C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738B7222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfIZJrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:47:16 -0400
Received: from foss.arm.com ([217.140.110.172]:43768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfIZJrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:47:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 789381000;
        Thu, 26 Sep 2019 02:47:15 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72A2E3F67D;
        Thu, 26 Sep 2019 02:47:14 -0700 (PDT)
Subject: Re: [PATCH] drm: Don't free jobs in wait_event_interruptible()
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     Sharat Masetty <smasetty@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20190925151404.23222-1-steven.price@arm.com>
 <321e99c1-4ce8-e6e1-83c8-2df1c78acce3@amd.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <bcdeda56-619d-cff1-7b62-12dd446c532e@arm.com>
Date:   Thu, 26 Sep 2019 10:47:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <321e99c1-4ce8-e6e1-83c8-2df1c78acce3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2019 08:07, Koenig, Christian wrote:
> Am 25.09.19 um 17:14 schrieb Steven Price:
>> drm_sched_cleanup_jobs() attempts to free finished jobs, however because
>> it is called as the condition of wait_event_interruptible() it must not
>> sleep. Unfortunately some free callbacks (notably for Panfrost) do sleep.
>>
>> Instead let's rename drm_sched_cleanup_jobs() to
>> drm_sched_get_cleanup_job() and simply return a job for processing if
>> there is one. The caller can then call the free_job() callback outside
>> the wait_event_interruptible() where sleeping is possible before
>> re-checking and returning to sleep if necessary.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 44 ++++++++++++++------------
>>   1 file changed, 24 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index 9a0ee74d82dc..0ed4aaa4e6d1 100644
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
>>   	unsigned long flags;
>>   
>>   	/* Don't destroy jobs while the timeout worker is running */
>>   	if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>>   	    !cancel_delayed_work(&sched->work_tdr))
>> -		return;
>> -
>> -
>> -	while (!list_empty(&sched->ring_mirror_list)) {
>> -		struct drm_sched_job *job;
>> +		return NULL;
>>   
>> -		job = list_first_entry(&sched->ring_mirror_list,
>> +	job = list_first_entry_or_null(&sched->ring_mirror_list,
>>   				       struct drm_sched_job, node);
> 
> This is probably better done after taking the lock, apart from that 
> looks good to me.

It wasn't previously protected by the lock - but I don't see any harm so
I'll post a v2.

Steve
