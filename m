Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8302C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF47206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nKRf9iQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgAGQ4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:56:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2967 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgAGQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:56:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e14b8140000>; Tue, 07 Jan 2020 08:55:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 08:56:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 08:56:05 -0800
Received: from [10.2.175.47] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 16:56:04 +0000
Subject: Re: [PATCH v6 12/19] ASoC: tegra: Add audio mclk configuration
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578370458-3686-1-git-send-email-skomatineni@nvidia.com>
 <1578370458-3686-13-git-send-email-skomatineni@nvidia.com>
 <c23bf3f5-55d6-ab93-fd7b-13f9f2155dcc@nvidia.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <d85c8529-9970-c79c-9430-ed80c47eaf36@nvidia.com>
Date:   Tue, 7 Jan 2020 08:56:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c23bf3f5-55d6-ab93-fd7b-13f9f2155dcc@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578416148; bh=f8gaJE8YQx8dx2YZzVxFIAa3k9W+j2ySsF0e2ZvJ+ew=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=nKRf9iQ7ueBa8610dAWd9hrOBvj7wIUx9m/R2edDX/4jJ7wdmFQI6NccQHX5EFX0+
         DEG+1M2xvY+fKq53lb2PWROk+XbBAHVs4yLW4qiO8zKVSAbZOuaDhEakK9BfSkDe0K
         A0x+aJ9OKIhXPXaZk7UoR4EumDLV4n5h9DysKc+qwRzkXMDfm4U4pLb7Hd6IGFmDZN
         jzoTWZJtd4M9n2R7TfRWTrsItcUoH3oHhuV4AwMmn1zEFlgFHJVlyGTGm9ED4R4p6P
         sxYD4jOE307h8H/8fXd45UQywJvud35wLalVhdSXYiShPb9kEROq2ZU7KJrGF6L/U9
         HspAABJGRvYPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/20 3:14 AM, Sameer Pujar wrote:
>
> On 1/7/2020 9:44 AM, Sowjanya Komatineni wrote:
>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>> through Tegra210 and currently Tegra clock driver does the initial=20
>> parent
>> configuration for audio mclk and keeps it enabled by default.
>>
>> With the move of PMC clocks from clock driver into pmc driver,
>> audio clocks parent configuration can be specified through the device=20
>> tree
>> using assigned-clock-parents property and audio mclk control should be
>> taken care by the audio driver.
>>
>> This patch has implementation for parent configuration when default=20
>> parent
>> configuration is not specified in the device tree and controls audio=20
>> mclk
>> enable and disable during machine startup and shutdown.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>
> Minor comments, otherwise LGTM.
>
Thanks Sameer. Will fix.
>> ---
>> =C2=A0 sound/soc/tegra/tegra_alc5632.c=C2=A0=C2=A0=C2=A0 | 21 ++++++++++
>> =C2=A0 sound/soc/tegra/tegra_asoc_utils.c | 84=20
>> ++++++++++++++++++++++++--------------
>> =C2=A0 sound/soc/tegra/tegra_asoc_utils.h |=C2=A0 2 +
>> =C2=A0 sound/soc/tegra/tegra_max98090.c=C2=A0=C2=A0 | 21 ++++++++++
>> =C2=A0 sound/soc/tegra/tegra_rt5640.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++=
+++++
>> =C2=A0 sound/soc/tegra/tegra_rt5677.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++=
+++++
>> =C2=A0 sound/soc/tegra/tegra_sgtl5000.c=C2=A0=C2=A0 | 21 ++++++++++
>> =C2=A0 sound/soc/tegra/tegra_wm8753.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++=
+++++
>> =C2=A0 sound/soc/tegra/tegra_wm8903.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++=
+++++
>> =C2=A0 sound/soc/tegra/trimslice.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 21 ++++++++++
>> =C2=A0 10 files changed, 224 insertions(+), 30 deletions(-)
>>
>> diff --git a/sound/soc/tegra/tegra_alc5632.c=20
>> b/sound/soc/tegra/tegra_alc5632.c
>> index 50a6d2ff4442..0fd10023f7a6 100644
>> --- a/sound/soc/tegra/tegra_alc5632.c
>> +++ b/sound/soc/tegra/tegra_alc5632.c
>> @@ -62,8 +62,29 @@ static int tegra_alc5632_asoc_hw_params(struct=20
>> snd_pcm_substream *substream,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static int tegra_alc5632_asoc_startup(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_alc5632 *machine =3D=20
>> snd_soc_card_get_drvdata(rtd->card);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util_d=
ata);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static void tegra_alc5632_asoc_shutdown(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_alc5632 *machine =3D=20
>> snd_soc_card_get_drvdata(rtd->card);
>> +
>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>> +}
>> +
>> =C2=A0 static const struct snd_soc_ops tegra_alc5632_asoc_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .startup =3D tegra_alc5632_asoc_startup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D tegra_alc5632_asoc_hw_para=
ms,
>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D tegra_alc5632_asoc_shutdown,
>> =C2=A0 };
>> =C2=A0 =C2=A0 static struct snd_soc_jack tegra_alc5632_hs_jack;
>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c=20
>> b/sound/soc/tegra/tegra_asoc_utils.c
>> index 0d2271952555..2886ae9f5a16 100644
>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>> @@ -60,8 +60,6 @@ int tegra_asoc_utils_set_rate(struct=20
>> tegra_asoc_utils_data *data, int srate,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->set_mclk =3D 0;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_cd=
ev1);
>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a_out0);
>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_set_rate(data->clk_pll=
_a, new_baseclock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> @@ -77,18 +75,6 @@ int tegra_asoc_utils_set_rate(struct=20
>> tegra_asoc_utils_data *data, int srate,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't set cdev1/extern1 rate; i=
t's locked to pll_a_out0 */
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_pll_a);
>> -=C2=A0=C2=A0=C2=A0 if (err) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't en=
able pll_a: %d\n", err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_pll_a_out0);
>> -=C2=A0=C2=A0=C2=A0 if (err) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't en=
able pll_a_out0: %d\n", err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_cdev=
1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev=
, "Can't enable cdev1: %d\n", err);
>> @@ -109,8 +95,6 @@ int tegra_asoc_utils_set_ac97_rate(struct=20
>> tegra_asoc_utils_data *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_cd=
ev1);
>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a_out0);
>> -=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * AC97 rate is fixed at 24.576MHz a=
nd is used for both the host
>> @@ -130,17 +114,27 @@ int tegra_asoc_utils_set_ac97_rate(struct=20
>> tegra_asoc_utils_data *data)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't set cdev1/extern1 rate; i=
t's locked to pll_a_out0 */
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_pll_a);
>> +=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_cdev1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't en=
able pll_a: %d\n", err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't en=
able cdev1: %d\n", err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_pll_a_ou=
t0);
>> -=C2=A0=C2=A0=C2=A0 if (err) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Can't en=
able pll_a_out0: %d\n", err);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 data->set_baseclock =3D pll_rate;
>> +=C2=A0=C2=A0=C2=A0 data->set_mclk =3D ac97_rate;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>> +
>> +void tegra_asoc_utils_clk_disable(struct tegra_asoc_utils_data *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_cdev1);
>> +}
>> +
>> +int tegra_asoc_utils_clk_enable(struct tegra_asoc_utils_data *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int err;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->c=
lk_cdev1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>> @@ -148,16 +142,13 @@ int tegra_asoc_utils_set_ac97_rate(struct=20
>> tegra_asoc_utils_data *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 data->set_baseclock =3D pll_rate;
>> -=C2=A0=C2=A0=C2=A0 data->set_mclk =3D ac97_rate;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> -EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>> =C2=A0 =C2=A0 int tegra_asoc_utils_init(struct tegra_asoc_utils_data *da=
ta,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct device *dev)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 struct clk *clk_out_1, *clk_extern1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->dev =3D dev;
>> @@ -193,9 +184,42 @@ int tegra_asoc_utils_init(struct=20
>> tegra_asoc_utils_data *data,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(da=
ta->clk_cdev1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_set_rate(data, 44100=
, 256 * 44100);
>> -=C2=A0=C2=A0=C2=A0 if (ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If clock parents are not set in DT, configur=
e here to use=20
>> clk_out_1
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * as mclk and extern1 as parent for Tegra30 an=
d higher.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!of_find_property(dev->of_node, "assigned-clock-=
parents",=20
>> NULL) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->soc > TEGRA_ASOC_UTILS=
_SOC_TEGRA20) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev,
>
> As this is a fallback mechanism, use dev_info or dev_dbg instead?
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Con=
figuring clocks for a legacy device-tree\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_extern1 =3D devm_clk_get=
(dev, "extern1");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clk_extern1)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_=
err(data->dev, "Can't retrieve clk extern1\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn PTR_ERR(clk_extern1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clk_set_parent(clk_e=
xtern1, data->clk_pll_a_out0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_=
err(data->dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "Set parent failed for clk extern1\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_out_1 =3D devm_clk_get(d=
ev, "clk_out_1");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(clk_out_1)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_=
err(data->dev, "Can't retrieve clk clk_out_1\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn PTR_ERR(clk_out_1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clk_set_parent(clk_o=
ut_1, clk_extern1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_=
err(data->dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "Set parent failed for clk_out_1\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_cdev1 =3D clk_out_=
1;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> diff --git a/sound/soc/tegra/tegra_asoc_utils.h=20
>> b/sound/soc/tegra/tegra_asoc_utils.h
>> index a34439587d59..6db93009a317 100644
>> --- a/sound/soc/tegra/tegra_asoc_utils.h
>> +++ b/sound/soc/tegra/tegra_asoc_utils.h
>> @@ -34,5 +34,7 @@ int tegra_asoc_utils_set_rate(struct=20
>> tegra_asoc_utils_data *data, int srate,
>> =C2=A0 int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data=20
>> *data);
>> =C2=A0 int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct device *dev);
>> +int tegra_asoc_utils_clk_enable(struct tegra_asoc_utils_data *data);
>> +void tegra_asoc_utils_clk_disable(struct tegra_asoc_utils_data *data);
>> =C2=A0 =C2=A0 #endif
>> diff --git a/sound/soc/tegra/tegra_max98090.c=20
>> b/sound/soc/tegra/tegra_max98090.c
>> index f554a3d4571f..98d1ff49074b 100644
>> --- a/sound/soc/tegra/tegra_max98090.c
>> +++ b/sound/soc/tegra/tegra_max98090.c
>> @@ -82,8 +82,29 @@ static int tegra_max98090_asoc_hw_params(struct=20
>> snd_pcm_substream *substream,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static int tegra_max98090_asoc_startup(struct snd_pcm_substream=
=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_max98090 *machine =3D=20
>> snd_soc_card_get_drvdata(rtd->card);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util_d=
ata);
>
> "ret" can be removed.
> instead "return tegra_asoc_utils_clk_enable(&machine->util_data)"
>
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static void tegra_max98090_asoc_shutdown(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_max98090 *machine =3D=20
>> snd_soc_card_get_drvdata(rtd->card);
>> +
>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>> +}
>> +
>> =C2=A0 static const struct snd_soc_ops tegra_max98090_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .startup =3D tegra_max98090_asoc_startup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D tegra_max98090_asoc_hw_par=
ams,
>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D tegra_max98090_asoc_shutdown,
>> =C2=A0 };
>> =C2=A0 =C2=A0 static struct snd_soc_jack tegra_max98090_hp_jack;
>> diff --git a/sound/soc/tegra/tegra_rt5640.c=20
>> b/sound/soc/tegra/tegra_rt5640.c
>> index 5c695dfea009..8705b1a32a14 100644
>> --- a/sound/soc/tegra/tegra_rt5640.c
>> +++ b/sound/soc/tegra/tegra_rt5640.c
>> @@ -65,8 +65,29 @@ static int tegra_rt5640_asoc_hw_params(struct=20
>> snd_pcm_substream *substream,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static int tegra_rt5640_asoc_startup(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_rt5640 *machine =3D snd_soc_card_get_dr=
vdata(rtd->card);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util_d=
ata);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static void tegra_rt5640_asoc_shutdown(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_rt5640 *machine =3D snd_soc_card_get_dr=
vdata(rtd->card);
>> +
>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>> +}
>> +
>> =C2=A0 static const struct snd_soc_ops tegra_rt5640_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .startup =3D tegra_rt5640_asoc_startup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D tegra_rt5640_asoc_hw_param=
s,
>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D tegra_rt5640_asoc_shutdown,
>> =C2=A0 };
>> =C2=A0 =C2=A0 static struct snd_soc_jack tegra_rt5640_hp_jack;
>> diff --git a/sound/soc/tegra/tegra_rt5677.c=20
>> b/sound/soc/tegra/tegra_rt5677.c
>> index fb86f76728b3..a44b5ddc33ee 100644
>> --- a/sound/soc/tegra/tegra_rt5677.c
>> +++ b/sound/soc/tegra/tegra_rt5677.c
>> @@ -82,8 +82,29 @@ static int tegra_rt5677_event_hp(struct=20
>> snd_soc_dapm_widget *w,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static int tegra_rt5677_asoc_startup(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_rt5677 *machine =3D snd_soc_card_get_dr=
vdata(rtd->card);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util_d=
ata);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static void tegra_rt5677_asoc_shutdown(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_rt5677 *machine =3D snd_soc_card_get_dr=
vdata(rtd->card);
>> +
>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>> +}
>> +
>> =C2=A0 static const struct snd_soc_ops tegra_rt5677_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .startup =3D tegra_rt5677_asoc_startup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D tegra_rt5677_asoc_hw_param=
s,
>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D tegra_rt5677_asoc_shutdown,
>> =C2=A0 };
>> =C2=A0 =C2=A0 static struct snd_soc_jack tegra_rt5677_hp_jack;
>> diff --git a/sound/soc/tegra/tegra_sgtl5000.c=20
>> b/sound/soc/tegra/tegra_sgtl5000.c
>> index 586f56f435f4..f3317dd4a79f 100644
>> --- a/sound/soc/tegra/tegra_sgtl5000.c
>> +++ b/sound/soc/tegra/tegra_sgtl5000.c
>> @@ -71,8 +71,29 @@ static int tegra_sgtl5000_hw_params(struct=20
>> snd_pcm_substream *substream,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static int tegra_sgtl5000_startup(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_sgtl5000 *machine =3D=20
>> snd_soc_card_get_drvdata(rtd->card);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util_d=
ata);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static void tegra_sgtl5000_shutdown(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_sgtl5000 *machine =3D=20
>> snd_soc_card_get_drvdata(rtd->card);
>> +
>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>> +}
>> +
>> =C2=A0 static const struct snd_soc_ops tegra_sgtl5000_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .startup =3D tegra_sgtl5000_startup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D tegra_sgtl5000_hw_params,
>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D tegra_sgtl5000_shutdown,
>> =C2=A0 };
>> =C2=A0 =C2=A0 static const struct snd_soc_dapm_widget=20
>> tegra_sgtl5000_dapm_widgets[] =3D {
>> diff --git a/sound/soc/tegra/tegra_wm8753.c=20
>> b/sound/soc/tegra/tegra_wm8753.c
>> index f76cfdc963ed..f4a000ec7506 100644
>> --- a/sound/soc/tegra/tegra_wm8753.c
>> +++ b/sound/soc/tegra/tegra_wm8753.c
>> @@ -75,8 +75,29 @@ static int tegra_wm8753_hw_params(struct=20
>> snd_pcm_substream *substream,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static int tegra_wm8753_startup(struct snd_pcm_substream *substr=
eam)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_wm8753 *machine =3D snd_soc_card_get_dr=
vdata(rtd->card);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util_d=
ata);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static void tegra_wm8753_shutdown(struct snd_pcm_substream *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_wm8753 *machine =3D snd_soc_card_get_dr=
vdata(rtd->card);
>> +
>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>> +}
>> +
>> =C2=A0 static const struct snd_soc_ops tegra_wm8753_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .startup =3D tegra_wm8753_startup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D tegra_wm8753_hw_params,
>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D tegra_wm8753_shutdown,
>> =C2=A0 };
>> =C2=A0 =C2=A0 static const struct snd_soc_dapm_widget=20
>> tegra_wm8753_dapm_widgets[] =3D {
>> diff --git a/sound/soc/tegra/tegra_wm8903.c=20
>> b/sound/soc/tegra/tegra_wm8903.c
>> index f5f78c3512cd..7b5cd1653821 100644
>> --- a/sound/soc/tegra/tegra_wm8903.c
>> +++ b/sound/soc/tegra/tegra_wm8903.c
>> @@ -82,8 +82,29 @@ static int tegra_wm8903_hw_params(struct=20
>> snd_pcm_substream *substream,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static int tegra_wm8903_startup(struct snd_pcm_substream *substr=
eam)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_wm8903 *machine =3D snd_soc_card_get_dr=
vdata(rtd->card);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util_d=
ata);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static void tegra_wm8903_shutdown(struct snd_pcm_substream *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_wm8903 *machine =3D snd_soc_card_get_dr=
vdata(rtd->card);
>> +
>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>> +}
>> +
>> =C2=A0 static const struct snd_soc_ops tegra_wm8903_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .startup =3D tegra_wm8903_startup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D tegra_wm8903_hw_params,
>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D tegra_wm8903_shutdown,
>> =C2=A0 };
>> =C2=A0 =C2=A0 static struct snd_soc_jack tegra_wm8903_hp_jack;
>> diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
>> index e51c67092c8f..4b703734904f 100644
>> --- a/sound/soc/tegra/trimslice.c
>> +++ b/sound/soc/tegra/trimslice.c
>> @@ -60,8 +60,29 @@ static int trimslice_asoc_hw_params(struct=20
>> snd_pcm_substream *substream,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static int trimslice_asoc_startup(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_trimslice *machine =3D=20
>> snd_soc_card_get_drvdata(rtd->card);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D tegra_asoc_utils_clk_enable(&machine->util_d=
ata);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static void trimslice_asoc_shutdown(struct snd_pcm_substream=20
>> *substream)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct snd_soc_pcm_runtime *rtd =3D substream->priva=
te_data;
>> +=C2=A0=C2=A0=C2=A0 struct tegra_trimslice *machine =3D=20
>> snd_soc_card_get_drvdata(rtd->card);
>> +
>> +=C2=A0=C2=A0=C2=A0 tegra_asoc_utils_clk_disable(&machine->util_data);
>> +}
>> +
>> =C2=A0 static const struct snd_soc_ops trimslice_asoc_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .startup =3D trimslice_asoc_startup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .hw_params =3D trimslice_asoc_hw_params,
>> +=C2=A0=C2=A0=C2=A0 .shutdown =3D trimslice_asoc_shutdown,
>> =C2=A0 };
>> =C2=A0 =C2=A0 static const struct snd_soc_dapm_widget trimslice_dapm_wid=
gets[] =3D {
