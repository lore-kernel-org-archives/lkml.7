Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D506C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B27217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xk2cGNjY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JjC9H1dI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfCNFp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:45:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfCNFpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:45:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7AD94609EF; Thu, 14 Mar 2019 05:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552541706;
        bh=QIt4dwIxDZtjIOhPMYl9C3L6oJO2HtLuKJjUu/Y0adU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xk2cGNjYq1dkUzGEnQb/q2R3zQ2lSXOxNW0mZtLqIvLs+0Q3mpXHdb7nhy6mS6CzK
         RgDQWhum0CwfUT9Z2Udr8IY72K7NjXOs/AQVNP0FCaGFYT3MolwId36/ODfFGwYoLE
         aCUOHxt7avKR8JeSAJaC45N/FAF9klUgFGMekws8=
Received: from [10.206.25.9] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: riteshh@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D597C602A7;
        Thu, 14 Mar 2019 05:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552541705;
        bh=QIt4dwIxDZtjIOhPMYl9C3L6oJO2HtLuKJjUu/Y0adU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JjC9H1dIoK/bfXvYzfkPOBOWUUc6+Tuu4ZOu0VBcMZg937oR9OTR4q31DXuqWtI+H
         tyIdgieG54h53bdD3vPGkatqwjpmuUUDEGGOuK29yANX7Ke45PCwx3g5/TfXsxT+dn
         COOtMgwhGT5mRe5LZskdrVwzfiY9w01TEjAaqJVI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D597C602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=riteshh@codeaurora.org
Subject: Re: [PATCH V3 07/10] mmc: tegra: add Tegra186 WAR for CQE
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-7-git-send-email-skomatineni@nvidia.com>
From:   Ritesh Harjani <riteshh@codeaurora.org>
Message-ID: <55701d04-1e55-e0a0-ecd7-d31eaec5240d@codeaurora.org>
Date:   Thu, 14 Mar 2019 11:04:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1552513552-23423-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/2019 3:15 AM, Sowjanya Komatineni wrote:
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
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Thanks,

Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f1aa0591112a..2f08b6e480df 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -106,6 +106,7 @@
>   #define NVQUIRK_HAS_PADCALIB				BIT(6)
>   #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
>   #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
> +#define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING		BIT(9)
>   
>   /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>   #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> @@ -1123,6 +1124,18 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>   		tegra_host->pad_calib_required = true;
>   }
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
>   static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
>   {
>   	struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -1164,6 +1177,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>   	.enable	= sdhci_tegra_cqe_enable,
>   	.disable = sdhci_cqe_disable,
>   	.dumpregs = sdhci_tegra_dumpregs,
> +	.update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
>   };
>   
>   static const struct sdhci_ops tegra_sdhci_ops = {
> @@ -1345,7 +1359,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>   		    NVQUIRK_HAS_PADCALIB |
>   		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>   		    NVQUIRK_ENABLE_SDR50 |
> -		    NVQUIRK_ENABLE_SDR104,
> +		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING,
>   	.min_tap_delay = 84,
>   	.max_tap_delay = 136,
>   };
