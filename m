Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CB4C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6572085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHLIYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:24:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:26525 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfHLIYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:24:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 01:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="scan'208";a="193908061"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2019 01:24:14 -0700
Subject: Re: [PATCH] mmc: sdhci-cadence: use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190808165301.GA30877@embeddedor>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <994dec08-a6fb-56b1-c931-9a034e9a5f8d@intel.com>
Date:   Mon, 12 Aug 2019 11:23:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808165301.GA30877@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/08/19 7:53 PM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct sdhci_cdns_priv {
> 	...
>         struct sdhci_cdns_phy_param phy_params[0];
> };
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following form:
> 
> sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params
> 
> with:
> 
> struct_size(priv, phy_params, nr_phy_params)
> 
> Also, notice that, in this case, variable priv_size is not necessary,
> hence it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 163d1cf4367e..1768a13f89be 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -337,7 +337,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> -	size_t priv_size;
>  	unsigned int nr_phy_params;
>  	int ret;
>  	struct device *dev = &pdev->dev;
> @@ -351,8 +350,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> -	priv_size = sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params;
> -	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, priv_size);
> +	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data,
> +				struct_size(priv, phy_params, nr_phy_params));
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
>  		goto disable_clk;
> 

