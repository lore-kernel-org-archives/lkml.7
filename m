Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC5421774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyBwlpRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfK1NGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:06:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42307 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1NGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:06:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so20001312lfl.9;
        Thu, 28 Nov 2019 05:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AI6KEV/OQHLxHTzwq8juxhBbtgR44zSvNcMa4TFhcYw=;
        b=qyBwlpRX49JUZ7UszKWTvsWJRZyAduf7gpv1ralMNfFt5EkSe5EPmLmnst8bBXZ0jG
         SWN0Il6b19N4/hudfH32VRII81NkZOWAH4tJbQ5xJI6X6CVRab+0+VGszo6R5vXX57Zl
         E0lqMpxIKaSo+FjbP9wjUJoAucyM73dLEhAXhppXaLR2R5Wtgf5mUC/6K2FUzTjNlUWm
         cxDlRYvgz4HAW6yD0IyoG6myuHDswGrQRR4qkScNV/uxABhUPoWnOLM6Sf9lAzzUUQEw
         WgrjdFn6mj+IjBF+w4Bwmz8FNMq//EXilOC8LfiuOOMon0Ke4pZJt1PcIsle5FaTZspW
         C1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AI6KEV/OQHLxHTzwq8juxhBbtgR44zSvNcMa4TFhcYw=;
        b=Gv7uHH6sDEUDW4cmT4PPgEDjvOpZ9T6cVEkWro/hDZuzI6rhugklm74KyqOytp7mVW
         tYUdql7rzkn96HqDaP3VeuJg3Q1/HsFqSpVND62p9YG+De/IvADsvntltjidLYqIlvQZ
         pfJRzR111TJh/G3FQ2imGI3Sip4mT3KFlbWF8B7TgpQJgnOYJn8fIOL+w1gXV/tirTsg
         wP4AoA9G2sIBu1WauNOEJs8fyCB+Ik0IeLHOcqpbys3r2tehDtrE6zsJJuWsA5kctw8C
         0HOjNv1FBCke9iaN0N81smVGg6QRzrf2QcpzbpMcyQKuo7VB6A7b5Txnv6rzpEXtkhUE
         wiug==
X-Gm-Message-State: APjAAAU9ZP+yVywV2/H4WiTja32VMLV+/CO0L9N0qQDlBy7zvYtNQh06
        I4tDHFphQsXfbDSW4uT8UEwuVmHz
X-Google-Smtp-Source: APXvYqzBYO9XlUW2vY6B1CCIVLFFa6OHe8JmDSEewXRN11r7o311dkzcH+7JD5joXI1A+5bjEA5HqQ==
X-Received: by 2002:a19:f716:: with SMTP id z22mr26436420lfe.25.1574946402842;
        Thu, 28 Nov 2019 05:06:42 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d26sm10182359ljo.54.2019.11.28.05.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:06:42 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Move PMC clocks into Tegra PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, sboyd@kernel.org
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms+renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <79e7bd6a-f138-1e7d-6e0b-435adde3b3e5@gmail.com>
 <04b093fe-5eff-1ad2-9a8a-7674dcb2318a@nvidia.com>
 <ebcce0df-bb7a-2f24-cfbc-daaf3ac6bb4f@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <45058e6b-244e-8926-584d-297452873612@gmail.com>
Date:   Thu, 28 Nov 2019 16:06:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ebcce0df-bb7a-2f24-cfbc-daaf3ac6bb4f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2019 00:38, Sowjanya Komatineni пишет:
> 
> On 11/27/19 9:02 AM, Sowjanya Komatineni wrote:
>>
>> On 11/27/19 6:31 AM, Dmitry Osipenko wrote:
>>> 27.11.2019 07:59, Sowjanya Komatineni пишет:
>>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
>>>> are currently registered by Tegra clock driver using clk_regiser_mux
>>>> and
>>>> clk_register_gate which performs direct Tegra PMC register access.
>>>>
>>>> When Tegra PMC is in secure mode, any access from non-secure world will
>>>> not go through.
>>>>
>>>> This patch series adds these Tegra PMC clocks and blink controls to
>>>> Tegra
>>>> PMC driver with PMC as clock provider and removed them from Tegra clock
>>>> driver. This also adds PMC specific clock id's to use in device tree
>>>> and
>>>> removed clock ids of PMC clock from Tegra clock driver.
>>>>
>>>> This series also includes patch to update clock provider from tegra_car
>>>> to pmc in the device tree tegra210-smaug.dts that uses clk_out_2
>>>> from PMC.
>>>>
>>>> [v2]:    Changes between v1 and v2 are
>>>>     - v2 includes patches for adding clk_out_1, clk_out_2, clk_out_3,
>>>>       blink controls to Tegra PMC driver and removing clk-tegra-pmc.
>>>>     - feedback related to pmc clocks in Tegra PMC driver from v1
>>>>     - Removed patches for WB0 PLLM overrides and PLLE IDDQ PMC
>>>> programming
>>>>       by the clock driver using helper functions from Tegra PMC.
>>>>
>>>>         Note:
>>>>       To use helper functions from PMC driver, PMC early init need to
>>>>       happen prior to using helper functions and these helper
>>>> functions are
>>>>       for PLLM Override and PLLE IDDQ programming in PMC during
>>>> PLLM/PLLE
>>>>       clock registration which happen in clock_init prior to Tegra PMC
>>>>       probe.
>>>>       Moving PLLM/PLLE clocks registration to happen after Tegra PMC
>>>>       impacts other clocks EMC, MC and corresponding tegra_emc_init and
>>>>       tegra_mc_init.
>>>>       This implementation of configuring PMC registers thru helper
>>>>       functions in clock driver needs proper changes across PMC, Clock,
>>>>       EMC and MC inits to have it work across all Tegra platforms.
>>>>
>>>>       Currently PLLM Override is not enabled in the bootloader so
>>>> proper
>>>>       patches for this fix will be taken care separately.
>>> Hello Sowjanya,
>>>
>>> Could you please clarify what do you mean by "PLLM Override not enabled
>>> in bootloader"?
>>>
>>> There is T124 Nyan Big Chromebook which is supported in upstream kernel,
>>> it has PLLM Override set by bootloader. I also have T30 Nexus 7 tablet
>>> which has the PLLM Override set by bootloader as well. It's not clear to
>>> me whether this patch series is supposed to break these devices. If the
>>> breakage is the case here, then I'm afraid you can't postpone supporting
>>> the PLLM Override and a full-featured implementation is needed.
>>
>> Hi Dmitry,
>>
>> Secure boot currently is enabled only on Tegra210 and Tegra210
>> bootloader doesn't enable PLLM override.
>>
>> So PLLM override/PLLE IDDQ being in clock driver currently will not
>> break on any of existing Tegra platforms.
>>
>>>
>>> I briefly tried to test this series on T30 and this time it doesn't hang
>>> on boot, but somehow WiFi MMC card detection is broken. AFAIK, the WiFi
>>> chip uses the Blink clock source and the clock should be enabled by the
>>> MMC core because this is how DT part looks like:
>>>
>>> brcm_wifi_pwrseq: wifi-pwrseq {
>>>     compatible = "mmc-pwrseq-simple";
>>>     clocks = <&pmc TEGRA_PMC_CLK_BLINK>;
>>>     clock-names = "ext_clock";
>>>     reset-gpios =  <&gpio TEGRA_GPIO(D, 3) GPIO_ACTIVE_LOW>;
>>>     post-power-on-delay-ms = <300>;
>>>     power-off-delay-us = <300>;
>>> };
>>>
>>> BTW, I  tried this series on a T20 device which also uses the Blink
>>> clock for WiFi card and it works. So looks like this patchset has some
>>> problem in regards to the T30 PMC clocks implementation.
>>>
>>> [snip]
>>
>> Blink init state is set to true for both Tegra20 and Tegra30 and all
>> go through the same blink programming sequence.
>>
>> Will try to add more debug messages to dump registers and will test
>> blink through device tree on T30 and will get back...
>>
>>
> define value for BLINK uses BIT macro instead of just position. Will fix
> this in v3.

Thanks, will try v3 once it will be ready.

I took a look through the T20 board's schematics and seems it doesn't
use the Blink clock for the WiFi, instead it uses 32k source directly
from PMU. While T30 board schematics tells that  32k comes out from the
Tegra chip.

BTW, I'm curious what's the reason for having Blink clock always-ON on
T20/30, any insights? Looks like it's just some relic from old clk
driver and it should be safe to drop the always-ON.
