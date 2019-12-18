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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7CFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747A21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjwniCJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfLRHbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:31:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41609 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLRHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:31:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so913292lfp.8;
        Tue, 17 Dec 2019 23:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SDB6QssLTyHajG3CTt3mKWtiYD8jcB4KCZajJQzXQig=;
        b=NjwniCJpwE+fkx+1587obPXfKmwAT4ePtmIaFhIGIg4U/kKJyrH47U46wlijsAQmJ1
         vHawollDRRDsXZe5XX2nPT+vqkHtZlOsal7QyWW2KpSqP0EDMxwzGMWLVF378QtVZV2q
         xyXvNzLwUGqQpiUE5XJTROIQLseAQXd5kkSN5PvVazlOGEcn6F1wAbQgRs/ijZCqomQr
         f2bYwewwlfq7cq3QI9vpv7fsB9+W+QEv6yxwSF4Cu4IiM6ScM9qdLpARAEpYFcVZzA1O
         QqeF8lyYqP1Tz9L8ptS8SOHRneNgKbZ1pmxbaNp/TpV/FMYqR5/PpRx6OqmYS9hyRO8Z
         0D8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDB6QssLTyHajG3CTt3mKWtiYD8jcB4KCZajJQzXQig=;
        b=JFESIgffKc60Vkxigwaxw3ixtke2bjABx0+HJNqZSTSezIbPmfuYYFsLRDV71ooUGy
         vLZvqo1PQz1yuZ4BcLljlBjeoqB7sbUk3CD0RuIJO8V4Wyoy7itfn5Q3beWB7DPB6Ggm
         UYKWt/zARTh6M7TFDQipWvR8Wrg2dFuEnNodxaxBh4HHxmfXDEYJPSAM66Lh1FjoBgzs
         63KD+5N+q+NaeYtjiMVnzB8m9QPCmMyXocOnyX1xiYYH0eMq7aJAC8RzK+OwTi4sf1Sa
         Krb3fosSQjhamJQU7RUDS3teUtQZODnlLByGjPlLqVGaIi1Wpp7YlWabQoKH9Wv9n1BX
         3Pdw==
X-Gm-Message-State: APjAAAUxwqnmSarXzuDjd9JS5zBzivZa1VOJg305IusaHxgc2zyEFJB9
        rSHyEB8P+Bd7HixTITBouO1jNvjP
X-Google-Smtp-Source: APXvYqzWyqKFiAYbpX42p0RBXnQ26wuPKncIPWmtogXJ19bJ/DFQcY1bcRgypFH0hxLi4Jye9TMtgQ==
X-Received: by 2002:a19:c205:: with SMTP id l5mr765590lfc.159.1576654292447;
        Tue, 17 Dec 2019 23:31:32 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id l28sm600151lfk.21.2019.12.17.23.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 23:31:31 -0800 (PST)
Subject: Re: [PATCH v4 13/19] ASoC: tegra: Add fallback implementation for
 audio mclk
From:   Dmitry Osipenko <digetx@gmail.com>
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
Message-ID: <de4d2693-3d5c-d154-22eb-2e41ddc12974@gmail.com>
Date:   Wed, 18 Dec 2019 10:31:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fb36edbf-08c9-aa7e-a7fd-6ee15261a525@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.12.2019 10:22, Dmitry Osipenko пишет:
> 18.12.2019 10:14, Sowjanya Komatineni пишет:
>>
>> On 12/17/19 11:01 PM, Dmitry Osipenko wrote:
>>> 18.12.2019 09:59, Dmitry Osipenko пишет:
>>>> 17.12.2019 23:04, Sowjanya Komatineni пишет:
>>>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
>>>>> are moved to Tegra PMC driver with pmc as clock provider and using pmc
>>>>> clock ids.
>>>>>
>>>>> New device tree uses clk_out_1 from pmc clock provider.
>>>>>
>>>>> So, this patch adds implementation for mclk fallback to extern1 when
>>>>> retrieving mclk returns -ENOENT to be backward compatible of new device
>>>>> tree with older kernels.
>>>>>
>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>> ---
>>>>>   sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>> index fe9ca8acd0fb..1b88c6043082 100644
>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>> @@ -191,7 +191,16 @@ int tegra_asoc_utils_init(struct
>>>>> tegra_asoc_utils_data *data,
>>>>>       data->clk_cdev1 = devm_clk_get(dev, "mclk");
>>>>>       if (IS_ERR(data->clk_cdev1)) {
>>>>>           dev_err(data->dev, "Can't retrieve clk cdev1\n");
>>>>> -        return PTR_ERR(data->clk_cdev1);
>>>>> +        if (PTR_ERR(data->clk_cdev1) != -ENOENT)
>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>> +        /* Fall back to extern1 */
>>>>> +        data->clk_cdev1 = devm_clk_get(dev, "extern1");
>>>>> +        if (IS_ERR(data->clk_cdev1)) {
>>>>> +            dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>> +        }
>>>>> +
>>>>> +        dev_err(data->dev, "Falling back to extern1\n");
>>>>>       }
>>>>>         /*
>>>>>
>>>> [    1.769091] ------------[ cut here ]------------
>>>> [    1.769249] WARNING: CPU: 2 PID: 1 at drivers/clk/clk.c:954
>>>> clk_core_disable+0xa5/0x1d4
>>>> [    1.769330] clk_out_1 already disabled
>>>> [    1.769459] Modules linked in:
>>>> [    1.769541] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
>>>> 5.5.0-rc1-next-20191213-00167-g6b9fbcdac8f3-dirty #266
>>>> [    1.769676] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>>> [    1.769775] [<c010e4bd>] (unwind_backtrace) from [<c010a0fd>]
>>>> (show_stack+0x11/0x14)
>>>> [    1.769918] [<c010a0fd>] (show_stack) from [<c09a37b1>]
>>>> (dump_stack+0x85/0x94)
>>>> [    1.770061] [<c09a37b1>] (dump_stack) from [<c011f3d1>]
>>>> (__warn+0xc1/0xc4)
>>>> [    1.770144] [<c011f3d1>] (__warn) from [<c011f691>]
>>>> (warn_slowpath_fmt+0x61/0x78)
>>>> [    1.770285] [<c011f691>] (warn_slowpath_fmt) from [<c04a0e7d>]
>>>> (clk_core_disable+0xa5/0x1d4)
>>>> [    1.770427] [<c04a0e7d>] (clk_core_disable) from [<c04a0fc3>]
>>>> (clk_core_disable_lock+0x17/0x20)
>>>> [    1.770516] [<c04a0fc3>] (clk_core_disable_lock) from [<c07792bb>]
>>>> (tegra_asoc_utils_set_rate+0x53/0x208)
>>>> [    1.770662] [<c07792bb>] (tegra_asoc_utils_set_rate) from
>>>> [<c077b8c5>] (tegra_rt5640_probe+0xd5/0x128)
>>>> [    1.770808] [<c077b8c5>] (tegra_rt5640_probe) from [<c0555eb7>]
>>>> (platform_drv_probe+0x33/0x68)
>>>> [    1.770958] [<c0555eb7>] (platform_drv_probe) from [<c055471d>]
>>>> (really_probe+0x14d/0x240)
>>>> [    1.771099] [<c055471d>] (really_probe) from [<c055493f>]
>>>> (driver_probe_device+0x43/0x11c)
>>>> [    1.771187] [<c055493f>] (driver_probe_device) from [<c0554b25>]
>>>> (device_driver_attach+0x3d/0x40)
>>>> [    1.771328] [<c0554b25>] (device_driver_attach) from [<c0554b5f>]
>>>> (__driver_attach+0x37/0x78)
>>>> [    1.771469] [<c0554b5f>] (__driver_attach) from [<c05532fb>]
>>>> (bus_for_each_dev+0x43/0x6c)
>>>> [    1.771609] [<c05532fb>] (bus_for_each_dev) from [<c0553e0f>]
>>>> (bus_add_driver+0xe3/0x148)
>>>> [    1.771692] [<c0553e0f>] (bus_add_driver) from [<c055531d>]
>>>> (driver_register+0x39/0xa0)
>>>> [    1.771833] [<c055531d>] (driver_register) from [<c0102c2f>]
>>>> (do_one_initcall+0x43/0x1bc)
>>>> [    1.771979] [<c0102c2f>] (do_one_initcall) from [<c1000ce5>]
>>>> (kernel_init_freeable+0x121/0x194)
>>>> [    1.772129] [<c1000ce5>] (kernel_init_freeable) from [<c09b40e9>]
>>>> (kernel_init+0xd/0xd0)
>>>> [    1.772215] [<c09b40e9>] (kernel_init) from [<c01010bd>]
>>>> (ret_from_fork+0x11/0x34)
>>>> [    1.772349] Exception stack(0xde907fb0 to 0xde907ff8)
>>>>
>>> Although, that's probably related to the "ASoC: tegra: Add initial
>>> parent configuration for audio mclk".
>>>
>> Actually I see these warnings of already unprepared and already disabled
>> for pll_a, pll_a_out0, and clk_out_1 even without this whole patch
>> series as well.
>>
>> I think its from tegra_asoc_utils_set_rate() doing clk_disable_unprepare
>> and these clocks are already unprepared and disabled so its just warning
>> from clk_core_unprepare and clk_core_disable.
> 
> Doesn't happen for me without this series.

But sound works with both old/new device-trees.
