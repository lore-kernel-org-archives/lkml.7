Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30A3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4D72166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUo2nTdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKGTjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:39:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52547 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKGTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:39:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id c17so3788827wmk.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9a7fJg7X5ZGewqvjA5LZwm7IjwMkLyF2YEiM5wrvuak=;
        b=MUo2nTdjCCe5diqCGSu2xoCQ0YMbvHgaxPZt5fTTEVu+O6TBet9izOOX7vmH198rKY
         EuQwiR9V77eey4436rweqAPp+YfvvD4ZHX6kHjyBn2r79fMPgKJYX79cbwc4BGn/Kce9
         c7S8L3bF5i9a+Mq8BdLcIemHpVVY/zo4pT/zUNlojR9Kb38Qr0uusea3f0ASUzQKe74e
         dE95IyRi3LbYbcKMYehpsriZ4prvxWD4bZZnAde2WOLqcHP64uZAB3tlcU6E22q65Zly
         khBUCvR6qYHCahe0OB4gGi7h/yTmZx1x3uYyOokveTWGPYyqHFYY1LQ2JIn0ieGE9IrG
         X8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9a7fJg7X5ZGewqvjA5LZwm7IjwMkLyF2YEiM5wrvuak=;
        b=sOkEo+Sbb43QRV8bIlQAnrSrJtlR2eJq2EZ4qAqdlo1cR2qvYoVNK9Q0P2HImHVWYB
         iRGkSvC9nbWitpL95p+V3jrNBlVZHn7ryVx8U5uKfNfonXvgReFKanapD3gWzb3lYcG/
         oui3Fn7yVYvFZHPSORNGjPSXPYy92ELJ1eYuhRARpGVoT2A6FZB5oMAesm8f7ZbAW3Rr
         C7p2cdubZPiSIoTHYwC3JMimRd54Dw6RpXoJG1QH4dY+pyAqnRjNHi8jrWRjNieGAae9
         RsWDftcnicMj8KZ6Hh863+wHUmiHZmPbmGNfLr0pK6Xa/LZ56qZZvaU6ob7x0JrnXp38
         pSnw==
X-Gm-Message-State: APjAAAVuLQUxeskNg6k7jyrQnbOy5maRMxHWNnfF6WJ4lQXpKq0kLAY4
        9Q2E7IJJQUjmE9SntoJDOAUhVA==
X-Google-Smtp-Source: APXvYqy2w08FS3+imnEqGsQbtdgQnHHbJcUe8TvJv6cWWPi4fzKZBmD26hwrBQ1WC9GQ7n2su7Atrw==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr4477198wmg.12.1573155550030;
        Thu, 07 Nov 2019 11:39:10 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:85c9:ca0d:aae1:f680? ([2a01:e34:ed2f:f020:85c9:ca0d:aae1:f680])
        by smtp.googlemail.com with ESMTPSA id j11sm3163328wrq.26.2019.11.07.11.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:39:09 -0800 (PST)
Subject: Re: [PATCH] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, od@zcrc.me,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
References: <20190809123824.26025-1-paul@crapouillou.net>
 <e8f1bd28-e8fe-926b-6741-3ab328f7815b@linaro.org>
 <54210a015f148218e11e7f3c1d107192@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a7aa0b0d-e52f-564f-11ef-a8b74f9f1ac8@linaro.org>
Date:   Thu, 7 Nov 2019 20:39:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <54210a015f148218e11e7f3c1d107192@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 16:56, Paul Cercueil wrote:
> Hi Daniel,
> 
> On 2019-08-16 16:54, Daniel Lezcano wrote:
>> On 09/08/2019 14:38, Paul Cercueil wrote:
>>> From: Maarten ter Huurne <maarten@treewalker.org>
>>>
>>> OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>>>
>>> SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
>>> JZ4780 have a 64-bit OST.
>>>
>>> This driver will register both a clocksource and a sched_clock to the
>>> system.
>>>
>>> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> Tested-by: Mathieu Malaterre <malat@debian.org>
>>> Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>> ---
>>>
>>
>> [ ... ]
>>
>>> +    err = clocksource_register_hz(cs, rate);
>>> +    if (err) {
>>> +        dev_err(dev, "clocksource registration failed: %d\n", err);
>>> +        clk_disable_unprepare(ost->clk);
>>> +        return err;
>>> +    }
>>> +
>>> +    /* Cannot register a sched_clock with interrupts on */
>>
>> Aren't they already disabled?
> 
> Sorry for the late reply.
> 
> No, they are not already disabled; this is what I get if I comment out
> the local_irq_save()/local_irq_restore():
> 
> [    0.361014] clocksource: ingenic-ost: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 159271703898 ns
> [    0.361515] clocksource: Switched to clocksource ingenic-ost
> [    0.361686] ------------[ cut here ]------------
> [    0.361893] WARNING: CPU: 0 PID: 1 at kernel/time/sched_clock.c:179
> sched_clock_register+0x7c/0x2e4
> [    0.362174] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc5+ #461
> [    0.362330] Stack : 80744558 80069b44 80770000 00000000 00000000
> 00dfd7a7 806e6db4 8106bb74
> [    0.362619]         806f0000 81067ca4 806f31c7 80769478 00000020
> 10000400 8106bb20 00dfd7a7
> [    0.362906]         00000000 00000000 80780000 00000000 00000007
> 00000001 00000049 3563722d
> [    0.363191]         8106ba61 00000000 ffffffff 00000010 806f0000
> 00000000 00000000 806f0000
> [    0.363477]         00000020 00000000 80714534 80770000 00000002
> 80319154 00000000 80770000
> [    0.363762]         ...
> [    0.363906] Call Trace:
> [    0.364087] [<8001af14>] show_stack+0x40/0x128
> [    0.364289] [<8002fd88>] __warn+0xb8/0xe0
> [    0.364478] [<8002fe14>] warn_slowpath_fmt+0x64/0xc0
> [    0.364678] [<8072b1c8>] sched_clock_register+0x7c/0x2e4
> [    0.364895] [<8073c874>] ingenic_ost_probe+0x224/0x248
> [    0.365090] [<803d5394>] platform_drv_probe+0x40/0x94
> [    0.365526] [<803d362c>] really_probe+0x104/0x374
> [    0.365743] [<803d3ff0>] device_driver_attach+0x78/0x80
> [    0.365938] [<803d4070>] __driver_attach+0x78/0x118
> [    0.366129] [<803d1700>] bus_for_each_dev+0x7c/0xc8
> [    0.366318] [<803d226c>] bus_add_driver+0x1bc/0x204
> [    0.366513] [<803d4878>] driver_register+0x84/0x14c
> [    0.366717] [<8073a144>] __platform_driver_probe+0x98/0x140
> [    0.366931] [<80724e38>] do_one_initcall+0x84/0x1b4
> [    0.367126] [<807250cc>] kernel_init_freeable+0x164/0x240
> [    0.367318] [<805df75c>] kernel_init+0x10/0xf8
> [    0.367510] [<8001542c>] ret_from_kernel_thread+0x14/0x1c
> [    0.367722] ---[ end trace 7fedf00408fa3bed ]---
> [    0.367985] sched_clock: 32 bits at 12MHz, resolution 83ns, wraps
> every 178956970966ns
> 
> At kernel/time/sched_clock.c:179 there is:
> WARN_ON(!irqs_disabled());

That is strange, no drivers is doing that and no warning is appearing.

Isn't missing a local_irq_disable in the code path in the stack above?

>>> +    local_irq_save(flags);
>>> +    if (soc_info->is64bit)
>>> +        sched_clock_register(ingenic_ost_read_cntl, 32, rate);
>>> +    else
>>> +        sched_clock_register(ingenic_ost_read_cnth, 32, rate);
>>> +    local_irq_restore(flags);
>>> +
>>> +    return 0;
>>> +}
>>> +


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

