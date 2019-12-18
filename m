Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C712C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B3D218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kkKtfiO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLRQcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:32:12 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5899 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfLRQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:32:12 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfa54800000>; Wed, 18 Dec 2019 08:32:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 08:32:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 18 Dec 2019 08:32:10 -0800
Received: from [10.2.164.84] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 16:32:08 +0000
Subject: Re: [PATCH v4 13/19] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-14-git-send-email-skomatineni@nvidia.com>
 <e2f96102-33fa-cbe5-f488-666b7b7ffb06@gmail.com>
 <7e49fef8-112c-1694-9316-7a23db8a01a4@gmail.com>
 <66a28f8a-82e8-5b12-464c-4c91441d1511@nvidia.com>
 <fb36edbf-08c9-aa7e-a7fd-6ee15261a525@gmail.com>
 <de4d2693-3d5c-d154-22eb-2e41ddc12974@gmail.com>
 <1499a012-f5e1-3c76-6750-5858765a0532@nvidia.com>
 <13074e67-2807-d494-b8b4-b2e3b529117a@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <c4e20767-2263-7a29-f50c-d36876ad58e2@nvidia.com>
Date:   Wed, 18 Dec 2019 08:32:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <13074e67-2807-d494-b8b4-b2e3b529117a@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576686720; bh=ojN0J52Mms4YB1Oz2k3/gp5yRH+VnUIaavZron+331I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=kkKtfiO+8RRjqHZVhoXUcMQnEj9KfRhy+oidwvkomvy44zzCl/WnQk9AzmxDYgb6T
         bBviXRTD1vqex6xibC2eCRVogjXlhzLz/iTQTP9AtcNatvUAhD/w/Q68LecvaBLgG9
         Vtd85m/lbwDSo2fZXYvgqbqkgaCyQblI46DB0o+4q9x+FmqH5ASHo6i62n4MBhhf34
         wuHAmFX8K2fGX7EPR6K53ETV4kn0b+X4fNN5FCNq0SAyXt84tDlegG7fPUM59GTQFL
         +L7pZaAiWa329ox9ZuhHdotL+G0rbzNrE7y0S/4A/fKcM8y4ENwOjsJcjShyYpwcQl
         tvUa8i5uiCZSA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/19 8:29 AM, Dmitry Osipenko wrote:
> 18.12.2019 18:43, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 12/17/19 11:31 PM, Dmitry Osipenko wrote:
>>> 18.12.2019 10:22, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> 18.12.2019 10:14, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> On 12/17/19 11:01 PM, Dmitry Osipenko wrote:
>>>>>> 18.12.2019 09:59, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>> 17.12.2019 23:04, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
>>>>>>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc
>>>>>>>> clocks
>>>>>>>> are moved to Tegra PMC driver with pmc as clock provider and
>>>>>>>> using pmc
>>>>>>>> clock ids.
>>>>>>>>
>>>>>>>> New device tree uses clk_out_1 from pmc clock provider.
>>>>>>>>
>>>>>>>> So, this patch adds implementation for mclk fallback to extern1 wh=
en
>>>>>>>> retrieving mclk returns -ENOENT to be backward compatible of new
>>>>>>>> device
>>>>>>>> tree with older kernels.
>>>>>>>>
>>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>>> ---
>>>>>>>>  =C2=A0=C2=A0 sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>>>>>>>  =C2=A0=C2=A0 1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>> index fe9ca8acd0fb..1b88c6043082 100644
>>>>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>> @@ -191,7 +191,16 @@ int tegra_asoc_utils_init(struct
>>>>>>>> tegra_asoc_utils_data *data,
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_cdev1 =3D devm_clk=
_get(dev, "mclk");
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(data->clk_cdev1))=
 {
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_=
err(data->dev, "Can't retrieve clk cdev1\n");
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(data->c=
lk_cdev1);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PTR_ERR(data->clk_=
cdev1) !=3D -ENOENT)
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return PTR_ERR(data->clk_cdev1);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Fall back to extern=
1 */
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->clk_cdev1 =3D de=
vm_clk_get(dev, "extern1");
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(data->clk_c=
dev1)) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return PTR_ERR(data->clk_cdev1);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(data->dev, "Fa=
lling back to extern1\n");
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.769091] ------------[ cut here ]------------
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.769249] WARNING: CPU: 2 PID: 1 at drivers/clk=
/clk.c:954
>>>>>>> clk_core_disable+0xa5/0x1d4
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.769330] clk_out_1 already disabled
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.769459] Modules linked in:
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.769541] CPU: 2 PID: 1 Comm: swapper/0 Not tai=
nted
>>>>>>> 5.5.0-rc1-next-20191213-00167-g6b9fbcdac8f3-dirty #266
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.769676] Hardware name: NVIDIA Tegra SoC (Flat=
tened Device
>>>>>>> Tree)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.769775] [<c010e4bd>] (unwind_backtrace) from =
[<c010a0fd>]
>>>>>>> (show_stack+0x11/0x14)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.769918] [<c010a0fd>] (show_stack) from [<c09a=
37b1>]
>>>>>>> (dump_stack+0x85/0x94)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.770061] [<c09a37b1>] (dump_stack) from [<c011=
f3d1>]
>>>>>>> (__warn+0xc1/0xc4)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.770144] [<c011f3d1>] (__warn) from [<c011f691=
>]
>>>>>>> (warn_slowpath_fmt+0x61/0x78)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.770285] [<c011f691>] (warn_slowpath_fmt) from=
 [<c04a0e7d>]
>>>>>>> (clk_core_disable+0xa5/0x1d4)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.770427] [<c04a0e7d>] (clk_core_disable) from =
[<c04a0fc3>]
>>>>>>> (clk_core_disable_lock+0x17/0x20)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.770516] [<c04a0fc3>] (clk_core_disable_lock) =
from [<c07792bb>]
>>>>>>> (tegra_asoc_utils_set_rate+0x53/0x208)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.770662] [<c07792bb>] (tegra_asoc_utils_set_ra=
te) from
>>>>>>> [<c077b8c5>] (tegra_rt5640_probe+0xd5/0x128)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.770808] [<c077b8c5>] (tegra_rt5640_probe) fro=
m [<c0555eb7>]
>>>>>>> (platform_drv_probe+0x33/0x68)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.770958] [<c0555eb7>] (platform_drv_probe) fro=
m [<c055471d>]
>>>>>>> (really_probe+0x14d/0x240)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.771099] [<c055471d>] (really_probe) from [<c0=
55493f>]
>>>>>>> (driver_probe_device+0x43/0x11c)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.771187] [<c055493f>] (driver_probe_device) fr=
om [<c0554b25>]
>>>>>>> (device_driver_attach+0x3d/0x40)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.771328] [<c0554b25>] (device_driver_attach) f=
rom [<c0554b5f>]
>>>>>>> (__driver_attach+0x37/0x78)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.771469] [<c0554b5f>] (__driver_attach) from [=
<c05532fb>]
>>>>>>> (bus_for_each_dev+0x43/0x6c)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.771609] [<c05532fb>] (bus_for_each_dev) from =
[<c0553e0f>]
>>>>>>> (bus_add_driver+0xe3/0x148)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.771692] [<c0553e0f>] (bus_add_driver) from [<=
c055531d>]
>>>>>>> (driver_register+0x39/0xa0)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.771833] [<c055531d>] (driver_register) from [=
<c0102c2f>]
>>>>>>> (do_one_initcall+0x43/0x1bc)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.771979] [<c0102c2f>] (do_one_initcall) from [=
<c1000ce5>]
>>>>>>> (kernel_init_freeable+0x121/0x194)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.772129] [<c1000ce5>] (kernel_init_freeable) f=
rom [<c09b40e9>]
>>>>>>> (kernel_init+0xd/0xd0)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.772215] [<c09b40e9>] (kernel_init) from [<c01=
010bd>]
>>>>>>> (ret_from_fork+0x11/0x34)
>>>>>>> [=C2=A0=C2=A0=C2=A0 1.772349] Exception stack(0xde907fb0 to 0xde907=
ff8)
>>>>>>>
>>>>>> Although, that's probably related to the "ASoC: tegra: Add initial
>>>>>> parent configuration for audio mclk".
>>>>>>
>>>>> Actually I see these warnings of already unprepared and already
>>>>> disabled
>>>>> for pll_a, pll_a_out0, and clk_out_1 even without this whole patch
>>>>> series as well.
>>>>>
>>>>> I think its from tegra_asoc_utils_set_rate() doing
>>>>> clk_disable_unprepare
>>>>> and these clocks are already unprepared and disabled so its just
>>>>> warning
>>>>> from clk_core_unprepare and clk_core_disable.
>>>> Doesn't happen for me without this series.
>> I looked at wrong log, right earlier clock driver keeps them enabled so
>> asoc_utils_set_rate() disables the clock fine but now enabling audio
>> clock should be done in asoc_utils_init() to let the
>> clk_disable_unprepare from asoc_utils_set_rate not to show this warning.
>>
>> But actually we don't need to have clock enabled in asoc_utils_init
>> prior to invoking asoc_utils_set_rate from utils_init and its just warns
>> during sound driver probe because clock is already in disabled state. At
>> same time it doesn't harm to have it kept enabled in utils_init. So will
>> keep it enabled in asoc_utils_init to prevent this warning to show up.
>>
>>> But sound works with both old/new device-trees.
> The rule of thumb: don't enable anything when it shouldn't be enabled.
> If clocks are disabled at the time of drivers probe, then drivers
> shouldn't disable the clocks.
Will fix asoc_utils_set_rate to disable only when its enabled.
