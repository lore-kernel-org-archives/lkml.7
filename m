Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06922C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D592075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vhv6WFV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgAFW7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:59:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41598 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFW7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:59:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so37478939lfp.8;
        Mon, 06 Jan 2020 14:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hcP8YB7ZVpJCAlYhLfCYmL9dEsNF8L5O7Bmb/KQU4/Q=;
        b=vhv6WFV6IRMwRf5308kZZDmnns3vPtn8XfDlSJIvgcAMdVcLCCEyWxK6X2q/telNq6
         ZgATmObw+NYY7TGRrarzB+rFz/MAm5V7odv0SjLwioHnAdm65Pfj1q1GM1DLAIj2LftI
         2w0gPCF0WkW3RWVJikSRnYLAeV+ww0uPBjpwhBm1x0zsJNRMWwZ53Z3qJZepPR7T5qwB
         tRA1qXjRnXn4wLSSzGhj6qrEpaU8aGXZlPc6m6neuDYCNDZx/afw+47adq04Ie/Q/2ur
         yfPuf8xx0+b8dsSIMGBqVEn2OcRUbN2kgn1+N0CHs/I3Gy0HPbfs3cdoHitJ5Oe9G7UM
         X+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hcP8YB7ZVpJCAlYhLfCYmL9dEsNF8L5O7Bmb/KQU4/Q=;
        b=qBwSMhwjCYgrAxwTU2l1EsGhadcpoN/ACz6yaw90eYqMyxRVykoerNN3IEg3QvmqA6
         +TPMJbeN0BYtQ0zyYGJ0BTuJK2bviS3ikAVe2dnvJGEtE5iv2DT2nwbysCBbfsYWSTNL
         U8nv7dW3fCpCVvI2o8vYKx01dsFFTHE2bIzfPgXVwN+27nCo2K4c0nDjofhTtajwdDzw
         KRyj9vDLGp0JYvakV+qJ0J2vdTk8vzzlOscZgt08TkJjGyZ9kfyxc/Hf0OcZDKxSCk2q
         lVnUoBLR4cv06H3+My0W2omQi8n9Q6HqOkWLCGpahS7cE0PERP6fhMPFSEs6+Mvxsv82
         MO3A==
X-Gm-Message-State: APjAAAUiN/vbTkP37J+emy+/uxL+/bInFZY8T+MUnLq/WOp/E5gJ3u6S
        iW0hYX1mo08H6+2CkxofA+1AxAA9
X-Google-Smtp-Source: APXvYqy7i5GZbUwBr/kvaV+uf4/f9DbV30a0gpyajPkPcVzjutAJh71X79ZCw7Lk03D5r5vLa8AZeQ==
X-Received: by 2002:ac2:485c:: with SMTP id 28mr57442176lfy.118.1578351546206;
        Mon, 06 Jan 2020 14:59:06 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id b19sm25422238ljk.25.2020.01.06.14.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 14:59:05 -0800 (PST)
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, josephl@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
 <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
 <20191225175736.GC27497@sirena.org.uk>
 <856d8a92-0c24-6722-952c-06b86c706e97@gmail.com>
 <dbbce994-27f5-d949-078d-05646100e6be@nvidia.com>
 <b6ec6cfd-d883-ea28-00f8-884fa80cfee1@nvidia.com>
 <576fca44-6734-5431-b523-512747a0bf12@gmail.com>
 <fb252096-e101-7d21-9717-c23607ae6edd@nvidia.com>
 <0f956c12-98cf-3466-f3ee-ffc3a23e3e3d@gmail.com>
 <9e08a1eb-7a9f-0ed0-a2f4-08f1d6f93958@nvidia.com>
 <359bf92f-2e67-28b2-8412-9e47bb24ffdb@nvidia.com>
 <5921f8e1-359d-4352-a785-8a685cd1a200@nvidia.com>
 <33eb0b3e-5605-3dfd-a6ea-a50ae1348c86@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <50657716-a719-6fe1-af3e-76eb90ca0ac5@gmail.com>
Date:   Tue, 7 Jan 2020 01:59:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <33eb0b3e-5605-3dfd-a6ea-a50ae1348c86@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.01.2020 19:30, Sowjanya Komatineni пишет:
> 
> On 1/6/20 8:09 AM, Sowjanya Komatineni wrote:
>>
>> On 1/5/20 8:21 PM, Sameer Pujar wrote:
>>>
>>> On 1/5/2020 10:33 AM, Sowjanya Komatineni wrote:
>>>>
>>>> On 1/4/20 5:05 PM, Dmitry Osipenko wrote:
>>>>> 04.01.2020 08:49, Sowjanya Komatineni пишет:
>>>>>> On 1/2/20 8:12 AM, Dmitry Osipenko wrote:
>>>>>>> 02.01.2020 10:03, Sowjanya Komatineni пишет:
>>>>>>>> On 12/27/19 1:19 PM, Sowjanya Komatineni wrote:
>>>>>>>>> On 12/27/19 6:56 AM, Dmitry Osipenko wrote:
>>>>>>>>>> 25.12.2019 20:57, Mark Brown пишет:
>>>>>>>>>>> On Mon, Dec 23, 2019 at 12:14:34AM +0300, Dmitry Osipenko wrote:
>>>>>>>>>>>> 21.12.2019 01:26, Sowjanya Komatineni пишет:
>>>>>>>>>>>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from
>>>>>>>>>>>>> Tegra30
>>>>>>>>>>>>> through Tegra210 and currently Tegra clock driver does
>>>>>>>>>>>>> initial parent
>>>>>>>>>>>>> configuration for audio mclk "clk_out_1" and enables them
>>>>>>>>>>>>> by default.
>>>>>>>>>>> Please delete unneeded context from mails when replying. 
>>>>>>>>>>> Doing this
>>>>>>>>>>> makes it much easier to find your reply in the message,
>>>>>>>>>>> helping ensure
>>>>>>>>>>> it won't be missed by people scrolling through the irrelevant
>>>>>>>>>>> quoted
>>>>>>>>>>> material.
>>>>>>>>>> Ok
>>>>>>>>>>
>>>>>>>>>>>>> - clk_disable_unprepare(data->clk_cdev1);
>>>>>>>>>>>>> - clk_disable_unprepare(data->clk_pll_a_out0);
>>>>>>>>>>>>> - clk_disable_unprepare(data->clk_pll_a);
>>>>>>>>>>>>> +    if (__clk_is_enabled(data->clk_cdev1))
>>>>>>>>>>>>> + clk_disable_unprepare(data->clk_cdev1);
>>>>>>>>>>>> The root of the problem is that you removed clocks enabling
>>>>>>>>>>>> from
>>>>>>>>>>>> tegra_asoc_utils_init().
>>>>>>>>> currently, audio mclk and its parent clocks enabling are from
>>>>>>>>> clock
>>>>>>>>> driver init and not from tegra_asoc_utils_init.
>>>>>>>>>>>> I'm not sure why clocks should be disabled during the
>>>>>>>>>>>> rate-changing,
>>>>>>>>>>>> probably this action is not really needed.
>>>>>>>>>>> I know nothing about this particular device but this is not that
>>>>>>>>>>> unusual a restriction for audio hardware, you often can't
>>>>>>>>>>> robustly reconfigure the clocking for a device while it's active
>>>>>>>>>>> due to issues in the hardware.  You often see issues with FIFOs
>>>>>>>>>>> glitching or state machines getting stuck. This may not be an
>>>>>>>>>>> issue here but if it's something that's documented as a
>>>>>>>>>>> requirement it's probably good to pay attention.
>>>>>>>>>> I don't know details about that hardware either, maybe it is
>>>>>>>>>> simply not
>>>>>>>>>> safe to change PLL_A rate dynamically and then
>>>>>>>>>> CLK_SET_RATE_GATE could
>>>>>>>>>> be used.
>>>>>>>>>>
>>>>>>>>>> If nobody knows for sure, then will be better to keep
>>>>>>>>>> tegra_asoc_utils_set_rate() unchanged.
>>>>>>>>> plla rate change through tegra_asoc_utils_set_rate() happens
>>>>>>>>> only when
>>>>>>>>> there is not active playback or record corresponding to this sound
>>>>>>>>> device.
>>>>>>>>>
>>>>>>>>> So, I don't see reason for disabling clock during rate change
>>>>>>>>> and not
>>>>>>>>> sure why we had this from the beginning.
>>>>>>>>>
>>>>>>>>> Thierry/Sameer,
>>>>>>>>>
>>>>>>>>> Can you please comment?
>>>>>>>>>
>>>>>>>>> Yes, we can use CLK_SET_RATE_GATE for PLLA and remove clock
>>>>>>>>> disabling
>>>>>>>>> before rate change.
>>>>>>>>>
>>>>>>>> PLLA is used for both I2S controller clock and also for audio
>>>>>>>> mclk. I2S
>>>>>>>> driver suspend resume implementations takes care of enabling and
>>>>>>>> disabling I2S clock but audio mclk will be enabled during that
>>>>>>>> time and
>>>>>>>> PLLA disable might not happen. So using CLK_SET_RATE_GATE
>>>>>>>> prevents rate
>>>>>>>> change to happen and as rate change happens only when there is
>>>>>>>> no active
>>>>>>>> audio record/playback, we can perform rate change without
>>>>>>>> disable/enable
>>>>>>>> during rate change.
>>>>>>>>
>>>>>>>> So probably below changes should be good.
>>>>>>>>
>>>>>>>>    * remove asoc_utils_set_rate call from asoc_utils_init as
>>>>>>>> set_rate
>>>>>>>>      happens during existing hw_params callback implementations
>>>>>>>> in sound
>>>>>>>>      drivers and there is no need to do rate change during
>>>>>>>> asoc_utils_init.
>>>>>>>>    * remove disable/enable clocks during rate change in
>>>>>>>> asoc_utils_set_rate.
>>>>>>>>    * add startup and shutdown snd_soc_ops callbacks to do enable
>>>>>>>> and
>>>>>>>>      disable audio mclk.
>>>>>>>>
>>>>>>> Sounds good, thanks. I'll be happy to review and test it.
>>>>>> Regarding disabling audio mclk during PLLA rate change, no need to
>>>>>> explicitly disable PLLA on asoc utils as clock driver takes care
>>>>>> of it
>>>>>> properly during pll rate change.
>>>>>>
>>>>>> But the downstream clock divider hardware can malfunction without
>>>>>> recovery when subject to unstable PLL output during locking, unless
>>>>>> clock is gated.
>>>>>>
>>>>>> So it is recommended to disable downstream clocks during PLL rate
>>>>>> change.
>>>>>>
>>>>>> PLLA downstream clocks are I2S and audio mclk (cdev1/clk1 and extern1
>>>>>> clocks) and I2S clock is disabled in I2S driver by PM runtime ops.
>>>>> The I2S driver uses asynchronous pm_runtime_put() and thus there is no
>>>>> guarantee that I2S clock is disabled at the time of changing PLLA
>>>>> rate.
>>>>> Could this be a problem?
>>>> Looking into soc_pcm_hw_params, I see dai_link hw_params ops happens
>>>> prior to  platform snd_soc_dai_driver hw_params ops.
>>>
>>> This is true.
>>>
>>>>
>>>> So, PLL rate change thru asoc_utils_set_rate happens during sample
>>>> rate config of dai_link hw_params ops and during this time I2S will
>>>> always be in idle state.
>>>
>>> This is probably not the case, since runtime resume for I2S would
>>> have already enabled the clock for I2S and in turn PLLA. The
>>> hw_param() call would happen later.
>>> We could have used a fixed clock rate for PLLA, but the reason why we
>>> are setting the rate at runtime is, we support sample rates (and
>>> multuples) of 8kHz and 11.025kHz.
>>> Both of these require a different PLLA base rate for downstream clock
>>> dividers to work properly. That is why, I think we have two base
>>> rates for PLLA.
>>>
>>> Even if we want to enable the clocks (for i2s) in hw_param(), this
>>> still may not help.
>>> For example there could be multiple I2S instances, which can use the
>>> same PLLA source. ALSA playback/capture on different I2S can run
>>> independently.
>>> Hence we are not sure if clk_disable_unprepare() in
>>> tegra_asoc_utils.c would actually disable PLLA. Hence I think the
>>> problem exists in current code too.
>>
>> clk_disable_unprepare in aosc_utils_set_rate will not disable PLLA as
>> it will be in use by other consumer (I2S).
>>
>> But clock driver it self takes care of disabling pll output and
>> keeping it in bypass state so its not really like PLLA output is off.
>>
>> So regarding PLLA rate change, we dont have to explicitly disable in
>> audio driver as pll clock driver takes care during rate update,
>>
>> But consumer clocks of PLLA need to be disabled during rate update so
>> existing dividers doesn't cause any malfunction with new rate update.
>>
>> audio mclk can will be in disabled state during rate update thru
>> hw_params with addition of shutdown snd_soc_ops callbacks to disable
>> of audio mclk.
>>
>> But issue is for I2S clock where clock might be in enabled state and
>> this is issue with current I2S driver already.
>>
>> Sameer/Dmitry,
>>
>> Making sure I2S clock is in disabled state during rate update is
>> something need to work thru for proper fix and this is not related to
>> this patch series as this issue exists with current upstream.
>>
>> So, can we take care of this as separate patch out of this series so I
>> can get this series out as this PMC clock changes are needed for
>> upcoming camera drivers.
>>
> Based on internal discussion with sameer, proper I2S clock fix will be
> take care separately and this is not something introduced with this
> patch series.
> 
> So, will move once with audio MCLK fix in next version of patch series.
> 
>   * remove asoc_utils_set_rate call from asoc_utils_init as set_rate
>     happens during hw_params callback based on existing driver
>   * add shutdown snd_soc_ops callbacks to disable of audio mclk
>   * remove disable clocks prior to rate change in asoc_utils_set_rate
>     (as audio mclk will already be in disabled state by the time
>     hw_param callback gets executed) and keep audio mclk enable after
>     rate change in asoc_utils_set_rate
> 
>>> We really want to allow user to run any sample rate in the supported
>>> range. However the sample rate is known during hw_param() callback.
>>>
>>> Looking at current discussion, we may have to provide an aternate way
>>> of switching PLLA base rate (may be not in ALSA callbacks)
>>>
>>>>
>>>> Sameer, Please confirm.
>>>>
>>>>>> For audio mclk, need to make sure mclk are disabled during rate
>>>>>> change.
>>>>>>
>>>>>> So below are the changes to audio clocks that will be in next
>>>>>> version.
>>>>>>
>>>>>>    * remove tegra_asoc_utils_set_rate call from
>>>>>> tegra_asoc_utils_init as
>>>>>>      tegra_asoc_utils_set_rate happens during hw_params callback.
>>>>>>    * add shutdown snd_soc_ops callbacks to disable of audio mclk.
>>>>>>    * remove disable audio mclk (cdev1) and plla clocks prior to rate
>>>>>>      change in tegra_asoc_utils_set_rate (as audio mclk will
>>>>>> always be in
>>>>>>      disabled state every time hw_param callback gets executed)
>>>>>> and keep
>>>>>>      audio mclk enable after the rate change in
>>>>>> tegra_asoc_utils_set_rate.
>>>>>>

Indeed, it should be better to factor out all changes that are not
directly related to the PMC patches into separate patchset.
