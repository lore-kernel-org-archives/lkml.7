Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3056C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D7F20665
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfGANca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:32:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:12447 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfGANc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:32:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 06:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,439,1557212400"; 
   d="scan'208";a="361834686"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2019 06:32:26 -0700
Subject: Re: [PATCH 1/3] mmc: sdhci-sprd: Add start_signal_voltage_switch ops
To:     Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1561094029.git.baolin.wang@linaro.org>
 <89fb15e88f33a3c1ce7b5eefa9414a20c984c579.1561094029.git.baolin.wang@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <09a99609-9126-1df5-5ec4-bffe65daeca6@intel.com>
Date:   Mon, 1 Jul 2019 16:31:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <89fb15e88f33a3c1ce7b5eefa9414a20c984c579.1561094029.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/19 9:12 AM, Baolin Wang wrote:
> For Spreadtrum SD host controller, we can not use standard SD registers
> to change and detect the I/O voltage signals, since our voltage regulator
> for I/O is fixed in hardware, and no signals were connected to the SD
> controller. Thus add Spreadtrum specific voltage switch ops to change
> voltage instead of using standard SD host registers.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 024c3c5..8b23c88 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -403,6 +403,22 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	sdhci_request(mmc, mrq);
>  }
>  
> +static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	int ret;
> +
> +	if (!IS_ERR(mmc->supply.vqmmc)) {
> +		ret = mmc_regulator_set_vqmmc(mmc, ios);
> +		if (ret) {
> +			pr_err("%s: Switching signalling voltage failed\n",
> +			       mmc_hostname(mmc));
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					     struct mmc_ios *ios)
>  {
> @@ -470,6 +486,14 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.request = sdhci_sprd_request;
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  		sdhci_sprd_hs400_enhanced_strobe;
> +	/*
> +	 * We can not use the standard ops to change and detect the voltage
> +	 * signal for Spreadtrum SD host controller, since our voltage regulator
> +	 * for I/O is fixed in hardware, that means we do not need control
> +	 * the standard SD host controller to change the I/O voltage.
> +	 */
> +	host->mmc_host_ops.start_signal_voltage_switch =
> +		sdhci_sprd_voltage_switch;
>  
>  	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
>  		MMC_CAP_ERASE | MMC_CAP_CMD23;
> 

