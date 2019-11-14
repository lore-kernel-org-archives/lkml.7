Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B41C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5D3206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNNLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:11:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:30469 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfKNNLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:11:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 05:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="235662970"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2019 05:11:42 -0800
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-aspeed: add inversion signal
 presence
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20191114125435.27756-1-i.mikhaylov@yadro.com>
 <20191114125435.27756-3-i.mikhaylov@yadro.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fcb5f8b5-40b9-6497-b24d-0b73e2525949@intel.com>
Date:   Thu, 14 Nov 2019 15:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114125435.27756-3-i.mikhaylov@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/19 2:54 PM, Ivan Mikhaylov wrote:
> Change the default .get_cd callback. Add inverted signal card detection
> check.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 8962f6664381..186559ee8fcc 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -143,6 +143,19 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
>  	return (delta / 0x100) - 1;
>  }
>  
> +static int aspeed_get_cd(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	int present = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
> +			 & SDHCI_CARD_PRESENT);
> +
> +	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
> +		present = !present;

Perhaps safer to flip the bit using CONFIG_MMC_SDHCI_IO_ACCESSORS and
->readl() callback

> +
> +	return present;
> +}
> +
>  static int aspeed_sdhci_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -183,6 +196,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>  
> +	host->mmc_host_ops.get_cd = aspeed_get_cd;
> +	if (of_property_read_bool(pdev->dev.of_node, "cd-inverted"))
> +		dev_info(&pdev->dev, "aspeed: sdhci: presence signal inversion enabled\n");

Is this print really needed?

> +
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto err_sdhci_add;
> 

