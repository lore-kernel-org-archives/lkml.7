Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17954C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D485B214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CG5mOnAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfHFXQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:16:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53720 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbfHFXQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:16:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so717745wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q61qm30k8cg74IhXkTUjHjLeO5mUvURwLoiElUgi8sA=;
        b=CG5mOnAd/KW5rIyYsfrD490hIM61X0WzvKgxKZKRNh1jbjz3QVZzq/BixrHW97Y1bZ
         5bcL6b5ns+9nUsXfNYBhtP1nup+a6bcv+sOsyI+6d78PGJXA+WQojPR+nXuAUKycyODS
         SF8LepmehB+2SnMgqAjYVO/syNqKd47gZ8RS6s7gYrmDvbTUOxzupWz+yoz5SXCmxe9n
         uUWFSm8nyF3ZKPovqDFvymKkg6Wm0AUuBWDYjSWxblYTcoakjOe/3IKGtDwYQHmxqc9Q
         WeRbC4xKJj1kqo/MnRE5WE/Ygbpg6qdGy3sONDN1T+ecuJvl+OlpV1DqSYBSFzXsNDwQ
         C3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q61qm30k8cg74IhXkTUjHjLeO5mUvURwLoiElUgi8sA=;
        b=HGPu1WYTzsPaaqtA/H+hJ1/3FuoIs9N9PuYBpLf417VE3YA/VuDQbefnmFZDSK3d+H
         pe0TSxYhHZol5Xbia7YL0WDiJXeXfhNW62Ts5SNemI68qy0jHGZghUGK7tdFAhtAWKud
         U2yNb2o3PQHI8Zs43spMuNsxjiXKu8JWZ4ZA1jXDfkV3t13i/FoRyrjxnsvhX9EDaKoI
         DHBMJiygbPLuWWjjltuoNQ8gxmh9YzSBye9dOw7cYege1NcDRHennEPlb2caSK4u8E4c
         CHvqG42GO8Q/M6bdj7SVoAupTz2X/qY7JqT0uhSGfy64FtLuFo+7Mxsm6QGbhXL8HZj5
         Iy9Q==
X-Gm-Message-State: APjAAAVhDBOLpX6ZiCG5ypoNeEcTbAnhVVY+p/w+EpynfcnZW/6ed1Hm
        wjo1PMizDJoj75xBe4ug8wKwJU+Noi8OQXi8Mhb8JjMgvMwuncv3NzcwPwdAB99aUYUlqjHTFyX
        gzQ8pwYSfFXpCBNYPzd5T1xcp7l5UqUL0IYFGJ7mZifozjrFHbrEcFd+cvTC59PPdNoqswb7cOL
        xjlxi0KHL9KXBXlmSZGqiD8cQOR/eJ2cQZDAX5Qpo=
X-Google-Smtp-Source: APXvYqxZdd7iJIqOekT+GFHNpa0uxjIVasHt3cn+nlZds1B0ydrjr2hGKRtue33c0rK7PgKaL/W/JQ==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr6790710wmf.51.1565133383213;
        Tue, 06 Aug 2019 16:16:23 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o6sm193083319wra.27.2019.08.06.16.16.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 16:16:22 -0700 (PDT)
Subject: Re: [PATCH 4.19 17/32] iommu/vt-d: Dont queue_iova() if there is no
 flush queue
From:   Dmitry Safonov <dima@arista.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
References: <20190802092101.913646560@linuxfoundation.org>
 <20190802092107.177554199@linuxfoundation.org> <20190803213453.GA22416@amd>
 <dc639510-5d88-5b05-a973-5f4b7c720f76@arista.com>
Message-ID: <858b5409-d8ed-5ff1-2daf-3f6287fb5c8e@arista.com>
Date:   Wed, 7 Aug 2019 00:16:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <dc639510-5d88-5b05-a973-5f4b7c720f76@arista.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 11:47 PM, Dmitry Safonov wrote:
> Hi Pavel,
> 
> On 8/3/19 10:34 PM, Pavel Machek wrote:
>> Hi!
>>
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -3721,7 +3721,7 @@ static void intel_unmap(struct device *d
>>>  
>>>  	freelist = domain_unmap(domain, start_pfn, last_pfn);
>>>  
>>> -	if (intel_iommu_strict) {
>>> +	if (intel_iommu_strict || !has_iova_flush_queue(&domain->iovad)) {
>>>  		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
>>>  				      nrpages, !freelist, 0);
>>>  		/* free iova */
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -65,9 +65,14 @@ init_iova_domain(struct iova_domain *iov
>>>  }
>>>  EXPORT_SYMBOL_GPL(init_iova_domain);
>>>  
>>> +bool has_iova_flush_queue(struct iova_domain *iovad)
>>> +{
>>> +	return !!iovad->fq;
>>
>> Should this be READ_ONCE()?
> 
> Why? Compiler can't anyhow assume that it's always true/false and there
> is a clear data dependency between this and:
> :	queue_iova(&domain->iovad, iova_pfn, nrpages,
> :			   (unsigned long)freelist);
> 
>>
>>> @@ -100,13 +106,17 @@ int init_iova_flush_queue(struct iova_do
>>>  	for_each_possible_cpu(cpu) {
>>>  		struct iova_fq *fq;
>>>  
>>> -		fq = per_cpu_ptr(iovad->fq, cpu);
>>> +		fq = per_cpu_ptr(queue, cpu);
>>>  		fq->head = 0;
>>>  		fq->tail = 0;
>>>  
>>>  		spin_lock_init(&fq->lock);
>>>  	}
>>>  
>>> +	smp_wmb();
>>> +
>>> +	iovad->fq = queue;
>>> +
>>
>> Could we have a comment why the barrier is needed,
> 
> I'm up for the comment if you feel like it - in my POV it's quite
> obvious that we want finish initializing the queue's internals before
> assigning the queue. I didn't put the comment exactly because I felt
> like it would state something evident [in my POV].
> 
>> and perhaps there
>> should be oposing smp_rmb() somewhere? Does this need to be
>> WRITE_ONCE() as it is racing against reader?
> 
> I feel confused. I might have forgotten everything about barriers, but
> again if I'm not mistaken, one doesn't need a barrier in:
> : if (A->a != NULL)
> :     use(A); /* dereferences A->a */
> : else
> :     /* don't use `a' */

And in this simplified example I mean that use() will either see A->a
initialized (IOW, CPU can't load A->a->field1 before checking the
condition) or use() will not be called.

Thanks,
          Dmitry
