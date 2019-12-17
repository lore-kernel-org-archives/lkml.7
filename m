Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1BFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA2C2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkr5thME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfLQPhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:37:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35561 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfLQPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so11466673lja.2;
        Tue, 17 Dec 2019 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AwBGKgAiV9treuZFBi82d53Otoj4Lv3V92XEOJ1XHME=;
        b=Mkr5thMEmR8OAPhy0taQlOBfG/ULvpuf8+4nA3bHdvpqI2A0xhn+z0TmwMl4mTfX6/
         B45KY3JgGCQwAdmiEqzWlSJGt4JLwvORlLU73eqLdBksfZwCVSTOQFqJR9wcTnv21nVT
         PvsxMR55AuIJGoEwfEy8Dgy1++URgq4JWn6J3czymfLKhbosWBfqYN4SAtn34oRnypQe
         lPrRnJuVPRvs2nFGzoxhf9du+OQvNztUY9eYWJa03ReOYwOTeKnN8q5KoaUvS0CK59CH
         JHzWyDooyluXEnW7QCN4JKag8yd8wvH6ae0L4drQ6sEtYqTeTtXdU/b3MmaiJ1tgpGrj
         BFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AwBGKgAiV9treuZFBi82d53Otoj4Lv3V92XEOJ1XHME=;
        b=Ke/ktxc0X37octtx8HS7KjIsQQZ2leY3F4m0iXrlpp72OoeFTTb2r6vD/Hyggznv7g
         0QqEcesWT81mgsfaS3Y9REhsKF0Ncmfmckq9aqUckE075f+Qqsscpk8kM0FANDGrr+Bj
         l28iVMkd3Yn6sOpu3PTsmo2UvAvih5H+c2uw7tBaNOMVlOcXsLByocETSb4taKt2yFym
         kQMQelzW7kM4wHUcqE0aRwJofBIsi/H7wIr00VipuVOZ0tu2AhP45NYWxYajyzWJJtTt
         vGaK8etABCdMGVKLElcwGAbEmzkKMiHfwwRQ7jRBiAgff5JPz47WSHTVGPHtrgDII7zv
         C2nQ==
X-Gm-Message-State: APjAAAXxhXtFqG6u/VBMAxANSi/36SYQFwkMbGMLNVG6dH7DfCuYB+L6
        3vTRq3xAz2DQPC4Z2plS1nA=
X-Google-Smtp-Source: APXvYqyEoQEST4NAViipvODu7wVl0HrApMPDB88pb0boJSYAMqok4HUFgZaq32nbQlPXIAXlbO96MA==
X-Received: by 2002:a2e:9596:: with SMTP id w22mr3626369ljh.21.1576597021861;
        Tue, 17 Dec 2019 07:37:01 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i13sm12639716ljg.89.2019.12.17.07.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:37:01 -0800 (PST)
Subject: Re: [PATCH v3 08/15] ASoC: tegra: Add audio mclk control through
 clk_out_1 and extern1
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
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alexios.zavras@intel.com,
        alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-9-git-send-email-skomatineni@nvidia.com>
 <0ce2e83b-800c-da1e-7a3c-3cf1427cfe20@gmail.com>
 <2eeceabe-b5f0-6f9e-ff8c-4ac6167b7cc3@nvidia.com>
 <41a7325c-9bb9-f681-4d30-d19079869d12@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d8f158cd-3bf5-383a-c9fe-650f6d7ac178@gmail.com>
Date:   Tue, 17 Dec 2019 18:36:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <41a7325c-9bb9-f681-4d30-d19079869d12@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2019 04:29, Sowjanya Komatineni пишет:
> 
> On 12/7/19 11:20 AM, Sowjanya Komatineni wrote:
>>
>> On 12/7/19 6:58 AM, Dmitry Osipenko wrote:
>>> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>>>> Current ASoC driver uses extern1 as cdev1 clock from Tegra30 onwards
>>>> through device tree.
>>>>
>>>> Actual audio mclk is clk_out_1 and to use PLLA for mclk rate control,
>>>> need to clk_out_1_mux parent to extern1 and extern1 parent to
>>>> PLLA_OUT0.
>>>>
>>>> Currently Tegra clock driver init sets the parents and enables both
>>>> clk_out_1 and extern1 clocks. But these clocks parent and enables
>>>> should
>>>> be controlled by ASoC driver.
>>>>
>>>> Clock parents can be specified in device tree using assigned-clocks
>>>> and assigned-clock-parents.
>>>>
>>>> To enable audio mclk, both clk_out_1 and extern1 clocks need to be
>>>> enabled.
>>>>
>>>> This patch configures parents for clk_out_1 and extern1 clocks if
>>>> device
>>>> tree does not specify clock parents inorder to support old device tree
>>>> and controls mclk using both clk_out_1 and extern1 clocks.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>   sound/soc/tegra/tegra_asoc_utils.c | 66
>>>> ++++++++++++++++++++++++++++++++++++++
>>>>   sound/soc/tegra/tegra_asoc_utils.h |  1 +
>>>>   2 files changed, 67 insertions(+)
>>>>
>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>> index 536a578e9512..8e3a3740df7c 100644
>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>> @@ -60,6 +60,7 @@ int tegra_asoc_utils_set_rate(struct
>>>> tegra_asoc_utils_data *data, int srate,
>>>>       data->set_mclk = 0;
>>>>         clk_disable_unprepare(data->clk_cdev1);
>>>> +    clk_disable_unprepare(data->clk_extern1);
>>>>       clk_disable_unprepare(data->clk_pll_a_out0);
>>>>       clk_disable_unprepare(data->clk_pll_a);
>>>>   @@ -89,6 +90,14 @@ int tegra_asoc_utils_set_rate(struct
>>>> tegra_asoc_utils_data *data, int srate,
>>>>           return err;
>>>>       }
>>>>   +    if (!IS_ERR_OR_NULL(data->clk_extern1)) {
>>>> +        err = clk_prepare_enable(data->clk_extern1);
>>>> +        if (err) {
>>>> +            dev_err(data->dev, "Can't enable extern1: %d\n", err);
>>>> +            return err;
>>>> +        }
>>>> +    }
>>>> +
>>>>       err = clk_prepare_enable(data->clk_cdev1);
>>>>       if (err) {
>>>>           dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>>>> @@ -109,6 +118,7 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>>> tegra_asoc_utils_data *data)
>>>>       int err;
>>>>         clk_disable_unprepare(data->clk_cdev1);
>>>> +    clk_disable_unprepare(data->clk_extern1);
>>>>       clk_disable_unprepare(data->clk_pll_a_out0);
>>>>       clk_disable_unprepare(data->clk_pll_a);
>>>>   @@ -142,6 +152,14 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>>> tegra_asoc_utils_data *data)
>>>>           return err;
>>>>       }
>>>>   +    if (!IS_ERR_OR_NULL(data->clk_extern1)) {
>>>> +        err = clk_prepare_enable(data->clk_extern1);
>>>> +        if (err) {
>>>> +            dev_err(data->dev, "Can't enable extern1: %d\n", err);
>>>> +            return err;
>>>> +        }
>>>> +    }
>>> Why this is needed given that clk_extern1 is either a child of MCLK or
>>> MCLK itself (on T20)? The child clocks are enabled when the parent is
>>> enabled.
>>
>> For T30 and later, clk_extern1 is one of the source for clk_out_1_mux.
>> clk_extern1 is in CAR and it has its own gate and mux.
>>
>> As audio mclk related clocks (clk_out_1, clk_out_1_mux, and extern1)
>> are moved into ASoC driver from clock driver
>>
>> need to enable extern1 gate as well along with clk_out1 for T30
>> through T210.
>>
>> Just FYI, extern1 enable here happens only when data->clk_extern1 is
>> available which is for T30 onwards.
>>
>>>>       err = clk_prepare_enable(data->clk_cdev1);
>>>>       if (err) {
>>>>           dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>>>> @@ -158,6 +176,7 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>>>>   int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>>>>                 struct device *dev)
>>>>   {
>>>> +    struct clk *clk_out_1_mux;
>>>>       int ret;
>>>>         data->dev = dev;
>>>> @@ -196,6 +215,51 @@ int tegra_asoc_utils_init(struct
>>>> tegra_asoc_utils_data *data,
>>>>           goto err_put_pll_a_out0;
>>>>       }
>>> In a previous patch you added fallback to EXTPERIPH when clk_get(MCLK)
>>> fails. This will work perfectly fine for the older kernels which have
>>> all clocks in the same single CaR driver, but this may not work that
>>> great for the newer kernels because PMC driver isn't registered early
>>> during boot and thus it is possible to get a legit -EPROBE_DEFER which
>>> shouldn't be ignored. In other words, you need to add into this patch a
>>> check for the error code returned by clk_get(MCLK) and fallback only for
>>> -EINVAL.
>> yeah right, will add check in next version.
>>>> +    /*
>>>> +     * If clock parents are not set in DT, configure here to use
>>>> clk_out_1
>>>> +     * as mclk and extern1 as parent for Tegra30 and higher.
>>>> +     */
>>>> +    if (!of_find_property(dev->of_node, "assigned-clock-parents",
>>>> NULL) &&
>>>> +        data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
>>>> +        data->clk_extern1 = clk_get_sys("clk_out_1", "extern1");
>>>> +        if (IS_ERR(data->clk_extern1)) {
>>>> +            dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>> +            ret = PTR_ERR(data->clk_extern1);
>>>> +            goto err_put_cdev1;
>>>> +        }
>>>> +
>>>> +        ret = clk_set_parent(data->clk_extern1, data->clk_pll_a_out0);
>>>> +        if (ret < 0) {
>>>> +            dev_err(data->dev,
>>>> +                "Set parent failed for clk extern1: %d\n",
>>>> +                ret);
>>>> +            goto err_put_cdev1;
>>>> +        }
>>>> +
>>>> +        clk_out_1_mux = clk_get_sys(NULL, "clk_out_1_mux");
>>> Note1: clk_get(dev, "clk_out_1_mux") should work here by letting clk
>>> core to fall back to the clk_get_sys() by itself. Either way should
>>> be good.
> 
> clk_get uses device rather and dev_id will be name of this device and
> when clk_get fall back to __clk_get_sys() it still will use dev id of
> this device rather than actual dev_id that pmc clocks are added to the
> lookup. So clk_get_sys() seems to be correct to use as we can specify
> exact dev_id and con_id.

It should be better to use something "resource managed", thus
devm_clk_get() should be a better choice.

> Also, clk_find retrieves clock from lookup only when it finds matching
> clock with both dev_id and con_id as pmc clocks are registered with both
> dev_id and con_id.
> 
> I see existing clock driver adds both extern and pmc clocks (clk_out) to
> lookup with same dev_id of clk_out_1/2/3 and con_id of extern1/2/3 and
> with this always extern clock will be retrieved and this is probably
> because old DT and audio driver always uses extern1 rather than actual
> clk_out_1
> 
> But this need to be fixed now as we changed to use clk_out directly
> rather than extern (even for other pmc clocks) to match actual hw design.
> 
> Will fix this as well to register pmc clocks using con_id as
> clk_out_1/2/3 in pmc driver and extern clocks using con_id of
> extern1/2/3 with dev_id being NULL so we can retrieve these clocks by
> just using con_id only using clk_get_sys as we switched to use clk_out_1
> directly as pmc clock rather than extern from DT and no longer need to
> pair pmc clocks to extern clocks.

I'm not sure it's worth the effort to care about con_ids if implicit
fallback to clk_get_sys(NULL, "...") does the right thing for the audio
driver.

IIRC, CCF uses variant of matching clocks by names, although I'm not
sure whether that applies to older stable kernels.

[snip]

