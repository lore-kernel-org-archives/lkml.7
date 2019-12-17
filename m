Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECBBC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A905C21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ALQZHoMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfLQQMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:12:30 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2212 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:12:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df8fe620000>; Tue, 17 Dec 2019 08:12:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 08:12:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 08:12:27 -0800
Received: from [10.2.174.101] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 16:12:25 +0000
Subject: Re: [PATCH v3 08/15] ASoC: tegra: Add audio mclk control through
 clk_out_1 and extern1
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>, <sboyd@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
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
 <41a7325c-9bb9-f681-4d30-d19079869d12@nvidia.com>
 <d8f158cd-3bf5-383a-c9fe-650f6d7ac178@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <fc491006-a316-5910-acb1-659c768b1038@nvidia.com>
Date:   Tue, 17 Dec 2019 08:12:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d8f158cd-3bf5-383a-c9fe-650f6d7ac178@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576599138; bh=VCBJHFGrESwMvceXLEg/yGkPHDui4WH+x57bSPKO0OU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=ALQZHoMNqt6P2jItSTO880oyBSwr44YswKWOiGUcwtEVQ9SYK8xhpaq7Uer9zLiI3
         xrLCSOpRqjww7IZjRI8bOmpK9f+/HDhdKF7raWQWbC4rC28JCSpq53vBD4odu21Gwx
         qswdFy7DLCIIZKfCxJSbPJFS/MP2cOjjOcETPYTiTKxQLbyhkWNRouJht5JGsB3dvy
         W833iVwfM6p2Wd8DjBCHVtte6fe9GSX42J9K06kemX3OmMVZYERAn9swT1gyQ1QD7q
         IQs7fn/SEy2Qmf3xhUz72bRQSkT3jrJY5vp7k9/9l77cw2ajxdKgjgsgWRVqdNsBLD
         5Dw2rG1FmeXxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/17/19 7:36 AM, Dmitry Osipenko wrote:
> 17.12.2019 04:29, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 12/7/19 11:20 AM, Sowjanya Komatineni wrote:
>>> On 12/7/19 6:58 AM, Dmitry Osipenko wrote:
>>>> 06.12.2019 05:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> Current ASoC driver uses extern1 as cdev1 clock from Tegra30 onwards
>>>>> through device tree.
>>>>>
>>>>> Actual audio mclk is clk_out_1 and to use PLLA for mclk rate control,
>>>>> need to clk_out_1_mux parent to extern1 and extern1 parent to
>>>>> PLLA_OUT0.
>>>>>
>>>>> Currently Tegra clock driver init sets the parents and enables both
>>>>> clk_out_1 and extern1 clocks. But these clocks parent and enables
>>>>> should
>>>>> be controlled by ASoC driver.
>>>>>
>>>>> Clock parents can be specified in device tree using assigned-clocks
>>>>> and assigned-clock-parents.
>>>>>
>>>>> To enable audio mclk, both clk_out_1 and extern1 clocks need to be
>>>>> enabled.
>>>>>
>>>>> This patch configures parents for clk_out_1 and extern1 clocks if
>>>>> device
>>>>> tree does not specify clock parents inorder to support old device tre=
e
>>>>> and controls mclk using both clk_out_1 and extern1 clocks.
>>>>>
>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>> ---
>>>>>  =C2=A0 sound/soc/tegra/tegra_asoc_utils.c | 66
>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>  =C2=A0 sound/soc/tegra/tegra_asoc_utils.h |=C2=A0 1 +
>>>>>  =C2=A0 2 files changed, 67 insertions(+)
>>>>>
>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>> index 536a578e9512..8e3a3740df7c 100644
>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>> @@ -60,6 +60,7 @@ int tegra_asoc_utils_set_rate(struct
>>>>> tegra_asoc_utils_data *data, int srate,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->set_mclk =3D 0;
>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->cl=
k_cdev1);
>>>>> +=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_extern1);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a=
_out0);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a=
);
>>>>>  =C2=A0 @@ -89,6 +90,14 @@ int tegra_asoc_utils_set_rate(struct
>>>>> tegra_asoc_utils_data *data, int srate,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 if (!IS_ERR_OR_NULL(data->clk_extern1)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enabl=
e(data->clk_extern1);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
ev_err(data->dev, "Can't enable extern1: %d\n", err);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn err;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_=
cdev1);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data-=
>dev, "Can't enable cdev1: %d\n", err);
>>>>> @@ -109,6 +118,7 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>>>> tegra_asoc_utils_data *data)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->cl=
k_cdev1);
>>>>> +=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_extern1);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a=
_out0);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_disable_unprepare(data->clk_pll_a=
);
>>>>>  =C2=A0 @@ -142,6 +152,14 @@ int tegra_asoc_utils_set_ac97_rate(struc=
t
>>>>> tegra_asoc_utils_data *data)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 if (!IS_ERR_OR_NULL(data->clk_extern1)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enabl=
e(data->clk_extern1);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
ev_err(data->dev, "Can't enable extern1: %d\n", err);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn err;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> Why this is needed given that clk_extern1 is either a child of MCLK or
>>>> MCLK itself (on T20)? The child clocks are enabled when the parent is
>>>> enabled.
>>> For T30 and later, clk_extern1 is one of the source for clk_out_1_mux.
>>> clk_extern1 is in CAR and it has its own gate and mux.
>>>
>>> As audio mclk related clocks (clk_out_1, clk_out_1_mux, and extern1)
>>> are moved into ASoC driver from clock driver
>>>
>>> need to enable extern1 gate as well along with clk_out1 for T30
>>> through T210.
>>>
>>> Just FYI, extern1 enable here happens only when data->clk_extern1 is
>>> available which is for T30 onwards.
>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D clk_prepare_enable(data->clk_=
cdev1);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data-=
>dev, "Can't enable cdev1: %d\n", err);
>>>>> @@ -158,6 +176,7 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate)=
;
>>>>>  =C2=A0 int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev)
>>>>>  =C2=A0 {
>>>>> +=C2=A0=C2=A0=C2=A0 struct clk *clk_out_1_mux;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->dev =3D dev;
>>>>> @@ -196,6 +215,51 @@ int tegra_asoc_utils_init(struct
>>>>> tegra_asoc_utils_data *data,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_put_=
pll_a_out0;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> In a previous patch you added fallback to EXTPERIPH when clk_get(MCLK)
>>>> fails. This will work perfectly fine for the older kernels which have
>>>> all clocks in the same single CaR driver, but this may not work that
>>>> great for the newer kernels because PMC driver isn't registered early
>>>> during boot and thus it is possible to get a legit -EPROBE_DEFER which
>>>> shouldn't be ignored. In other words, you need to add into this patch =
a
>>>> check for the error code returned by clk_get(MCLK) and fallback only f=
or
>>>> -EINVAL.
>>> yeah right, will add check in next version.
>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If clock parents are not set in DT, confi=
gure here to use
>>>>> clk_out_1
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * as mclk and extern1 as parent for Tegra30=
 and higher.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0 if (!of_find_property(dev->of_node, "assigned-clo=
ck-parents",
>>>>> NULL) &&
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->soc > TEGRA_ASOC_UT=
ILS_SOC_TEGRA20) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_extern1 =3D clk=
_get_sys("clk_out_1", "extern1");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(data->clk_exte=
rn1)) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
ev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D PTR_ERR(data->clk_extern1);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto err_put_cdev1;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clk_set_parent(da=
ta->clk_extern1, data->clk_pll_a_out0);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
ev_err(data->dev,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "Set parent failed for clk extern1: %d\n",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto err_put_cdev1;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk_out_1_mux =3D clk_get=
_sys(NULL, "clk_out_1_mux");
>>>> Note1: clk_get(dev, "clk_out_1_mux") should work here by letting clk
>>>> core to fall back to the clk_get_sys() by itself. Either way should
>>>> be good.
>> clk_get uses device rather and dev_id will be name of this device and
>> when clk_get fall back to __clk_get_sys() it still will use dev id of
>> this device rather than actual dev_id that pmc clocks are added to the
>> lookup. So clk_get_sys() seems to be correct to use as we can specify
>> exact dev_id and con_id.
> It should be better to use something "resource managed", thus
> devm_clk_get() should be a better choice.
>
>> Also, clk_find retrieves clock from lookup only when it finds matching
>> clock with both dev_id and con_id as pmc clocks are registered with both
>> dev_id and con_id.
>>
>> I see existing clock driver adds both extern and pmc clocks (clk_out) to
>> lookup with same dev_id of clk_out_1/2/3 and con_id of extern1/2/3 and
>> with this always extern clock will be retrieved and this is probably
>> because old DT and audio driver always uses extern1 rather than actual
>> clk_out_1
>>
>> But this need to be fixed now as we changed to use clk_out directly
>> rather than extern (even for other pmc clocks) to match actual hw design=
.
>>
>> Will fix this as well to register pmc clocks using con_id as
>> clk_out_1/2/3 in pmc driver and extern clocks using con_id of
>> extern1/2/3 with dev_id being NULL so we can retrieve these clocks by
>> just using con_id only using clk_get_sys as we switched to use clk_out_1
>> directly as pmc clock rather than extern from DT and no longer need to
>> pair pmc clocks to extern clocks.
> I'm not sure it's worth the effort to care about con_ids if implicit
> fallback to clk_get_sys(NULL, "...") does the right thing for the audio
> driver.
>
> IIRC, CCF uses variant of matching clocks by names, although I'm not
> sure whether that applies to older stable kernels.
>
> [snip]

Current clock driver adds EXTERN clock to lookup with dev_id as=20
clk_out_1/2/3 and con_id as extern_1/2/3

With this we can retrieve clock from lookup only with clk_get_sys where=20
we can pass dev_id as clk_out_1/2/3 and con_id as extern_1/2/3.

We cant use devm_clk_get() or clk_get() for retrieving clocks from=20
lookup by passing device object from sound driver as dev_id will be diff=20
and clk_find will return NULL.


But with the fix of having dev_id as NULL and use only con_id to add to=20
lookup, we can use resource managed APIs devm_clk_get.

So was saying will fix this in clock driver as part of removing=20
clk_out_1/2/3 ids and pmc init from clock driver so we can use=20
devm_clk_get API in audio driver.

>
