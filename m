Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38393C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83FD2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrVgZg5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDKUNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:13:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37163 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKUNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:13:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so8996614wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Snk0V6XtSIG2dhzszN8hpaCEWnR/usZmLA+BB29u8/o=;
        b=UrVgZg5GITyJWy4lwHpHot6Pey2+J4RYO/M9MgLoctpPQPvZQJRWSdvDiKRBfGnlnK
         9N7+kfdfEA++oIFqLqfTHbRPc8Z92zlVhJRBnXEnoE98XDhc5vFOQqOCIcdK18JxF1RU
         Od9BHAMWu7XXu8zL89GUN90/rJYjDFNe4CeQjwkyTE08ZhiyTl8xaO9n2t24ikjzsHSk
         7I8GtDHJtk3NBXgLNN5aWimW5KfrIH5X1xIW8BONA2Md6tMHWNx8QhkwXewWHqT+VWIk
         rMEp/y1aGjaG2Uz9Fu367La83JKVQo3SI8ttK6iq+KH1SizdKKZPLf5KbW96WuFppLyB
         vqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Snk0V6XtSIG2dhzszN8hpaCEWnR/usZmLA+BB29u8/o=;
        b=pdWg9LEQfemgCLcnPcnyyDfsaK8wbQyC6Tb86fTTKWrKJHZmtqMc5ptuCC6BrzZG7U
         FWim31puDM1VqkojL9U+mbLGakA25P3Vv1o5Lo6LQh/ZGPpFZEufAMCTneDQetIQifOK
         yKYu2bBFjM++zo9yT9O+R2I3a3tnkteIBS7UcXnahDyytq1SeJc486yL0HCZSQD0MJmI
         52sB8oOR9Td+gBNq+bamtHvyQgZWRO8iY5pCidnCxtd1jOAHNvwNOXbVWw8/hNdj9gEk
         O3CDt+6/oBUuRmmNDFR+B/+cmzL0gTcI9ETcmgUSQvUwColrNTzDsQaKa/s2as56pFR2
         i3cw==
X-Gm-Message-State: APjAAAV+iWA7b1L5k0upcKq27ntIAvEEwSozEEY+wcbgWic8YHZlCyrD
        HjUcSw+q9xBD37TZ1FimyqE5Gw==
X-Google-Smtp-Source: APXvYqxfgdG1RC10T/Y8TQobW/UcP7WyJs+0RM6JxddJU8lc3aLLnDrEyRRt8j3OuMWgUqqajEJ9Pg==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr31134194wrj.228.1555013587914;
        Thu, 11 Apr 2019 13:13:07 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id a17sm5982865wmg.40.2019.04.11.13.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:13:06 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Remove
 omap_dm_timer_set_load_start
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Keerthy <j-keerthy@ti.com>
References: <20190327050126.12064-1-natechancellor@gmail.com>
 <20190327081142.GA11034@lenoch> <20190404141730.GE49658@atomide.com>
 <6defcea8-1e94-14ac-f9c5-e14c61ea4d99@linaro.org>
 <20190410200748.GN2839@atomide.com>
 <b8a177ee-0058-2730-4c95-56834f6bafd4@linaro.org>
 <20190411193614.GA8469@archlinux-i9>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d6a52524-006c-0a2f-2687-b65095b9c81f@linaro.org>
Date:   Thu, 11 Apr 2019 22:13:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411193614.GA8469@archlinux-i9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 21:36, Nathan Chancellor wrote:
> On Thu, Apr 11, 2019 at 09:20:56PM +0200, Daniel Lezcano wrote:
>> On 10/04/2019 22:07, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Daniel Lezcano <daniel.lezcano@linaro.org> [190410 17:02]:
>>>> can you ask for an acked-by before pulling a patch in your tree?
>>>
>>> I certainly do ask and wait for acks where possible :)
>>
>> Ok, I may have missed them.
>>
>>> Note that I have not applied this patch. I just added
>>> Keerthy to Cc on this thread so maybe you misread the
>>> message earlier. My comment "seems like no other
>>> takers" was for Ladislav regarding somebody picking up
>>> his earlier work, not for picking up this patch :)
>>
>> Actually I was referring to the commit 592ea6bd1fad. Anyway as stated
>> above I could have miss your call.
>>
>>> In any case, I've been waiting for you guys to pick up
>>> the patch, here's my ack if you're waiting for it:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>
>> The patch does not apply. Is it aligned with tip/timers/core ?
>>
> 
> The commit this fixes is in timers/urgent and it doesn't look like that
> has been backmerged into timers/core.

I can see those fixes in timers/core:

Fixes: 592ea6bd1fad ("clocksource: timer-ti-dm: Make unexported
functions static")
Fixes: 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
omap_dm_timer_set_load_start() static")


Are you referring to another fix?

>>>> On 04/04/2019 16:17, Tony Lindgren wrote:
>>>>> * Ladislav Michl <ladis@linux-mips.org> [190327 08:12]:
>>>>>> Hello Nathan,
>>>>>>
>>>>>> On Tue, Mar 26, 2019 at 10:01:27PM -0700, Nathan Chancellor wrote:
>>>>>>> Commit 008258d995a6 ("clocksource/drivers/timer-ti-dm: Make
>>>>>>> omap_dm_timer_set_load_start() static") made omap_dm_time_set_load_start
>>>>>>> static because its prototype was not defined in a header. Unfortunately,
>>>>>>> this causes a build warning on multi_v7_defconfig because this function
>>>>>>> is not used anywhere in this translation unit:
>>>>>>>
>>>>>>> drivers/clocksource/timer-ti-dm.c:589:12: error: unused function
>>>>>>> 'omap_dm_timer_set_load_start' [-Werror,-Wunused-function]
>>>>>>>
>>>>>>> In fact, omap_dm_timer_set_load_start hasn't been used anywhere since
>>>>>>> commit f190be7f39a5 ("staging: tidspbridge: remove driver") and the
>>>>>>> prototype was removed in commit 592ea6bd1fad ("clocksource: timer-ti-dm:
>>>>>>> Make unexported functions static"), which is probably where this should
>>>>>>> have happened.
>>>>>>
>>>>>> Alternatively you might want to look at "clocksource: timer-ti-dm: Add event
>>>>>> capture": https://patchwork.kernel.org/patch/10237217/ (it makes use of
>>>>>> function being removed here). It is a part of an attempt to add event capture
>>>>>> for OMAP. Of course I would like this functionality to be implemented, but
>>>>>> as I do not have a time to continue, I cannot really object removing this
>>>>>> function.
>>>>>>
>>>>>> Just in case you'd be interested in finishing this task ;-)
>>>>>
>>>>> Well seems like no other takers :) We can always find the missing
>>>>> function in git history when needed, so I suggest we apply this.
>>>>>
>>>>> Adding Keerthy to Cc as he just posted a similar patch.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Tony
>>>>>
>>>>
>>>>
>>>> -- 
>>>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>>>
>>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>>> <http://twitter.com/#!/linaroorg> Twitter |
>>>> <http://www.linaro.org/linaro-blog/> Blog
>>>>
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

