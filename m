Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE3C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2709222CD
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zTchbkJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfJCIeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:34:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51932 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfJCIeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:34:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so1549206wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pI9C6ahl+nbQHPAC35dp9wq8rqxSsDDWofoWIyRDkLM=;
        b=zTchbkJbgDTpNLzYwpdrWTE/gd+vuOPqap7nsSbbZ7+8Ec77H1VBaUDGtFpxoA8Wsy
         rO2dvutBNGUKTXyH+TJSnv6zLMGC8UBJjbZ/DzCH3ko9E+3EEUAZNvxBnKTjImTxKGHg
         dFid8JAY3zOjgb0NKCgxcHpbwJXFBuGJR2nOeNlybSaS3hFq9eIa1e8Diqpp1nosCmjz
         GNr1KuzN7K3FCz0nMCInp5KFNv0xH8+1uC1g3VYS9Qm449WqeUoPFBSFasSQLUn/U4eM
         tBhXWmFRC05WZo/hqCw1XiR8CdQT8uhC6ekLnd1hwADf8pIesbTUpa81F+D60JXHYCOC
         xmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pI9C6ahl+nbQHPAC35dp9wq8rqxSsDDWofoWIyRDkLM=;
        b=f3Ds7R5jXpEGkiCEGVNCfpz6U8umvLOlIbYnZOfAPinEnbzlnFeuV1f0EdBmZG7iCw
         80WV3ji4AjttzHwzyKY0sR/0Rd/ZyzL8r4ROAKEWqrND0SsnhdCD2lqqxL3LSPfTu25y
         BCSFNClzJ5ksXb39voqKDQnPJ61dWKbLEwstCrk5hOoze4lpTuqvhs1Q/dtpQT+86kBe
         gZ+0KAaI5PRm5lMWrtnIblRsDHBeDAuEkfm5n8ziOVZ4zRwBDr3wnb1GybQJg3TaFawn
         oAQYEf2/WKBUXlICu62J9JwWbOdDQFr82Uq20Idk0iDh0ydGUUbVVx+6nevx3kny8733
         MprQ==
X-Gm-Message-State: APjAAAVlfb0pWu0KHCTpX1MdbYwyf0gSG9cRdzLG9vS0i7gKK4Itt8Np
        s1+kzHdSV0vIBBX3UkonoSyzBg==
X-Google-Smtp-Source: APXvYqw4bv6iyI1N5Z9utskDI3+DaWWDjbAcHP6jbcMIYZDH9RbG+kUfYFbm+NrAdKLO8R+/Yht+8Q==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr6042506wmi.151.1570091661782;
        Thu, 03 Oct 2019 01:34:21 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id x129sm2591475wmg.8.2019.10.03.01.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 01:34:20 -0700 (PDT)
Subject: Re: drm_sched with panfrost crash on T820
To:     "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        Hillf Danton <hdanton@sina.com>
References: <e450fbe6-dec7-2704-59c2-db7e869d67f5@baylibre.com>
 <f0ab487e-8d49-987b-12b8-7a115a6543e1@amd.com>
 <20190930145228.14000-1-hdanton@sina.com>
 <d2888614-8644-7d04-b73b-3ab7c6623e9a@amd.com>
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
From:   Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <7339b7a1-2d1c-4379-89a0-daf8b28d81c8@baylibre.com>
Date:   Thu, 3 Oct 2019 10:34:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d2888614-8644-7d04-b73b-3ab7c6623e9a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

Le 02/10/2019 à 16:40, Grodzovsky, Andrey a écrit :
> 
> On 9/30/19 10:52 AM, Hillf Danton wrote:
>> On Mon, 30 Sep 2019 11:17:45 +0200 Neil Armstrong wrote:
>>> Did a new run from 5.3:
>>>
>>> [   35.971972] Call trace:
>>> [   35.974391]  drm_sched_increase_karma+0x5c/0xf0
>>> 			ffff000010667f38	FFFF000010667F94
>>> 			drivers/gpu/drm/scheduler/sched_main.c:335
>>>
>>> The crashing line is :
>>>                                  if (bad->s_fence->scheduled.context ==
>>>                                      entity->fence_context) {
>>>
>>> Doesn't seem related to guilty job.
>> Bail out if s_fence is no longer fresh.
>>
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -333,6 +333,10 @@ void drm_sched_increase_karma(struct drm
>>   
>>   			spin_lock(&rq->lock);
>>   			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
>> +				if (!smp_load_acquire(&bad->s_fence)) {
>> +					spin_unlock(&rq->lock);
>> +					return;
>> +				}
>>   				if (bad->s_fence->scheduled.context ==
>>   				    entity->fence_context) {
>>   					if (atomic_read(&bad->karma) >
>> @@ -543,7 +547,7 @@ EXPORT_SYMBOL(drm_sched_job_init);
>>   void drm_sched_job_cleanup(struct drm_sched_job *job)
>>   {
>>   	dma_fence_put(&job->s_fence->finished);
>> -	job->s_fence = NULL;
>> +	smp_store_release(&job->s_fence, 0);
>>   }
>>   EXPORT_SYMBOL(drm_sched_job_cleanup);
> 

This fixed the problem on the 10 CI runs.

Neil

> 
> Does this change help the problem ? Note that drm_sched_job_cleanup is 
> called from scheduler thread which is stopped at all times when work_tdr 
> thread is running and anyway the 'bad' job is still in the 
> ring_mirror_list while it's being accessed from  
> drm_sched_increase_karma so I don't think drm_sched_job_cleanup can be 
> called for it BEFORE or while drm_sched_increase_karma is executed.
> 
> Andrey
> 
> 
>>   
>> --
>>
