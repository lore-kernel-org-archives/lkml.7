Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4160CC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E30D206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIDd54xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfD1Mr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:47:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53663 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfD1Mr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 08:47:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id 26so10155271wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HeqZfMG85Hh9y7RrB9f0z3kHk2qos78GYvMoJ7R8cWc=;
        b=VIDd54xqsBjyWypghXVEKrXZmwbUthgDhIYp4h4EKt+H2hiO84916d5PZjDtYd3Kd1
         CaJvrtquCfh/T2kxNygu5iUZUx788BEmM7mYi+gN2E3B9cjDKvgYFb1hAGRpFGX7Afzp
         daWy9XFgKszgHtzO3ACjjUyA7Vo5HzfKOvx4ijsRNuOCX03PyjYMpOZ8q5NoQxw2h7gw
         Rj4N0MNmCGuGlKjqpvUyxKBD0ey4Gb5mHIZJNUJiLq9dNkeFylNtNKncPORFIqYCTJV4
         3Sgr3dgDCUkzr/UkxmEjVuQeWDsuQbOMaH5dZ8tUw5sdgxLcyEOs/MnjrtbbbOnozXUM
         h8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HeqZfMG85Hh9y7RrB9f0z3kHk2qos78GYvMoJ7R8cWc=;
        b=B93y4dkQdlL7Q8VtVSnrbh9zBjTPGqwBKii6vM/wvzQUzj1MaQTbNTWDv96smFdzgZ
         avlj533oOMUaoNpsNyYjhehmC9JojRFktslMD6fGPlSl8Xx+P4tHJOT9DfRDkbtTLSkf
         HbvAp3YSGswQNP3RcSTj7QJJJSCa/9blLEtKuXeKy9vq3CyrmjBP790sS74rTOA/AFr1
         J5nBJySMFrC5YMqQT+oSUtBCkMPZbp2kKAxM2llOoM48e3E0f+WMvhvadXUms77daAzS
         jJ4iDmDJ4BhQ8yiGd2kiA2N5Dw6XcSCnuVk0G0IsKQVnZ0HGnzN5YWw1eqtQgMPwq+l3
         Epvw==
X-Gm-Message-State: APjAAAX2dJfP2tSTI1z1nwIlebu3TlarSzelkz2dXSWJa4dEZodCciYc
        KbniYmcZqtL+oCeqTwCbyM2K10ZKfwc=
X-Google-Smtp-Source: APXvYqwkZgNRFbMqz/Vpf+gKG6RMI2QqcdMUVem2/kPB4Xo68FgesFEo4ptEr/mPbC86hsEJdvNNrQ==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr13864555wmb.110.1556455646425;
        Sun, 28 Apr 2019 05:47:26 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id o5sm28238015wmc.16.2019.04.28.05.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 05:47:25 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: at91sam9261ek: remove unused chosen nodes
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190408151155.20279-1-alexandre.belloni@bootlin.com>
 <2f831f1b-c87d-48bd-cf02-2ebb334b964c@linaro.org>
Message-ID: <c71a65c4-51bd-2dec-07bb-31daa3715325@linaro.org>
Date:   Sun, 28 Apr 2019 14:47:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2f831f1b-c87d-48bd-cf02-2ebb334b964c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?


On 08/04/2019 18:30, Daniel Lezcano wrote:
> 
> Hi Rob,
> 
> the following patch has been pushed in 2016 by commit 51f0aeb2d21f1.
> 
> Being able to specify which timer should act as a clocksource or a
> clockevent is often requested. Doing this from the driver itself forces
> to do some assumption in the timer definition ordering in the DT.
> 
> That impacts badly the resulting code and its self-encapsulation.
> 
>  - There is one node and the driver hardcodes the value and initializes
> a clocksource and a clockevent
> 
>  - There are several nodes, one for the clocksource and one for the
> clockevent, and the driver assumes the order of the node in the DT
> 
>  - There are several nodes and multiple channels and those are used for
> PWM. It is impossible to know which one are used for PWM or for the
> clocksource or for the clockevent
> 
> For example with STM32, we should be able to specify which timer to use.
> There are 16 timers IIRC, they can be used for PWM, clocksource or
> clockevent. Half is 16 bits, other half is 32 bits, depending on the
> destination of the platform we can be interested to use one or another
> without recompiling a kernel but just the DT.
> 
> We need a way to specify which timer to be used from the DT. The patch
> below sounded like a good way to characterize the nodes as they belong
> to the 'chosen' node and we stay to a 'linux' thing.
> 
> What do you think ?
> 
> 
> On 08/04/2019 17:11, Alexandre Belloni wrote:
>> The chosen clocksource and clockevent bindings have never been accepted and
>> parsed, remove them.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> ---
>>  arch/arm/boot/dts/at91sam9261ek.dts | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
>> index a57f2d435dca..11ed55d8a87d 100644
>> --- a/arch/arm/boot/dts/at91sam9261ek.dts
>> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
>> @@ -15,14 +15,6 @@
>>  	chosen {
>>  		bootargs = "rootfstype=ubifs ubi.mtd=5 root=ubi0:rootfs rw";
>>  		stdout-path = "serial0:115200n8";
>> -
>> -		clocksource {
>> -			timer = <&timer0>;
>> -		};
>> -
>> -		clockevent {
>> -			timer = <&timer1>;
>> -		};
>>  	};
>>  
>>  	memory {
>>
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

