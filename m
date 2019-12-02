Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F7A20833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzWZaaFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLBRJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:09:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38341 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLBRJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:09:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so392884lfm.5;
        Mon, 02 Dec 2019 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U5owG/LNQp37887crEqy2krNGviKjIAZqknpx9+eSTE=;
        b=HzWZaaFiHaLISnrJN/Y+/337Ql3ejH2WzCCCwQWAsrAIgg3afcXYHoOtaPYFfZiWea
         QpU8AIRud/pXDQv3bepLYTQDtkWhZm7E80EC59aqsFq75V85mU9nbd5b+LyNSHiKV62q
         KhN+P4qwMkLgFcIwQaANVebUG+8VCJVoT4dQDqwAC4V6rs0svyFJN+UBzY5VnzAmMhef
         +Yb5kNGJnvChEVMtWtlFsGVbhPBYfzUuAWIlxd5BXqmr+AgohMVJAt50P6K5L8a0pJJJ
         PcWl49gu0g9dhioTBEfK8dUOPG+nGothSIGj6QXb8JUUvf0//d7dyuYP0ocab8nNfCvO
         SNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U5owG/LNQp37887crEqy2krNGviKjIAZqknpx9+eSTE=;
        b=cUETWvteoKA0d5+j8pEcTnqw0NiodH33JG0tYb+fnhGEQMFuewh/Gpnw0eW9wkiH7q
         UmKtKt18sZrWCI8yF6+tPquwFAxCesBNz56q6McCCM5wqiGhDEpXL0ZGakCCAbSdrEh+
         g0MEs3Q0UW3QQHPC+vC3y0bvo/ggaOx6A2quDGDn+7u1odNYn039jN8bThQciI0VViXq
         LbYdCfYOyjJ9GrI7nb0s/5nLSKJENwU1L6sJGe2YJNUif0FPidy/1rPa3Bx8r6/l1Dv0
         aPkRHrSk+E9HQ5PX/aH/hRIzKXvYCWRM1/Yt1TlhHmQTN1amYcHy4pVUw0C8ZqhrZjDb
         8yxg==
X-Gm-Message-State: APjAAAXqWeGrZYXECF7YKt5zRrOQgZ/1+jw33CB16eiKlPIWvlFCf9p2
        aq6DhBn3uj1Ub5ousrufdzfChtNJ
X-Google-Smtp-Source: APXvYqw3axLT041EynLDZcJsLKTYSgzFQPe1KnDFN5BsWUUf9K93lqIpG871TPn6wAsbpz4yiXZORg==
X-Received: by 2002:ac2:5626:: with SMTP id b6mr71481lff.74.1575306576148;
        Mon, 02 Dec 2019 09:09:36 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id k22sm14777562lfm.48.2019.12.02.09.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 09:09:35 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Move PMC clocks into Tegra PMC driver
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <45058e6b-244e-8926-584d-297452873612@gmail.com>
Message-ID: <ccb7b50e-1a71-9803-4dba-b0e743a085df@gmail.com>
Date:   Mon, 2 Dec 2019 20:09:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <45058e6b-244e-8926-584d-297452873612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2019 16:06, Dmitry Osipenko пишет:
> 28.11.2019 00:38, Sowjanya Komatineni пишет:
>>
>> On 11/27/19 9:02 AM, Sowjanya Komatineni wrote:
>>>
>>> On 11/27/19 6:31 AM, Dmitry Osipenko wrote:
>>>> 27.11.2019 07:59, Sowjanya Komatineni пишет:
>>>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
>>>>> are currently registered by Tegra clock driver using clk_regiser_mux
>>>>> and
>>>>> clk_register_gate which performs direct Tegra PMC register access.
>>>>>
>>>>> When Tegra PMC is in secure mode, any access from non-secure world will
>>>>> not go through.
>>>>>
>>>>> This patch series adds these Tegra PMC clocks and blink controls to
>>>>> Tegra
>>>>> PMC driver with PMC as clock provider and removed them from Tegra clock
>>>>> driver. This also adds PMC specific clock id's to use in device tree
>>>>> and
>>>>> removed clock ids of PMC clock from Tegra clock driver.
>>>>>
>>>>> This series also includes patch to update clock provider from tegra_car
>>>>> to pmc in the device tree tegra210-smaug.dts that uses clk_out_2
>>>>> from PMC.
>>>>>
>>>>> [v2]:    Changes between v1 and v2 are
>>>>>     - v2 includes patches for adding clk_out_1, clk_out_2, clk_out_3,
>>>>>       blink controls to Tegra PMC driver and removing clk-tegra-pmc.
>>>>>     - feedback related to pmc clocks in Tegra PMC driver from v1
>>>>>     - Removed patches for WB0 PLLM overrides and PLLE IDDQ PMC
>>>>> programming
>>>>>       by the clock driver using helper functions from Tegra PMC.
>>>>>
>>>>>         Note:
>>>>>       To use helper functions from PMC driver, PMC early init need to
>>>>>       happen prior to using helper functions and these helper
>>>>> functions are
>>>>>       for PLLM Override and PLLE IDDQ programming in PMC during
>>>>> PLLM/PLLE
>>>>>       clock registration which happen in clock_init prior to Tegra PMC
>>>>>       probe.
>>>>>       Moving PLLM/PLLE clocks registration to happen after Tegra PMC
>>>>>       impacts other clocks EMC, MC and corresponding tegra_emc_init and
>>>>>       tegra_mc_init.
>>>>>       This implementation of configuring PMC registers thru helper
>>>>>       functions in clock driver needs proper changes across PMC, Clock,
>>>>>       EMC and MC inits to have it work across all Tegra platforms.
>>>>>
>>>>>       Currently PLLM Override is not enabled in the bootloader so
>>>>> proper
>>>>>       patches for this fix will be taken care separately.
>>>> Hello Sowjanya,
>>>>
>>>> Could you please clarify what do you mean by "PLLM Override not enabled
>>>> in bootloader"?
>>>>
>>>> There is T124 Nyan Big Chromebook which is supported in upstream kernel,
>>>> it has PLLM Override set by bootloader. I also have T30 Nexus 7 tablet
>>>> which has the PLLM Override set by bootloader as well. It's not clear to
>>>> me whether this patch series is supposed to break these devices. If the
>>>> breakage is the case here, then I'm afraid you can't postpone supporting
>>>> the PLLM Override and a full-featured implementation is needed.
>>>
>>> Hi Dmitry,
>>>
>>> Secure boot currently is enabled only on Tegra210 and Tegra210
>>> bootloader doesn't enable PLLM override.
>>>
>>> So PLLM override/PLLE IDDQ being in clock driver currently will not
>>> break on any of existing Tegra platforms.
>>>
>>>>
>>>> I briefly tried to test this series on T30 and this time it doesn't hang
>>>> on boot, but somehow WiFi MMC card detection is broken. AFAIK, the WiFi
>>>> chip uses the Blink clock source and the clock should be enabled by the
>>>> MMC core because this is how DT part looks like:
>>>>
>>>> brcm_wifi_pwrseq: wifi-pwrseq {
>>>>     compatible = "mmc-pwrseq-simple";
>>>>     clocks = <&pmc TEGRA_PMC_CLK_BLINK>;
>>>>     clock-names = "ext_clock";
>>>>     reset-gpios =  <&gpio TEGRA_GPIO(D, 3) GPIO_ACTIVE_LOW>;
>>>>     post-power-on-delay-ms = <300>;
>>>>     power-off-delay-us = <300>;
>>>> };
>>>>
>>>> BTW, I  tried this series on a T20 device which also uses the Blink
>>>> clock for WiFi card and it works. So looks like this patchset has some
>>>> problem in regards to the T30 PMC clocks implementation.
>>>>
>>>> [snip]
>>>
>>> Blink init state is set to true for both Tegra20 and Tegra30 and all
>>> go through the same blink programming sequence.
>>>
>>> Will try to add more debug messages to dump registers and will test
>>> blink through device tree on T30 and will get back...
>>>
>>>
>> define value for BLINK uses BIT macro instead of just position. Will fix
>> this in v3.
> 
> Thanks, will try v3 once it will be ready.
> 
> I took a look through the T20 board's schematics and seems it doesn't
> use the Blink clock for the WiFi, instead it uses 32k source directly
> from PMU. While T30 board schematics tells that  32k comes out from the
> Tegra chip.

That was wrong, both T20 and T30 are identical in regards to the clk32k
wiring. I'm not sure what's difference between T20 and T30 that made
WiFi card not to work without the blink clock on T30, maybe it's a WiFi
chip difference.

> BTW, I'm curious what's the reason for having Blink clock always-ON on
> T20/30, any insights? Looks like it's just some relic from old clk
> driver and it should be safe to drop the always-ON.
> 

