Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1797C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E6A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7OCgUGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfEUMUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:20:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35212 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEUMU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:20:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so2685306wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sQApL1cqd19VkIm4pubZ6dXE2WTIfR88gzmCttd0K/A=;
        b=R7OCgUGMrSIeViC8AH6N5r+HN+2K3QGt7qjUECLJGUPDlLd7IklNJAowqbGLPhw+UD
         dfvVSryq1Zq5b8xen4ZTDfqQNN/lEFn+iowlblxjp+log2JS8qHkG7MA1EhkZWVts1nJ
         IdBbTSUnFLUeruwrslNvRALU1W6n03RUTn9fyH6fSGUB2PXAbYhDTeWbo1NtqmsKjQ7U
         vwUMNS4loVHRAWsQFn1yi0UboLINfksLl+qs9UECalsBhHyKkgKNYowHpH+rUttqWi7m
         miC/xfrqCZd1BvrZrA9GbL95jRbYsHzHHqMhVxFAcaaXPkUTwYnO1U0J+QS+/G85vzYA
         Dn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQApL1cqd19VkIm4pubZ6dXE2WTIfR88gzmCttd0K/A=;
        b=m2hjvTyKZnHZTr6yZKI1YqVYCiAgJ3HtCtgTvNteAHxp78/fCzSYnO0TulzwyZQQRI
         yOOYIHUv0QMkg9GPu+qPs+em1z+4kQFh9x8WmK5M4Do3zZXuvjqp6VvvWPbd8s4wJNZE
         haUvh81a2+2ztyogvNflDhwNbJtgT+LB3m2rCzdMawV4013nENZ7IxnydKpBytJqOy+3
         w13k18gVMWK2x6sudV2u7wdbF82U9YmOLex4/EUT11hKXy7P009WMdD5H7ZWIm9/rizq
         sSTqhpslZdVHoCqdxnPpglp0ouSOkoujSz1SDCUi5wi0GuyIKszGoESHXgVcBd++HVp9
         rXsQ==
X-Gm-Message-State: APjAAAXreqTARYlU3IKSiwX6GEEvlD9eQMMKXqodOuZI0u+nMU3FBw1l
        J8RcLCgHoUj/a+RaK4g9VAfKRg==
X-Google-Smtp-Source: APXvYqzWFC1JYdWW2qx2XJeNPiFqqrIssBm1g1LraQauF+PsEAx/Kn0wKkDxf+v8EVzo0N7Y85O11g==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr3042359wmc.36.1558441226627;
        Tue, 21 May 2019 05:20:26 -0700 (PDT)
Received: from [192.168.27.66] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 74sm3013102wma.7.2019.05.21.05.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 05:20:25 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] driver: clocksource: Add nxp system counter timer
 driver support
To:     Jacky Bai <ping.bai@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20190521072355.12928-1-ping.bai@nxp.com>
 <20190521072355.12928-2-ping.bai@nxp.com>
 <5823cd07-312b-600c-1b78-dc5bff2a12eb@linaro.org>
 <VI1PR0402MB3519B14C5AF93F246907F03A87070@VI1PR0402MB3519.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bc03b0c8-52cf-58e1-e7b3-bb1f2345c05b@linaro.org>
Date:   Tue, 21 May 2019 14:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3519B14C5AF93F246907F03A87070@VI1PR0402MB3519.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 14:01, Jacky Bai wrote:
> 
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: Tuesday, May 21, 2019 6:08 PM
>> To: Jacky Bai <ping.bai@nxp.com>; tglx@linutronix.de; robh+dt@kernel.org;
>> shawnguo@kernel.org; mark.rutland@arm.com; Aisheng Dong
>> <aisheng.dong@nxp.com>
>> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>
>> Subject: Re: [PATCH v4 2/2] driver: clocksource: Add nxp system counter timer
>> driver support
>>
>> On 21/05/2019 09:18, Jacky Bai wrote:
>>> From: Bai Ping <ping.bai@nxp.com>
>>>
>>> The system counter (sys_ctr) is a programmable system counter which
>>> provides a shared time base to the Cortex A15, A7, A53 etc cores.
>>> It is intended for use in applications where the counter is always
>>> powered on and supports multiple, unrelated clocks. The sys_ctr
>>> hardware
>>> supports:
>>>  - 56-bit counter width (roll-over time greater than 40 years)
>>
>> The benefit of using more than 32bits on a 32bits system is not proven.
>>
> 
> It is mainly used on 64bit ARMv8 system.

Oh, ok. Fair enough.

> 
>> The function to read and build the 56bits value can have a very significant
>> impact on the performance of your platform.
>>
>> Using a 32bits counter can be enough if it does not wrap too fast.
>>
>> Can you consider a 32 bits counter ?
> 
> this counter is ARMv8 arch timer's counter source. As it also has timer function, so I choose it
> to act as a broadcast timer for cpuidle. The timer interrupt can only be triggered when 'compare[55:0] <= counter[55:0]'.
> So you mean that only use the lower 32bit to implement this timer? If so, I can change to use only the lower 32bit.

IMO it is preferable but you decide (probably compare with how long it
takes to wrap when 32bits).



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

