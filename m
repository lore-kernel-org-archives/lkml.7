Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B59C32755
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E0020865
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNVe5cll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438906AbfIWKIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:08:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39911 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405389AbfIWKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:08:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so13233408wrj.6;
        Mon, 23 Sep 2019 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGzE/JEJtt+rvm91KEZllp8C2a/sv8MDOECcgYTWrp4=;
        b=qNVe5cllZXwIgGgc+Y49JzgZFlBGYqVrqy320/XyQvq4D0adVk/p3rfM6gn8QmIMhm
         rVcfW7q1L8aWD4sGnyPqcuK4vdR3HGR1lR1dd4QwSHNUWoqh98sy7tuOW3vmRyKnO/MB
         kubCtIQl7hsf7+7t2QQdDs5enciQ54XvdJLsc22RHhPfpPqGB6bgzUCMmQ8mce+dVi5B
         DVHsPm3tNxA6ePwv9f565008d5CVENcU88Dng66L6sPchTuhAV0NU92DaICWWPz03ig2
         ifSz9Q0mh6e/oiqcFuZfnm4H91fjQSXi/qUcUH5fRsEhUAw6TLbg5aVXvuNMmrBScGlT
         kjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGzE/JEJtt+rvm91KEZllp8C2a/sv8MDOECcgYTWrp4=;
        b=ggKwuLSR0PJrZBMpPD4ybAdQ9Uoe8d0lZQE2vW/4akxG3St0jL5J4VmvKOVh5EZX8k
         mARaeLYB1FucQiAAlldORmTQxTTxJaE+XjvZSE9PQ50XRf7TYqPyiHAOOSICox/Slkp1
         +GCyhrbKm3ECsUpHT5R6OZB9WNv8PReDZAvW4rn9Cy2VQv3FjwU21J42b8P2wjcYSBBk
         ELWZ9k04vtBl1qWtzsfIxR9dFNgHnbOAaCJTQzLhrnaQBhmNSKtluUlawLCsUizv0HEw
         71D+GhIasDFvRPdJC5waDQfY3NqbIg0N57uQyyFcJvm0wmsBlERg//hV+vq/faNp0SSW
         wp/Q==
X-Gm-Message-State: APjAAAWQ/lxfERgOH7ivXNjlxfukj1gH+23SENSGN9OD4ul0OjDDwWWY
        1LLG+gNtzXDKdkioG5z3fOQ=
X-Google-Smtp-Source: APXvYqzAKeHpn5DdsVoIdn0Rnwpwx7oDjkyyi5edbCPKTyjYii+IQjWIzOl/pB4FprjKwdj4Myl3qQ==
X-Received: by 2002:adf:f606:: with SMTP id t6mr20253689wrp.197.1569233294337;
        Mon, 23 Sep 2019 03:08:14 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id y13sm13796985wrg.8.2019.09.23.03.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:08:13 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mmc: tegra: Implement ->set_dma_mask()
Date:   Mon, 23 Sep 2019 12:08:10 +0200
Message-Id: <20190923100810.12698-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923100810.12698-1-thierry.reding@gmail.com>
References: <20190923100810.12698-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolin Chen <nicoleotsuka@gmail.com>

The SDHCI controller on Tegra186 supports 40-bit addressing, which is
usually enough to address all of system memory. However, if the SDHCI
controller is behind an IOMMU, the address space can go beyond. This
happens on Tegra186 and later where the ARM SMMU has an input address
space of 48 bits. If the DMA API is backed by this ARM SMMU, the top-
down IOVA allocator will cause IOV addresses to be returned that the
SDHCI controller cannot access.

Unfortunately, prior to the introduction of the ->set_dma_mask() host
operation, the SDHCI core would set either a 64-bit DMA mask if the
controller claimed to support 64-bit addressing, or a 32-bit DMA mask
otherwise.

Since the full 64 bits cannot be addressed on Tegra, this had to be
worked around in commit 68481a7e1c84 ("mmc: tegra: Mark 64 bit dma
broken on Tegra186") by setting the SDHCI_QUIRK2_BROKEN_64_BIT_DMA
quirk, which effectively restricts the DMA mask to 32 bits.

One disadvantage of this is that dma_map_*() APIs will now try to use
the swiotlb to bounce DMA to addresses beyond of the controller's DMA
mask. This in turn caused degraded performance and can lead to
situations where the swiotlb buffer is exhausted, which in turn leads
to DMA transfers to fail.

With the recent introduction of the ->set_dma_mask() host operation,
this can now be properly fixed. For each generation of Tegra, the exact
supported DMA mask can be configured. This kills two birds with one
stone: it avoids the use of bounce buffers because system memory never
exceeds the addressable memory range of the SDHCI controllers on these
devices, and at the same time when an IOMMU is involved, it prevents
IOV addresses from being allocated beyond the addressible range of the
controllers.

Since the DMA mask is now properly handled, the 64-bit DMA quirk can be
removed.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
[treding@nvidia.com: provide more background in commit message]
Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add Tested-by from Nicolin, Acked-by from Adrian

 drivers/mmc/host/sdhci-tegra.c | 48 ++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 02d8f524bb9e..7bc950520fd9 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -104,6 +105,7 @@
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
+	u64 dma_mask;
 	u32 nvquirks;
 	u8 min_tap_delay;
 	u8 max_tap_delay;
@@ -1233,11 +1235,25 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
 	.update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
 };
 
+static int tegra_sdhci_set_dma_mask(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *platform = sdhci_priv(host);
+	struct sdhci_tegra *tegra = sdhci_pltfm_priv(platform);
+	const struct sdhci_tegra_soc_data *soc = tegra->soc_data;
+	struct device *dev = mmc_dev(host->mmc);
+
+	if (soc->dma_mask)
+		return dma_set_mask_and_coherent(dev, soc->dma_mask);
+
+	return 0;
+}
+
 static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
+	.set_dma_mask = tegra_sdhci_set_dma_mask,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
@@ -1257,6 +1273,7 @@ static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
 	.pdata = &sdhci_tegra20_pdata,
+	.dma_mask = DMA_BIT_MASK(32),
 	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
 		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
 };
@@ -1283,6 +1300,7 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.pdata = &sdhci_tegra30_pdata,
+	.dma_mask = DMA_BIT_MASK(32),
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104 |
@@ -1295,6 +1313,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.write_w    = tegra_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
+	.set_dma_mask = tegra_sdhci_set_dma_mask,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
@@ -1316,6 +1335,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
@@ -1325,22 +1345,13 @@ static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
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
+	.dma_mask = DMA_BIT_MASK(34),
 };
 
 static const struct sdhci_ops tegra210_sdhci_ops = {
@@ -1349,6 +1360,7 @@ static const struct sdhci_ops tegra210_sdhci_ops = {
 	.write_w    = tegra210_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
+	.set_dma_mask = tegra_sdhci_set_dma_mask,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
@@ -1369,6 +1381,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
+	.dma_mask = DMA_BIT_MASK(34),
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
 		    NVQUIRK_HAS_PADCALIB |
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
@@ -1383,6 +1396,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
+	.set_dma_mask = tegra_sdhci_set_dma_mask,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
@@ -1398,20 +1412,13 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
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
+	.dma_mask = DMA_BIT_MASK(40),
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
 		    NVQUIRK_HAS_PADCALIB |
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
@@ -1424,6 +1431,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
 	.pdata = &sdhci_tegra186_pdata,
+	.dma_mask = DMA_BIT_MASK(39),
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
 		    NVQUIRK_HAS_PADCALIB |
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
-- 
2.23.0

