Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893AC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3FB2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pISxBC+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgAGW4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:56:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47044 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgAGW4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:56:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so1258713ljc.13;
        Tue, 07 Jan 2020 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SmAaNlqX7wktMzlx+PndgXg6P7/OceJAZF8e2T4rFsk=;
        b=pISxBC+CwrFnifLFtbUDSEPoXWhewuFGjcbF7HnhNniuA5FtthlSYCpVkmpIB79m96
         mOJA0eNkHLmAoYUo+a9ve5sncjZUjCGdJmOUwv68tNg23UR/7m4NPlnUpVDEKf6zcOBG
         4h9zQZ7jij4MdXSOlqyoeaqurv9REuRMuBMP9vqGDmZ+1vmaBtp9Mht3S01M0rJkG+8p
         /kje1cuZflBVR1/uiOumJYQtnhPv/gtQlv4vVboT4W2ZFKpshTwQtDsOCMMszj3p/PL1
         ftt4CdV7Ds7XQ6EpS/xJ9gQhIwEXwdhOALi2CsUSeltofBQ9BOr2bbZz/cPWy62MmDSp
         Kubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SmAaNlqX7wktMzlx+PndgXg6P7/OceJAZF8e2T4rFsk=;
        b=TJTTEoIeniTmZqP322kuD8d52IqWHzYPvZUKesrK+QLgvesuUvhRQSsAMhkyIsXtAW
         iSWOokj0qI0axFATvnR/LFLnMHl6gOtpJRh+ujn0FRaOiIjxJY1h8oJpu9YMW3M90byZ
         eSbvn8rYE5b6J/wjpKeslHXxcekeZh2HdYWOmsxNbEL3uK2spH3fyUMAyhPgaj0IM5GK
         t1dWzXLLRPywzcIzcGYvJoMj6oeB7Mfp0T4eY+cT8rTOAluyIlDS8Rffkr6BFxfenMzS
         TxybU2TBW1tqMXy2YqBurVBjANlE8JQgmtwflZUOJn8Supht20mez2auXKoTlxTzUoMh
         2GOw==
X-Gm-Message-State: APjAAAV+bbazqiwAwyB5AUch3lYU5KE67NNx6nVzEaunw0gPNC4P+cJe
        pwpmWJUi6NSxMbylJ64S4eXdjUfr
X-Google-Smtp-Source: APXvYqzpAupBmEWmIFUIVX9WoUfMIHfTyxQkbTOHJwcqkkAraTAH9ZO+tqCmm35t+5NmNLnMZJLThg==
X-Received: by 2002:a2e:461a:: with SMTP id t26mr1069905lja.204.1578437793579;
        Tue, 07 Jan 2020 14:56:33 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id 2sm390279ljq.38.2020.01.07.14.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 14:56:32 -0800 (PST)
Subject: Re: [PATCH v6 12/19] ASoC: tegra: Add audio mclk configuration
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, josephl@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1578370458-3686-1-git-send-email-skomatineni@nvidia.com>
 <1578370458-3686-13-git-send-email-skomatineni@nvidia.com>
 <c23bf3f5-55d6-ab93-fd7b-13f9f2155dcc@nvidia.com>
 <d85c8529-9970-c79c-9430-ed80c47eaf36@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <adb4c9dd-043a-ffca-7a1d-c6b30055b7a0@gmail.com>
Date:   Wed, 8 Jan 2020 01:56:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d85c8529-9970-c79c-9430-ed80c47eaf36@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.01.2020 19:56, Sowjanya Komatineni пишет:
> 
> On 1/7/20 3:14 AM, Sameer Pujar wrote:
>>
>> On 1/7/2020 9:44 AM, Sowjanya Komatineni wrote:
>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>>> through Tegra210 and currently Tegra clock driver does the initial
>>> parent
>>> configuration for audio mclk and keeps it enabled by default.
>>>
>>> With the move of PMC clocks from clock driver into pmc driver,
>>> audio clocks parent configuration can be specified through the device
>>> tree
>>> using assigned-clock-parents property and audio mclk control should be
>>> taken care by the audio driver.
>>>
>>> This patch has implementation for parent configuration when default
>>> parent
>>> configuration is not specified in the device tree and controls audio
>>> mclk
>>> enable and disable during machine startup and shutdown.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>
>> Minor comments, otherwise LGTM.
>>
> Thanks Sameer. Will fix.
>>> ---
>>>   sound/soc/tegra/tegra_alc5632.c    | 21 ++++++++++
>>>   sound/soc/tegra/tegra_asoc_utils.c | 84
>>> ++++++++++++++++++++++++--------------
>>>   sound/soc/tegra/tegra_asoc_utils.h |  2 +
>>>   sound/soc/tegra/tegra_max98090.c   | 21 ++++++++++
>>>   sound/soc/tegra/tegra_rt5640.c     | 21 ++++++++++
>>>   sound/soc/tegra/tegra_rt5677.c     | 21 ++++++++++
>>>   sound/soc/tegra/tegra_sgtl5000.c   | 21 ++++++++++
>>>   sound/soc/tegra/tegra_wm8753.c     | 21 ++++++++++
>>>   sound/soc/tegra/tegra_wm8903.c     | 21 ++++++++++
>>>   sound/soc/tegra/trimslice.c        | 21 ++++++++++
>>>   10 files changed, 224 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/sound/soc/tegra/tegra_alc5632.c
>>> b/sound/soc/tegra/tegra_alc5632.c
>>> index 50a6d2ff4442..0fd10023f7a6 100644
>>> --- a/sound/soc/tegra/tegra_alc5632.c
>>> +++ b/sound/soc/tegra/tegra_alc5632.c
>>> @@ -62,8 +62,29 @@ static int tegra_alc5632_asoc_hw_params(struct
>>> snd_pcm_substream *substream,
>>>       return 0;
>>>   }
>>>   +static int tegra_alc5632_asoc_startup(struct snd_pcm_substream
>>> *substream)
>>> +{
>>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>> +    struct tegra_alc5632 *machine =
>>> snd_soc_card_get_drvdata(rtd->card);
>>> +    int ret;
>>> +
>>> +    ret = tegra_asoc_utils_clk_enable(&machine->util_data);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static void tegra_alc5632_asoc_shutdown(struct snd_pcm_substream
>>> *substream)
>>> +{
>>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>> +    struct tegra_alc5632 *machine =
>>> snd_soc_card_get_drvdata(rtd->card);
>>> +
>>> +    tegra_asoc_utils_clk_disable(&machine->util_data);
>>> +}
>>> +
>>>   static const struct snd_soc_ops tegra_alc5632_asoc_ops = {
>>> +    .startup = tegra_alc5632_asoc_startup,
>>>       .hw_params = tegra_alc5632_asoc_hw_params,
>>> +    .shutdown = tegra_alc5632_asoc_shutdown,
>>>   };
>>>     static struct snd_soc_jack tegra_alc5632_hs_jack;
>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>> index 0d2271952555..2886ae9f5a16 100644
>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>> @@ -60,8 +60,6 @@ int tegra_asoc_utils_set_rate(struct
>>> tegra_asoc_utils_data *data, int srate,
>>>       data->set_mclk = 0;
>>>         clk_disable_unprepare(data->clk_cdev1);
>>> -    clk_disable_unprepare(data->clk_pll_a_out0);
>>> -    clk_disable_unprepare(data->clk_pll_a);
>>>         err = clk_set_rate(data->clk_pll_a, new_baseclock);
>>>       if (err) {
>>> @@ -77,18 +75,6 @@ int tegra_asoc_utils_set_rate(struct
>>> tegra_asoc_utils_data *data, int srate,
>>>         /* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>>>   -    err = clk_prepare_enable(data->clk_pll_a);
>>> -    if (err) {
>>> -        dev_err(data->dev, "Can't enable pll_a: %d\n", err);
>>> -        return err;
>>> -    }
>>> -
>>> -    err = clk_prepare_enable(data->clk_pll_a_out0);
>>> -    if (err) {
>>> -        dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
>>> -        return err;
>>> -    }
>>> -
>>>       err = clk_prepare_enable(data->clk_cdev1);
>>>       if (err) {
>>>           dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>>> @@ -109,8 +95,6 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>> tegra_asoc_utils_data *data)
>>>       int err;
>>>         clk_disable_unprepare(data->clk_cdev1);
>>> -    clk_disable_unprepare(data->clk_pll_a_out0);
>>> -    clk_disable_unprepare(data->clk_pll_a);
>>>         /*
>>>        * AC97 rate is fixed at 24.576MHz and is used for both the host
>>> @@ -130,17 +114,27 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>> tegra_asoc_utils_data *data)
>>>         /* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>>>   -    err = clk_prepare_enable(data->clk_pll_a);
>>> +    err = clk_prepare_enable(data->clk_cdev1);
>>>       if (err) {
>>> -        dev_err(data->dev, "Can't enable pll_a: %d\n", err);
>>> +        dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>>>           return err;
>>>       }
>>>   -    err = clk_prepare_enable(data->clk_pll_a_out0);
>>> -    if (err) {
>>> -        dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
>>> -        return err;
>>> -    }
>>> +    data->set_baseclock = pll_rate;
>>> +    data->set_mclk = ac97_rate;
>>> +
>>> +    return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>>> +
>>> +void tegra_asoc_utils_clk_disable(struct tegra_asoc_utils_data *data)
>>> +{
>>> +    clk_disable_unprepare(data->clk_cdev1);
>>> +}
>>> +
>>> +int tegra_asoc_utils_clk_enable(struct tegra_asoc_utils_data *data)
>>> +{
>>> +    int err;
>>>         err = clk_prepare_enable(data->clk_cdev1);
>>>       if (err) {
>>> @@ -148,16 +142,13 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>> tegra_asoc_utils_data *data)
>>>           return err;
>>>       }
>>>   -    data->set_baseclock = pll_rate;
>>> -    data->set_mclk = ac97_rate;
>>> -
>>>       return 0;
>>>   }
>>> -EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>>>     int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>>>                 struct device *dev)
>>>   {
>>> +    struct clk *clk_out_1, *clk_extern1;
>>>       int ret;
>>>         data->dev = dev;
>>> @@ -193,9 +184,42 @@ int tegra_asoc_utils_init(struct
>>> tegra_asoc_utils_data *data,
>>>           return PTR_ERR(data->clk_cdev1);
>>>       }
>>>   -    ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
>>> -    if (ret)
>>> -        return ret;
>>> +    /*
>>> +     * If clock parents are not set in DT, configure here to use
>>> clk_out_1
>>> +     * as mclk and extern1 as parent for Tegra30 and higher.
>>> +     */
>>> +    if (!of_find_property(dev->of_node, "assigned-clock-parents",
>>> NULL) &&
>>> +        data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
>>> +        dev_err(data->dev,
>>
>> As this is a fallback mechanism, use dev_info or dev_dbg instead?

dev_warn

>>> +            "Configuring clocks for a legacy device-tree\n");

I'd also add another message here saying "Please update your DT", for
clarity.
