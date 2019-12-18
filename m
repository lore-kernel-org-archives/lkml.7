Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E45C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B475C227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRjbZ5kq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLRQ3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:29:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39996 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfLRQ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:29:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id u1so2829414ljk.7;
        Wed, 18 Dec 2019 08:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WQicZqKEkT2OZmLOJnAO4CaO5tjlYphliKW/thglAIk=;
        b=mRjbZ5kqRb+nZFf1VYRVS1SFpeF3hbzu+2gaBs5D6Y2M+gnXwgTING/FvsX+tThtKq
         5rTMofkjV/E5e/MZ2j3tDncSitqVr6ADrqGh3gW0MIH6jXgQ7BbwX+CUCcHOI3+6Xcxi
         97QSlFdsUcmdVBFG1VE+oMSIiDWaFff3Mir25eMJE4x2iY0h8l53ivzAeDTGe8640P+2
         Sl5cDTP9ce5q8uGCXLt+wsXeyEBpIxz/NCwIA2BAaKGk4H6rKTGGnyi4+UycA47MIvyI
         FI2sw8osMwmsURvQ6ZK9B/QWQeAcUh9Dk7MGjlCBuplDJk02So++mPvc1teFE8iUjS1L
         bqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WQicZqKEkT2OZmLOJnAO4CaO5tjlYphliKW/thglAIk=;
        b=TSzxmyUj/M9xm7SqTYOv5lmXhgRMQYSe/rAMnzu/p9iqRgA8zByB5PSiFl1eLrfgTP
         5KQpwYcfnE1qx0p9azkRS5W5San5EHSI33BpMFty3FQVnKTYRezAKWAxuor8hYnMfSWh
         UBcVwPGba6gSf69IgJ0dH/MsrCBBPiXd9R8uRPXiVwjNeX7U0NnjZ51pkERXDPjxpE5b
         V1M0xpyJXe0veylyUv9rdIAQiEo/TvDIiNE0/ZnsPXVgkKkcvzmiKWD10lIJ4RVUDaD2
         SMVZBaaQYkwF4YKrwJ1W1Esx16oJ3k5ulF8a16Y+r3FfVplT8jsE+5tcOQ8ME4Gkapai
         7HJg==
X-Gm-Message-State: APjAAAXLYo8Y6QXKl18TQn69jubDhK3qvXHaFKrVZyu0P0d5UCYxzlUt
        wkekC/WCYPRzVGwnjqjiwOxCmeEy
X-Google-Smtp-Source: APXvYqyLt6czXw6YDKW6MkhVKWnt1H6Ng7jVNikMA9C5Un3Gx3rBOieGP7JmsHrw3Bj3sbIKfp167A==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr2437609ljj.148.1576686553416;
        Wed, 18 Dec 2019 08:29:13 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u16sm1426742ljo.22.2019.12.18.08.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:29:12 -0800 (PST)
Subject: Re: [PATCH v4 13/19] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-14-git-send-email-skomatineni@nvidia.com>
 <e2f96102-33fa-cbe5-f488-666b7b7ffb06@gmail.com>
 <7e49fef8-112c-1694-9316-7a23db8a01a4@gmail.com>
 <66a28f8a-82e8-5b12-464c-4c91441d1511@nvidia.com>
 <fb36edbf-08c9-aa7e-a7fd-6ee15261a525@gmail.com>
 <de4d2693-3d5c-d154-22eb-2e41ddc12974@gmail.com>
 <1499a012-f5e1-3c76-6750-5858765a0532@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <13074e67-2807-d494-b8b4-b2e3b529117a@gmail.com>
Date:   Wed, 18 Dec 2019 19:29:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1499a012-f5e1-3c76-6750-5858765a0532@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.12.2019 18:43, Sowjanya Komatineni пишет:
> 
> On 12/17/19 11:31 PM, Dmitry Osipenko wrote:
>> 18.12.2019 10:22, Dmitry Osipenko пишет:
>>> 18.12.2019 10:14, Sowjanya Komatineni пишет:
>>>> On 12/17/19 11:01 PM, Dmitry Osipenko wrote:
>>>>> 18.12.2019 09:59, Dmitry Osipenko пишет:
>>>>>> 17.12.2019 23:04, Sowjanya Komatineni пишет:
>>>>>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc
>>>>>>> clocks
>>>>>>> are moved to Tegra PMC driver with pmc as clock provider and
>>>>>>> using pmc
>>>>>>> clock ids.
>>>>>>>
>>>>>>> New device tree uses clk_out_1 from pmc clock provider.
>>>>>>>
>>>>>>> So, this patch adds implementation for mclk fallback to extern1 when
>>>>>>> retrieving mclk returns -ENOENT to be backward compatible of new
>>>>>>> device
>>>>>>> tree with older kernels.
>>>>>>>
>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>> ---
>>>>>>>    sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>> index fe9ca8acd0fb..1b88c6043082 100644
>>>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>> @@ -191,7 +191,16 @@ int tegra_asoc_utils_init(struct
>>>>>>> tegra_asoc_utils_data *data,
>>>>>>>        data->clk_cdev1 = devm_clk_get(dev, "mclk");
>>>>>>>        if (IS_ERR(data->clk_cdev1)) {
>>>>>>>            dev_err(data->dev, "Can't retrieve clk cdev1\n");
>>>>>>> -        return PTR_ERR(data->clk_cdev1);
>>>>>>> +        if (PTR_ERR(data->clk_cdev1) != -ENOENT)
>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>> +        /* Fall back to extern1 */
>>>>>>> +        data->clk_cdev1 = devm_clk_get(dev, "extern1");
>>>>>>> +        if (IS_ERR(data->clk_cdev1)) {
>>>>>>> +            dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>> +        }
>>>>>>> +
>>>>>>> +        dev_err(data->dev, "Falling back to extern1\n");
>>>>>>>        }
>>>>>>>          /*
>>>>>>>
>>>>>> [    1.769091] ------------[ cut here ]------------
>>>>>> [    1.769249] WARNING: CPU: 2 PID: 1 at drivers/clk/clk.c:954
>>>>>> clk_core_disable+0xa5/0x1d4
>>>>>> [    1.769330] clk_out_1 already disabled
>>>>>> [    1.769459] Modules linked in:
>>>>>> [    1.769541] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
>>>>>> 5.5.0-rc1-next-20191213-00167-g6b9fbcdac8f3-dirty #266
>>>>>> [    1.769676] Hardware name: NVIDIA Tegra SoC (Flattened Device
>>>>>> Tree)
>>>>>> [    1.769775] [<c010e4bd>] (unwind_backtrace) from [<c010a0fd>]
>>>>>> (show_stack+0x11/0x14)
>>>>>> [    1.769918] [<c010a0fd>] (show_stack) from [<c09a37b1>]
>>>>>> (dump_stack+0x85/0x94)
>>>>>> [    1.770061] [<c09a37b1>] (dump_stack) from [<c011f3d1>]
>>>>>> (__warn+0xc1/0xc4)
>>>>>> [    1.770144] [<c011f3d1>] (__warn) from [<c011f691>]
>>>>>> (warn_slowpath_fmt+0x61/0x78)
>>>>>> [    1.770285] [<c011f691>] (warn_slowpath_fmt) from [<c04a0e7d>]
>>>>>> (clk_core_disable+0xa5/0x1d4)
>>>>>> [    1.770427] [<c04a0e7d>] (clk_core_disable) from [<c04a0fc3>]
>>>>>> (clk_core_disable_lock+0x17/0x20)
>>>>>> [    1.770516] [<c04a0fc3>] (clk_core_disable_lock) from [<c07792bb>]
>>>>>> (tegra_asoc_utils_set_rate+0x53/0x208)
>>>>>> [    1.770662] [<c07792bb>] (tegra_asoc_utils_set_rate) from
>>>>>> [<c077b8c5>] (tegra_rt5640_probe+0xd5/0x128)
>>>>>> [    1.770808] [<c077b8c5>] (tegra_rt5640_probe) from [<c0555eb7>]
>>>>>> (platform_drv_probe+0x33/0x68)
>>>>>> [    1.770958] [<c0555eb7>] (platform_drv_probe) from [<c055471d>]
>>>>>> (really_probe+0x14d/0x240)
>>>>>> [    1.771099] [<c055471d>] (really_probe) from [<c055493f>]
>>>>>> (driver_probe_device+0x43/0x11c)
>>>>>> [    1.771187] [<c055493f>] (driver_probe_device) from [<c0554b25>]
>>>>>> (device_driver_attach+0x3d/0x40)
>>>>>> [    1.771328] [<c0554b25>] (device_driver_attach) from [<c0554b5f>]
>>>>>> (__driver_attach+0x37/0x78)
>>>>>> [    1.771469] [<c0554b5f>] (__driver_attach) from [<c05532fb>]
>>>>>> (bus_for_each_dev+0x43/0x6c)
>>>>>> [    1.771609] [<c05532fb>] (bus_for_each_dev) from [<c0553e0f>]
>>>>>> (bus_add_driver+0xe3/0x148)
>>>>>> [    1.771692] [<c0553e0f>] (bus_add_driver) from [<c055531d>]
>>>>>> (driver_register+0x39/0xa0)
>>>>>> [    1.771833] [<c055531d>] (driver_register) from [<c0102c2f>]
>>>>>> (do_one_initcall+0x43/0x1bc)
>>>>>> [    1.771979] [<c0102c2f>] (do_one_initcall) from [<c1000ce5>]
>>>>>> (kernel_init_freeable+0x121/0x194)
>>>>>> [    1.772129] [<c1000ce5>] (kernel_init_freeable) from [<c09b40e9>]
>>>>>> (kernel_init+0xd/0xd0)
>>>>>> [    1.772215] [<c09b40e9>] (kernel_init) from [<c01010bd>]
>>>>>> (ret_from_fork+0x11/0x34)
>>>>>> [    1.772349] Exception stack(0xde907fb0 to 0xde907ff8)
>>>>>>
>>>>> Although, that's probably related to the "ASoC: tegra: Add initial
>>>>> parent configuration for audio mclk".
>>>>>
>>>> Actually I see these warnings of already unprepared and already
>>>> disabled
>>>> for pll_a, pll_a_out0, and clk_out_1 even without this whole patch
>>>> series as well.
>>>>
>>>> I think its from tegra_asoc_utils_set_rate() doing
>>>> clk_disable_unprepare
>>>> and these clocks are already unprepared and disabled so its just
>>>> warning
>>>> from clk_core_unprepare and clk_core_disable.
>>> Doesn't happen for me without this series.
> 
> I looked at wrong log, right earlier clock driver keeps them enabled so
> asoc_utils_set_rate() disables the clock fine but now enabling audio
> clock should be done in asoc_utils_init() to let the
> clk_disable_unprepare from asoc_utils_set_rate not to show this warning.
> 
> But actually we don't need to have clock enabled in asoc_utils_init
> prior to invoking asoc_utils_set_rate from utils_init and its just warns
> during sound driver probe because clock is already in disabled state. At
> same time it doesn't harm to have it kept enabled in utils_init. So will
> keep it enabled in asoc_utils_init to prevent this warning to show up.
> 
>> But sound works with both old/new device-trees.

The rule of thumb: don't enable anything when it shouldn't be enabled.
If clocks are disabled at the time of drivers probe, then drivers
shouldn't disable the clocks.
