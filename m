Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D632084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbfCYKmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:42:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:64820 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbfCYKmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:42:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 03:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134508843"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 03:42:48 -0700
Subject: Re: [PATCH V4 07/10] mmc: tegra: add Tegra186 WAR for CQE
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        riteshh@codeaurora.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
 <1553402727-23130-7-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f42156ea-dd53-efbc-3412-b82c34458ea2@intel.com>
Date:   Mon, 25 Mar 2019 12:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553402727-23130-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/19 6:45 AM, Sowjanya Komatineni wrote:
> Tegra186 CQHCI host has a known bug where CQHCI controller selects
> DATA_PRESENT_SELECT bit to 1 for DCMDs with R1B response type and
> since DCMD does not trigger any data transfer, DCMD task complete
> happens leaving the DATA FSM of host controller in wait state for
> the data.
> 
> This effects the data transfer tasks issued after the DCMDs with
> R1b response type resulting in timeout.
> 
> SW WAR is to set CMD_TIMING to 1 in DCMD task descriptor. This bug
> and SW WAR is applicable only for Tegra186 and not for Tegra194.
> 
> This patch implements this WAR thru NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING
> for Tegra186 and also implements update_dcmd_desc of cqhci_host_ops
> interface to set CMD_TIMING bit depending on the NVQUIRK.
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f1aa0591112a..2f08b6e480df 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -106,6 +106,7 @@
>  #define NVQUIRK_HAS_PADCALIB				BIT(6)
>  #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
>  #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
> +#define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING		BIT(9)
>  
>  /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>  #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> @@ -1123,6 +1124,18 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>  		tegra_host->pad_calib_required = true;
>  }
>  
> +static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
> +					 struct mmc_request *mrq, u64 *data)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(mmc_priv(mmc));
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +
> +	if (soc_data->nvquirks & NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING &&
> +	    mrq->cmd->flags & MMC_RSP_R1B)
> +		*data |= CQHCI_CMD_TIMING(1);
> +}
> +
>  static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -1164,6 +1177,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>  	.enable	= sdhci_tegra_cqe_enable,
>  	.disable = sdhci_cqe_disable,
>  	.dumpregs = sdhci_tegra_dumpregs,
> +	.update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
>  };
>  
>  static const struct sdhci_ops tegra_sdhci_ops = {
> @@ -1345,7 +1359,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>  		    NVQUIRK_HAS_PADCALIB |
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>  		    NVQUIRK_ENABLE_SDR50 |
> -		    NVQUIRK_ENABLE_SDR104,
> +		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING,
>  	.min_tap_delay = 84,
>  	.max_tap_delay = 136,
>  };
> 

