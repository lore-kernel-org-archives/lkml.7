Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A34C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ED92075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfDBHnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:43:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:10722 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfDBHnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:43:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 00:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="157407651"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga002.fm.intel.com with ESMTP; 02 Apr 2019 00:43:41 -0700
Subject: Re: [PATCH v2] mmc: sdhci_am654: Clear HISPD_ENA in some lower speed
 modes
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20190401125804.5665-1-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <356a8af6-03ab-2827-03c9-a386c8cfaec8@intel.com>
Date:   Tue, 2 Apr 2019 10:42:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401125804.5665-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/04/19 3:58 PM, Faiz Abbas wrote:
> According to the AM654x Data Manual[1], the setup timing in lower speed
> modes can only be met if the controller uses a falling edge data launch.
> 
> To ensure this, the HIGH_SPEED_ENA (HOST_CONTROL[2]) bit should be
> cleared in default speed, SD high speed, MMC high speed, SDR12 and SDR25
> speed modes.
> 
> Use the sdhci writeb callback to implement this condition.
> 
> [1] http://www.ti.com/lit/gpn/am6546 Section 5.10.5.16.1
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> v2: Dropped QUIRK in favour of writeb callback
> 
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci_am654.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 28fcd8f580a1..6379fba8b122 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -993,6 +993,7 @@ config MMC_SDHCI_OMAP
>  config MMC_SDHCI_AM654
>  	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
>  	depends on MMC_SDHCI_PLTFM && OF
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in TI's AM654 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index eea183e90f1b..a91c0b45c48d 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -158,6 +158,27 @@ static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
>  	sdhci_set_power_noreg(host, mode, vdd);
>  }
>  
> +static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
> +{
> +	unsigned char timing = host->mmc->ios.timing;
> +
> +	if (reg == SDHCI_HOST_CONTROL) {
> +		switch (timing) {
> +		/*
> +		 * According to the data manual, HISPD bit
> +		 * should not be set in these speed modes.
> +		 */
> +		case MMC_TIMING_SD_HS:
> +		case MMC_TIMING_MMC_HS:
> +		case MMC_TIMING_UHS_SDR12:
> +		case MMC_TIMING_UHS_SDR25:
> +			val &= ~SDHCI_CTRL_HISPD;
> +		}
> +	}
> +
> +	writeb(val, host->ioaddr + reg);
> +}
> +
>  static struct sdhci_ops sdhci_am654_ops = {
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -165,6 +186,7 @@ static struct sdhci_ops sdhci_am654_ops = {
>  	.set_bus_width = sdhci_set_bus_width,
>  	.set_power = sdhci_am654_set_power,
>  	.set_clock = sdhci_am654_set_clock,
> +	.write_b = sdhci_am654_write_b,
>  	.reset = sdhci_reset,
>  };
>  
> 

