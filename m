Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC49C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18767207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E8IpkiBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgAGXX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:23:56 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6758 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgAGXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:23:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1512f70000>; Tue, 07 Jan 2020 15:23:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 15:23:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 15:23:53 -0800
Received: from [10.2.175.47] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 23:23:51 +0000
Subject: Re: [PATCH v6 12/19] ASoC: tegra: Add audio mclk configuration
To:     Dmitry Osipenko <digetx@gmail.com>,
        Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578370458-3686-1-git-send-email-skomatineni@nvidia.com>
 <1578370458-3686-13-git-send-email-skomatineni@nvidia.com>
 <c23bf3f5-55d6-ab93-fd7b-13f9f2155dcc@nvidia.com>
 <d85c8529-9970-c79c-9430-ed80c47eaf36@nvidia.com>
 <adb4c9dd-043a-ffca-7a1d-c6b30055b7a0@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <fb9b620b-e923-abbb-e293-bea763802440@nvidia.com>
Date:   Tue, 7 Jan 2020 15:23:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <adb4c9dd-043a-ffca-7a1d-c6b30055b7a0@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578439415; bh=pgi0NOoAPzSz8Cm0HMUMjzFMDxKZcmUKv8NlLM+OOTM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=E8IpkiBxTH4n7DYh6TOgjFg0yCf1XVy5e/TsLmstE3vs6lbnR3XklsT7poSXwkQ/Z
         En3Hw6pDdQrRF7gDfPXjqTmYYzOKzZBCrgYcouPt5BJpn7w8pT7wyxpdi1NTtBU1Y1
         K0qfC8C5M/4e9UNSTzBNUSQOkIMr+J3pNB7SEo95VzFEzA4sa4JnGZZSomEjOzC8XL
         /+sSWF32z8ZGsYLwpG6ASHWIZiyE+2NnrhnEh5fBVB+jBwBKHHbh7qtwz3Y2RA3rLT
         Sb57JpPH0k7qvUV7TSrTLqMpDIVq1xycKbmXcTsBw/kMQdUwfodZZ8336qXWsrD7CG
         Fz2gKGYmFn9Qg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/20 2:56 PM, Dmitry Osipenko wrote:
> 07.01.2020 19:56, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 1/7/20 3:14 AM, Sameer Pujar wrote:
>>> On 1/7/2020 9:44 AM, Sowjanya Komatineni wrote:
>>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>>>> through Tegra210 and currently Tegra clock driver does the initial
>>>> parent
>>>> configuration for audio mclk and keeps it enabled by default.
>>>>
>>>> With the move of PMC clocks from clock driver into pmc driver,
>>>> audio clocks parent configuration can be specified through the device
>>>> tree
>>>> using assigned-clock-parents property and audio mclk control should be
>>>> taken care by the audio driver.
>>>>
>>>> This patch has implementation for parent configuration when default
>>>> parent
>>>> configuration is not specified in the device tree and controls audio
>>>> mclk
>>>> enable and disable during machine startup and shutdown.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> Minor comments, otherwise LGTM.
>>>
>> Thanks Sameer. Will fix.
>>>> ---
>>>>  =C2=A0 sound/soc/tegra/tegra_alc5632.c=C2=A0=C2=A0=C2=A0 | 21 +++++++=
+++
>>>>  =C2=A0 sound/soc/tegra/tegra_asoc_utils.c | 84
>>>> ++++++++++++++++++++++++--------------
>>>>  =C2=A0 sound/soc/tegra/tegra_asoc_utils.h |=C2=A0 2 +
>>>>  =C2=A0 sound/soc/tegra/tegra_max98090.c=C2=A0=C2=A0 | 21 ++++++++++
>>>>  =C2=A0 sound/soc/tegra/tegra_rt5640.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++=
++++++++
>>>>  =C2=A0 sound/soc/tegra/tegra_rt5677.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++=
++++++++
>>>>  =C2=A0 sound/soc/tegra/tegra_sgtl5000.c=C2=A0=C2=A0 | 21 ++++++++++
>>>>  =C2=A0 sound/soc/tegra/tegra_wm8753.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++=
++++++++
>>>>  =C2=A0 sound/soc/tegra/tegra_wm8903.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++=
++++++++
>>>>  =C2=A0 sound/soc/tegra/trimslice.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 21 ++++++++++
>>>>  =C2=A0 10 files changed, 224 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/sound/soc/tegra/tegra_alc5632.c
>>>> b/sound/soc/tegra/tegra_alc5632.c
>>>> index 50a6d2ff4442..0fd10023f7a6 100644
>>>> --- a/sound/soc/tegra/tegra_alc5632.c
>>>> +++ b/sound/soc/tegra/tegra_alc5632.c
>>>> @@ -62,8 +62,29 @@ static int tegra_alc5632_asoc_hw_params(struct
>>>> snd_pcm_substream *substream,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>  =C2=A0 }
>>>>  =C2=A0 +static int tegra_alc5632_asoc_startup(struct snd_pcm_substrea=
m
>>>> *substream)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->pri=
vate_data;
>>>> +=C2=A0=C2=A0=C2=A0 struct tegra_alc5632 *machine =3D
>>>> snd_soc_card_get_drvdata(rtd->card);
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util=
_data);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>> +}
>>>> +
>>>> +static void tegra_alc5632_asoc_shutdown(struct snd_pcm_substream
>>>> *substream)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->pri=
vate_data;
>>>> +=C2=A0=C2=A0=C2=A0 struct tegra_alc5632 *machine =3D
>>>> snd_soc_card_get_drvdata(rtd->card);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>>>> +}
>>>> +
>>>>  =C2=A0 static const struct snd_soc_ops tegra_alc5632_asoc_ops =3D {
>>>> +=C2=A0=C2=A0=C2=A0 .startup =3D tegra_alc5632_asoc_startup,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D tegra_alc5632_asoc_hw_p=
arams,
>>>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D tegra_alc5632_asoc_shutdown,
>>>>  =C2=A0 };
>>>>  =C2=A0 =C2=A0 static struct snd_soc_jack tegra_alc5632_hs_jack;
>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>> index 0d2271952555..2886ae9f5a16 100644
>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>> @@ -60,8 +60,6 @@ int tegra_asoc_utils_set_rate(struct
>>>> tegra_asoc_utils_data *data, int srate,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->set_mclk =3D 0;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk=
_cdev1);
>>>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a_out0);
>>>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a);
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_set_rate(data->clk_=
pll_a, new_baseclock);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>> @@ -77,18 +75,6 @@ int tegra_asoc_utils_set_rate(struct
>>>> tegra_asoc_utils_data *data, int srate,
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't set cdev1/extern1 rate=
; it's locked to pll_a_out0 */
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_pll_a=
);
>>>> -=C2=A0=C2=A0=C2=A0 if (err) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't =
enable pll_a: %d\n", err);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_pll_a_out0);
>>>> -=C2=A0=C2=A0=C2=A0 if (err) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't =
enable pll_a_out0: %d\n", err);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> -
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_c=
dev1);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->=
dev, "Can't enable cdev1: %d\n", err);
>>>> @@ -109,8 +95,6 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>>> tegra_asoc_utils_data *data)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk=
_cdev1);
>>>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a_out0);
>>>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a);
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * AC97 rate is fixed at 24.576MH=
z and is used for both the host
>>>> @@ -130,17 +114,27 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>>> tegra_asoc_utils_data *data)
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't set cdev1/extern1 rate=
; it's locked to pll_a_out0 */
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_pll_a=
);
>>>> +=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_cdev1);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't =
enable pll_a: %d\n", err);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't =
enable cdev1: %d\n", err);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_pll_a=
_out0);
>>>> -=C2=A0=C2=A0=C2=A0 if (err) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't =
enable pll_a_out0: %d\n", err);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 data->set_baseclock =3D pll_rate;
>>>> +=C2=A0=C2=A0=C2=A0 data->set_mclk =3D ac97_rate;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>>>> +
>>>> +void tegra_asoc_utils_clk_disable(struct tegra_asoc_utils_data *data)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_cdev1);
>>>> +}
>>>> +
>>>> +int tegra_asoc_utils_clk_enable(struct tegra_asoc_utils_data *data)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 int err;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data=
->clk_cdev1);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>> @@ -148,16 +142,13 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>>> tegra_asoc_utils_data *data)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 data->set_baseclock =3D pll_rate;
>>>> -=C2=A0=C2=A0=C2=A0 data->set_mclk =3D ac97_rate;
>>>> -
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>  =C2=A0 }
>>>> -EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>>>>  =C2=A0 =C2=A0 int tegra_asoc_utils_init(struct tegra_asoc_utils_data =
*data,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct device *dev)
>>>>  =C2=A0 {
>>>> +=C2=A0=C2=A0=C2=A0 struct clk *clk_out_1, *clk_extern1;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->dev =3D dev;
>>>> @@ -193,9 +184,42 @@ int tegra_asoc_utils_init(struct
>>>> tegra_asoc_utils_data *data,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR=
(data->clk_cdev1);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_set_rate(data, 44=
100, 256 * 44100);
>>>> -=C2=A0=C2=A0=C2=A0 if (ret)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If clock parents are not set in DT, config=
ure here to use
>>>> clk_out_1
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * as mclk and extern1 as parent for Tegra30 =
and higher.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 if (!of_find_property(dev->of_node, "assigned-cloc=
k-parents",
>>>> NULL) &&
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->soc > TEGRA_ASOC_UTI=
LS_SOC_TEGRA20) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev,
>>> As this is a fallback mechanism, use dev_info or dev_dbg instead?
> dev_warn
>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "C=
onfiguring clocks for a legacy device-tree\n");
> I'd also add another message here saying "Please update your DT", for
> clarity.
OK, Will add.
