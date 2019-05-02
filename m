Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3F20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEBGdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 02:33:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:38635 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfEBGdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:33:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 23:33:43 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2019 23:33:39 -0700
Subject: Re: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
To:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org,
        "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>
Cc:     djkurtz@chromium.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "Sen, Pankaj" <Pankaj.Sen@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190501175457.195855-2-rrangel@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
Date:   Thu, 2 May 2019 09:32:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501175457.195855-2-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: some AMD people

On 1/05/19 8:54 PM, Raul E Rangel wrote:
> AMD SDHC 0x7906 requires a hard reset to clear all internal state.
> Otherwise it can get into a bad state where the DATA lines are always
> read as zeros.
> 
> This change requires firmware that can transition the device into
> D3Cold for it to work correctly. If the firmware does not support
> transitioning to D3Cold then the power state transitions are a no-op.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
>  drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 99b0fec2836b..532fbcbd373b 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -25,6 +25,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/scatterlist.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mmc/slot-gpio.h>
> @@ -1498,11 +1499,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>  	return 0;
>  }
>  
> +static u32 sdhci_read_present_state(struct sdhci_host *host)
> +{
> +	return sdhci_readl(host, SDHCI_PRESENT_STATE);
> +}
> +
> +void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 present_state;
> +
> +	/*
> +	 * SDHC 0x7906 requires a hard reset to clear all internal state.
> +	 * Otherwise it can get into a bad state where the DATA lines are always
> +	 * read as zeros.
> +	 */
> +	if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
> +		pci_clear_master(pdev);
> +
> +		pci_save_state(pdev);
> +
> +		pci_set_power_state(pdev, PCI_D3cold);
> +		pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
> +			pdev->current_state);
> +		pci_set_power_state(pdev, PCI_D0);
> +
> +		pci_restore_state(pdev);
> +
> +		/*
> +		 * SDHCI_RESET_ALL says the card detect logic should not be
> +		 * reset, but since we need to reset the entire controller
> +		 * we should wait until the card detect logic has stabilized.
> +		 *
> +		 * This normally takes about 40ms.
> +		 */
> +		readx_poll_timeout(
> +			sdhci_read_present_state,
> +			host,
> +			present_state,
> +			present_state & SDHCI_CD_STABLE,
> +			10000,
> +			100000
> +		);
> +	}
> +
> +	return sdhci_reset(host, mask);
> +}
> +
>  static const struct sdhci_ops amd_sdhci_pci_ops = {
>  	.set_clock			= sdhci_set_clock,
>  	.enable_dma			= sdhci_pci_enable_dma,
>  	.set_bus_width			= sdhci_set_bus_width,
> -	.reset				= sdhci_reset,
> +	.reset				= amd_sdhci_reset,
>  	.set_uhs_signaling		= sdhci_set_uhs_signaling,
>  };
>  
> 

