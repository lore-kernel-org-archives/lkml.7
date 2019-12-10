Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489B0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F852073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYl60B4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfLJJT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:19:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42936 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:19:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so19100117wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xI0I8uqrzuTNerpq9Ti31206ZK1s/1xE0e/fs4M6/fA=;
        b=OYl60B4xn5ARMhmYOO90KfxT66aDEFpphwMJDJXb+7jBH/gxqcalyyZRQ1ACLdIscF
         V2O25FNJ95sHZTnB2+4ws3aQd2LwdhjyP27Dqhy09wsPcb5vrT4II9yQO8qwinYCCelc
         YUV1Vv9lPDvUZViH0ztaCuHWQaCH3shTL501TwaWxEpHLfAhst1aiaPdmP49ZfUxX5Z8
         j/FLHGroJcJOGufSjLSN7CQtcgd9F8AT8z0Iw8M6NRlK2NmRS1mY0FuXloOQFLAfKcWC
         0k5cQ55nFD+k9VYO+9so8gVfMmje/fetVDejmuvfgUWr0LD+NMcyfMo4+h5fxiSx2TYn
         zDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xI0I8uqrzuTNerpq9Ti31206ZK1s/1xE0e/fs4M6/fA=;
        b=HZWtA+IIMbaHmx9qvqRnBkqs2trRwwVYv2MjmiFe/tTHhy54B6PkVP+9IW9YXunuYr
         o1M20q+FlRTrWa755p2FBAH8cD+zHOKIXbs6K7FTgkfmFRrrPR1Jtc2+XRaurGdwTRLZ
         ecoDnXwTKu4J/XQAiV1OBHmHLa17EPWT1NRVk3zVQAQvyztjsXa4BKZ32NRpMx/BzfcI
         67TF7n/tpK029TPSexGg82/Tm2u9eTH7Y5dZRFV/vxtgOS9CP0733Iby24WDAOC03p/J
         Y9YzzdkPUpuCJMNwD2AHtg3+Sz9iavUumk/B4aKhCe+/+EDvJjuw1KKa/gw8lpoLAl8n
         bNzw==
X-Gm-Message-State: APjAAAWcr3kvOP54ScOvg7S2fXLsNNwZqg6r5Q2nIL6CY8/ipSNdzEJO
        kji8WzSG/MPfEIgLW4kgG+YyBQ==
X-Google-Smtp-Source: APXvYqy4m+bEJibzg36VT6Vvj4e4LFoK77VRXrDuKhMpdmAj4gbj7wYaLo4UJYqIkhuA313uN/h5yQ==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr1819072wrl.377.1575969564772;
        Tue, 10 Dec 2019 01:19:24 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:683a:fee4:9950:e8ce? ([2a01:e34:ed2f:f020:683a:fee4:9950:e8ce])
        by smtp.googlemail.com with ESMTPSA id d67sm2403157wmd.13.2019.12.10.01.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:19:24 -0800 (PST)
Subject: Re: [PATCH] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Cercueil <paul@crapouillou.net>, od@zcrc.me,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
References: <20190809123824.26025-1-paul@crapouillou.net>
 <e8f1bd28-e8fe-926b-6741-3ab328f7815b@linaro.org>
 <54210a015f148218e11e7f3c1d107192@crapouillou.net>
 <a7aa0b0d-e52f-564f-11ef-a8b74f9f1ac8@linaro.org>
 <1573156678.3.0@crapouillou.net>
 <78a8e3f2-c608-a2a1-4fd4-f379866726b5@linaro.org>
 <1573158869.3.2@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <10e6ee08-4f5e-7220-045d-be7ca74b4345@linaro.org>
Date:   Tue, 10 Dec 2019 10:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1573158869.3.2@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 21:34, Paul Cercueil wrote:
> 
> 
> Le jeu., nov. 7, 2019 at 21:22, Daniel Lezcano
> <daniel.lezcano@linaro.org> a écrit :
>> On 07/11/2019 20:57, Paul Cercueil wrote:
>>>
>>>
>>>  Le jeu., nov. 7, 2019 at 20:39, Daniel Lezcano
>>>  <daniel.lezcano@linaro.org> a écrit :
>>>>  On 07/11/2019 16:56, Paul Cercueil wrote:
>>>>>   Hi Daniel,
>>>>>
>>>>>   On 2019-08-16 16:54, Daniel Lezcano wrote:
>>>>>>   On 09/08/2019 14:38, Paul Cercueil wrote:
>>>>>>>   From: Maarten ter Huurne <maarten@treewalker.org>
>>>>>>>
>>>>>>>   OST is the OS Timer, a 64-bit timer/counter with buffered reading.
>>>>>>>
>>>>>>>   SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
>>>>>>>   JZ4780 have a 64-bit OST.
>>>>>>>
>>>>>>>   This driver will register both a clocksource and a sched_clock
>>>>>>> to the
>>>>>>>   system.
>>>>>>>
>>>>>>>   Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
>>>>>>>   Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>>>>   Tested-by: Mathieu Malaterre <malat@debian.org>
>>>>>>>   Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>>>>>>   ---
>>>>>>>
>>>>>>
>>>>>>   [ ... ]
>>>>>>
>>>>>>>   +    err = clocksource_register_hz(cs, rate);
>>>>>>>   +    if (err) {
>>>>>>>   +        dev_err(dev, "clocksource registration failed: %d\n",
>>>>>>> err);
>>>>>>>   +        clk_disable_unprepare(ost->clk);
>>>>>>>   +        return err;
>>>>>>>   +    }
>>>>>>>   +
>>>>>>>   +    /* Cannot register a sched_clock with interrupts on */
>>>>>>
>>>>>>   Aren't they already disabled?
>>>>>
>>>>>   Sorry for the late reply.
>>>>>
>>>>>   No, they are not already disabled; this is what I get if I
>>>>> comment out
>>>>>   the local_irq_save()/local_irq_restore():
>>>>>
>>>>>   [    0.361014] clocksource: ingenic-ost: mask: 0xffffffff
>>>>> max_cycles:
>>>>>   0xffffffff, max_idle_ns: 159271703898 ns
>>>>>   [    0.361515] clocksource: Switched to clocksource ingenic-ost
>>>>>   [    0.361686] ------------[ cut here ]------------
>>>>>   [    0.361893] WARNING: CPU: 0 PID: 1 at
>>>>> kernel/time/sched_clock.c:179
>>>>>   sched_clock_register+0x7c/0x2e4
>>>>>   [    0.362174] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-rc5+
>>>>> #461
>>>>>   [    0.362330] Stack : 80744558 80069b44 80770000 00000000 00000000
>>>>>   00dfd7a7 806e6db4 8106bb74
>>>>>   [    0.362619]         806f0000 81067ca4 806f31c7 80769478 00000020
>>>>>   10000400 8106bb20 00dfd7a7
>>>>>   [    0.362906]         00000000 00000000 80780000 00000000 00000007
>>>>>   00000001 00000049 3563722d
>>>>>   [    0.363191]         8106ba61 00000000 ffffffff 00000010 806f0000
>>>>>   00000000 00000000 806f0000
>>>>>   [    0.363477]         00000020 00000000 80714534 80770000 00000002
>>>>>   80319154 00000000 80770000
>>>>>   [    0.363762]         ...
>>>>>   [    0.363906] Call Trace:
>>>>>   [    0.364087] [<8001af14>] show_stack+0x40/0x128
>>>>>   [    0.364289] [<8002fd88>] __warn+0xb8/0xe0
>>>>>   [    0.364478] [<8002fe14>] warn_slowpath_fmt+0x64/0xc0
>>>>>   [    0.364678] [<8072b1c8>] sched_clock_register+0x7c/0x2e4
>>>>>   [    0.364895] [<8073c874>] ingenic_ost_probe+0x224/0x248
>>>>>   [    0.365090] [<803d5394>] platform_drv_probe+0x40/0x94
>>>>>   [    0.365526] [<803d362c>] really_probe+0x104/0x374
>>>>>   [    0.365743] [<803d3ff0>] device_driver_attach+0x78/0x80
>>>>>   [    0.365938] [<803d4070>] __driver_attach+0x78/0x118
>>>>>   [    0.366129] [<803d1700>] bus_for_each_dev+0x7c/0xc8
>>>>>   [    0.366318] [<803d226c>] bus_add_driver+0x1bc/0x204
>>>>>   [    0.366513] [<803d4878>] driver_register+0x84/0x14c
>>>>>   [    0.366717] [<8073a144>] __platform_driver_probe+0x98/0x140
>>>>>   [    0.366931] [<80724e38>] do_one_initcall+0x84/0x1b4
>>>>>   [    0.367126] [<807250cc>] kernel_init_freeable+0x164/0x240
>>>>>   [    0.367318] [<805df75c>] kernel_init+0x10/0xf8
>>>>>   [    0.367510] [<8001542c>] ret_from_kernel_thread+0x14/0x1c
>>>>>   [    0.367722] ---[ end trace 7fedf00408fa3bed ]---
>>>>>   [    0.367985] sched_clock: 32 bits at 12MHz, resolution 83ns, wraps
>>>>>   every 178956970966ns
>>>>>
>>>>>   At kernel/time/sched_clock.c:179 there is:
>>>>>   WARN_ON(!irqs_disabled());
>>>>
>>>>  That is strange, no drivers is doing that and no warning is appearing.
>>>>
>>>>  Isn't missing a local_irq_disable in the code path in the stack above?
>>>
>>>  I think it comes to the fact that the other drivers are probed much
>>>  earlier in the boot process, while this one is probed as a regular
>>>  platform device driver.
>>
>>
>> There are other drivers doing and nobody is disabling the interrupt:
>>
>> em_sti.c:static struct platform_driver em_sti_device_driver = {
>> ingenic-timer.c:static struct platform_driver ingenic_tcu_driver = {
>> sh_cmt.c:static struct platform_driver sh_cmt_device_driver = {
>> sh_mtu2.c:static struct platform_driver sh_mtu2_device_driver = {
>> sh_tmu.c:static struct platform_driver sh_tmu_device_driver = {
>> timer-ti-dm.c:static struct platform_driver omap_dm_timer_driver = {
> 
> Yes, but they don't register a sched_clock at all (except for
> ingenic-timer, but it does probe using TIMER_OF_DECLARE), and this
> warning is in sched_clock_register().
> 
>>
>>>>>>>   +    local_irq_save(flags);
>>>>>>>   +    if (soc_info->is64bit)
>>>>>>>   +        sched_clock_register(ingenic_ost_read_cntl, 32, rate);
>>>>>>>   +    else
>>>>>>>   +        sched_clock_register(ingenic_ost_read_cnth, 32, rate);
>>>>>>>   +    local_irq_restore(flags);
>>>>>>>   +
>>>>>>>   +    return 0;
>>>>>>>   +}
>>>>>>>   +

Thomas,

the local_irq_save/restore calls shouldn't be in the
sched_clock_register() function instead of showing a warning?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

