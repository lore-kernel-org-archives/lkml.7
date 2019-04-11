Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A89C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23EE2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNGCAm3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDKTVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:21:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45917 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDKTVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:21:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so8773308wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gDMZcoKquUSIkDhjy8NKXTspfQYszazqfgEtb90sjjE=;
        b=PNGCAm3qblaX5Kd8ZJhSCM8xzO/gyUjtC3VQs37Vk89AaaO/SrjguNSRFS7IcgWJ16
         gGahdjk3fEyF8WntAzCkCEGfJF4536Tb9wVhIWew8B5l/ri0Dr4xLJNQRIF7Gr9fwAR6
         dGnwA2DxOkH//pHVW2W0/eYVf9TVBxakzEI6W8Es6ztJ2XWBXoC/BStscHaY2N/sF7qq
         5fYH7TJ0OBshqs4h6MSmL4GDFbB3teP5YeHjhDFxcqNJTdOo0hqJEENtxI9IQ7ojdFmP
         +zxqMfuA+n37BeufKWawiJCguA2fEQB/EmAmdFB05PoQpwJT0lsOQ8lpxWaS2BNKZ897
         dgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gDMZcoKquUSIkDhjy8NKXTspfQYszazqfgEtb90sjjE=;
        b=gMFhA7AfyGBX0rySoSGg+jDmsTgt70LLbS3UceTyVKYxNzyeZipUZrfmovdHbQKv6P
         OAy9E+W3sX48vtx3GkStnqm46E0dte7I+OHFi+w/uOvW3bJBQ7rRvUlnqwqfWz41Tz9X
         fA+93Alj2mb6tkHIBCFwrVMLANXxwjPL7/j4oa65NXSI6HQ8Ik8cZN3WVDz9HWuhyJus
         13T49r2OxzS2kjLMhb64dY6tIMeRNSK6Tu1sboE4T/l4hJOHhTgLC8SD0lOLhk7pf3/f
         V+uEy1AoSntPD+hnCpRhOBqa6cC9fY3SXOf2PuwGk/FhHzrW4YWtsfI3C7jun/kiDjy+
         bcEA==
X-Gm-Message-State: APjAAAWhVNP35I5/+FpokR/xP7LXBkd11vnuvKWfNl8I2t8mLXtQ7g1K
        KVnqWLrLWVNxaHkOxTWKmalCxg==
X-Google-Smtp-Source: APXvYqwnzYn1gBiUYHGw3o3LDcGDK0bZ1KlzRTfLKdcj8C0p/xbJzlB8aAG3MR5JhAb3ybBCA0r7dw==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr18496696wro.180.1555010458599;
        Thu, 11 Apr 2019 12:20:58 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id z140sm15577020wmc.27.2019.04.11.12.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 12:20:57 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
To:     Tony Lindgren <tony@atomide.com>
Cc:     Ladislav Michl <ladis@linux-mips.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch> <20190404141730.GE49658@atomide.com>
 <6defcea8-1e94-14ac-f9c5-e14c61ea4d99@linaro.org>
 <20190410200748.GN2839@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
Date:   Thu, 11 Apr 2019 21:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410200748.GN2839@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2019 22:07, Tony Lindgren wrote:
> Hi,
> 
> * Daniel Lezcano <daniel.lezcano@linaro.org> [190410 17:02]:
>> can you ask for an acked-by before pulling a patch in your tree?
> 
> I certainly do ask and wait for acks where possible :)

Ok, I may have missed them.

> Note that I have not applied this patch. I just added
> Keerthy to Cc on this thread so maybe you misread the
> message earlier. My comment "seems like no other
> takers" was for Ladislav regarding somebody picking up
> his earlier work, not for picking up this patch :)

Actually I was referring to the commit 592ea6bd1fad. Anyway as stated
above I could have miss your call.

> In any case, I've been waiting for you guys to pick up
> the patch, here's my ack if you're waiting for it:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

The patch does not apply. Is it aligned with tip/timers/core ?

>> On 04/04/2019 16:17, Tony Lindgren wrote:
>>> * Ladislav Michl <ladis@linux-mips.org> [190327 08:12]:
>>>> Hello Nathan,
>>>>
>>>> On Tue, Mar 26, 2019 at 10:01:27PM -0700, Nathan Chancellor wrote:
>>>>> Commit 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
>>>>> omap_dm_timer_set_load_start() static") made omap_dm_time_set_load_start
>>>>> static because its prototype was not defined in a header. Unfortunately,
>>>>> this causes a build warning on multi_v7_defconfig because this function
>>>>> is not used anywhere in this translation unit:
>>>>>
>>>>> drivers/clocksource/timer-ti-dm.c:589:12: error: unused function
>>>>> 'omap_dm_timer_set_load_start' [-Werror,-Wunused-function]
>>>>>
>>>>> In fact, omap_dm_timer_set_load_start hasn't been used anywhere since
>>>>> commit f190be7f39a5 ("staging: tidspbridge: remove driver") and the
>>>>> prototype was removed in commit 592ea6bd1fad ("clocksource: timer-ti-dm:
>>>>> Make unexported functions static"), which is probably where this should
>>>>> have happened.
>>>>
>>>> Alternatively you might want to look at "clocksource: timer-ti-dm: Add event
>>>> capture": https://patchwork.kernel.org/patch/10237217/ (it makes use of
>>>> function being removed here). It is a part of an attempt to add event capture
>>>> for OMAP. Of course I would like this functionality to be implemented, but
>>>> as I do not have a time to continue, I cannot really object removing this
>>>> function.
>>>>
>>>> Just in case you'd be interested in finishing this task ;-)
>>>
>>> Well seems like no other takers :) We can always find the missing
>>> function in git history when needed, so I suggest we apply this.
>>>
>>> Adding Keerthy to Cc as he just posted a similar patch.
>>>
>>> Regards,
>>>
>>> Tony
>>>
>>
>>
>> -- 
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

