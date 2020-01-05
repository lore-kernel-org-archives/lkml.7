Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C58FC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 05:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D655F24679
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 05:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WTMRBnc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgAEFEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 00:04:12 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5212 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAEFEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 00:04:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e116e120000>; Sat, 04 Jan 2020 21:03:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 04 Jan 2020 21:03:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 04 Jan 2020 21:03:30 -0800
Received: from [10.2.169.188] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 5 Jan
 2020 05:03:29 +0000
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
To:     Dmitry Osipenko <digetx@gmail.com>, Mark Brown <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <9e08a1eb-7a9f-0ed0-a2f4-08f1d6f93958@nvidia.com>
Date:   Sat, 4 Jan 2020 21:03:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0f956c12-98cf-3466-f3ee-ffc3a23e3e3d@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578200594; bh=mqELazUrdlbCs0VwMApedGlBc4mGw4jHtcOSTHHW3Ec=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=WTMRBnc9NoeD++lzXTh9F1a9Uyvl0P+ZsEWtAXXYemMcmLrkFBceU2Y4UfSOFTTP1
         X6KZmzq9DC2kbqKEbZ2w29gF/S4SNDtpIcVhfGp67lygu8vmExeqUpTTChsZSPEhta
         Ljvr5c57GUxJRmKMOfMWdQS+YE6e+3/qUTdPkvvFYhiw071FLLdSuYbqGkxDXGJkDn
         bpjhvKULBEvUkPgXLJsC+OePe49HPc/KClPWXg+NpNbdviEzqgaIDnecQgzYhhDnKI
         HaZfcWSciQrFwgSQgC/po9Esi9qsBD4WGG11mBblH/3OhRZDmkgGURefajlUc8yQDc
         9SoG01A6NMtcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/20 5:05 PM, Dmitry Osipenko wrote:
> 04.01.2020 08:49, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 1/2/20 8:12 AM, Dmitry Osipenko wrote:
>>> 02.01.2020 10:03, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 12/27/19 1:19 PM, Sowjanya Komatineni wrote:
>>>>> On 12/27/19 6:56 AM, Dmitry Osipenko wrote:
>>>>>> 25.12.2019 20:57, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>> On Mon, Dec 23, 2019 at 12:14:34AM +0300, Dmitry Osipenko wrote:
>>>>>>>> 21.12.2019 01:26, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
>>>>>>>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra3=
0
>>>>>>>>> through Tegra210 and currently Tegra clock driver does initial pa=
rent
>>>>>>>>> configuration for audio mclk "clk_out_1" and enables them by defa=
ult.
>>>>>>> Please delete unneeded context from mails when replying.=C2=A0 Doin=
g this
>>>>>>> makes it much easier to find your reply in the message, helping ens=
ure
>>>>>>> it won't be missed by people scrolling through the irrelevant quote=
d
>>>>>>> material.
>>>>>> Ok
>>>>>>
>>>>>>>>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_cdev1);
>>>>>>>>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a_out0);
>>>>>>>>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a);
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (__clk_is_enabled(data->clk_cdev1))
>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare=
(data->clk_cdev1);
>>>>>>>> The root of the problem is that you removed clocks enabling from
>>>>>>>> tegra_asoc_utils_init().
>>>>> currently, audio mclk and its parent clocks enabling are from clock
>>>>> driver init and not from tegra_asoc_utils_init.
>>>>>>>> I'm not sure why clocks should be disabled during the rate-changin=
g,
>>>>>>>> probably this action is not really needed.
>>>>>>> I know nothing about this particular device but this is not that
>>>>>>> unusual a restriction for audio hardware, you often can't
>>>>>>> robustly reconfigure the clocking for a device while it's active
>>>>>>> due to issues in the hardware.=C2=A0 You often see issues with FIFO=
s
>>>>>>> glitching or state machines getting stuck.=C2=A0 This may not be an
>>>>>>> issue here but if it's something that's documented as a
>>>>>>> requirement it's probably good to pay attention.
>>>>>> I don't know details about that hardware either, maybe it is simply =
not
>>>>>> safe to change PLL_A rate dynamically and then CLK_SET_RATE_GATE cou=
ld
>>>>>> be used.
>>>>>>
>>>>>> If nobody knows for sure, then will be better to keep
>>>>>> tegra_asoc_utils_set_rate() unchanged.
>>>>> plla rate change through tegra_asoc_utils_set_rate() happens only whe=
n
>>>>> there is not active playback or record corresponding to this sound
>>>>> device.
>>>>>
>>>>> So, I don't see reason for disabling clock during rate change and not
>>>>> sure why we had this from the beginning.
>>>>>
>>>>> Thierry/Sameer,
>>>>>
>>>>> Can you please comment?
>>>>>
>>>>> Yes, we can use CLK_SET_RATE_GATE for PLLA and remove clock disabling
>>>>> before rate change.
>>>>>
>>>> PLLA is used for both I2S controller clock and also for audio mclk. I2=
S
>>>> driver suspend resume implementations takes care of enabling and
>>>> disabling I2S clock but audio mclk will be enabled during that time an=
d
>>>> PLLA disable might not happen. So using CLK_SET_RATE_GATE prevents rat=
e
>>>> change to happen and as rate change happens only when there is no acti=
ve
>>>> audio record/playback, we can perform rate change without disable/enab=
le
>>>> during rate change.
>>>>
>>>> So probably below changes should be good.
>>>>
>>>>    * remove asoc_utils_set_rate call from asoc_utils_init as set_rate
>>>>      happens during existing hw_params callback implementations in sou=
nd
>>>>      drivers and there is no need to do rate change during asoc_utils_=
init.
>>>>    * remove disable/enable clocks during rate change in asoc_utils_set=
_rate.
>>>>    * add startup and shutdown snd_soc_ops callbacks to do enable and
>>>>      disable audio mclk.
>>>>
>>> Sounds good, thanks. I'll be happy to review and test it.
>> Regarding disabling audio mclk during PLLA rate change, no need to
>> explicitly disable PLLA on asoc utils as clock driver takes care of it
>> properly during pll rate change.
>>
>> But the downstream clock divider hardware can malfunction without
>> recovery when subject to unstable PLL output during locking, unless
>> clock is gated.
>>
>> So it is recommended to disable downstream clocks during PLL rate change=
.
>>
>> PLLA downstream clocks are I2S and audio mclk (cdev1/clk1 and extern1
>> clocks) and I2S clock is disabled in I2S driver by PM runtime ops.
> The I2S driver uses asynchronous pm_runtime_put() and thus there is no
> guarantee that I2S clock is disabled at the time of changing PLLA rate.
> Could this be a problem?
Looking into soc_pcm_hw_params, I see dai_link hw_params ops happens=20
prior to=C2=A0 platform snd_soc_dai_driver hw_params ops.

So, PLL rate change thru asoc_utils_set_rate happens during sample rate=20
config of dai_link hw_params ops and during this time I2S will always be=20
in idle state.

Sameer, Please confirm.

>> For audio mclk, need to make sure mclk are disabled during rate change.
>>
>> So below are the changes to audio clocks that will be in next version.
>>
>>    * remove tegra_asoc_utils_set_rate call from tegra_asoc_utils_init as
>>      tegra_asoc_utils_set_rate happens during hw_params callback.
>>    * add shutdown snd_soc_ops callbacks to disable of audio mclk.
>>    * remove disable audio mclk (cdev1) and plla clocks prior to rate
>>      change in tegra_asoc_utils_set_rate (as audio mclk will always be i=
n
>>      disabled state every time hw_param callback gets executed) and keep
>>      audio mclk enable after the rate change in tegra_asoc_utils_set_rat=
e.
>>
