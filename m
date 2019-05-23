Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C835C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AB320862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISreeSU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfEWNZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:25:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43329 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbfEWNZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:25:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so5971662wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wbRasSgTQa32t2jIb/yGrsi9dG9VweUBHx1lryI7rqs=;
        b=ISreeSU5fm64y5nIINtKesjdhpNNQjNJFes6JFFmqw2RTwqpmqba4CaUrIGrMmsMgb
         PGTpmonHdvY8tbDzNL48mosdHzvMILM+WZ+u8LAfxpM5dfuVnVS+PLc54nQFYy9PEeAh
         umy04EHHnPoC92T+JXk10eBzOuWo4T1TmC/fobAcusXG4c95E9IoN0QnCBj3zfgyzGIw
         x51u3gB4tyXnzTJLt/FHTGowCi3ufFXfS/qtJ25+oV1rH0qqMV2nqRWsqehKmEXhXvhk
         tf2PBbQF1uB3DJO7H4jYxg53SFoPBmEO6/m7VeC65w5z2oqZVpC4m7XnUym883xHAxmo
         FPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbRasSgTQa32t2jIb/yGrsi9dG9VweUBHx1lryI7rqs=;
        b=Pc/87x3XOGC4d/pWfZGV/phobweOhr0E1ZNypjCN3aaPwPVnOYJZNGhdBxF9A65nTu
         98o6Hs/5NAXlFeQMFDV7BSHA2+4XAztU6in++q7rx4Vzw+1wP+3/NNl0vZvNdFOjbHQ6
         MxJSFX/o3AUE1jgjFu37iUbTjc2AC7LlOshIDk1GTdNYXuCi+bPyT7FNU1nwp0hiYn9c
         COUb5GW0F1NMI5vK3sX8hsXPelaTXkKZvy3r9BgzuGCSkTHuPwsBMk0RgshScf1j1kXJ
         HOtHPu8XD6YLeDNFFgxIpO24gwaVEwQ/WAxnsBgG2dOaWGcGGN8oPt7BuQ/w7hfokVrB
         SLxQ==
X-Gm-Message-State: APjAAAWIEJJyMmNCNNcpXbQ6kwyTccHe/WCropYdSDzxp5EAw8EdAkq6
        TgFYbVJ/E35XMUOSISFiTX8y51Ix2mOByQ==
X-Google-Smtp-Source: APXvYqzgjoLbtDHSUM0BbzPB/AEW11R/JZZOjqkDy1w4+S9jeqCNZbxcnwc7bmnodJXUt/zG5+zp9Q==
X-Received: by 2002:adf:cc8b:: with SMTP id p11mr44444965wrj.13.1558617949630;
        Thu, 23 May 2019 06:25:49 -0700 (PDT)
Received: from [192.168.43.165] ([37.170.117.75])
        by smtp.googlemail.com with ESMTPSA id i125sm17099647wmi.2.2019.05.23.06.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 06:25:49 -0700 (PDT)
Subject: Re: [RFC 1/2] clocksource: davinci-timer: add support for clockevents
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190417144709.19588-1-brgl@bgdev.pl>
 <20190417144709.19588-2-brgl@bgdev.pl>
 <187fdcd8-4cc8-3871-ee66-1ebd7408b1fe@linaro.org>
 <CAMRc=MdQ_GORGaw1szwvBRqKzkZQCZNnEcwkNzmGduEbiDR4Lw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ca00f49f-0fa2-1907-feac-ba798dce365b@linaro.org>
Date:   Thu, 23 May 2019 15:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdQ_GORGaw1szwvBRqKzkZQCZNnEcwkNzmGduEbiDR4Lw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bartosz,



On 23/05/2019 14:58, Bartosz Golaszewski wrote:

[ ... ]

>>> +++ b/drivers/clocksource/timer-davinci.c
>>> @@ -0,0 +1,272 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +//
>>> +// TI DaVinci clocksource driver
>>> +//
>>> +// Copyright (C) 2019 Texas Instruments
>>> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> +// (with tiny parts adopted from code by Kevin Hilman <khilman@baylibre.com>)
>>
>> The header format is wrong, it should be:
>>
>> // SPDX-License-Identifier: GPL-2.0-only
>> /*
>>  * TI DaVinci clocksource driver
>>  *
>>  * ...
>>  * ...
>>  *
>>  */
> 
> It's not wrong. It looks like it's at the maintainers discretion and
> I've been asked to use both forms by different maintainers. Seems you
> just can't get it right. :) I've changed it in v2 though.

Right, I've been through the documentation but it is still unclear for
me. So let's stick to whatever you want for now.

[ ... ]

>>> +static int
>>> +davinci_clockevent_set_next_event_std(unsigned long cycles,
>>> +                                   struct clock_event_device *dev)
>>> +{
>>> +     struct davinci_clockevent *clockevent;
>>> +     unsigned int enamode;
>>> +
>>> +     clockevent = to_davinci_clockevent(dev);
>>> +     enamode = clockevent->enamode_disabled;
>>> +
>>> +     davinci_clockevent_update(clockevent, DAVINCI_TIMER_REG_TCR,
>>> +                               clockevent->enamode_mask,
>>> +                               clockevent->enamode_disabled);
>>
>> What is for this function with the DAVINCI_TIMER_REG_TCR parameter?
> 
> I'm not sure I understand the question. :(

I meant davinci_clockevent_update is always called with the
DAVINCI_TIMER_REG_TCR parameter.

So it can be changed to:
static void davinci_clockevent_update(struct davinci_clockevent 	
						*clockevent,
					unsigned int mask,
					unsigned int val)
{
	davinci_reg_update(clockevent->base, DAVINCI_TIMER_REG_TCR,
				 mask, val);
}


Alternatively davinci_clockevent_update can be replaced by a direct call
to davinci_reg_update.

[ ... ]

>>> +     clockevent->dev.cpumask = cpumask_of(0);
>>> +
>>> +     clockevent->base = base;
>>> +     clockevent->tim_off = DAVINCI_TIMER_REG_TIM12;
>>> +     clockevent->prd_off = DAVINCI_TIMER_REG_PRD12;
>>> +
>>> +     shift = DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
>>> +     clockevent->enamode_disabled = DAVINCI_TIMER_ENAMODE_DISABLED << shift;
>>> +     clockevent->enamode_oneshot = DAVINCI_TIMER_ENAMODE_ONESHOT << shift;
>>> +     clockevent->enamode_periodic = DAVINCI_TIMER_ENAMODE_PERIODIC << shift;
>>> +     clockevent->enamode_mask = DAVINCI_TIMER_ENAMODE_MASK << shift;
>>
>> I don't see where 'shift' can be different from TIM12 here neither in
>> the second patch for those values. Why create these fields instead of
>> pre-computed macros?
>>
> 
> The variable 'shift' here is only to avoid breaking the lines (just a helper).
> 
> The shift itself can be different though in the second patch -
> specifically when calling davinci_clocksource_init().
> 
> If I were to use predefined values for clockevent, we'd still need
> another set of values for clocksource. I think it's clearer the way it
> is.

Ah yes, I see, it is passed as parameter. Ok, let's keep it this way if
you prefer.

>>> +     if (timer_cfg->cmp_off) {
>>> +             clockevent->cmp_off = timer_cfg->cmp_off;
>>> +             clockevent->dev.set_next_event =
>>> +                             davinci_clockevent_set_next_event_cmp;
>>> +     } else {
>>> +             clockevent->dev.set_next_event =
>>> +                             davinci_clockevent_set_next_event_std;
>>> +     }
>>> +
>>> +     rv = request_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
>>> +                      davinci_timer_irq_timer, IRQF_TIMER,
>>> +                      "clockevent", clockevent);
>>
>> May be replace "clockevent" by eg. "tim12"?
>>
> 
> I don't think this is a good idea. Now if you look at /proc/interrupts
> you can tell immediately what the interrupt is for ("clockevent").
> With "tim12" it's no longer that clear.

Yes, "tim12" can be confusing. However, it is good practice to add a
device name aside with its purpose in case there are several timers
defined on the system. "clockevent" is a kernel internal representation
of a timer, so may be a name like "timer/tim12" or something in the same
spirit would be more adequate.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

