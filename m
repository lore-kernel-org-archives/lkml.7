Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCAAC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC93F2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rm3dRrT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLGTVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:21:03 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4325 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfLGTVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:21:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5debfb870000>; Sat, 07 Dec 2019 11:20:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 07 Dec 2019 11:21:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 07 Dec 2019 11:21:00 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec
 2019 19:20:57 +0000
Received: from [10.2.171.190] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec 2019
 19:20:55 +0000
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <2eeceabe-b5f0-6f9e-ff8c-4ac6167b7cc3@nvidia.com>
Date:   Sat, 7 Dec 2019 11:20:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0ce2e83b-800c-da1e-7a3c-3cf1427cfe20@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575746442; bh=XsxPB5pJgcgFT4S1zIwFNCo+8dq0T0oiuwHx3cDdt0k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=rm3dRrT8DoZiaBe3STNWQhvol2GJqNiNh5zZ0z4BxpWW/0AauPEkpxj9p7vqZB1AG
         I/UhIsCx9J5s0r1/ePr6O/ZxdPIIxDAITlNLbOK9YVkR/4lDYtvZK55KmJYQDpt/BE
         1bfnnihNl/TSBgzxTrdNph0c3o9Q/WQ8bDWp8wpUBogVpbY958ii32Qfh1OKw4SEpC
         4nTb3UERjVLO0pfxFYYBGX6PYMYMIgX7vvM3RDPpzMPtzyJYnJQFkYYT3cj7w6H5ZX
         DUpRBuOIYZys70l1rMHC1ivdWFpiXkNwAeaPYYTO1QjKoqJjidyGS9bxIBKToKa+rL
         VrtV6Nb+N3ojw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/19 6:58 AM, Dmitry Osipenko wrote:
> 06.12.2019 05:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Current ASoC driver uses extern1 as cdev1 clock from Tegra30 onwards
>> through device tree.
>>
>> Actual audio mclk is clk_out_1 and to use PLLA for mclk rate control,
>> need to clk_out_1_mux parent to extern1 and extern1 parent to PLLA_OUT0.
>>
>> Currently Tegra clock driver init sets the parents and enables both
>> clk_out_1 and extern1 clocks. But these clocks parent and enables should
>> be controlled by ASoC driver.
>>
>> Clock parents can be specified in device tree using assigned-clocks
>> and assigned-clock-parents.
>>
>> To enable audio mclk, both clk_out_1 and extern1 clocks need to be
>> enabled.
>>
>> This patch configures parents for clk_out_1 and extern1 clocks if device
>> tree does not specify clock parents inorder to support old device tree
>> and controls mclk using both clk_out_1 and extern1 clocks.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   sound/soc/tegra/tegra_asoc_utils.c | 66 ++++++++++++++++++++++++++++++=
++++++++
>>   sound/soc/tegra/tegra_asoc_utils.h |  1 +
>>   2 files changed, 67 insertions(+)
>>
>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_=
asoc_utils.c
>> index 536a578e9512..8e3a3740df7c 100644
>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>> @@ -60,6 +60,7 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_=
data *data, int srate,
>>   	data->set_mclk =3D 0;
>>  =20
>>   	clk_disable_unprepare(data->clk_cdev1);
>> +	clk_disable_unprepare(data->clk_extern1);
>>   	clk_disable_unprepare(data->clk_pll_a_out0);
>>   	clk_disable_unprepare(data->clk_pll_a);
>>  =20
>> @@ -89,6 +90,14 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils=
_data *data, int srate,
>>   		return err;
>>   	}
>>  =20
>> +	if (!IS_ERR_OR_NULL(data->clk_extern1)) {
>> +		err =3D clk_prepare_enable(data->clk_extern1);
>> +		if (err) {
>> +			dev_err(data->dev, "Can't enable extern1: %d\n", err);
>> +			return err;
>> +		}
>> +	}
>> +
>>   	err =3D clk_prepare_enable(data->clk_cdev1);
>>   	if (err) {
>>   		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>> @@ -109,6 +118,7 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc=
_utils_data *data)
>>   	int err;
>>  =20
>>   	clk_disable_unprepare(data->clk_cdev1);
>> +	clk_disable_unprepare(data->clk_extern1);
>>   	clk_disable_unprepare(data->clk_pll_a_out0);
>>   	clk_disable_unprepare(data->clk_pll_a);
>>  =20
>> @@ -142,6 +152,14 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_aso=
c_utils_data *data)
>>   		return err;
>>   	}
>>  =20
>> +	if (!IS_ERR_OR_NULL(data->clk_extern1)) {
>> +		err =3D clk_prepare_enable(data->clk_extern1);
>> +		if (err) {
>> +			dev_err(data->dev, "Can't enable extern1: %d\n", err);
>> +			return err;
>> +		}
>> +	}
> Why this is needed given that clk_extern1 is either a child of MCLK or
> MCLK itself (on T20)? The child clocks are enabled when the parent is
> enabled.

For T30 and later, clk_extern1 is one of the source for clk_out_1_mux.=20
clk_extern1 is in CAR and it has its own gate and mux.

As audio mclk related clocks (clk_out_1, clk_out_1_mux, and extern1) are=20
moved into ASoC driver from clock driver

need to enable extern1 gate as well along with clk_out1 for T30 through=20
T210.

Just FYI, extern1 enable here happens only when data->clk_extern1 is=20
available which is for T30 onwards.

>>   	err =3D clk_prepare_enable(data->clk_cdev1);
>>   	if (err) {
>>   		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>> @@ -158,6 +176,7 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>>   int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>>   			  struct device *dev)
>>   {
>> +	struct clk *clk_out_1_mux;
>>   	int ret;
>>  =20
>>   	data->dev =3D dev;
>> @@ -196,6 +215,51 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_d=
ata *data,
>>   		goto err_put_pll_a_out0;
>>   	}
> In a previous patch you added fallback to EXTPERIPH when clk_get(MCLK)
> fails. This will work perfectly fine for the older kernels which have
> all clocks in the same single CaR driver, but this may not work that
> great for the newer kernels because PMC driver isn't registered early
> during boot and thus it is possible to get a legit -EPROBE_DEFER which
> shouldn't be ignored. In other words, you need to add into this patch a
> check for the error code returned by clk_get(MCLK) and fallback only for
> -EINVAL.
yeah right, will add check in next version.
>> +	/*
>> +	 * If clock parents are not set in DT, configure here to use clk_out_1
>> +	 * as mclk and extern1 as parent for Tegra30 and higher.
>> +	 */
>> +	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &&
>> +	    data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
>> +		data->clk_extern1 =3D clk_get_sys("clk_out_1", "extern1");
>> +		if (IS_ERR(data->clk_extern1)) {
>> +			dev_err(data->dev, "Can't retrieve clk extern1\n");
>> +			ret =3D PTR_ERR(data->clk_extern1);
>> +			goto err_put_cdev1;
>> +		}
>> +
>> +		ret =3D clk_set_parent(data->clk_extern1, data->clk_pll_a_out0);
>> +		if (ret < 0) {
>> +			dev_err(data->dev,
>> +				"Set parent failed for clk extern1: %d\n",
>> +				ret);
>> +			goto err_put_cdev1;
>> +		}
>> +
>> +		clk_out_1_mux =3D clk_get_sys(NULL, "clk_out_1_mux");
> Note1: clk_get(dev, "clk_out_1_mux") should work here by letting clk
> core to fall back to the clk_get_sys() by itself. Either way should be go=
od.
>
> Note2: devm_clk_get() could be used everywhere here. Maybe it won't hurt
> to convert tegra_asoc_utils to use managed resources to keep code a bit
> cleaner. It should be a separate patch.

OK Will add patch to use devm_clk_get() in tegra_asoc_utils_init and=20
will use same for these patches

>> +		if (IS_ERR(clk_out_1_mux)) {
>> +			dev_err(data->dev, "Can't retrieve clk clk_out_1_mux\n");
>> +			ret =3D PTR_ERR(clk_out_1_mux);
>> +			goto err_put_cdev1;
>> +		}
>> +
>> +		ret =3D clk_set_parent(clk_out_1_mux, data->clk_extern1);
>> +		if (ret < 0) {
>> +			dev_err(data->dev,
>> +				"Set parent failed for clk_out_1_mux: %d\n",
>> +				ret);
>> +			clk_put(clk_out_1_mux);
>> +			goto err_put_cdev1;
>> +		}
> clk_put(clk_cdev1);
>
>> +		data->clk_cdev1 =3D clk_get_sys(NULL, "clk_out_1");
>> +		if (IS_ERR(data->clk_cdev1)) {
>> +			dev_err(data->dev, "Can't retrieve clk clk_out_1\n");
>> +			ret =3D PTR_ERR(data->clk_cdev1);
>> +			goto err_put_cdev1;
> goto err_put_pll_a_out0;
>
>> +		}
>> +	}
>> +
>>   	ret =3D tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
>>   	if (ret)
>>   		goto err_put_cdev1;
>> @@ -215,6 +279,8 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_init);
>>  =20
>>   void tegra_asoc_utils_fini(struct tegra_asoc_utils_data *data)
>>   {
>> +	if (!IS_ERR_OR_NULL(data->clk_extern1))
>> +		clk_put(data->clk_extern1);
>>   	clk_put(data->clk_cdev1);
>>   	clk_put(data->clk_pll_a_out0);
>>   	clk_put(data->clk_pll_a);
>> diff --git a/sound/soc/tegra/tegra_asoc_utils.h b/sound/soc/tegra/tegra_=
asoc_utils.h
>> index 0c13818dee75..5f2b96478caf 100644
>> --- a/sound/soc/tegra/tegra_asoc_utils.h
>> +++ b/sound/soc/tegra/tegra_asoc_utils.h
>> @@ -25,6 +25,7 @@ struct tegra_asoc_utils_data {
>>   	struct clk *clk_pll_a;
>>   	struct clk *clk_pll_a_out0;
>>   	struct clk *clk_cdev1;
>> +	struct clk *clk_extern1;
>>   	int set_baseclock;
>>   	int set_mclk;
>>   };
>>
