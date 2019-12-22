Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EDDC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E2A2063A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 21:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihaRYykM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLVVS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 16:18:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41254 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfLVVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 16:18:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so15879328ljc.8;
        Sun, 22 Dec 2019 13:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gFk165C6u1WowXAQ/IGtjex+DHRYGJFw3gc6psMVtlA=;
        b=ihaRYykMD85EYqYo/KbWsm5uuiFj7d3g+rXehpol0Jeai6ky/JJvNyR0+xJFp2yFfi
         GY0C4KNnB+n8Nf5HTbN8s8CUsMl2oP/oQLiFDWldaN23NkhGoBvswmdmPF2XXsTg6Oih
         /f0lQlvRUtsblWAXjPDCPPMTcMxHbIhbIwiSzKsyP2cKCzsj2BjJ3KYSRjKGpPqyhN2B
         s76WE0LMGOFDILn9B3bDohhUB9IP2UGqC44MJOaIQ8khGNfEodP+CzPz8z2q4QATjJEC
         74Hfs3OWHNZHA/fDhAUvGrH24rm3/byQSa7KZBtxY/t97DsnN8Qocwx3e4mkX/M7ZFbA
         8brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gFk165C6u1WowXAQ/IGtjex+DHRYGJFw3gc6psMVtlA=;
        b=bM1Q/CEUGuBr79/srHErEid9tu2S8/aUluJ8s80I/6Usx/NUCDbUGrG6Kx4I1aWzZy
         GGAZjggIwFUcDFlF0575gJydaW1IoubdsVecYyjv2PBBTimvC+5yw6Gd7NyqCOwQ9lw9
         YYlaBuaOTKiYk6A5AuqWYfbR940MSXyKLHBfiJjPMGDydE4U/NKErDLDm4ig5g8kndyb
         E5Dwm2+WkfuE+TvTFzyPR5PyVgOaQ/slLScDrZt/aGhjLgXzXA77di9YA3BMh+0u5gr8
         QKdYRRVd+NuI+5TAkVgun2+so0gEoDgheaF90tbuiyZ7c/pZ1GBGVnGIJCWdsCyRnDut
         qvGg==
X-Gm-Message-State: APjAAAVXcR54GzcMKrrhVjI7Ry6fa595lHxmmFt8AYAjO3rkYSfjXiNj
        QA8a2AQLmY/g2PE9gnhfvtH+1lgG
X-Google-Smtp-Source: APXvYqyrBdcwJ5LbnZkgNY56puGtk5JX9gVePW8df8SvKK7yrSYs7xf3SOjdzrAB53UbSumgem5nGQ==
X-Received: by 2002:a2e:9050:: with SMTP id n16mr5257829ljg.49.1577049533897;
        Sun, 22 Dec 2019 13:18:53 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r2sm7100058lfn.13.2019.12.22.13.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 13:18:53 -0800 (PST)
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
 <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
Message-ID: <1b79ab92-c163-3857-dd38-df35c509b823@gmail.com>
Date:   Mon, 23 Dec 2019 00:18:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.12.2019 00:14, Dmitry Osipenko пишет:
> 21.12.2019 01:26, Sowjanya Komatineni пишет:
>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>> through Tegra210 and currently Tegra clock driver does initial parent
>> configuration for audio mclk "clk_out_1" and enables them by default.
>>
>> With the move of Tera PMC clocks from clock driver to Tegra PMC
>> driver, initial parent configuration for audio clocks are through
>> the device tree using assigned-clock-parents property.
>>
>> Default clock parents can be specified in device tree using
>> assigned-clocks and assigned-clock-parents and there is no need
>> to have clock driver do parent configuration and enable audio related
>> clocks.
>>
>> This patch has implementation for initial parent configuration in
>> audio driver when default parent configuration is not specified in the
>> device tree using assigned-clock properties and enables audio clocks
>> during the clock rate change.
>>
>> This patch configures PLLA_OUT0 as parent to extern1 and extern1
>> as parent to clk_out_1 and uses clk_out_1 as cdev1 clock to allow
>> mclk control from this driver.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  sound/soc/tegra/tegra_asoc_utils.c | 71 ++++++++++++++++++++++----------------
>>  1 file changed, 41 insertions(+), 30 deletions(-)
>>
>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
>> index 38535962029c..fc3135c08f43 100644
>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>> @@ -7,6 +7,7 @@
>>   */
>>  
>>  #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
> 
> This is illegal, it is not a clock provider.
> 
>>  #include <linux/device.h>
>>  #include <linux/err.h>
>>  #include <linux/kernel.h>
>> @@ -59,9 +60,8 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
>>  	data->set_baseclock = 0;
>>  	data->set_mclk = 0;
>>  
>> -	clk_disable_unprepare(data->clk_cdev1);
>> -	clk_disable_unprepare(data->clk_pll_a_out0);
>> -	clk_disable_unprepare(data->clk_pll_a);
>> +	if (__clk_is_enabled(data->clk_cdev1))
>> +		clk_disable_unprepare(data->clk_cdev1);
> 
> The root of the problem is that you removed clocks enabling from
> tegra_asoc_utils_init().
> 
> I'm not sure why clocks should be disabled during the rate-changing,
> probably this action is not really needed.
> 
> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
> b/sound/soc/tegra/tegra_asoc_utils.c
> index 46ff70c16b74..789fd03e51a7 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.c
> +++ b/sound/soc/tegra/tegra_asoc_utils.c
> @@ -7,7 +7,6 @@
>   */
> 
>  #include <linux/clk.h>
> -#include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
> @@ -60,9 +59,6 @@ int tegra_asoc_utils_set_rate(struct
> tegra_asoc_utils_data *data, int srate,
>  	data->set_baseclock = 0;
>  	data->set_mclk = 0;
> 
> -	if (__clk_is_enabled(data->clk_cdev1))
> -		clk_disable_unprepare(data->clk_cdev1);
> -
>  	err = clk_set_rate(data->clk_pll_a, new_baseclock);
>  	if (err) {
>  		dev_err(data->dev, "Can't set pll_a rate: %d\n", err);
> @@ -77,12 +73,6 @@ int tegra_asoc_utils_set_rate(struct
> tegra_asoc_utils_data *data, int srate,
> 
>  	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
> 
> -	err = clk_prepare_enable(data->clk_cdev1);
> -	if (err) {
> -		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
> -		return err;
> -	}
> -
>  	data->set_baseclock = new_baseclock;
>  	data->set_mclk = mclk;
> 
> @@ -96,9 +86,6 @@ int tegra_asoc_utils_set_ac97_rate(struct
> tegra_asoc_utils_data *data)
>  	const int ac97_rate = 24576000;
>  	int err;
> 
> -	if (__clk_is_enabled(data->clk_cdev1))
> -		clk_disable_unprepare(data->clk_cdev1);
> -
>  	/*
>  	 * AC97 rate is fixed at 24.576MHz and is used for both the host
>  	 * controller and the external codec
> @@ -117,12 +104,6 @@ int tegra_asoc_utils_set_ac97_rate(struct
> tegra_asoc_utils_data *data)
> 
>  	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
> 
> -	err = clk_prepare_enable(data->clk_cdev1);
> -	if (err) {
> -		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
> -		return err;
> -	}
> -
>  	data->set_baseclock = pll_rate;
>  	data->set_mclk = ac97_rate;
> 
> @@ -213,6 +194,12 @@ int tegra_asoc_utils_init(struct
> tegra_asoc_utils_data *data,
>  		data->clk_cdev1 = clk_out_1;
>  	}
> 
> +	ret = clk_prepare_enable(data->clk_cdev1);
> +	if (ret) {
> +		dev_err(data->dev, "Can't enable cdev1: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
> 
>  	return ret;
> 
> 
>>  	err = clk_set_rate(data->clk_pll_a, new_baseclock);
>>  	if (err) {
>> @@ -77,18 +77,6 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
>>  
>>  	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>>  
>> -	err = clk_prepare_enable(data->clk_pll_a);
>> -	if (err) {
>> -		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
>> -		return err;
>> -	}
>> -
>> -	err = clk_prepare_enable(data->clk_pll_a_out0);
>> -	if (err) {
>> -		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
>> -		return err;
>> -	}
>> -
>>  	err = clk_prepare_enable(data->clk_cdev1);
>>  	if (err) {
>>  		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>> @@ -108,9 +96,8 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
>>  	const int ac97_rate = 24576000;
>>  	int err;
>>  
>> -	clk_disable_unprepare(data->clk_cdev1);
>> -	clk_disable_unprepare(data->clk_pll_a_out0);
>> -	clk_disable_unprepare(data->clk_pll_a);
>> +	if (__clk_is_enabled(data->clk_cdev1))
>> +		clk_disable_unprepare(data->clk_cdev1);
>>  
>>  	/*
>>  	 * AC97 rate is fixed at 24.576MHz and is used for both the host
>> @@ -130,18 +117,6 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
>>  
>>  	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>>  
>> -	err = clk_prepare_enable(data->clk_pll_a);
>> -	if (err) {
>> -		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
>> -		return err;
>> -	}
>> -
>> -	err = clk_prepare_enable(data->clk_pll_a_out0);
>> -	if (err) {
>> -		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
>> -		return err;
>> -	}
>> -
>>  	err = clk_prepare_enable(data->clk_cdev1);
>>  	if (err) {
>>  		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>> @@ -158,6 +133,7 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>>  int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>>  			  struct device *dev)
>>  {
>> +	struct clk *clk_out_1, *clk_extern1;
>>  	int ret;
>>  
>>  	data->dev = dev;
>> @@ -193,6 +169,41 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>>  		return PTR_ERR(data->clk_cdev1);
>>  	}
>>  
>> +	/*
>> +	 * If clock parents are not set in DT, configure here to use clk_out_1
>> +	 * as mclk and extern1 as parent for Tegra30 and higher.
>> +	 */
>> +	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &&
>> +	    data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
> 
> Please add a message here about falling back to configuring clocks for a
> legacy device-tree, telling that device-tree needs to be updated.
> 
>> +		clk_extern1 = devm_clk_get(dev, "extern1");
>> +		if (IS_ERR(clk_extern1)) {
>> +			dev_err(data->dev, "Can't retrieve clk extern1\n");
>> +			return PTR_ERR(clk_extern1);
>> +		}
>> +
>> +		ret = clk_set_parent(clk_extern1, data->clk_pll_a_out0);
>> +		if (ret < 0) {
>> +			dev_err(data->dev,
>> +				"Set parent failed for clk extern1\n");
>> +			return ret;
>> +		}
>> +
>> +		clk_out_1 = devm_clk_get(dev, "clk_out_1");
>> +		if (IS_ERR(clk_out_1)) {
>> +			dev_err(data->dev, "Can't retrieve clk clk_out_1\n");
>> +			return PTR_ERR(clk_out_1);
>> +		}
>> +
>> +		ret = clk_set_parent(clk_out_1, clk_extern1);
>> +		if (ret < 0) {
>> +			dev_err(data->dev,
>> +				"Set parent failed for clk_out_1\n");
>> +			return ret;
>> +		}
>> +
>> +		data->clk_cdev1 = clk_out_1;
>> +	}
>> +
>>  	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);

Actually, this tegra_asoc_utils_set_rate() should be removed because it
doesn't do anything useful since drivers configure the clock rate when
necessary.

>>  	return ret;
>>
> 
> I'd also add tegra_asoc_utils_deinit() to disable clock on drivers removal.
> 

