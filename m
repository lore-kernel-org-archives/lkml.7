Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF33CC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DFA21841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZjKCDCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfEVITe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:19:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33707 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbfEVITc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:19:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so4119063wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wm7USqdu+jHYGWfH9S7SpMuameCsVZ9veEzhXK92UAo=;
        b=JZjKCDCBSttnMb0+fn138fsCpqGDGVoOKzPgaU2mAoTZrx++Uerj2qFFt7Lq+L7q6A
         ANii67poZ7jScEk2s3V4T8O76prygpZJP71t4AeDerVqJpMWUa2bA7WPshdbtPBKiKCy
         B95OpFp/w7DD79nEoymu6uHIQ32w+PBa5NmM193gxIL4MT43X5BfiTtLlmFY/14FbCwh
         jtx10k8/mnjiqzE6GexW2WRcnLTsJsrwYuhqL6WNe+lA0qptdQtDzNpEiBgTgBMVHdcm
         JVEnoTK3FLpQVfgQWSy72jGZyNID2cnZ1uSaRuWgVxt8dYP1bVjWscp/m+rqK0jMkyrv
         btig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wm7USqdu+jHYGWfH9S7SpMuameCsVZ9veEzhXK92UAo=;
        b=bCQNP5vbgYb7I3k8BEMGww6k9PJiKwBjuu4huSlauiOeFKEIdQsIaqO78IJqXau5Wg
         MI58UYJrME48+TpeHdBCczKvf/LLxQT2Zx9ZHPZYpqYMAtkY8hdPW9cOUsH5tvgO7mHL
         Y+aWUmr4530vxYOPyqLnf3MtwnNxHlWHAm6u2xt+cggJlRxXhp6XWWFQB9dGfuhyprU0
         Zn2Yc9H9zR+tPM3BpeV8vXU/aEFVVEswEkUplWz1tYpEYEGGpZHJSYUo50ybVSzZIbWu
         djCoCwjxUKUMV3PpcxavaKz8R3qJH/QCv+2eTNqTEr0DJcshyTYVLbQgA92qUwejEibh
         /Vtg==
X-Gm-Message-State: APjAAAWY021pepfgNVx2EbBS2Wpt5ky7baon+35APAl30clr4tz+VrO9
        RbbxA2mxEQNy6qvJbDqHpOuH2JkYJH/4pw==
X-Google-Smtp-Source: APXvYqxjLZytVFJILZeHk5UQVBKybXMi9/eW9XaTxhyiW3F+6M1upnZ0tBsOLRxV/JKsXWxtf9dGWA==
X-Received: by 2002:a1c:cb0e:: with SMTP id b14mr6125266wmg.61.1558513170535;
        Wed, 22 May 2019 01:19:30 -0700 (PDT)
Received: from [10.1.203.87] (nat-wifi.sssup.it. [193.205.81.22])
        by smtp.googlemail.com with ESMTPSA id o4sm6530168wmo.20.2019.05.22.01.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 01:19:29 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: at91sam9261ek: remove unused chosen nodes
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190408151155.20279-1-alexandre.belloni@bootlin.com>
 <2f831f1b-c87d-48bd-cf02-2ebb334b964c@linaro.org>
Message-ID: <1aa65857-7638-b78f-8cde-cc5c968555cc@linaro.org>
Date:   Wed, 22 May 2019 10:19:29 +0200
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


Hi Rob,

a gentle ping ... ;)

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

