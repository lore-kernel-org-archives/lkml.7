Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8B6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F97321D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xIIB7t9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbfJDPDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:03:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35063 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbfJDPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:03:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so6238194wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AFKYB40YJrX94dmbX2foh6YfCwAV4FqZbML1ow8KGBI=;
        b=xIIB7t9a9IEgXwx7XwYtSCW8uGEDloL9Jr3bD1Jeww0dSvYmv34gSriUIsVWUOIf+f
         lIUCf5QixvNlmPzRimX+PGRxaZS7ofJ+SkxlqqpdRhe9wGTEAi4Y4fd1QDK7NGLx+VTc
         E2YtvXzFaIhg7Re7kFL9RwAybUfVRZCkudTMuf7JxFriC+wW29c/mX8mp1wS/p/PO1rK
         LqINR0GbNmmPT4i+R+ljqbCl2YSn0fU2hy3slNoqaMmVB4cg/lj8rTVk9nxvrnjBT0FS
         yQ2HvoCYMoKAbl/MlNDfWKGalmk2Zd5d1BYgJrrn1K0zSdo+0QWz5NovRWOSqsgYWoFc
         87Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AFKYB40YJrX94dmbX2foh6YfCwAV4FqZbML1ow8KGBI=;
        b=EbDul8S73SEswHMQ2G6hTrK7aPU0bX062jjJrrzi2vDwgMgjRArtkfSzboiSERupgv
         xRvJLRmQqiEuSy/Ty2MkQTmuMFzBVvqAq+qcuJ4sEihfweB1uQwPOHbh3EHcv2KZJLO1
         G/yzu6vN1n6BBd/W9i2K/x6rmJmjcJcQ1tdWWLa4LZxhNrJT2AGp6433LaRj7qCMFF8c
         vvVtRrVrCvSFe+4ZgTvZhFgh2KEpM8/YIIQ7Tww5f+D1868OH3DIy+Fb7R1NQ8nP8zdG
         X6HXwNbA79EhHUQwPssKHBpoE1g5WknelXbJ6LHhh1OXUh6RBo7iaKB35ZhF3GX7DHnw
         Rxfw==
X-Gm-Message-State: APjAAAW7huiyqTNB5cvimMw/4Cs78QvW/mddsy39ijAMt5CjMFSc6cXI
        lqR6ZkD6ovv3fidT1NALPZrgBg==
X-Google-Smtp-Source: APXvYqwwX+0eLtalJ7cv52Xddw5jCFbUMq98EyH7FHo1dBe23N52xK/z7xkcnOADnY7Up3rYSwoc8g==
X-Received: by 2002:a1c:4085:: with SMTP id n127mr11738355wma.68.1570201396808;
        Fri, 04 Oct 2019 08:03:16 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n7sm6589320wrt.59.2019.10.04.08.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:03:16 -0700 (PDT)
Subject: Re: drm_sched with panfrost crash on T820
To:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <e450fbe6-dec7-2704-59c2-db7e869d67f5@baylibre.com>
 <f0ab487e-8d49-987b-12b8-7a115a6543e1@amd.com>
 <20190930145228.14000-1-hdanton@sina.com>
 <d2888614-8644-7d04-b73b-3ab7c6623e9a@amd.com>
 <7339b7a1-2d1c-4379-89a0-daf8b28d81c8@baylibre.com>
 <94096e4e-0f60-79d1-69b5-c7c3e59a4d78@amd.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <f44204b4-ce5c-b26e-580d-5bb21314be1f@baylibre.com>
Date:   Fri, 4 Oct 2019 17:03:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <94096e4e-0f60-79d1-69b5-c7c3e59a4d78@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 16:53, Grodzovsky, Andrey wrote:
> 
> On 10/3/19 4:34 AM, Neil Armstrong wrote:
>> Hi Andrey,
>>
>> Le 02/10/2019 à 16:40, Grodzovsky, Andrey a écrit :
>>> On 9/30/19 10:52 AM, Hillf Danton wrote:
>>>> On Mon, 30 Sep 2019 11:17:45 +0200 Neil Armstrong wrote:
>>>>> Did a new run from 5.3:
>>>>>
>>>>> [   35.971972] Call trace:
>>>>> [   35.974391]  drm_sched_increase_karma+0x5c/0xf0
>>>>> 			ffff000010667f38	FFFF000010667F94
>>>>> 			drivers/gpu/drm/scheduler/sched_main.c:335
>>>>>
>>>>> The crashing line is :
>>>>>                                   if (bad->s_fence->scheduled.context ==
>>>>>                                       entity->fence_context) {
>>>>>
>>>>> Doesn't seem related to guilty job.
>>>> Bail out if s_fence is no longer fresh.
>>>>
>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>> @@ -333,6 +333,10 @@ void drm_sched_increase_karma(struct drm
>>>>    
>>>>    			spin_lock(&rq->lock);
>>>>    			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
>>>> +				if (!smp_load_acquire(&bad->s_fence)) {
>>>> +					spin_unlock(&rq->lock);
>>>> +					return;
>>>> +				}
>>>>    				if (bad->s_fence->scheduled.context ==
>>>>    				    entity->fence_context) {
>>>>    					if (atomic_read(&bad->karma) >
>>>> @@ -543,7 +547,7 @@ EXPORT_SYMBOL(drm_sched_job_init);
>>>>    void drm_sched_job_cleanup(struct drm_sched_job *job)
>>>>    {
>>>>    	dma_fence_put(&job->s_fence->finished);
>>>> -	job->s_fence = NULL;
>>>> +	smp_store_release(&job->s_fence, 0);
>>>>    }
>>>>    EXPORT_SYMBOL(drm_sched_job_cleanup);
>> This fixed the problem on the 10 CI runs.
>>
>> Neil
> 
> 
> These are good news but I still fail to see how this fixes the problem - 
> Hillf, do you mind explaining how you came up with this particular fix - 
> what was the bug you saw ?

As Steven explained, seems the same job was submitted on both HW slots,
and then when timeout occurs each thread calls panfrost_job_timedout
which leads to drm_sched_stop() on the first call and on the
second call the job was already freed.

Steven proposed a working fix, and this one does the same but on
the drm_sched side. This one looks cleaner, but panfrost should
not call drm_sched_stop() twice for the same job.

Neil

> 
> Andrey
> 
>>
>>> Does this change help the problem ? Note that drm_sched_job_cleanup is
>>> called from scheduler thread which is stopped at all times when work_tdr
>>> thread is running and anyway the 'bad' job is still in the
>>> ring_mirror_list while it's being accessed from
>>> drm_sched_increase_karma so I don't think drm_sched_job_cleanup can be
>>> called for it BEFORE or while drm_sched_increase_karma is executed.
>>>
>>> Andrey
>>>
>>>
>>>>    
>>>> --
>>>>

