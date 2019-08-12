Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F03C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DCE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfHLIeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:34:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:19885 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfHLIeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:34:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 01:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="scan'208";a="193909168"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2019 01:34:16 -0700
Subject: Re: [PATCH v1] Revert "mmc: sdhci-tegra: drop ->get_ro()
 implementation"
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
References: <20190808222430.28477-1-digetx@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1771bc5f-864c-ea05-be06-f45d9260a446@intel.com>
Date:   Mon, 12 Aug 2019 11:33:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808222430.28477-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/08/19 1:24 AM, Dmitry Osipenko wrote:
> The WRITE_PROTECT bit is always in a "protected mode" on Tegra and
> WP-GPIO state need to be used instead. In a case of the GPIO absence,
> write-enable should be assumed. External SD is writable once again as
> a result of this patch because the offending commit changed behaviour for
> the case of a missing WP-GPIO to fall back to WRITE_PROTECT bit-checking,
> which is incorrect for Tegra.
> 
> Cc: stable@vger.kernel.org # v5.1+
> Fixes: e8391453e27f ("mmc: sdhci-tegra: drop ->get_ro() implementation")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Can we get an Ack from someone from Nvidia

> ---
>  drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f4d4761cf20a..02d8f524bb9e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -258,6 +258,16 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
>  	}
>  }
>  
> +static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
> +{
> +	/*
> +	 * Write-enable shall be assumed if GPIO is missing in a board's
> +	 * device-tree because SDHCI's WRITE_PROTECT bit doesn't work on
> +	 * Tegra.
> +	 */
> +	return mmc_gpio_get_ro(host->mmc);
> +}
> +
>  static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1224,6 +1234,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>  };
>  
>  static const struct sdhci_ops tegra_sdhci_ops = {
> +	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> @@ -1279,6 +1290,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
>  };
>  
>  static const struct sdhci_ops tegra114_sdhci_ops = {
> +	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_w    = tegra_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
> @@ -1332,6 +1344,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
>  };
>  
>  static const struct sdhci_ops tegra210_sdhci_ops = {
> +	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_w    = tegra210_sdhci_writew,
>  	.write_l    = tegra_sdhci_writel,
> @@ -1366,6 +1379,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  };
>  
>  static const struct sdhci_ops tegra186_sdhci_ops = {
> +	.get_ro     = tegra_sdhci_get_ro,
>  	.read_w     = tegra_sdhci_readw,
>  	.write_l    = tegra_sdhci_writel,
>  	.set_clock  = tegra_sdhci_set_clock,
> 

