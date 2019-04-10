Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB087C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C1F2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbkvXOG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfDJRBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:01:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36189 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfDJRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:01:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so3401883wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1HwBR23D4l+xU76iPNbUKjBj8GW5SzZRAKdVRvOKYlo=;
        b=xbkvXOG3ngng9TsjpXRuaUFgtkkRkPcCczXBLnukNKAw3jNdCD+kHZZ9B2bkv9sA8w
         aTNccsN+tFcQa8zGTckYZoenXzb8HUFI3iFR/cwoeDq0oc/ZCOnJ0DshE8qZ0/AM0MsR
         SuDOlpAOke1p50I89tLQw6wEMeNqL91zh2oZ+wcGytTSxDvSxS8Em4Jm8CSZ0BkdNWjl
         Y8gEtpDkucJ7y/pO9p7ADC1b9Y+qTxZ+pOlBNNsPY2OXN8VNSA2MkCGTjYCbejALo7zq
         6uH6TIGtbA7EVeaiIQmSYxzkjJzqa0qWx8Ap1oH/7kj2+BYTOrdaMOLLTEVgPeJmZcpU
         U8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1HwBR23D4l+xU76iPNbUKjBj8GW5SzZRAKdVRvOKYlo=;
        b=LlycKOAMF096ky0J1wZFnd/+GVMHo41lNReTByV0m3ZXD4ETVMQaprFLfJM/eRs24X
         pQwCOntULuci7/05n7qNKsr8lJO79wUhWGUvT68rJzPDTkQbharsacVrLeGqXYSiXV3z
         PZy2jG6MEEUHIT2Y+n/aOWFCicIxYZtBhSpba81JA8j0tSkwXR0yjQXisWYeIy2V97p0
         +hc3YcCfth8Ye62hutfNlr+emaoVPfh14puXYj1Bd7M4GvlUBmzmWZV2QbFt4HgTRnVl
         vtrcmBzcaJqa9+AeTkzAwCFl/mWqrGXkK3dJrya19v8kza4lChEV2liS5/7gx6Rn59pd
         vwoA==
X-Gm-Message-State: APjAAAXtIqCXhKghGrB53nJHquQ+p3DmsBQ72hb9K11xxMR5CJqUCPHt
        Z9yKP6WUaiXGSdIET6PLwBnM6A==
X-Google-Smtp-Source: APXvYqx8mG66oUKaOhwoEo8Xw7VfIR5xXdhs08gsN2w1DAOVKGwXzwoaXunMpAmxyb07UY7Yp9gElQ==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr3533815wmh.32.1554915703052;
        Wed, 10 Apr 2019 10:01:43 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id u8sm37302342wrt.69.2019.04.10.10.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:01:41 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
To:     Tony Lindgren <tony@atomide.com>,
        Ladislav Michl <ladis@linux-mips.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch> <20190404141730.GE49658@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6defcea8-1e94-14ac-f9c5-e14c61ea4d99@linaro.org>
Date:   Wed, 10 Apr 2019 19:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404141730.GE49658@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tony,

can you ask for an acked-by before pulling a patch in your tree?



On 04/04/2019 16:17, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [190327 08:12]:
>> Hello Nathan,
>>
>> On Tue, Mar 26, 2019 at 10:01:27PM -0700, Nathan Chancellor wrote:
>>> Commit 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
>>> omap_dm_timer_set_load_start() static") made omap_dm_time_set_load_start
>>> static because its prototype was not defined in a header. Unfortunately,
>>> this causes a build warning on multi_v7_defconfig because this function
>>> is not used anywhere in this translation unit:
>>>
>>> drivers/clocksource/timer-ti-dm.c:589:12: error: unused function
>>> 'omap_dm_timer_set_load_start' [-Werror,-Wunused-function]
>>>
>>> In fact, omap_dm_timer_set_load_start hasn't been used anywhere since
>>> commit f190be7f39a5 ("staging: tidspbridge: remove driver") and the
>>> prototype was removed in commit 592ea6bd1fad ("clocksource: timer-ti-dm:
>>> Make unexported functions static"), which is probably where this should
>>> have happened.
>>
>> Alternatively you might want to look at "clocksource: timer-ti-dm: Add event
>> capture": https://patchwork.kernel.org/patch/10237217/ (it makes use of
>> function being removed here). It is a part of an attempt to add event capture
>> for OMAP. Of course I would like this functionality to be implemented, but
>> as I do not have a time to continue, I cannot really object removing this
>> function.
>>
>> Just in case you'd be interested in finishing this task ;-)
> 
> Well seems like no other takers :) We can always find the missing
> function in git history when needed, so I suggest we apply this.
> 
> Adding Keerthy to Cc as he just posted a similar patch.
> 
> Regards,
> 
> Tony
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

