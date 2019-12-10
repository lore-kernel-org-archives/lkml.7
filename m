Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3089C2BD09
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E702073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XXH6hTtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfLJAyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:54:36 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16186 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfLJAyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:54:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5deeecb60000>; Mon, 09 Dec 2019 16:54:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 09 Dec 2019 16:54:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 09 Dec 2019 16:54:34 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 00:54:34 +0000
Received: from [10.2.174.71] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 00:54:32 +0000
Subject: Re: [PATCH v3 08/15] ASoC: tegra: Add audio mclk control through
 clk_out_1 and extern1
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <tglx@linutronix.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-9-git-send-email-skomatineni@nvidia.com>
 <0ce2e83b-800c-da1e-7a3c-3cf1427cfe20@gmail.com>
 <2eeceabe-b5f0-6f9e-ff8c-4ac6167b7cc3@nvidia.com>
 <5d26e32c-a346-4d42-9872-840964512144@gmail.com>
 <79661e2f-dcd4-6dd5-9b4d-9dcc40de478a@nvidia.com>
 <664a0b15-7136-2a11-f0a0-06f32cca1a9c@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <d984ca35-2c8f-d28c-e3c8-688f76ecd98f@nvidia.com>
Date:   Mon, 9 Dec 2019 16:54:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <664a0b15-7136-2a11-f0a0-06f32cca1a9c@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575939254; bh=oDpjvhPKdKxOplyhkA/Vfi4vK8JfrUiRbAih49q1Mfs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=XXH6hTtnAn/LTfi8HDcMWBLKXf7wQZ8g4Jd0G2RFr5XlQ4/e9PjS+vRf7+eEliPRc
         qHVjDkvIMROEDusdyotvvJVYpuQzMsXNBKW0cQ64dsYkUUAXOqmRPlBREQ/Zlh1CqD
         B5zp50Z0ru9e7dsc8/5Y6lNtJfYovm980v0EeldVnao/o23euDd3uXtLH/ANKMHxMk
         cpxwmYQ+64ZKXtZXXf+WPSX/NQDdB0S3fexhbfdH4ku92wEyOOQJMfxVsjiMYfXx6G
         nbcWaO27zdlPinIjs0FVkpgR1Hndq8h3wkOwmj908Cz/UEC74zYWXV7Dt+kadzOQZu
         F3CCjYSv0fehA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/9/19 3:12 PM, Dmitry Osipenko wrote:
> 10.12.2019 02:05, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 12/9/19 12:06 PM, Dmitry Osipenko wrote:
>>> 07.12.2019 22:20, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 12/7/19 6:58 AM, Dmitry Osipenko wrote:
>>>>> 06.12.2019 05:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>> Current ASoC driver uses extern1 as cdev1 clock from Tegra30 onwards
>>>>>> through device tree.
>>>>>>
>>>>>> Actual audio mclk is clk_out_1 and to use PLLA for mclk rate control=
,
>>>>>> need to clk_out_1_mux parent to extern1 and extern1 parent to
>>>>>> PLLA_OUT0.
>>>>>>
>>>>>> Currently Tegra clock driver init sets the parents and enables both
>>>>>> clk_out_1 and extern1 clocks. But these clocks parent and enables
>>>>>> should
>>>>>> be controlled by ASoC driver.
>>>>>>
>>>>>> Clock parents can be specified in device tree using assigned-clocks
>>>>>> and assigned-clock-parents.
>>>>>>
>>>>>> To enable audio mclk, both clk_out_1 and extern1 clocks need to be
>>>>>> enabled.
>>>>>>
>>>>>> This patch configures parents for clk_out_1 and extern1 clocks if
>>>>>> device
>>>>>> tree does not specify clock parents inorder to support old device tr=
ee
>>>>>> and controls mclk using both clk_out_1 and extern1 clocks.
>>>>>>
>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>> ---
>>>>>>  =C2=A0=C2=A0 sound/soc/tegra/tegra_asoc_utils.c | 66
>>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>>  =C2=A0=C2=A0 sound/soc/tegra/tegra_asoc_utils.h |=C2=A0 1 +
>>>>>>  =C2=A0=C2=A0 2 files changed, 67 insertions(+)
>>>>>>
>>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>> index 536a578e9512..8e3a3740df7c 100644
>>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>> @@ -60,6 +60,7 @@ int tegra_asoc_utils_set_rate(struct
>>>>>> tegra_asoc_utils_data *data, int srate,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->set_mclk =3D 0;
>>>>>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(d=
ata->clk_cdev1);
>>>>>> +=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_extern1);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->cl=
k_pll_a_out0);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->cl=
k_pll_a);
>>>>>>  =C2=A0=C2=A0 @@ -89,6 +90,14 @@ int tegra_asoc_utils_set_rate(struc=
t
>>>>>> tegra_asoc_utils_data *data, int srate,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 err;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>  =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 if (!IS_ERR_OR_NULL(data->clk_exte=
rn1)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enab=
le(data->clk_extern1);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
dev_err(data->dev, "Can't enable extern1: %d\n", err);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return err;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>> +
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(dat=
a->clk_cdev1);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_er=
r(data->dev, "Can't enable cdev1: %d\n", err);
>>>>>> @@ -109,6 +118,7 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>>>>> tegra_asoc_utils_data *data)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>>>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(d=
ata->clk_cdev1);
>>>>>> +=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_extern1);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->cl=
k_pll_a_out0);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->cl=
k_pll_a);
>>>>>>  =C2=A0=C2=A0 @@ -142,6 +152,14 @@ int tegra_asoc_utils_set_ac97_rat=
e(struct
>>>>>> tegra_asoc_utils_data *data)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 err;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>  =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 if (!IS_ERR_OR_NULL(data->clk_exte=
rn1)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enab=
le(data->clk_extern1);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
dev_err(data->dev, "Can't enable extern1: %d\n", err);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return err;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> Why this is needed given that clk_extern1 is either a child of MCLK o=
r
>>>>> MCLK itself (on T20)? The child clocks are enabled when the parent is
>>>>> enabled.
>>>> For T30 and later, clk_extern1 is one of the source for clk_out_1_mux.
>>>> clk_extern1 is in CAR and it has its own gate and mux.
>>>>
>>>> As audio mclk related clocks (clk_out_1, clk_out_1_mux, and extern1) a=
re
>>>> moved into ASoC driver from clock driver
>>>>
>>>> need to enable extern1 gate as well along with clk_out1 for T30 throug=
h
>>>> T210.
>>>>
>>>> Just FYI, extern1 enable here happens only when data->clk_extern1 is
>>>> available which is for T30 onwards.
>>> clk_out_1 is the parent of extern1, thus extern1 is enabled by the clk
>>> core whenever clk_out_1 is enabled because data->clk_cdev1=3Dclk_out_1.=
 An
>>> I missing something?
>>>
>>> [snip]
>> extern1 is the parent for clk_out_1. explained extern1 clock path to
>> clk_out in reply to your comment in other patch of this series.
> Right, I meant extern1 the parent of clk_out_1, sorry for the confusion.
> So when clk_out_1 (child) is enabled, extern1 (parent) is enabled as well=
.
>
> I'll take a closer look at the other email tomorrow.
yes, will remove explicitly enabling extern1 in next version.
