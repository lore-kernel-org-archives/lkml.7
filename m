Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06578C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B916D208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 21:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AzMye6NQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfL0VZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:25:28 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7134 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfL0VZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 16:25:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0676b90001>; Fri, 27 Dec 2019 13:25:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 27 Dec 2019 13:25:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 27 Dec 2019 13:25:26 -0800
Received: from [10.2.173.37] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Dec
 2019 21:25:25 +0000
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
 <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
 <1b79ab92-c163-3857-dd38-df35c509b823@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <4fd01e04-8240-8562-467d-324f7adbdbdf@nvidia.com>
Date:   Fri, 27 Dec 2019 13:25:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1b79ab92-c163-3857-dd38-df35c509b823@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577481914; bh=NhLysUMDR5A8pJ/qWwjX71WWrzvkEcKkywTqxVpwI/M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=AzMye6NQ2mWSVw3lnFblMI2o1tRqdDsGzIQXAbl+KbAbqFfj4spzqLF3+ETqh1SYI
         2in6f1xBxlvgk1GKSu6t4Cpe5Eha6HRHcXU1lYvg+x2xr++OpprB883qu//xaWhxZa
         9ziERtL6eXznaJhgA+sd8jZDwbY+39G2/oc1pPSQgbJLMzX7k0TH3p8VxHOml5/kfI
         KMaoTtd7XpGSHXNpIOwg/fGaQNmfDhVVzu2hhdCp20WSz2zaZYMdXRSjVD/pFt3560
         kxl/5mniINbFNPO1U8uG8wDfyyiAYAuw6Y/6qmRP2gYHrwVVVSoAm2EtLuKahkRF5i
         YH/5JxDyQ110A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/22/19 1:18 PM, Dmitry Osipenko wrote:
> 23.12.2019 00:14, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 21.12.2019 01:26, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>>> through Tegra210 and currently Tegra clock driver does initial parent
>>> configuration for audio mclk "clk_out_1" and enables them by default.
>>>
>>> With the move of Tera PMC clocks from clock driver to Tegra PMC
>>> driver, initial parent configuration for audio clocks are through
>>> the device tree using assigned-clock-parents property.
>>>
>>> Default clock parents can be specified in device tree using
>>> assigned-clocks and assigned-clock-parents and there is no need
>>> to have clock driver do parent configuration and enable audio related
>>> clocks.
>>>
>>> This patch has implementation for initial parent configuration in
>>> audio driver when default parent configuration is not specified in the
>>> device tree using assigned-clock properties and enables audio clocks
>>> during the clock rate change.
>>>
>>> This patch configures PLLA_OUT0 as parent to extern1 and extern1
>>> as parent to clk_out_1 and uses clk_out_1 as cdev1 clock to allow
>>> mclk control from this driver.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   sound/soc/tegra/tegra_asoc_utils.c | 71 ++++++++++++++++++++++-------=
---------
>>>   1 file changed, 41 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra=
_asoc_utils.c
>>> index 38535962029c..fc3135c08f43 100644
>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>> @@ -7,6 +7,7 @@
>>>    */
>>>  =20
>>>   #include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>> This is illegal, it is not a clock provider.
>>
__clk_is_enabled API is used in this patch to disable clock only when=20
its enabled.

__clk_is_enabled API is from clk-provider.h

>>>   #include <linux/device.h>
>>>   #include <linux/err.h>
>>>   #include <linux/kernel.h>
>>> @@ -59,9 +60,8 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils=
_data *data, int srate,
>>>   	data->set_baseclock =3D 0;
>>>   	data->set_mclk =3D 0;
>>>  =20
>>> -	clk_disable_unprepare(data->clk_cdev1);
>>> -	clk_disable_unprepare(data->clk_pll_a_out0);
>>> -	clk_disable_unprepare(data->clk_pll_a);
>>> +	if (__clk_is_enabled(data->clk_cdev1))
>>> +		clk_disable_unprepare(data->clk_cdev1);
>> The root of the problem is that you removed clocks enabling from
>> tegra_asoc_utils_init().
>>
>> I'm not sure why clocks should be disabled during the rate-changing,
>> probably this action is not really needed.
>>
>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>> b/sound/soc/tegra/tegra_asoc_utils.c
>> index 46ff70c16b74..789fd03e51a7 100644
>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>> @@ -7,7 +7,6 @@
>>    */
>>
>>   #include <linux/clk.h>
>> -#include <linux/clk-provider.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>>   #include <linux/kernel.h>
>> @@ -60,9 +59,6 @@ int tegra_asoc_utils_set_rate(struct
>> tegra_asoc_utils_data *data, int srate,
>>   	data->set_baseclock =3D 0;
>>   	data->set_mclk =3D 0;
>>
>> -	if (__clk_is_enabled(data->clk_cdev1))
>> -		clk_disable_unprepare(data->clk_cdev1);
>> -
>>   	err =3D clk_set_rate(data->clk_pll_a, new_baseclock);
>>   	if (err) {
>>   		dev_err(data->dev, "Can't set pll_a rate: %d\n", err);
>> @@ -77,12 +73,6 @@ int tegra_asoc_utils_set_rate(struct
>> tegra_asoc_utils_data *data, int srate,
>>
>>   	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>>
>> -	err =3D clk_prepare_enable(data->clk_cdev1);
>> -	if (err) {
>> -		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>> -		return err;
>> -	}
>> -
>>   	data->set_baseclock =3D new_baseclock;
>>   	data->set_mclk =3D mclk;
>>
>> @@ -96,9 +86,6 @@ int tegra_asoc_utils_set_ac97_rate(struct
>> tegra_asoc_utils_data *data)
>>   	const int ac97_rate =3D 24576000;
>>   	int err;
>>
>> -	if (__clk_is_enabled(data->clk_cdev1))
>> -		clk_disable_unprepare(data->clk_cdev1);
>> -
>>   	/*
>>   	 * AC97 rate is fixed at 24.576MHz and is used for both the host
>>   	 * controller and the external codec
>> @@ -117,12 +104,6 @@ int tegra_asoc_utils_set_ac97_rate(struct
>> tegra_asoc_utils_data *data)
>>
>>   	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>>
>> -	err =3D clk_prepare_enable(data->clk_cdev1);
>> -	if (err) {
>> -		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>> -		return err;
>> -	}
>> -
>>   	data->set_baseclock =3D pll_rate;
>>   	data->set_mclk =3D ac97_rate;
>>
>> @@ -213,6 +194,12 @@ int tegra_asoc_utils_init(struct
>> tegra_asoc_utils_data *data,
>>   		data->clk_cdev1 =3D clk_out_1;
>>   	}
>>
>> +	ret =3D clk_prepare_enable(data->clk_cdev1);
>> +	if (ret) {
>> +		dev_err(data->dev, "Can't enable cdev1: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>   	ret =3D tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
>>
>>   	return ret;
>>
>>
>>>   	err =3D clk_set_rate(data->clk_pll_a, new_baseclock);
>>>   	if (err) {
>>> @@ -77,18 +77,6 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_util=
s_data *data, int srate,
>>>  =20
>>>   	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>>>  =20
>>> -	err =3D clk_prepare_enable(data->clk_pll_a);
>>> -	if (err) {
>>> -		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
>>> -		return err;
>>> -	}
>>> -
>>> -	err =3D clk_prepare_enable(data->clk_pll_a_out0);
>>> -	if (err) {
>>> -		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
>>> -		return err;
>>> -	}
>>> -
>>>   	err =3D clk_prepare_enable(data->clk_cdev1);
>>>   	if (err) {
>>>   		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>>> @@ -108,9 +96,8 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc=
_utils_data *data)
>>>   	const int ac97_rate =3D 24576000;
>>>   	int err;
>>>  =20
>>> -	clk_disable_unprepare(data->clk_cdev1);
>>> -	clk_disable_unprepare(data->clk_pll_a_out0);
>>> -	clk_disable_unprepare(data->clk_pll_a);
>>> +	if (__clk_is_enabled(data->clk_cdev1))
>>> +		clk_disable_unprepare(data->clk_cdev1);
>>>  =20
>>>   	/*
>>>   	 * AC97 rate is fixed at 24.576MHz and is used for both the host
>>> @@ -130,18 +117,6 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_as=
oc_utils_data *data)
>>>  =20
>>>   	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>>>  =20
>>> -	err =3D clk_prepare_enable(data->clk_pll_a);
>>> -	if (err) {
>>> -		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
>>> -		return err;
>>> -	}
>>> -
>>> -	err =3D clk_prepare_enable(data->clk_pll_a_out0);
>>> -	if (err) {
>>> -		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
>>> -		return err;
>>> -	}
>>> -
>>>   	err =3D clk_prepare_enable(data->clk_cdev1);
>>>   	if (err) {
>>>   		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>>> @@ -158,6 +133,7 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>>>   int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>>>   			  struct device *dev)
>>>   {
>>> +	struct clk *clk_out_1, *clk_extern1;
>>>   	int ret;
>>>  =20
>>>   	data->dev =3D dev;
>>> @@ -193,6 +169,41 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_=
data *data,
>>>   		return PTR_ERR(data->clk_cdev1);
>>>   	}
>>>  =20
>>> +	/*
>>> +	 * If clock parents are not set in DT, configure here to use clk_out_=
1
>>> +	 * as mclk and extern1 as parent for Tegra30 and higher.
>>> +	 */
>>> +	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &=
&
>>> +	    data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
>> Please add a message here about falling back to configuring clocks for a
>> legacy device-tree, telling that device-tree needs to be updated.
>>
Will add in v6
>>> +		clk_extern1 =3D devm_clk_get(dev, "extern1");
>>> +		if (IS_ERR(clk_extern1)) {
>>> +			dev_err(data->dev, "Can't retrieve clk extern1\n");
>>> +			return PTR_ERR(clk_extern1);
>>> +		}
>>> +
>>> +		ret =3D clk_set_parent(clk_extern1, data->clk_pll_a_out0);
>>> +		if (ret < 0) {
>>> +			dev_err(data->dev,
>>> +				"Set parent failed for clk extern1\n");
>>> +			return ret;
>>> +		}
>>> +
>>> +		clk_out_1 =3D devm_clk_get(dev, "clk_out_1");
>>> +		if (IS_ERR(clk_out_1)) {
>>> +			dev_err(data->dev, "Can't retrieve clk clk_out_1\n");
>>> +			return PTR_ERR(clk_out_1);
>>> +		}
>>> +
>>> +		ret =3D clk_set_parent(clk_out_1, clk_extern1);
>>> +		if (ret < 0) {
>>> +			dev_err(data->dev,
>>> +				"Set parent failed for clk_out_1\n");
>>> +			return ret;
>>> +		}
>>> +
>>> +		data->clk_cdev1 =3D clk_out_1;
>>> +	}
>>> +
>>>   	ret =3D tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
> Actually, this tegra_asoc_utils_set_rate() should be removed because it
> doesn't do anything useful since drivers configure the clock rate when
> necessary.
>
>>>   	return ret;
>>>
>> I'd also add tegra_asoc_utils_deinit() to disable clock on drivers remov=
al.
Will add this in v6
