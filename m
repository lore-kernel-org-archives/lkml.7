Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2763EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0277E280E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfFCMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:22:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:24308 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfFCMWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:22:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 05:22:03 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga005.jf.intel.com with ESMTP; 03 Jun 2019 05:21:59 -0700
Subject: Re: [PATCH 3/9] mmc: sdhci-sprd: Add optional gate clock support
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <16b895cf30c235dc656eeed5888069b6266ab5f8.1558346019.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2969091b-408d-c505-d406-ce4b4f0679e0@intel.com>
Date:   Mon, 3 Jun 2019 15:20:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <16b895cf30c235dc656eeed5888069b6266ab5f8.1558346019.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 1:11 PM, Baolin Wang wrote:
> For the Spreadtrum SC9860 platform, we should enable another gate clock
> '2x_enable' to make the SD host controller work well.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index e741491..31ba7d6 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -60,6 +60,7 @@ struct sdhci_sprd_host {
>  	u32 version;
>  	struct clk *clk_sdio;
>  	struct clk *clk_enable;
> +	struct clk *clk_2x_enable;
>  	u32 base_rate;
>  	int flags; /* backup of host attribute */
>  };
> @@ -364,6 +365,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	}
>  	sprd_host->clk_enable = clk;
>  
> +	clk = devm_clk_get(&pdev->dev, "2x_enable");
> +	if (!IS_ERR(clk))
> +		sprd_host->clk_2x_enable = clk;
> +
>  	ret = clk_prepare_enable(sprd_host->clk_sdio);
>  	if (ret)
>  		goto pltfm_free;
> @@ -372,6 +377,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto clk_disable;
>  
> +	ret = clk_prepare_enable(sprd_host->clk_2x_enable);
> +	if (ret)
> +		goto clk_disable2;
> +
>  	sdhci_sprd_init_config(host);
>  	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
>  	sprd_host->version = ((host->version & SDHCI_VENDOR_VER_MASK) >>
> @@ -408,6 +417,9 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  
> +	clk_disable_unprepare(sprd_host->clk_2x_enable);
> +
> +clk_disable2:
>  	clk_disable_unprepare(sprd_host->clk_enable);
>  
>  clk_disable:
> @@ -427,6 +439,7 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
>  	mmc_remove_host(mmc);
>  	clk_disable_unprepare(sprd_host->clk_sdio);
>  	clk_disable_unprepare(sprd_host->clk_enable);
> +	clk_disable_unprepare(sprd_host->clk_2x_enable);
>  
>  	mmc_free_host(mmc);
>  
> @@ -449,6 +462,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
>  
>  	clk_disable_unprepare(sprd_host->clk_sdio);
>  	clk_disable_unprepare(sprd_host->clk_enable);
> +	clk_disable_unprepare(sprd_host->clk_2x_enable);
>  
>  	return 0;
>  }
> @@ -459,19 +473,28 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
>  	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
>  	int ret;
>  
> -	ret = clk_prepare_enable(sprd_host->clk_enable);
> +	ret = clk_prepare_enable(sprd_host->clk_2x_enable);
>  	if (ret)
>  		return ret;
>  
> +	ret = clk_prepare_enable(sprd_host->clk_enable);
> +	if (ret)
> +		goto clk_2x_disable;
> +
>  	ret = clk_prepare_enable(sprd_host->clk_sdio);
> -	if (ret) {
> -		clk_disable_unprepare(sprd_host->clk_enable);
> -		return ret;
> -	}
> +	if (ret)
> +		goto clk_disable;
>  
>  	sdhci_runtime_resume_host(host);
> -
>  	return 0;
> +
> +clk_disable:
> +	clk_disable_unprepare(sprd_host->clk_enable);
> +
> +clk_2x_disable:
> +	clk_disable_unprepare(sprd_host->clk_2x_enable);
> +
> +	return ret;
>  }
>  #endif
>  
> 

