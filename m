Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE1C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825E22467E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0pCaH3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfLGO6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 09:58:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42164 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfLGO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 09:58:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id e28so10768474ljo.9;
        Sat, 07 Dec 2019 06:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/imZWgogkJNGBucbjtRZxaPGtt1kBLD7qb/xwoDYS4s=;
        b=E0pCaH3vDxnkefhjjUyBMVa4eElOa5Ckdy/LKrGLf8aXx/78+uraTf92N9AHGwQB5K
         hyEvipNxohqsJzHbwNst34qs4SmotSI/epy4iUFAzh4rd2EmFPM2IUm2dAz4dAMHLA0v
         NHylNprU48EV2Dlqnl/G1Ioj7tcd+4EvHo91C6aH1X9NUwNSj4SoSCBhIGihZYq2jvUN
         pCW4snFb63egiiIKdU3/7/2JxanwVcgG6pVF8u2UiGLbKXmCrSS+502dNPLCbNtrujc7
         fC9F455QEqDCSJwdHv34KfM0s9hJuRONXClLAiIJOenkW+ZX8k7bdhUMOEaJGHvit5yl
         Flvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/imZWgogkJNGBucbjtRZxaPGtt1kBLD7qb/xwoDYS4s=;
        b=Ot3RI0J9JubEyWVQnP402CETKepQs0xOHla/JhsIPwRCee6Os++9+tInKszi6Jj/nc
         GLkvYKHHpHsB+X3HRdTfPmfcA4qIkgJZvipFEOTj1h5cZz08LS4J/fOl+zjgAKXo6I9f
         v6/cRKggwMrPSSuVKmVqqp/q/Iftr5j+QnlYn1Bhpg4mrPX9HReQokZit5rXm4B97TB2
         gYS1qZlLfv02jOc/iAmPFoyATTGLuV3w33HijX2aynuiH6VspcCcFDDieYoFXtj/Gs9R
         6cGT8k8WOu/VyEDuxLgFfyB/aIkxFyHjNWWkp7qIGTrn7wyxQZKjWRKD30eai2DB4I7b
         DniA==
X-Gm-Message-State: APjAAAUnHW4xbYG+hW2GQRIm6Qji6bzLaWHJu6nMyuhLyka8qnYsT6uG
        IaKHiVYbZ64pvKVHlFKJdMI=
X-Google-Smtp-Source: APXvYqzCLFcB+qy6VVeu0N85TcceEA4RmU7DjZYPsLQ2KXJoTz0NBamVyczhKjzphiPt1EQX73AN/Q==
X-Received: by 2002:a2e:7d01:: with SMTP id y1mr12036901ljc.100.1575730718710;
        Sat, 07 Dec 2019 06:58:38 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q27sm1158561ljc.65.2019.12.07.06.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 06:58:37 -0800 (PST)
Subject: Re: [PATCH v3 08/15] ASoC: tegra: Add audio mclk control through
 clk_out_1 and extern1
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-9-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0ce2e83b-800c-da1e-7a3c-3cf1427cfe20@gmail.com>
Date:   Sat, 7 Dec 2019 17:58:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575600535-26877-9-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.12.2019 05:48, Sowjanya Komatineni пишет:
> Current ASoC driver uses extern1 as cdev1 clock from Tegra30 onwards
> through device tree.
> 
> Actual audio mclk is clk_out_1 and to use PLLA for mclk rate control,
> need to clk_out_1_mux parent to extern1 and extern1 parent to PLLA_OUT0.
> 
> Currently Tegra clock driver init sets the parents and enables both
> clk_out_1 and extern1 clocks. But these clocks parent and enables should
> be controlled by ASoC driver.
> 
> Clock parents can be specified in device tree using assigned-clocks
> and assigned-clock-parents.
> 
> To enable audio mclk, both clk_out_1 and extern1 clocks need to be
> enabled.
> 
> This patch configures parents for clk_out_1 and extern1 clocks if device
> tree does not specify clock parents inorder to support old device tree
> and controls mclk using both clk_out_1 and extern1 clocks.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  sound/soc/tegra/tegra_asoc_utils.c | 66 ++++++++++++++++++++++++++++++++++++++
>  sound/soc/tegra/tegra_asoc_utils.h |  1 +
>  2 files changed, 67 insertions(+)
> 
> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
> index 536a578e9512..8e3a3740df7c 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.c
> +++ b/sound/soc/tegra/tegra_asoc_utils.c
> @@ -60,6 +60,7 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
>  	data->set_mclk = 0;
>  
>  	clk_disable_unprepare(data->clk_cdev1);
> +	clk_disable_unprepare(data->clk_extern1);
>  	clk_disable_unprepare(data->clk_pll_a_out0);
>  	clk_disable_unprepare(data->clk_pll_a);
>  
> @@ -89,6 +90,14 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
>  		return err;
>  	}
>  
> +	if (!IS_ERR_OR_NULL(data->clk_extern1)) {
> +		err = clk_prepare_enable(data->clk_extern1);
> +		if (err) {
> +			dev_err(data->dev, "Can't enable extern1: %d\n", err);
> +			return err;
> +		}
> +	}
> +
>  	err = clk_prepare_enable(data->clk_cdev1);
>  	if (err) {
>  		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
> @@ -109,6 +118,7 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
>  	int err;
>  
>  	clk_disable_unprepare(data->clk_cdev1);
> +	clk_disable_unprepare(data->clk_extern1);
>  	clk_disable_unprepare(data->clk_pll_a_out0);
>  	clk_disable_unprepare(data->clk_pll_a);
>  
> @@ -142,6 +152,14 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
>  		return err;
>  	}
>  
> +	if (!IS_ERR_OR_NULL(data->clk_extern1)) {
> +		err = clk_prepare_enable(data->clk_extern1);
> +		if (err) {
> +			dev_err(data->dev, "Can't enable extern1: %d\n", err);
> +			return err;
> +		}
> +	}

Why this is needed given that clk_extern1 is either a child of MCLK or
MCLK itself (on T20)? The child clocks are enabled when the parent is
enabled.

>  	err = clk_prepare_enable(data->clk_cdev1);
>  	if (err) {
>  		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
> @@ -158,6 +176,7 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
>  int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>  			  struct device *dev)
>  {
> +	struct clk *clk_out_1_mux;
>  	int ret;
>  
>  	data->dev = dev;
> @@ -196,6 +215,51 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>  		goto err_put_pll_a_out0;
>  	}
In a previous patch you added fallback to EXTPERIPH when clk_get(MCLK)
fails. This will work perfectly fine for the older kernels which have
all clocks in the same single CaR driver, but this may not work that
great for the newer kernels because PMC driver isn't registered early
during boot and thus it is possible to get a legit -EPROBE_DEFER which
shouldn't be ignored. In other words, you need to add into this patch a
check for the error code returned by clk_get(MCLK) and fallback only for
-EINVAL.

> +	/*
> +	 * If clock parents are not set in DT, configure here to use clk_out_1
> +	 * as mclk and extern1 as parent for Tegra30 and higher.
> +	 */
> +	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &&
> +	    data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
> +		data->clk_extern1 = clk_get_sys("clk_out_1", "extern1");
> +		if (IS_ERR(data->clk_extern1)) {
> +			dev_err(data->dev, "Can't retrieve clk extern1\n");
> +			ret = PTR_ERR(data->clk_extern1);
> +			goto err_put_cdev1;
> +		}
> +
> +		ret = clk_set_parent(data->clk_extern1, data->clk_pll_a_out0);
> +		if (ret < 0) {
> +			dev_err(data->dev,
> +				"Set parent failed for clk extern1: %d\n",
> +				ret);
> +			goto err_put_cdev1;
> +		}
> +
> +		clk_out_1_mux = clk_get_sys(NULL, "clk_out_1_mux");

Note1: clk_get(dev, "clk_out_1_mux") should work here by letting clk
core to fall back to the clk_get_sys() by itself. Either way should be good.

Note2: devm_clk_get() could be used everywhere here. Maybe it won't hurt
to convert tegra_asoc_utils to use managed resources to keep code a bit
cleaner. It should be a separate patch.

> +		if (IS_ERR(clk_out_1_mux)) {
> +			dev_err(data->dev, "Can't retrieve clk clk_out_1_mux\n");
> +			ret = PTR_ERR(clk_out_1_mux);
> +			goto err_put_cdev1;
> +		}
> +
> +		ret = clk_set_parent(clk_out_1_mux, data->clk_extern1);
> +		if (ret < 0) {
> +			dev_err(data->dev,
> +				"Set parent failed for clk_out_1_mux: %d\n",
> +				ret);
> +			clk_put(clk_out_1_mux);
> +			goto err_put_cdev1;
> +		}

clk_put(clk_cdev1);

> +		data->clk_cdev1 = clk_get_sys(NULL, "clk_out_1");
> +		if (IS_ERR(data->clk_cdev1)) {
> +			dev_err(data->dev, "Can't retrieve clk clk_out_1\n");
> +			ret = PTR_ERR(data->clk_cdev1);
> +			goto err_put_cdev1;

goto err_put_pll_a_out0;

> +		}
> +	}
> +
>  	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
>  	if (ret)
>  		goto err_put_cdev1;
> @@ -215,6 +279,8 @@ EXPORT_SYMBOL_GPL(tegra_asoc_utils_init);
>  
>  void tegra_asoc_utils_fini(struct tegra_asoc_utils_data *data)
>  {
> +	if (!IS_ERR_OR_NULL(data->clk_extern1))
> +		clk_put(data->clk_extern1);
>  	clk_put(data->clk_cdev1);
>  	clk_put(data->clk_pll_a_out0);
>  	clk_put(data->clk_pll_a);
> diff --git a/sound/soc/tegra/tegra_asoc_utils.h b/sound/soc/tegra/tegra_asoc_utils.h
> index 0c13818dee75..5f2b96478caf 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.h
> +++ b/sound/soc/tegra/tegra_asoc_utils.h
> @@ -25,6 +25,7 @@ struct tegra_asoc_utils_data {
>  	struct clk *clk_pll_a;
>  	struct clk *clk_pll_a_out0;
>  	struct clk *clk_cdev1;
> +	struct clk *clk_extern1;
>  	int set_baseclock;
>  	int set_mclk;
>  };
> 

