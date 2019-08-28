Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F69C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3936A22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfH1NOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:14:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:60641 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1NOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:14:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 06:14:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="182025210"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2019 06:14:07 -0700
Subject: Re: [PATCH V6 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
References: <20190827003335.2494-1-benchuanggli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <99735a03-c698-624d-f5cf-4feed7e6a9ca@intel.com>
Date:   Wed, 28 Aug 2019 16:13:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827003335.2494-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/19 3:33 AM, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add support for the GL9750 and GL9755 chipsets.
> 
> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> tuning flow for GL9750.

Looks good, one minor comment

> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
> ---
>  drivers/mmc/host/Makefile         |   2 +-
>  drivers/mmc/host/sdhci-pci-core.c |   2 +
>  drivers/mmc/host/sdhci-pci-gli.c  | 354 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |   5 +
>  4 files changed, 362 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-gli.c
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 73578718f119..661445415090 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
> -				   sdhci-pci-dwc-mshc.o
> +				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 4154ee11b47d..e5835fbf73bc 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1682,6 +1682,8 @@ static const struct pci_device_id pci_ids[] = {
>  	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
>  	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
>  	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
> +	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
> +	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
>  	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>  	/* Generic SD host controller */
>  	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> new file mode 100644
> index 000000000000..d0ca3c60f8de
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Genesys Logic, Inc.
> + *
> + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *
> + * Version: v0.9.0 (2019-08-08)
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/pci.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/delay.h>
> +#include "sdhci.h"
> +#include "sdhci-pci.h"
> +
> +/*  Genesys Logic extra registers */
> +#define SDHCI_GLI_9750_WT         0x800
> +#define   SDHCI_GLI_9750_WT_EN      BIT(0)
> +#define   GLI_9750_WT_EN_ON	    0x1
> +#define   GLI_9750_WT_EN_OFF	    0x0
> +
> +#define SDHCI_GLI_9750_DRIVING      0x860
> +#define   SDHCI_GLI_9750_DRIVING_1    GENMASK(11, 0)
> +#define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
> +#define   GLI_9750_DRIVING_1_VALUE    0xFFF
> +#define   GLI_9750_DRIVING_2_VALUE    0x3
> +
> +#define SDHCI_GLI_9750_PLL	      0x864
> +#define   SDHCI_GLI_9750_PLL_TX2_INV    BIT(23)
> +#define   SDHCI_GLI_9750_PLL_TX2_DLY    GENMASK(22, 20)
> +#define   GLI_9750_PLL_TX2_INV_VALUE    0x1
> +#define   GLI_9750_PLL_TX2_DLY_VALUE    0x0
> +
> +#define SDHCI_GLI_9750_SW_CTRL      0x874
> +#define   SDHCI_GLI_9750_SW_CTRL_4    GENMASK(7, 6)
> +#define   GLI_9750_SW_CTRL_4_VALUE    0x3
> +
> +#define SDHCI_GLI_9750_MISC            0x878
> +#define   SDHCI_GLI_9750_MISC_TX1_INV    BIT(2)
> +#define   SDHCI_GLI_9750_MISC_RX_INV     BIT(3)
> +#define   SDHCI_GLI_9750_MISC_TX1_DLY    GENMASK(6, 4)
> +#define   GLI_9750_MISC_TX1_INV_VALUE    0x0
> +#define   GLI_9750_MISC_RX_INV_ON        0x1
> +#define   GLI_9750_MISC_RX_INV_OFF       0x0
> +#define   GLI_9750_MISC_RX_INV_VALUE     GLI_9750_MISC_RX_INV_OFF
> +#define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
> +
> +#define SDHCI_GLI_9750_TUNING_CONTROL	          0x540
> +#define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
> +#define   GLI_9750_TUNING_CONTROL_EN_ON             0x1
> +#define   GLI_9750_TUNING_CONTROL_EN_OFF            0x0
> +#define   SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1    BIT(16)
> +#define   SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2    GENMASK(20, 19)
> +#define   GLI_9750_TUNING_CONTROL_GLITCH_1_VALUE    0x1
> +#define   GLI_9750_TUNING_CONTROL_GLITCH_2_VALUE    0x2
> +
> +#define SDHCI_GLI_9750_TUNING_PARAMETERS           0x544
> +#define   SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY    GENMASK(2, 0)
> +#define   GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE    0x1
> +
> +#define GLI_MAX_TUNING_LOOP 40
> +
> +/* Genesys Logic chipset */
> +static inline void gl9750_wt_on(struct sdhci_host *host)
> +{
> +	u32 wt_value = 0;
> +	u32 wt_enable = 0;
> +
> +	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
> +	wt_enable = FIELD_GET(SDHCI_GLI_9750_WT_EN, wt_value);
> +
> +	if (wt_enable == GLI_9750_WT_EN_ON)
> +		return;
> +
> +	wt_value &= ~SDHCI_GLI_9750_WT_EN;
> +	wt_value |= FIELD_PREP(SDHCI_GLI_9750_WT_EN, GLI_9750_WT_EN_ON);
> +
> +	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
> +}
> +
> +static inline void gl9750_wt_off(struct sdhci_host *host)
> +{
> +	u32 wt_value = 0;
> +	u32 wt_enable = 0;
> +
> +	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
> +	wt_enable = FIELD_GET(SDHCI_GLI_9750_WT_EN, wt_value);
> +
> +	if (wt_enable == GLI_9750_WT_EN_OFF)
> +		return;
> +
> +	wt_value &= ~SDHCI_GLI_9750_WT_EN;
> +	wt_value |= FIELD_PREP(SDHCI_GLI_9750_WT_EN, GLI_9750_WT_EN_OFF);
> +
> +	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
> +}
> +
> +static void gli_set_9750(struct sdhci_host *host)
> +{
> +	u32 driving_value = 0;
> +	u32 pll_value = 0;
> +	u32 sw_ctrl_value = 0;
> +	u32 misc_value = 0;
> +	u32 parameter_value = 0;
> +	u32 control_value = 0;
> +
> +	u16 ctrl2 = 0;
> +
> +	gl9750_wt_on(host);
> +
> +	driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
> +	pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
> +	sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
> +	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +	parameter_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_PARAMETERS);
> +	control_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	driving_value &= ~(SDHCI_GLI_9750_DRIVING_1);
> +	driving_value &= ~(SDHCI_GLI_9750_DRIVING_2);
> +	driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_1,
> +				    GLI_9750_DRIVING_1_VALUE);
> +	driving_value |= FIELD_PREP(SDHCI_GLI_9750_DRIVING_2,
> +				    GLI_9750_DRIVING_2_VALUE);
> +	sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
> +
> +	sw_ctrl_value &= ~SDHCI_GLI_9750_SW_CTRL_4;
> +	sw_ctrl_value |= FIELD_PREP(SDHCI_GLI_9750_SW_CTRL_4,
> +				    GLI_9750_SW_CTRL_4_VALUE);
> +	sdhci_writel(host, sw_ctrl_value, SDHCI_GLI_9750_SW_CTRL);
> +
> +	/* reset the tuning flow after reinit and before starting tuning */
> +	pll_value &= ~SDHCI_GLI_9750_PLL_TX2_INV;
> +	pll_value &= ~SDHCI_GLI_9750_PLL_TX2_DLY;
> +	pll_value |= FIELD_PREP(SDHCI_GLI_9750_PLL_TX2_INV,
> +				GLI_9750_PLL_TX2_INV_VALUE);
> +	pll_value |= FIELD_PREP(SDHCI_GLI_9750_PLL_TX2_DLY,
> +				GLI_9750_PLL_TX2_DLY_VALUE);
> +
> +	misc_value &= ~SDHCI_GLI_9750_MISC_TX1_INV;
> +	misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;
> +	misc_value &= ~SDHCI_GLI_9750_MISC_TX1_DLY;
> +	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_TX1_INV,
> +				 GLI_9750_MISC_TX1_INV_VALUE);
> +	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
> +				 GLI_9750_MISC_RX_INV_VALUE);
> +	misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_TX1_DLY,
> +				 GLI_9750_MISC_TX1_DLY_VALUE);
> +
> +	parameter_value &= ~SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY;
> +	parameter_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY,
> +				      GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE);
> +
> +	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1;
> +	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2;
> +	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_1,
> +				    GLI_9750_TUNING_CONTROL_GLITCH_1_VALUE);
> +	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_GLITCH_2,
> +				    GLI_9750_TUNING_CONTROL_GLITCH_2_VALUE);
> +
> +	sdhci_writel(host, pll_value, SDHCI_GLI_9750_PLL);
> +	sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
> +
> +	/* disable tuned clk */
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +
> +	/* enable tuning parameters control */
> +	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_EN;
> +	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_EN,
> +				    GLI_9750_TUNING_CONTROL_EN_ON);
> +	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	/* write tuning parameters */
> +	sdhci_writel(host, parameter_value, SDHCI_GLI_9750_TUNING_PARAMETERS);
> +
> +	/* disable tuning parameters control */
> +	control_value &= ~SDHCI_GLI_9750_TUNING_CONTROL_EN;
> +	control_value |= FIELD_PREP(SDHCI_GLI_9750_TUNING_CONTROL_EN,
> +				    GLI_9750_TUNING_CONTROL_EN_OFF);
> +	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
> +
> +	/* clear tuned clk */
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
> +
> +	udelay(1);
> +
> +	gl9750_wt_off(host);
> +}
> +
> +static void gli_set_9750_rx_inv(struct sdhci_host *host, bool b)
> +{
> +	u32 misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +
> +	gl9750_wt_on(host);
> +
> +	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
> +	if (b) {
> +		misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;
> +		misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
> +					 GLI_9750_MISC_RX_INV_ON);
> +		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
> +	} else {
> +		misc_value &= ~SDHCI_GLI_9750_MISC_RX_INV;
> +		misc_value |= FIELD_PREP(SDHCI_GLI_9750_MISC_RX_INV,
> +					 GLI_9750_MISC_RX_INV_OFF);
> +		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
> +	}
> +
> +	gl9750_wt_off(host);
> +}
> +
> +static int __sdhci_execute_tuning_9750(struct sdhci_host *host, u32 opcode)
> +{
> +	int i;
> +	int rx_inv = 0;
> +
> +	for (rx_inv = 0; rx_inv < 2; rx_inv++) {
> +		if (rx_inv & 0x1)
> +			gli_set_9750_rx_inv(host, true);
> +		else
> +			gli_set_9750_rx_inv(host, false);
> +
> +		sdhci_start_tuning(host);
> +
> +		for (i = 0; i < GLI_MAX_TUNING_LOOP; i++) {
> +			u16 ctrl;
> +
> +			sdhci_send_tuning(host, opcode);
> +
> +			if (!host->tuning_done) {
> +				if (rx_inv == 1) {
> +					pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
> +						mmc_hostname(host->mmc));
> +					sdhci_abort_tuning(host, opcode);
> +					return -ETIMEDOUT;
> +				}
> +				sdhci_abort_tuning(host, opcode);
> +				break;
> +			}
> +
> +			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> +				if (ctrl & SDHCI_CTRL_TUNED_CLK)
> +					return 0; /* Success! */
> +				break;
> +			}
> +		}
> +	}
> +
> +	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> +		mmc_hostname(host->mmc));
> +	sdhci_reset_tuning(host);
> +	return -EAGAIN;
> +}
> +
> +static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	host->mmc->retune_period = 0;
> +	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
> +		host->mmc->retune_period = host->tuning_count;
> +
> +	gli_set_9750(host);
> +	host->tuning_err = __sdhci_execute_tuning_9750(host, opcode);
> +	sdhci_end_tuning(host);
> +
> +	return 0;
> +}
> +
> +static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
> +{
> +	struct sdhci_host *host = slot->host;
> +
> +	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
> +static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
> +{
> +	struct sdhci_host *host = slot->host;
> +
> +	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
> +static void sdhci_gli_voltage_switch(struct sdhci_host *host)
> +{
> +	usleep_range(5000, 5500);
> +}
> +
> +static void sdhci_gl9750_reset(struct sdhci_host *host, u8 mask)
> +{
> +	sdhci_reset(host, mask);
> +	gli_set_9750(host);
> +}
> +
> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS

Arguably CONFIG_MMC_SDHCI_IO_ACCESSORS needs to be removed altogether. i.e.
making the accessors always available.  So for now, I'd prefer to select
MMC_SDHCI_IO_ACCESSORS:

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 14d89a108edd..c3bd967d8a1a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
 	select IOSF_MBI if X86
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the PCI Secure Digital Host Controller Interface.
 	  Most controllers found today are PCI devices.

> +static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> +{
> +	u32 value;
> +
> +	value = readl(host->ioaddr + reg);
> +	if (unlikely(reg == SDHCI_MAX_CURRENT)) {
> +		if (!(value & 0xff))
> +			value |= 0xc8;
> +	}
> +	return value;
> +}
> +#endif
> +
> +static const struct sdhci_ops sdhci_gl9755_ops = {
> +	.set_clock		= sdhci_set_clock,
> +	.enable_dma		= sdhci_pci_enable_dma,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= sdhci_reset,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.voltage_switch		= sdhci_gli_voltage_switch,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_gl9755 = {
> +	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
> +	.probe_slot	= gli_probe_slot_gl9755,
> +	.ops            = &sdhci_gl9755_ops,
> +};
> +
> +static const struct sdhci_ops sdhci_gl9750_ops = {
> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> +	.read_l                 = sdhci_gl9750_readl,
> +#endif
> +	.set_clock		= sdhci_set_clock,
> +	.enable_dma		= sdhci_pci_enable_dma,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= sdhci_gl9750_reset,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.voltage_switch		= sdhci_gli_voltage_switch,
> +	.platform_execute_tuning = gl9750_execute_tuning,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_gl9750 = {
> +	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
> +	.probe_slot	= gli_probe_slot_gl9750,
> +	.ops            = &sdhci_gl9750_ops,
> +};
> +
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index e5dc6e44c7a4..738ba5afcc20 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -65,6 +65,9 @@
>  
>  #define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202
>  
> +#define PCI_DEVICE_ID_GLI_9755		0x9755
> +#define PCI_DEVICE_ID_GLI_9750		0x9750
> +
>  /*
>   * PCI device class and mask
>   */
> @@ -185,5 +188,7 @@ int sdhci_pci_enable_dma(struct sdhci_host *host);
>  extern const struct sdhci_pci_fixes sdhci_arasan;
>  extern const struct sdhci_pci_fixes sdhci_snps;
>  extern const struct sdhci_pci_fixes sdhci_o2;
> +extern const struct sdhci_pci_fixes sdhci_gl9750;
> +extern const struct sdhci_pci_fixes sdhci_gl9755;
>  
>  #endif /* __SDHCI_PCI_H */
> 

