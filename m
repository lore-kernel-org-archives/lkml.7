Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C2AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B9B2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YzlDmBrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfJCIgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:36:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35568 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:36:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so1579442wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8oCj6ABjq7IlXduobnbx0HLQeAm5zYdqgwLkEMvrhbw=;
        b=YzlDmBrtuA4f9f4HTwJHuL34tp98Iq2VnrTUagXtMFfd+jt++BjGXLI6tci4A8zoCc
         869h3jCYtcNG52dut7CzsK3A0MR4OTGfeBO90dYg3e4okqfFu1eRVBbhtuKOvaFdzXOZ
         R/aHm/rfC+QMjdrAFJS/63fymA3B5ncpJ0yqpq2KoYLhCBZ9oiCt1MWm02eMvtwTdRck
         4y1stcrfo1YK0hXsQ7qdPaiKS/kKQJCru9YxHuccY1LykDPOExc2q0lg8NKyFbzIjsoS
         m9nWEKRP44kyK61grkf7hoR9wlcd8f+UIbsRs6mpTJfeVlhXbePzY59F/9URJN9kXotI
         +0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8oCj6ABjq7IlXduobnbx0HLQeAm5zYdqgwLkEMvrhbw=;
        b=g93z/s5rOKchB46CSnTOYZPhZtMwtr0CvIPu2WV1/wQpy8NSJDvb7+tsNPhEufjoYS
         cbkiMi6OdgsquIOShA+THpsxZX8n3vH0uyqy8BGZdYq8pgq5Ae+UPK7Wp+D95UlPAIqG
         xog0YK9qi72VIU0unt30pN4e8OC2Fk/XjB0jzzzwP8Clav9bodIx9cCWSWrB+GRV3Vqm
         AbO3nOcLMKVkvX46f0MUYw+UPRhFC6VRqort6aJO5AtGpCfUN4g/bDS6a0E0F4+CU7VP
         FLfhzc7wEwWl5QvFwvC0xwS+O0uJ/HR3J7LBSeg0L2Ru7mQ9zfbRBNijqkCgKMEQfsJ+
         yXyg==
X-Gm-Message-State: APjAAAW7TolVGbf/h5BvBGTtokyl3aPDBi6+PZ4d3C4fzQGygN049ejT
        zMgujV4JpyuhaadXSfzeQA7q1g==
X-Google-Smtp-Source: APXvYqy9NDEB2yuGbVOhGF2VnlxJIeKnAJPF5k4qit+D2Gt0YxqgW5XPWOAplITRI1XXKlf6ghpMqw==
X-Received: by 2002:a1c:980e:: with SMTP id a14mr5717814wme.99.1570091806362;
        Thu, 03 Oct 2019 01:36:46 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id t17sm2461962wrp.72.2019.10.03.01.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 01:36:45 -0700 (PDT)
Subject: Re: drm_sched with panfrost crash on T820
To:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
References: <e450fbe6-dec7-2704-59c2-db7e869d67f5@baylibre.com>
 <f0ab487e-8d49-987b-12b8-7a115a6543e1@amd.com>
 <5f7d10ab-1ce5-25aa-90bd-4f87ed2a9bfb@baylibre.com>
 <d5ceef14-b876-c102-d793-25289635cab1@amd.com>
Cc:     Erico Nunes <nunes.erico@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <530d1549-367f-b387-7f89-be6221b864a9@baylibre.com>
Date:   Thu, 3 Oct 2019 10:36:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d5ceef14-b876-c102-d793-25289635cab1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/10/2019 à 18:53, Grodzovsky, Andrey a écrit :
> 
> On 9/30/19 5:17 AM, Neil Armstrong wrote:
>> Hi Andrey,
>>
>> On 27/09/2019 22:55, Grodzovsky, Andrey wrote:
>>> Can you please use addr2line or gdb to pinpoint where in
>>> drm_sched_increase_karma you hit the NULL ptr ? It looks like the guilty
>>> job, but to be sure.
>> Did a new run from 5.3:
>>
>> [   35.971972] Call trace:
>> [   35.974391]  drm_sched_increase_karma+0x5c/0xf0	ffff000010667f38	FFFF000010667F94	drivers/gpu/drm/scheduler/sched_main.c:335
>>
>>
>> The crashing line is :
>>                                  if (bad->s_fence->scheduled.context ==
>>                                      entity->fence_context) {
>>
>> Doesn't seem related to guilty job.
>>
>> Neil
> 
> 
> Thanks Neil, by guilty i meant the 'bad' job. I reviewed the code and 
> can't see anything suspicious for now. To help clarify could you please 
> provide ftrace log for this ? All the dma_fence and gpu_scheduler traces 
> can help. I usually just set them all up in one line using trace-cmd 
> utility like this before starting the run. If you have any relevant 
> traces in panfrost it aslo can be useful.
> 
> sudo trace-cmd start -e dma_fence -e gpu_scheduler

Sure but I'll need much more time to do this, in the meantime I did 10 runs with your
patch and is fixed the issue.

I'll try to generate the traces.

Neil

> 
> Andrey
> 
> 
>>
>>> Andrey
>>>
>>> On 9/27/19 4:12 AM, Neil Armstrong wrote:
>>>> Hi Christian,
>>>>
>>>> In v5.3, running dEQP triggers the following kernel crash :
>>>>
>>>> [   20.224982] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
>>>> [...]
>>>> [   20.291064] Hardware name: Khadas VIM2 (DT)
>>>> [   20.295217] Workqueue: events drm_sched_job_timedout
>>>> [...]
>>>> [   20.304867] pc : drm_sched_increase_karma+0x5c/0xf0
>>>> [   20.309696] lr : drm_sched_increase_karma+0x44/0xf0
>>>> [...]
>>>> [   20.396720] Call trace:
>>>> [   20.399138]  drm_sched_increase_karma+0x5c/0xf0
>>>> [   20.403623]  panfrost_job_timedout+0x12c/0x1e0
>>>> [   20.408021]  drm_sched_job_timedout+0x48/0xa0
>>>> [   20.412336]  process_one_work+0x1e0/0x320
>>>> [   20.416300]  worker_thread+0x40/0x450
>>>> [   20.419924]  kthread+0x124/0x128
>>>> [   20.423116]  ret_from_fork+0x10/0x18
>>>> [   20.426653] Code: f9400001 540001c0 f9400a83 f9402402 (f9401c64)
>>>> [   20.432690] ---[ end trace bd02f890139096a7 ]---
>>>>
>>>> Which never happens, at all, on v5.2.
>>>>
>>>> I did a (very) long (7 days, ~100runs) bisect run using our LAVA lab (thanks tomeu !), but
>>>> bisecting was not easy since the bad commit landed on drm-misc-next after v5.1-rc6, and
>>>> then v5.2-rc1 was backmerged into drm-misc-next at:
>>>> [1] 374ed5429346 Merge drm/drm-next into drm-misc-next
>>>>
>>>> Thus bisecting between [1] ang v5.2-rc1 leads to commit based on v5.2-rc1... where panfrost was
>>>> not enabled in the Khadas VIM2 DT.
>>>>
>>>> Anyway, I managed to identify 3 possibly breaking commits :
>>>> [2] 290764af7e36 drm/sched: Keep s_fence->parent pointer
>>>> [3] 5918045c4ed4 drm/scheduler: rework job destruction
>>>> [4] a5343b8a2ca5 drm/scheduler: Add flag to hint the release of guilty job.
>>>>
>>>> But [1] and [2] doesn't crash the same way :
>>>> [   16.257912] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000060
>>>> [...]
>>>> [   16.308307] CPU: 4 PID: 80 Comm: kworker/4:1 Not tainted 5.1.0-rc2-01185-g290764af7e36-dirty #378
>>>> [   16.317099] Hardware name: Khadas VIM2 (DT)
>>>> [...])
>>>> [   16.330907] pc : refcount_sub_and_test_checked+0x4/0xb0
>>>> [   16.336078] lr : refcount_dec_and_test_checked+0x14/0x20
>>>> [...]
>>>> [   16.423533] Process kworker/4:1 (pid: 80, stack limit = 0x(____ptrval____))
>>>> [   16.430431] Call trace:
>>>> [   16.432851]  refcount_sub_and_test_checked+0x4/0xb0
>>>> [   16.437681]  drm_sched_job_cleanup+0x24/0x58
>>>> [   16.441908]  panfrost_job_free+0x14/0x28
>>>> [   16.445787]  drm_sched_job_timedout+0x6c/0xa0
>>>> [   16.450102]  process_one_work+0x1e0/0x320
>>>> [   16.454067]  worker_thread+0x40/0x450
>>>> [   16.457690]  kthread+0x124/0x128
>>>> [   16.460882]  ret_from_fork+0x10/0x18
>>>> [   16.464421] Code: 52800000 d65f03c0 d503201f aa0103e3 (b9400021)
>>>> [   16.470456] ---[ end trace 39a67412ee1b64b5 ]---
>>>>
>>>> and [3] fails like on v5.3 (in drm_sched_increase_karma):
>>>> [   33.830080] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
>>>> [...]
>>>> [   33.871946] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>>> [   33.877450] Modules linked in:
>>>> [   33.880474] CPU: 6 PID: 81 Comm: kworker/6:1 Not tainted 5.1.0-rc2-01186-ga5343b8a2ca5-dirty #380
>>>> [   33.889265] Hardware name: Khadas VIM2 (DT)
>>>> [   33.893419] Workqueue: events drm_sched_job_timedout
>>>> [...]
>>>> [   33.903069] pc : drm_sched_increase_karma+0x5c/0xf0
>>>> [   33.907898] lr : drm_sched_increase_karma+0x44/0xf0
>>>> [...]
>>>> [   33.994924] Process kworker/6:1 (pid: 81, stack limit = 0x(____ptrval____))
>>>> [   34.001822] Call trace:
>>>> [   34.004242]  drm_sched_increase_karma+0x5c/0xf0
>>>> [   34.008726]  panfrost_job_timedout+0x12c/0x1e0
>>>> [   34.013122]  drm_sched_job_timedout+0x48/0xa0
>>>> [   34.017438]  process_one_work+0x1e0/0x320
>>>> [   34.021402]  worker_thread+0x40/0x450
>>>> [   34.025026]  kthread+0x124/0x128
>>>> [   34.028218]  ret_from_fork+0x10/0x18
>>>> [   34.031755] Code: f9400001 540001c0 f9400a83 f9402402 (f9401c64)
>>>> [   34.037792] ---[ end trace be3fd6f77f4df267 ]---
>>>>
>>>>
>>>> When I revert [3] on [1], i get the same crash as [2], meaning
>>>> the commit [3] masks the failure [2] introduced.
>>>>
>>>> Do you know how to solve this ?
>>>>
>>>> Thanks,
>>>> Neil
