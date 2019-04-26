Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2B8C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276D3208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6aAA1lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfDZLuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:50:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45178 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:50:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id b3so3637095qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OECKUnsN+FqcH1qRH152YaHz7XnfVWlzSXg8RoYceaM=;
        b=e6aAA1lGMAA1b1MDUX3AZLbYlvuAd6Sm3u0WMutGvkoQkn2M4fD7MCyhGjo3LFiQsf
         SbtOh6DGlQGtbKpWP4E0QCg07CBxFic28ZHhk1Lw/h7gL2IXiTNdfz/4E5Vl4VH/hUCX
         jGpyj70QMMlCYjioQkwYdGwRKIesxu8rK3L4Ef/eGbmz8Sm6LeBrW/CHTyX2oIPtI0wu
         726qJulRc8BVpVW4ceGaZ+LdL6Ig23K2j4NVmEW22p/a+m4Gv9JoJK2ewDN4QPb6vdu7
         BgcIRG3uwb1O+U9b+hGmCys7teAUVym1HtMLeg3GOB3GD1ksEtRnaPpysVpAfZrRVnDX
         oxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OECKUnsN+FqcH1qRH152YaHz7XnfVWlzSXg8RoYceaM=;
        b=jRCE4n7Bu/ST4kGMUZrE4My8f3s20LP3sGR3vUJP5M9uYsdSUryJq+XJrQ2dMGoouw
         gcNF0EyjNSfAvPjzj4H6cfvN8c1cP72dAKZMv5P0B4Pi5cdMfqB7exe0LFxLR0Zndd0e
         oJFxkv4GtSevuLoYp199FodJy0RobUtD+5HOSTJsX3Q7+8SZIfHvqotCXud66iS0BcQ4
         z7ocAVD1NXIeHfK97APr+f6GlLTxFht9kXhv1ukYVIPXUqM/I84kDkyHppoYmJb2Sikd
         j6ikc5YwwQSdbZurIp4syKzsw5VWcjvgYtVkn9Dz/a+6vGa141RtG4WLCAYaNPzfGrj+
         O8fw==
X-Gm-Message-State: APjAAAWrdpAPKTdRFsqMKPwI6hBUmjxhsHt2xaKn8TpJBa2Mpp/H5TYh
        jp2V1loLmQLc1dC18foa/uNbmw==
X-Google-Smtp-Source: APXvYqxk0oUTt9x5YxE/ilK1Ma5rhlf58J6rbM8if7Vx1xf7iO5xI7eUFOVEJK1lTS8xxIQUtU0jPQ==
X-Received: by 2002:a0c:9d02:: with SMTP id m2mr26350975qvf.32.1556279423586;
        Fri, 26 Apr 2019 04:50:23 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id j25sm15380902qtc.24.2019.04.26.04.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 04:50:22 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <b777c6da-0fe2-96d2-240d-96b065a3f18d@arm.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CC2F07D.1080603@linaro.org>
Date:   Fri, 26 Apr 2019 07:50:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <b777c6da-0fe2-96d2-240d-96b065a3f18d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2019 11:57 AM, Ionela Voinescu wrote:
> Hi Thara,
> 
> The idea and the results look promising. I'm trying to understand better
> the cause of the improvements so I've added below some questions that
> would help me out with this.

Hi Ionela,

Thanks for the review.

> 
> 
>> Regarding testing, basic build, boot and sanity testing have been
>> performed on hikey960 mainline kernel with debian file system.
>> Further, aobench (An occlusion renderer for benchmarking realworld
>> floating point performance), dhrystone and hackbench test have been
>> run with the thermal pressure algorithm. During testing, due to
>> constraints of step wise governor in dealing with big little systems,
>> cpu cooling was disabled on little core, the idea being that
>> big core will heat up and cpu cooling device will throttle the
>> frequency of the big cores there by limiting the maximum available
>> capacity and the scheduler will spread out tasks to little cores as well.
>> Finally, this patch series has been boot tested on db410C running v5.1-rc4
>> kernel.
>>
> 
> Did you try using IPA as well? It is better equipped to deal with
> big-LITTLE systems and it's more probable IPA will be used for these
> systems, where your solution will have the biggest impact as well.
> The difference will be that you'll have both the big cluster and the
> LITTLE cluster capped in different proportions depending on their
> utilization and their efficiency.

No. I did not use IPA simply because it was not enabled in mainline. I
agree it is better equipped  to deal with big-little systems. The idea
to remove cpu cooling on little cluster was to in some (not the
cleanest) manner to mimic this. But I agree that IPA testing is possibly
the next step.Any help in this regard is appreciated.

> 
>> During the course of development various methods of capturing
>> and reflecting thermal pressure were implemented.
>>
>> The first method to be evaluated was to convert the
>> capped max frequency into capacity and have the scheduler use the
>> instantaneous value when updating cpu_capacity.
>> This method is referenced as "Instantaneous Thermal Pressure" in the
>> test results below. 
>>
>> The next two methods employs different methods of averaging the
>> thermal pressure before applying it when updating cpu_capacity.
>> The first of these methods re-used the PELT algorithm already present
>> in the kernel that does the averaging of rt and dl load and utilization.
>> This method is referenced as "Thermal Pressure Averaging using PELT fmwk"
>> in the test results below.
>>
>> The final method employs an averaging algorithm that collects and
>> decays thermal pressure based on the decay period. In this method,
>> the decay period is configurable. This method is referenced as
>> "Thermal Pressure Averaging non-PELT Algo. Decay : XXX ms" in the
>> test results below.
>>
>> The test results below shows 3-5% improvement in performance when
>> using the third solution compared to the default system today where
>> scheduler is unware of cpu capacity limitations due to thermal events.
>>
> 
> Did you happen to record the amount of capping imposed on the big cores
> when these results were obtained? Did you find scenarios where the
> capacity of the bigs resulted in being lower than the capacity of the
> LITTLEs (capacity inversion)?
> This is one case where we'll see a big impact in considering thermal
> pressure.

I think I saw capacity inversion in some scenarios. I did not
particularly capture them.

> 
> Also, given that these are more or less sustained workloads, I'm
> wondering if there is any effect on workloads running on an uncapped
> system following capping. I would image such a test being composed of a
> single threaded period (no capping) followed by a multi-threaded period
> (with capping), continued in a loop. It might be interesting to have
> something like this as well, as part of your test coverage

I do not understand this. There is either capping for a workload or no
capping. There is no sysctl entry to turn on or off capping.

Regards
Thara
> 
> 
> Thanks,
> Ionela.
> 


-- 
Regards
Thara
