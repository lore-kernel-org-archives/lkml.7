Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E51BC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FE12075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHZaSRtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfECUbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 16:31:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38914 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECUbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 16:31:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id a9so9343109wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gBhXA59o/c781Pvshp85zebQ9EEVjzWDcnY6gG7a87w=;
        b=PHZaSRtmiNGiwAV8S5F9JHdFSjGfqFg+LkAMtDezkRzbYSNAWuCt2quelw2tF58iYn
         ZnkYxYDCTR2y/V/HCbC4pvBDdi6+wGfkLGt7hjF+dfAbZw1kejNypPKYgACjPJHvbGBi
         fhTOV4gXgU2vbqSoVbRX9MFuBnLa/GM9RiiORPYy48QIOpvdxH2BBGeVIifSsnD0i+Gw
         oZ066xHQUmFveUxz45pU8jhDmlxAs6S2T5e8SNWOoErxp9eedLWEJI88yKrWXDvzQzMZ
         O05uJwvayXvR8xpqrh1jJ9RnKrM2noeuL6Ct8b1J4V+VEBu4NuaWCrgBAI45SfeMUyYY
         pISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gBhXA59o/c781Pvshp85zebQ9EEVjzWDcnY6gG7a87w=;
        b=oVv5lgytg85Fns5n40REsIcsxYGRKRvFX+wGOSqdvckIAgywAR9HS6Qj8Jwr2+rUXw
         pM2DxRHcDpvHB0aMty4zKI8d+aWOHoFhYwIiM/E6pf1Y3Isli3Cpyl6hbHZcHnJe2rBs
         xddruuzfRGEEVMDQW+Dt+3hnZ8K6PuFuKuR5ba1BPZrVZUawOWn++sfjyuTX3GWJXoAC
         pCRxkPuepCfSEfqYscNRIhuaFpVizDTLV90z4mJ4k/Gb0gjb0QfGhU5RtLil29nfVjLn
         YaOYlSL2+99guV4xDL5VdaikpHFG+w4wABqtPIH/QHILuL/R/0qMpWYKYGIu0XyELnnB
         gTTQ==
X-Gm-Message-State: APjAAAXMF008sxI1WgnWxTXe9ps1Xmga5+KQJ7bjG/v+yHMpbxpbTx6s
        3pongMzSMaPlBqLMesdfCdT4mH2qBQs=
X-Google-Smtp-Source: APXvYqzTCgSlT6YwMdtVV+8KbloZwQiWOo5rQ3sEqs15f5DRkzOvlRByLiiJKVdhu2CyhmXoGKBCnw==
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr8037426wre.259.1556915504762;
        Fri, 03 May 2019 13:31:44 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id i30sm4225043wrc.8.2019.05.03.13.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 13:31:43 -0700 (PDT)
Subject: Re: [PATCH 7/7] clocksource/arm_arch_timer: Use
 arch_timer_read_counter to access stable counters
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-8-marc.zyngier@arm.com>
 <2a60a031-1eab-2d5e-89ff-b5d516545eeb@linaro.org>
 <bbe9b8c1-132f-bbfa-e3d0-ad10c4165ad7@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2f3417f6-95e5-f27a-693d-5aa460fb152d@linaro.org>
Date:   Fri, 3 May 2019 22:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bbe9b8c1-132f-bbfa-e3d0-ad10c4165ad7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 30/04/2019 17:27, Marc Zyngier wrote:
> On 15/04/2019 13:16, Daniel Lezcano wrote:
>> On 08/04/2019 17:49, Marc Zyngier wrote:
>>> Instead of always going via arch_counter_get_cntvct_stable to
>>> access the counter workaround, let's have arch_timer_read_counter
>>> to point to the right method.
>>>
>>> For that, we need to track whether any CPU in the system has a
>>> workaround for the counter. This is done by having an atomic
>>> variable tracking this.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>
>> [ ... ]
>>
>>> +
>>>  /*
>>>   * Default to cp15 based access because arm64 uses this function for
>>>   * sched_clock() before DT is probed and the cp15 method is guaranteed
>>> @@ -372,6 +392,7 @@ static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
>>>  DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
>>>  EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
>>>  
>>> +static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
>>
>> Wouldn't make sense to READ_ONCE / WRITE_ONCE instead of using an atomic?
> 
> I don't think *_ONCE says anything about the atomicity of the access. It
> only instruct the compiler that this should only be accessed once, and
> not reloaded/rewritten. In this case, WRITE_ONCE() would work just as
> well, but I feel that setting the expectations do matter.
> 
> I also had a vague idea to use this as a refcount to drop the
> workarounds as CPUs get hotplugged off, in which case we'd need the RMW
> operations to be atomic.
> 
> Anyway, I'm not hell bent on this. If you fundamentally disagree with me
> I'll change it.

As you are planning to extend its usage for refcounting in the hotplug
path, I think it is fine.

Thanks

  -- Daniel




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

