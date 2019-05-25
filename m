Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4603AC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138CC20851
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2+3oUfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfEYOQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 10:16:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55244 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEYOQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:16:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so12007529wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jARxfBsrYNvn7p8/Iwq3xmRStS+33h/bwiy/IOpncSw=;
        b=J2+3oUfC3vN7+6n1601HaKaX2N0bISJtdFuFv7AxD82JHNdlPlSsKja61ewa8f63Fj
         hKAbHrX0BwDFlnvvoFNaO/TVkkmDjAlw1pacC6Y9gi9hBjnCy7BJnvqizLRZAj+uR0Nm
         E03ujVVYpD/P2v45a2BedfgJplBratCM4QliZKsCFTO4yz4zPZzSiHjgoKRdk+oZS84P
         vijPl9LaOh9GTD1AM19CgjjbJ+VswPStIVPrcUimIKplWeQTuum4Ll9CUT3EIhjx6fBp
         AJaG9OUofavZqi/ZEq88Mw2lP1pR12IlEAh/n1qaZovRKgxDqfTtlElc644kZI+SDh3K
         faVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jARxfBsrYNvn7p8/Iwq3xmRStS+33h/bwiy/IOpncSw=;
        b=AI8dnTZlm+tcxtsEJsa62BczCPcNk6fl9uAJzDr5vU9w7KNS5wYfb5Sb724YiEb7lm
         6IyZTZGdWNxE7qvPERtezKAcCHQQyYu4D3Pni3CZnXJe+9qfYokXfnGieneeXXio+DGL
         FzZEUee5KNJ6Zw1ilZ5UBGvbwP4ICPlF3a2Jiocoeqk+wI21ZALq3sXej1bRetU2k9o8
         2UQ3od/A5cCHIbRnGPSUPHPyARn4EjJttC5M/EN1GXsXo1ADcm+ElSUUdH/Ksm02i+OJ
         iQWt4ZCRpftdnUsiesOse1QoG/ZtDC1GXymYQjZs2D8MYYk/yxWkV6NOmitqVGPaguXA
         +cbA==
X-Gm-Message-State: APjAAAX1QHfdYHeiSABvgDSbNuHAsBHxrpJaMhU8TsL+bzL9QYvCsbOQ
        60HplkDLgh/Gfq7vegI5tPnMWA==
X-Google-Smtp-Source: APXvYqwrPmYJuj/du/Dc8iJgUR2Ouxp1rFf0arkcYlJk38pzVkHpeaXVsyMTuTwWL9kjZEwVOZ3S3A==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr20950643wmc.28.1558793772558;
        Sat, 25 May 2019 07:16:12 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id z23sm1996078wml.42.2019.05.25.07.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 07:16:12 -0700 (PDT)
Subject: Re: [RFC v2 1/2] clocksource: davinci-timer: add support for
 clockevents
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190523125813.29506-1-brgl@bgdev.pl>
 <20190523125813.29506-2-brgl@bgdev.pl>
 <dbe04cda-4f42-46b5-0808-e756a65180d2@linaro.org>
 <CAMRc=MfUFE_yBSqS-s4fVcU9W11Amgeer-eXWNBrkG0Z7KD4tA@mail.gmail.com>
 <5f513fdc-7768-43b8-9d0c-56f07a60768f@linaro.org>
 <CAMRc=MeFMQ9rz-=8GktGtaQm1j-X66RsCBTqR3-mofc4Bju8-w@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a4585f30-5fa7-7fde-bbbd-c32464c0f060@linaro.org>
Date:   Sat, 25 May 2019 16:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeFMQ9rz-=8GktGtaQm1j-X66RsCBTqR3-mofc4Bju8-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 13:53, Bartosz Golaszewski wrote:
> pt., 24 maj 2019 o 10:59 Daniel Lezcano <daniel.lezcano@linaro.org> napisał(a):
>>
>> On 24/05/2019 09:28, Bartosz Golaszewski wrote:
>>> czw., 23 maj 2019 o 18:38 Daniel Lezcano <daniel.lezcano@linaro.org> napisał(a):
>>>>
>>>> On 23/05/2019 14:58, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> Currently the clocksource and clockevent support for davinci platforms
>>>>> lives in mach-davinci. It hard-codes many things, uses global variables,
>>>>> implements functionalities unused by any platform and has code fragments
>>>>> scattered across many (often unrelated) files.
>>>>>
>>>>> Implement a new, modern and simplified timer driver and put it into
>>>>> drivers/clocksource. We still need to support legacy board files so
>>>>> export a config structure and a function that allows machine code to
>>>>> register the timer.
>>>>>
>>>>> The timer we're using is 64-bit but can be programmed in dual 32-bit
>>>>> mode (both chained and unchained). We're using dual 32-bit mode to
>>>>> have separate counters for clockevents and clocksource.
>>>>>
>>>>> This patch contains the core code and support for clockevent. The
>>>>> clocksource code will be included in a subsequent patch.
>>>>>

[ ... ]

>>>>> +static unsigned int
>>>>> +davinci_clockevent_read(struct davinci_clockevent *clockevent,
>>>>> +                     unsigned int reg)
>>>>> +{
>>>>> +     return readl_relaxed(clockevent->base + reg);
>>>>> +}
>>>>> +
>>>>> +static void davinci_clockevent_write(struct davinci_clockevent *clockevent,
>>>>> +                                  unsigned int reg, unsigned int val)
>>>>> +{
>>>>> +     writel_relaxed(val, clockevent->base + reg);
>>>>> +}
>>>>> +
>>>>> +static void davinci_tcr_update(void __iomem *base,
>>>>> +                            unsigned int mask, unsigned int val)
>>>>> +{
>>>>> +     davinci_tcr &= ~mask;
>>>>> +     davinci_tcr |= val & mask;
>>>>
>>>>
>>>> I don't see when the davinci_tcr is initialized.
>>>>
>>>
>>> It's set to 0x0 by the compiler and we're setting the register to 0x0
>>> in davinci_timer_init().
>>
>> Why did you need to readl before in the previous version? The idea of
>> caching the value was to save an extra readl.
>>
>> If it is always zero, then we don't need this variable neither the read,
>> just doing:
>>
>> writel_relaxed(val & mask, base + DAVINCI_TIMER_REG_TCR);
>>
>> should work no ?
> 
> It's not always zero. Its reset value is zero and we write 0 to it at
> init time just to make sure, but then we modify it according to the
> configuration. The single TCR register controls both halves of the
> timer, so we do need an actual update, not a simple write.

Ok but the driver can be oneshot or disabled in the code (mutually
exclusive), no ?

So doing

 - writel(oneshot, base);
 - writel(disabled, base);

works without any mask computation, no?

Well the above assumes other part of the register aren't changed by
other subsystems (or by the timer itself).











-- :
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

