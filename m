Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7104BC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410772075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwsPLUjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfECUcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 16:32:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36591 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfECUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 16:32:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id o4so9366020wra.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yFWs26NyTQBBHnTLimY9fErMEAAd/wEGYGdh8uiAhr0=;
        b=bwsPLUjEVmFYODhU+c2MOxzIKK3emyjBG6iCWkMYBqFtQoZdtIYr6hP52/jRNoLJo3
         eWFwTsZ2fupPL6Yoij/cbTqbcsRY+MzOnQEEKtNsW53PcpsKck2s4WkmtNdIqAiaXUAy
         E3mzAvJqLybY/fO/hL8AAASs3qDmwPdkVMzVPx2N1Y41P4Mbq+zvb+n2nkupMjvO1YqX
         0kDWD4Vcls4ZVIQ5kCgjh7EeAMPRqNNgVglP9OP3zyMjI8L2apKkMVzj7JNQKHSmwlun
         gj4oDbVZVohDucTN1kUJOHCyBXUxoVk1ncVAOn3CjBu//3/hgcrBaoVvgGOLCygDOHzl
         nQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFWs26NyTQBBHnTLimY9fErMEAAd/wEGYGdh8uiAhr0=;
        b=BcOe0B8u01Oez2E7sNX5JuKkSM7QRtrxNVsM4CcvknqY9hH/klRevYfTlMx7uJZdCz
         VB0q9l44xhvBevBbpth6M32ncmnqJ2/TRhdPk0YhCHqNvspUZzZSb2NUU/W0XodLSEYz
         l3fURG29wENLF3nqF1nBLhxvjrylUwN4uWQMp0DK7RGt90RhoO0WhuuNs8K63Ma6+l8E
         mLDjZWKSMhrTnQ/vnFklNJNu4xX6JNTe5WAOcN53Jqdh4mtuZ49JVjO5apVzbt2ssLh5
         3pBD4MjxEtyv8Neo8pm60/WcwvIuvwG1TaG2S+sVrQ4L/biAWXDmbiNCod4GUOdzJWAp
         ITaQ==
X-Gm-Message-State: APjAAAUf5/lmdEEDe+Dl1WyWtx7tINdm52ygqRAWU2PWwOp4eKaUzxoR
        elCG3X3pNJIvBapQ9XtJYw1r+T0FL78=
X-Google-Smtp-Source: APXvYqydkBhECIudeVFVl1XOv4VNXeL9LFJR4eBdis9OQQ3nSkYQIomuAj4y2ShR8eFhfGxf0ZXcjA==
X-Received: by 2002:adf:fd04:: with SMTP id e4mr8683562wrr.145.1556915546193;
        Fri, 03 May 2019 13:32:26 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id e8sm4779602wrc.96.2019.05.03.13.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 13:32:25 -0700 (PDT)
Subject: Re: [PATCH 7/7] clocksource/arm_arch_timer: Use
 arch_timer_read_counter to access stable counters
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-8-marc.zyngier@arm.com>
 <2a60a031-1eab-2d5e-89ff-b5d516545eeb@linaro.org>
 <bbe9b8c1-132f-bbfa-e3d0-ad10c4165ad7@arm.com>
 <cef220b8-f46d-0653-8249-a9d48b2efc48@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c8449908-1f8a-a10e-bfce-95bd7415e523@linaro.org>
Date:   Fri, 3 May 2019 22:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cef220b8-f46d-0653-8249-a9d48b2efc48@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Valentin,

On 30/04/2019 17:39, Valentin Schneider wrote:
> Hi,
> 
> On 30/04/2019 16:27, Marc Zyngier wrote:
> [...]
>>>> @@ -372,6 +392,7 @@ static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
>>>>  DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
>>>>  EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
>>>>  
>>>> +static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
>>>
>>> Wouldn't make sense to READ_ONCE / WRITE_ONCE instead of using an atomic?
>>
>> I don't think *_ONCE says anything about the atomicity of the access. It
>> only instruct the compiler that this should only be accessed once, and
>> not reloaded/rewritten.
> 
> FWIW 7bd3e239d6c6 ("locking: Remove atomicy checks from {READ,WRITE}_ONCE")
> points this out.

Interesting, thanks for the pointer.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

