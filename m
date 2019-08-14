Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8565EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B265205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg6kl5Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfHNA4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:56:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36788 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfHNA4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:56:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so1746150pfi.3;
        Tue, 13 Aug 2019 17:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yd9YckEjmHyzuO2k/bJAhB54mNRDAVacBG/r+Hq6cX0=;
        b=Wg6kl5HyD40ncNWCXvdCr2PGdFKf3GGQ0odLxgedcdM9cPBkJo7av4R+uUIFkMRXJX
         JOsWv0H0N4MFVqTAMofDfPDSRrsIE9hIK6LnODezCQFYfVW6u32e/2t6dUke7sbUPN8M
         YJ5WUL+NC+PtPdMNbpYwmDmN2MAZxQbJGBVGVNhxPkDe5S6I/gKIzgaN4CsftxzMglm2
         F6rbxwtplfK+yPxASD040awcZZo+FNzfExBd7WzZLyDXsPAN6I7Xcqt7A3d45vWW+T9o
         dAtYiZ2im1EODkwz2cCaPSpaOVEX7qyCmtLSeBzPIeLiIQVVK69WWpBm+LS8GbFnFJke
         eeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yd9YckEjmHyzuO2k/bJAhB54mNRDAVacBG/r+Hq6cX0=;
        b=tLVe7jZYoCE+LMIlLFJl72ExjuceBBCpLYa2e30BCWoFV3Hicj+XolBbbufL4zK3vS
         4hjNnw3vZ+LX4TZsKAGDkyCr3lJ6XdXvi2+jWCiDIL1l7VW+wKhvoCbGYZgCK88YN99a
         icXkIwnaGV4NkwzbM6bh/1xZQghLj8pZkocWoob6ho5vGztmpLMrCOnZ0Lv7BhyREc41
         Ifr3A3MsN5t6usw+Rl+7SsV8c2InXP2Q5zX/JXIncwrvObrgqxQFp79LNYKlbOUK+yXo
         B/HG07Cs8LnSbGeeX73raCjm7zSgiTYLdv9Lpn242gK0xWyjhWVCTo2kPyjwGxdQR3lu
         /F5w==
X-Gm-Message-State: APjAAAVrPOfwiQVKmA2d8FiJaIqIrJgrDX0liOeoS1waC5nje70BA5Lx
        CANAMFFSB/Pbg4/ovff9ktI=
X-Google-Smtp-Source: APXvYqw7AVhOBMa6nguYuGGN9Wx2r9pmAWHS5ii6sAcWs0NWBvK2z8TbuCGQkWvfE7bAJgW/+epm6w==
X-Received: by 2002:a63:4a51:: with SMTP id j17mr36573371pgl.284.1565744202379;
        Tue, 13 Aug 2019 17:56:42 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id s24sm75567356pgm.3.2019.08.13.17.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 17:56:41 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, vdumpa@nvidia.com
Subject: [PATCH v2] mmc: tegra: Implement enable_dma() to set dma_mask
Date:   Tue, 13 Aug 2019 17:57:41 -0700
Message-Id: <20190814005741.13331-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Integrated the change and commit message made by Thierry Reding ]

The SDHCI controller found in early Tegra SoCs (from Tegra20 through
Tegra114) used an AHB interface to the memory controller, which allowed
only 32 bits of memory to be addressed.

Starting with Tegra124, this limitation was removed by making the SDHCI
controllers native MCCIF clients, which means that they got increased
bandwidth and better arbitration to the memory controller as well as an
address range extended to 40 bits, out of which only 34 were actually
used (bits 34-39 are tied to 0 in the controller).

For Tegra186, all of the 40 bits can be used; For Tegra194, 39-bit can
be used.

So far, sdhci-tegra driver has been relying on sdhci core to configure
the DMA_BIT_MASK between 32-bit or 64-bit, using one of quirks2 flags:
SDHCI_QUIRK2_BROKEN_64_BIT_DMA. However, there is a common way, being
mentioned in sdhci.c file, to set dma_mask via enable_dma() callback in
the device driver directly.

So this patch implements an enable_dma() callback in the sdhci-tegra,
in order to set an accurate DMA_BIT_MASK, other than just 32/64 bits.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v1->v2:
 * Applied to older SoC, suggested by Thierry.
 * Note that only Tegra210, Tegra186 and Tegra194 are tested.

 drivers/mmc/host/sdhci-tegra.c | 48 ++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f4d4761cf20a..6156ffb145cd 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -16,6 +16,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/dma-mapping.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -104,6 +105,7 @@
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
+	u64 dma_bit_mask;
 	u32 nvquirks;
 	u8 min_tap_delay;
 	u8 max_tap_delay;
@@ -749,6 +751,19 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+static int tegra_sdhci_enable_dma(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
+	struct device *dev = mmc_dev(host->mmc);
+
+	if (soc_data->dma_bit_mask)
+		return dma_set_mask_and_coherent(dev, soc_data->dma_bit_mask);
+
+	return 0;
+}
+
 static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1228,6 +1243,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
+	.enable_dma = tegra_sdhci_enable_dma,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
@@ -1246,6 +1262,7 @@ static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
 	.pdata = &sdhci_tegra20_pdata,
+	.dma_bit_mask = DMA_BIT_MASK(32),
 	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
 		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
 };
@@ -1272,6 +1289,7 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.pdata = &sdhci_tegra30_pdata,
+	.dma_bit_mask = DMA_BIT_MASK(32),
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
@@ -1284,6 +1302,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
+	.enable_dma = tegra_sdhci_enable_dma,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
@@ -1304,6 +1323,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
+	.dma_bit_mask = DMA_BIT_MASK(32),
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
@@ -1313,22 +1333,13 @@ static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   /*
-		    * The TRM states that the SD/MMC controller found on
-		    * Tegra124 can address 34 bits (the maximum supported by
-		    * the Tegra memory controller), but tests show that DMA
-		    * to or from above 4 GiB doesn't work. This is possibly
-		    * caused by missing programming, though it's not obvious
-		    * what sequence is required. Mark 64-bit DMA broken for
-		    * now to fix this for existing users (e.g. Nyan boards).
-		    */
-		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops  = &tegra114_sdhci_ops,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 	.pdata = &sdhci_tegra124_pdata,
+	.dma_bit_mask = DMA_BIT_MASK(34),
 };
 
 static const struct sdhci_ops tegra210_sdhci_ops = {
@@ -1337,6 +1348,7 @@ static const struct sdhci_ops tegra210_sdhci_ops = {
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
+	.enable_dma = tegra_sdhci_enable_dma,
 	.reset      = tegra_sdhci_reset,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.voltage_switch = tegra_sdhci_voltage_switch,
@@ -1356,6 +1368,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
+	.dma_bit_mask = DMA_BIT_MASK(34),
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
 		    NVQUIRK_HAS_PADCALIB |
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
@@ -1370,6 +1383,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
+	.enable_dma = tegra_sdhci_enable_dma,
 	.reset      = tegra_sdhci_reset,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.voltage_switch = tegra_sdhci_voltage_switch,
@@ -1384,20 +1398,13 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   /* SDHCI controllers on Tegra186 support 40-bit addressing.
-		    * IOVA addresses are 48-bit wide on Tegra186.
-		    * With 64-bit dma mask used for SDHCI, accesses can
-		    * be broken. Disable 64-bit dma, which would fall back
-		    * to 32-bit dma mask. Ideally 40-bit dma mask would work,
-		    * But it is not supported as of now.
-		    */
-		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops  = &tegra186_sdhci_ops,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 	.pdata = &sdhci_tegra186_pdata,
+	.dma_bit_mask = DMA_BIT_MASK(40),
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
 		    NVQUIRK_HAS_PADCALIB |
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
@@ -1410,6 +1417,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
 	.pdata = &sdhci_tegra186_pdata,
+	.dma_bit_mask = DMA_BIT_MASK(39),
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
 		    NVQUIRK_HAS_PADCALIB |
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
-- 
2.17.1

