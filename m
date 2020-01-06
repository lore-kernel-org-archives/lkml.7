Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F51C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E466324670
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C5Et2+sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgAFEVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 23:21:54 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10172 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgAFEVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 23:21:53 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e12b5ce0000>; Sun, 05 Jan 2020 20:21:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 05 Jan 2020 20:21:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 05 Jan 2020 20:21:51 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jan
 2020 04:21:44 +0000
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <359bf92f-2e67-28b2-8412-9e47bb24ffdb@nvidia.com>
Date:   Mon, 6 Jan 2020 09:51:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9e08a1eb-7a9f-0ed0-a2f4-08f1d6f93958@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578284494; bh=tnbjdAmln75q3VV3tpCj5+j3ymlAVN3jjW/2BbGPdwk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=C5Et2+sR8/h3N/Zot5151ZgyUyEb54gC93XBDJkoh4UNlWaGhHYivOV/1UsdeK8X+
         LgoREm5nyEqCTUbsGOo/a1KQMjAQdg+aCynpIByorh9elq7+tu/GhBHpctF9hmsz0e
         wnT2Bp5nalOSgWXA7mzTRLcSyMeGeTwJEi3Q/YC/t1KOtI2dlJLZx9GNbsBf1bcaO7
         +0HnP/+y6iL0u+Ab645psDethUdanQRnlY/yJdin8f64GO9q38Nl+O0myGzr/EtC14
         J7G3FRfHC1v1jJO+mWAxtUKDE7lVMQdcWJC125/eGfPrQ+DaR3WAdOQkesMHIcWkrc
         qjt6uwWvLisuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2020 10:33 AM, Sowjanya Komatineni wrote:
>
> On 1/4/20 5:05 PM, Dmitry Osipenko wrote:
>> 04.01.2020 08:49, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On 1/2/20 8:12 AM, Dmitry Osipenko wrote:
>>>> 02.01.2020 10:03, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> On 12/27/19 1:19 PM, Sowjanya Komatineni wrote:
>>>>>> On 12/27/19 6:56 AM, Dmitry Osipenko wrote:
>>>>>>> 25.12.2019 20:57, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>>> On Mon, Dec 23, 2019 at 12:14:34AM +0300, Dmitry Osipenko wrote:
>>>>>>>>> 21.12.2019 01:26, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
>>>>>>>>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from=20
>>>>>>>>>> Tegra30
>>>>>>>>>> through Tegra210 and currently Tegra clock driver does=20
>>>>>>>>>> initial parent
>>>>>>>>>> configuration for audio mclk "clk_out_1" and enables them by=20
>>>>>>>>>> default.
>>>>>>>> Please delete unneeded context from mails when replying.=C2=A0 Doi=
ng=20
>>>>>>>> this
>>>>>>>> makes it much easier to find your reply in the message, helping=20
>>>>>>>> ensure
>>>>>>>> it won't be missed by people scrolling through the irrelevant=20
>>>>>>>> quoted
>>>>>>>> material.
>>>>>>> Ok
>>>>>>>
>>>>>>>>>> - clk_disable_unprepare(data->clk_cdev1);
>>>>>>>>>> - clk_disable_unprepare(data->clk_pll_a_out0);
>>>>>>>>>> - clk_disable_unprepare(data->clk_pll_a);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (__clk_is_enabled(data->clk_cdev1))
>>>>>>>>>> + clk_disable_unprepare(data->clk_cdev1);
>>>>>>>>> The root of the problem is that you removed clocks enabling from
>>>>>>>>> tegra_asoc_utils_init().
>>>>>> currently, audio mclk and its parent clocks enabling are from clock
>>>>>> driver init and not from tegra_asoc_utils_init.
>>>>>>>>> I'm not sure why clocks should be disabled during the=20
>>>>>>>>> rate-changing,
>>>>>>>>> probably this action is not really needed.
>>>>>>>> I know nothing about this particular device but this is not that
>>>>>>>> unusual a restriction for audio hardware, you often can't
>>>>>>>> robustly reconfigure the clocking for a device while it's active
>>>>>>>> due to issues in the hardware.=C2=A0 You often see issues with FIF=
Os
>>>>>>>> glitching or state machines getting stuck. This may not be an
>>>>>>>> issue here but if it's something that's documented as a
>>>>>>>> requirement it's probably good to pay attention.
>>>>>>> I don't know details about that hardware either, maybe it is=20
>>>>>>> simply not
>>>>>>> safe to change PLL_A rate dynamically and then CLK_SET_RATE_GATE=20
>>>>>>> could
>>>>>>> be used.
>>>>>>>
>>>>>>> If nobody knows for sure, then will be better to keep
>>>>>>> tegra_asoc_utils_set_rate() unchanged.
>>>>>> plla rate change through tegra_asoc_utils_set_rate() happens only=20
>>>>>> when
>>>>>> there is not active playback or record corresponding to this sound
>>>>>> device.
>>>>>>
>>>>>> So, I don't see reason for disabling clock during rate change and=20
>>>>>> not
>>>>>> sure why we had this from the beginning.
>>>>>>
>>>>>> Thierry/Sameer,
>>>>>>
>>>>>> Can you please comment?
>>>>>>
>>>>>> Yes, we can use CLK_SET_RATE_GATE for PLLA and remove clock=20
>>>>>> disabling
>>>>>> before rate change.
>>>>>>
>>>>> PLLA is used for both I2S controller clock and also for audio=20
>>>>> mclk. I2S
>>>>> driver suspend resume implementations takes care of enabling and
>>>>> disabling I2S clock but audio mclk will be enabled during that=20
>>>>> time and
>>>>> PLLA disable might not happen. So using CLK_SET_RATE_GATE prevents=20
>>>>> rate
>>>>> change to happen and as rate change happens only when there is no=20
>>>>> active
>>>>> audio record/playback, we can perform rate change without=20
>>>>> disable/enable
>>>>> during rate change.
>>>>>
>>>>> So probably below changes should be good.
>>>>>
>>>>> =C2=A0=C2=A0 * remove asoc_utils_set_rate call from asoc_utils_init a=
s set_rate
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 happens during existing hw_params callback i=
mplementations in=20
>>>>> sound
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 drivers and there is no need to do rate chan=
ge during=20
>>>>> asoc_utils_init.
>>>>> =C2=A0=C2=A0 * remove disable/enable clocks during rate change in=20
>>>>> asoc_utils_set_rate.
>>>>> =C2=A0=C2=A0 * add startup and shutdown snd_soc_ops callbacks to do e=
nable and
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 disable audio mclk.
>>>>>
>>>> Sounds good, thanks. I'll be happy to review and test it.
>>> Regarding disabling audio mclk during PLLA rate change, no need to
>>> explicitly disable PLLA on asoc utils as clock driver takes care of it
>>> properly during pll rate change.
>>>
>>> But the downstream clock divider hardware can malfunction without
>>> recovery when subject to unstable PLL output during locking, unless
>>> clock is gated.
>>>
>>> So it is recommended to disable downstream clocks during PLL rate=20
>>> change.
>>>
>>> PLLA downstream clocks are I2S and audio mclk (cdev1/clk1 and extern1
>>> clocks) and I2S clock is disabled in I2S driver by PM runtime ops.
>> The I2S driver uses asynchronous pm_runtime_put() and thus there is no
>> guarantee that I2S clock is disabled at the time of changing PLLA rate.
>> Could this be a problem?
> Looking into soc_pcm_hw_params, I see dai_link hw_params ops happens=20
> prior to=C2=A0 platform snd_soc_dai_driver hw_params ops.

This is true.

>
> So, PLL rate change thru asoc_utils_set_rate happens during sample=20
> rate config of dai_link hw_params ops and during this time I2S will=20
> always be in idle state.

This is probably not the case, since runtime resume for I2S would have=20
already enabled the clock for I2S and in turn PLLA. The hw_param() call=20
would happen later.
We could have used a fixed clock rate for PLLA, but the reason why we=20
are setting the rate at runtime is, we support sample rates (and=20
multuples) of 8kHz and 11.025kHz.
Both of these require a different PLLA base rate for downstream clock=20
dividers to work properly. That is why, I think we have two base rates=20
for PLLA.

Even if we want to enable the clocks (for i2s) in hw_param(), this still=20
may not help.
For example there could be multiple I2S instances, which can use the=20
same PLLA source. ALSA playback/capture on different I2S can run=20
independently.
Hence we are not sure if clk_disable_unprepare() in tegra_asoc_utils.c=20
would actually disable PLLA. Hence I think the problem exists in current=20
code too.

We really want to allow user to run any sample rate in the supported=20
range. However the sample rate is known during hw_param() callback.

Looking at current discussion, we may have to provide an aternate way of=20
switching PLLA base rate (may be not in ALSA callbacks)

>
> Sameer, Please confirm.
>
>>> For audio mclk, need to make sure mclk are disabled during rate change.
>>>
>>> So below are the changes to audio clocks that will be in next version.
>>>
>>> =C2=A0=C2=A0 * remove tegra_asoc_utils_set_rate call from=20
>>> tegra_asoc_utils_init as
>>> =C2=A0=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_set_rate happens during hw_pa=
rams callback.
>>> =C2=A0=C2=A0 * add shutdown snd_soc_ops callbacks to disable of audio m=
clk.
>>> =C2=A0=C2=A0 * remove disable audio mclk (cdev1) and plla clocks prior =
to rate
>>> =C2=A0=C2=A0=C2=A0=C2=A0 change in tegra_asoc_utils_set_rate (as audio =
mclk will always=20
>>> be in
>>> =C2=A0=C2=A0=C2=A0=C2=A0 disabled state every time hw_param callback ge=
ts executed) and=20
>>> keep
>>> =C2=A0=C2=A0=C2=A0=C2=A0 audio mclk enable after the rate change in=20
>>> tegra_asoc_utils_set_rate.
>>>
