Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A6AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6AB20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXTUkV+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfDCDdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:33:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40503 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCDdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:33:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so4323513plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 20:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jbb66Gq4hxOmdDo413ybTs1TFHX9luMtW2Ycj0bUqGk=;
        b=hXTUkV+MQqfSMg+pre8w1bv+alE7XnEuXrIU41z2RE3j6dgyLtP8gvBZni/UDVgcQ1
         aNXnWlxG/+Lz+08skF5QtIH/CkV3UPhOfDmtAJWPjpYhD0Zkv3j/XySpDUkhofeIS6Oo
         q+FsumoyUMJB1L/wtT0h0iyuMZjsnazqK6th9qYrtp6uC54dYLqebAcVv77TCYnpRT4M
         V+Jxth+PDNdxhKbVcZ0VcDq9vaYjDPhw6VJaia7tw3aC2niRNRkbG6ND9VeUIfRD/ISG
         ndeyU6fUy9fjxMmRP8z4KUJD3UgvX0xYa6llauLa3j9NjNXlE5glYGWqtOUg9cVLV1Mf
         Kgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbb66Gq4hxOmdDo413ybTs1TFHX9luMtW2Ycj0bUqGk=;
        b=azYIEf7PTUOynmF0YmJdB3El0MxiHzb9flq00gewD7W19WCCRZLTMF1T5X3qVMyavI
         VTzE1gXox8EJHYrHiEDqIL+UXcixMsSrRz8to3VxaFofSiNnK0W5vWSRyfrZjN5j09Ke
         4xC/HUH4diRw6Bnh4tRRHDrZlBvsjw6oj8nbstjkvL/OGzq6rvbejI19yawxvUsnQwp7
         HWuFg1eitpUWUFwRpPufV+MY5/ZY4nglhuWl+Zp5wwGqUaF69iUbN82MawFgLCHpx2T/
         mPxINfUv1M8IyyRv3EYJ+dw4L16R5QF4ojMCGHfnIvKyP2NzDK35fsbPltVA3LJE9Yhd
         fI+w==
X-Gm-Message-State: APjAAAWmrwNjjjQR8Z2JpcFQilmKztPPjHWSraDJ0OBdmB1HnvVxjBM7
        tqUBw0tXK3PcJJWax7oQSYTAgw==
X-Google-Smtp-Source: APXvYqzYbiZDMR2KYfXB9LCNMpazJWieTQjoWPgjDD2xAmCVP+cUnlZCvYJiQoddac7tcjhgTfBfKg==
X-Received: by 2002:a17:902:7481:: with SMTP id h1mr33384652pll.206.1554262379491;
        Tue, 02 Apr 2019 20:32:59 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id t82sm39923872pfa.153.2019.04.02.20.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 20:32:58 -0700 (PDT)
Subject: Re: [PATCH 5/7] thermal/drivers/core: Remove depends on THERMAL in
 Kconfig
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-5-daniel.lezcano@linaro.org>
 <CAHLCerNvp9Bb0TwCcO91ecrbzKGe7epCHFk=fx4RGJgHDE_BRA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9afb2911-512a-9048-9ed8-6aa9dd29a848@linaro.org>
Date:   Wed, 3 Apr 2019 05:32:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHLCerNvp9Bb0TwCcO91ecrbzKGe7epCHFk=fx4RGJgHDE_BRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 02/04/2019 20:51, Amit Kucheria wrote:
> On Tue, Apr 2, 2019 at 11:14 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The dependency on the THERMAL option to be set is already there implicitly
>> by the "if THERMAL" conditionnal option. The sub Kconfigs do not have to
>> check against the THERMAL option as they are called from a Kconfig block
>> which is enabled by the conditionnal option.
>>
>> Remove the useless "depends on THERMAL" in the Kconfigs.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig       | 2 --
>>  drivers/thermal/intel/Kconfig | 1 -
>>  drivers/thermal/qcom/Kconfig  | 1 -
>>  3 files changed, 4 deletions(-)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index ccf5b9408d7a..d8aa7fac8c56 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -24,7 +24,6 @@ config THERMAL_STATISTICS
>>
>>  config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>>         int "Emergency poweroff delay in milli-seconds"
>> -       depends on THERMAL
>>         default 0
>>         help
>>           Thermal subsystem will issue a graceful shutdown when
>> @@ -152,7 +151,6 @@ config CPU_THERMAL
>>         bool "generic cpu cooling support"
>>         depends on CPU_FREQ
>>         depends on THERMAL_OF
>> -       depends on THERMAL=y
> 
> This will break the intention of afa1f2ab43d48d0e1. At the moment, we
> need THERMAL=y if we want cpu_cooling.

The patch 1/7 changes the thermal option from tristate to bool, so the
thermal is compiled-in always. The dependency is no longer needed in
this case. Did I miss something?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

