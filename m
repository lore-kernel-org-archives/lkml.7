Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C18BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7E6206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lr3FHb2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfDZNr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:47:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43030 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:47:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id g4so4079028qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MbWe//je4LbsyhsREszn800tXE4tRYHtoJAL4NLLETE=;
        b=lr3FHb2Tdv2IfInSFm37fwY2LybIc/DhWCZu71SoWnQUdFv5GCTrV8hUjTGPfePLSc
         +9K7Z0J6DOHlMy+ZFl5N+yU41glewsvdkglZB3+u1PwNCcJoaZcSvafOWiqbLQ1zGpwD
         8wnQ6iSA1PpgSV5gY3a7rK0JJ2f0wOh5v+4BdAiaH7PtYf75gDHx1fId7bDVrZqgyv1J
         OyZLRcVuIZ8kZvK5X9yB1hUekcSJbFiIo29HHPWoGNwaojzD9SIlqquJzm9zBd55V4tG
         tT/zIpS3sAVLYUTfxsQiJxOo35DS5TUstOySJWLWtsfez7irVbVUFk17iOIm7b1/zotT
         bhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MbWe//je4LbsyhsREszn800tXE4tRYHtoJAL4NLLETE=;
        b=pJOZQuW5BDQpXUvzCChoH8AABwTlFuCG5SSrNhRLAdcJOrflKTmDreFTB9aDD3RxYL
         wnxWNEDAydOiPXogXeqw6/FKeTmwdBiGqhAxSuXCFjpBuFkZ+V9UpSsfPeqABVuodHlJ
         lI5CbvCG5AbqMx2/HCIjN0xBL12rqvegCj7enoCrlUmyHXCFdRY6uC0wUr3LEKSpmh9m
         mkgtOZdPHojc05oGlZ2ZCAbjGZlkoB9tT8n+V9CkDpKiIVEFV7zdEGMsCroVjjzqWe9d
         rJBOZnCpzaXIm3f6fcGpz3taI9l/cGKWaNHUrX/+c5p2VG6kmc4rTNEmtvTQH/TFCk0t
         K3rA==
X-Gm-Message-State: APjAAAWS08ij+OTxfmMwN9x2rg4+TBJYpovEUlsGwKnu9SzzXi1eE3Sy
        jtG02+SjPmkLZIrxsmbFZ4JSRQ==
X-Google-Smtp-Source: APXvYqw92z78h/5lBkp63ti1SBwXrH/MZaB7h1iuNrAeQPN6+8VTnuS0YwdkALrdpZX2wL9Llb6C2Q==
X-Received: by 2002:a0c:d1ad:: with SMTP id e42mr29516697qvh.208.1556286476742;
        Fri, 26 Apr 2019 06:47:56 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.gmail.com with ESMTPSA id y18sm14010893qty.78.2019.04.26.06.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 06:47:55 -0700 (PDT)
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
To:     Quentin Perret <quentin.perret@arm.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
 <20190418094833.owlobrx6x5gclvhy@queper01-lin> <5CBF93F6.8000109@linaro.org>
 <20190425104504.pbej3b74pwinx6jj@queper01-ThinkPad-T460s>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5CC30C09.4020005@linaro.org>
Date:   Fri, 26 Apr 2019 09:47:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190425104504.pbej3b74pwinx6jj@queper01-ThinkPad-T460s>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2019 06:45 AM, Quentin Perret wrote:
> On Tuesday 23 Apr 2019 at 18:38:46 (-0400), Thara Gopinath wrote:
>> I think there is one major difference between user-defined frequency
>> constraints and frequency constraints due to thermal events in terms of
>> the time period the system spends in the the constraint state.
>> Typically, a user constraint lasts for seconds if not minutes and I
>> think in this case cpu_capacity_orig should reflect this constraint and
>> not cpu_capacity like this patch set.
> 
> That might not always be true I think. There's tons of userspace thermal
> deamons out there, and I wouldn't be suprised if they were writing into
> the cpufreq sysfs files, although I'm not sure.
> 
> Another thing is, if you want to change the capacity_orig value, you'll
> need to rebuild the sched domains and all I believe. Otherwise there is
> a risk to 'break' the sd_asym flags. So we need to make sure we're happy
> to pay that price.

Hi Quentin,

I saw Vincent's reply on this and my answer is similar. I completely
agree that this will involve a rebuild of sched domains. My thought on
cpufreq capping max frequency from the user space is that the capping is
for long term basis and hence we could live with re-building sched
domains. If user space wants to control the max frequency of a cpu for
thermal reasons then the cooling device sys interface should be used. In
practical scenario, I am interested in knowing why thermal daemons
control cpufreq sysfs files instead of cooling device files.

Regards
Thara

> 
>> Also, in case of the user
>> constraint, there is possibly no need to accumulate and average the
>> capacity constraints and instantaneous values can be directly applied to
>> cpu_capacity_orig. On the other hand thermal pressure is more spiky and
>> sometimes in the order of ms and us requiring the accumulating and
>> averaging.
>>>
>>> Perhaps the Intel boost stuff could be factored in there ? That is,
>>> at times when the boost freq is not reachable capacity_of() would appear
>>> smaller ... Unless this wants to be reflected instantaneously ?
>> Again, do you think intel boost is more applicable to be reflected in
>> cpu_capacity_orig and not cpu_capacity?
> 
> I'm not even sure if we want to reflect it at all TBH, but I'd be
> interested to see what Intel folks think :-)
> 
> Thanks,
> Quentin
> 


-- 
Regards
Thara
