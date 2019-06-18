Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3613C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EF220665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfFRG6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:58:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:62901 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFRG6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:58:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 23:58:04 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga008.jf.intel.com with ESMTP; 17 Jun 2019 23:58:02 -0700
Subject: Re: [PATCH v2 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller
 supports 8-bit width
To:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20190617201014.84503-1-rrangel@chromium.org>
 <20190617201014.84503-2-rrangel@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <866e6b54-7e4b-472d-7134-e322b2f0810e@intel.com>
Date:   Tue, 18 Jun 2019 09:56:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617201014.84503-2-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/19 11:10 PM, Raul E Rangel wrote:
> The O2 controller supports 8-bit EMMC access.
> 
> JESD84-B51 section A.6.3.a defines the bus testing procedure that
> `mmc_select_bus_width()` implements. This is used to determine the actual
> bus width of the eMMC.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> I tested this on an AMD chromebook.
> 
> $ cat /sys/kernel/debug/mmc1/ios
> clock:          200000000 Hz
> actual clock:   200000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> 
> Before this patch only 4 bit was negotiated.
> 
>  drivers/mmc/host/sdhci-pci-o2micro.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index dd21315922c87..9dc4548271b4b 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -395,11 +395,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_pci_chip *chip;
>  	struct sdhci_host *host;
> -	u32 reg;
> +	u32 reg, caps;
>  	int ret;
>  
>  	chip = slot->chip;
>  	host = slot->host;
> +
> +	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +
> +	/*
> +	 * mmc_select_bus_width() will test the bus to determine the actual bus
> +	 * width.
> +	 */
> +	if (caps & SDHCI_CAN_DO_8BIT)
> +		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +
>  	switch (chip->pdev->device) {
>  	case PCI_DEVICE_ID_O2_SDS0:
>  	case PCI_DEVICE_ID_O2_SEABIRD0:
> 

