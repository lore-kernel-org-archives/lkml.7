Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C691FC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C222205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h8X8NPee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfGIKMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:12:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3825 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGIKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:12:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2468890000>; Tue, 09 Jul 2019 03:12:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 03:12:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 09 Jul 2019 03:12:20 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 10:12:13 +0000
Subject: Re: [PATCH v1] i2c: tegra: Compile PM functions unconditionally
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "Wolfram Sang" <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190707231234.11679-1-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <13be0f2e-2131-2e0d-d39f-9f1c964b8698@nvidia.com>
Date:   Tue, 9 Jul 2019 11:12:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707231234.11679-1-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562667145; bh=30gNHPfyhaFNJ6Klft+DktYka3Ta2cIvCT6iqeMPorI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=h8X8NPeeWPB86ub0L6XkU5i/BprfGwHTjQ4fHJor9F8iTKnWoCcYKBy309Ab2a4zs
         cl4e64DpslzK+9cPsAxRBCYxjZL8lxiKuT//mKtqDnHX9kjv1u5CbxSAirDW4RkHbT
         AR1YKT9iisqhQnaWTbyKUkz3iNl0WGWHhvY4d9O7GVELiflLnpYCsBpw+b2g/04ULP
         ly51PkYnsSwL8LNtbT43+eTLCxSMcrtRFozZox6PfJLbyuvD08WSLYfyYcah0/ySK5
         BfSpAMCftsM4dOMeLBUN4+FfPJkWqoMS6x4rWrVnNsLkXxFDTDneQ91yRVjLYG2XwI
         TVsp6sLbobV8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/07/2019 00:12, Dmitry Osipenko wrote:
> The I2C driver fails to probe if CONFIG_PM_SLEEP=n because runtime PM
> doesn't depend on the PM sleep and in this case the runtime PM ops are
> not included in the driver, resulting in I2C clock not being enabled.
> It's much cleaner to simply allow compiler to remove the dead code
> instead of messing with the #ifdefs.
> 
> This patch fixes such errors when CONFIG_PM_SLEEP=n:
> 
>   tegra-i2c 7000c400.i2c: timeout waiting for fifo flush
>   tegra-i2c 7000c400.i2c: Failed to initialize i2c controller
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 9fcb13beeb8f..18f0ceed9f1b 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -636,7 +636,7 @@ static void tegra_dvc_init(struct tegra_i2c_dev *i2c_dev)
>  	dvc_writel(i2c_dev, val, DVC_CTRL_REG1);
>  }
>  
> -static int tegra_i2c_runtime_resume(struct device *dev)
> +static int __maybe_unused tegra_i2c_runtime_resume(struct device *dev)
>  {
>  	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>  	int ret;
> @@ -665,7 +665,7 @@ static int tegra_i2c_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static int tegra_i2c_runtime_suspend(struct device *dev)
> +static int __maybe_unused tegra_i2c_runtime_suspend(struct device *dev)
>  {
>  	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>  
> @@ -1711,8 +1711,7 @@ static int tegra_i2c_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int tegra_i2c_suspend(struct device *dev)
> +static int __maybe_unused tegra_i2c_suspend(struct device *dev)
>  {
>  	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>  
> @@ -1721,7 +1720,7 @@ static int tegra_i2c_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tegra_i2c_resume(struct device *dev)
> +static int __maybe_unused tegra_i2c_resume(struct device *dev)
>  {
>  	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>  	int err;
> @@ -1741,18 +1740,13 @@ static const struct dev_pm_ops tegra_i2c_pm = {
>  			   NULL)
>  };
>  
> -#define TEGRA_I2C_PM	(&tegra_i2c_pm)
> -#else
> -#define TEGRA_I2C_PM	NULL
> -#endif
> -
>  static struct platform_driver tegra_i2c_driver = {
>  	.probe   = tegra_i2c_probe,
>  	.remove  = tegra_i2c_remove,
>  	.driver  = {
>  		.name  = "tegra-i2c",
>  		.of_match_table = tegra_i2c_of_match,
> -		.pm    = TEGRA_I2C_PM,
> +		.pm    = &tegra_i2c_pm,
>  	},
>  };
>  

Looks good to me.

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
