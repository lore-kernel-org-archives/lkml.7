Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0682C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC042075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDPEsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:48:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:59582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfDPEsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:48:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2401AF40;
        Tue, 16 Apr 2019 04:48:29 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Tue, 16 Apr 2019 14:47:29 +1000
Subject: [PATCH 4/5] mmc: mtk-sd: enable internal card-detect logic.
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155539004931.25108.17076624786044710325.stgit@noble.brown>
In-Reply-To: <155538933003.25108.3338569916935462285.stgit@noble.brown>
References: <155538933003.25108.3338569916935462285.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk-sd silicon has integrated card-detect logic that is
enabled, at least, on the MT7621 as used in the GNUBEE NAS.

If the sdhci isn't marked non-removable and doesn't have a
cd-gpio configured, assume the internal cd logic should be used.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/mtk-sd.c |   58 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d379f2ece305..341cf5f03429 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -300,6 +300,8 @@
 #define CMD_TIMEOUT         (HZ/10 * 5)	/* 100ms x5 */
 #define DAT_TIMEOUT         (HZ    * 5)	/* 1000ms x5 */
 
+#define DEFAULT_DEBOUNCE	(8)	/* 8 cycles CD debounce */
+
 #define PAD_DELAY_MAX	32 /* PAD delay cells */
 /*--------------------------------------------------------------------------*/
 /* Descriptor Structure                                                     */
@@ -430,6 +432,7 @@ struct msdc_host {
 	bool hs400_cmd_resp_sel_rising;
 				 /* cmd response sample selection for HS400 */
 	bool hs400_mode;	/* current eMMC will run at hs400 mode */
+	bool internal_cd;	/* Use internal card-detect logic */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
@@ -1430,6 +1433,11 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 			sdio_signal_irq(host->mmc);
 		}
 
+		if ((events & event_mask) & MSDC_INT_CDSC) {
+			mmc_detect_change(host->mmc, msecs_to_jiffies(20));
+			events &= ~MSDC_INT_CDSC;
+		}
+
 		if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
 			break;
 
@@ -1463,14 +1471,24 @@ static void msdc_init_hw(struct msdc_host *host)
 	/* Reset */
 	msdc_reset_hw(host);
 
-	/* Disable card detection */
-	sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
-
 	/* Disable and clear all interrupts */
 	writel(0, host->base + MSDC_INTEN);
 	val = readl(host->base + MSDC_INT);
 	writel(val, host->base + MSDC_INT);
 
+	/* Configure card detection */
+	if (host->internal_cd) {
+		sdr_set_field(host->base + MSDC_PS, MSDC_PS_CDDEBOUNCE,
+			      DEFAULT_DEBOUNCE);
+		sdr_set_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
+		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_CDSC);
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_INSWKUP);
+	} else {
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_INSWKUP);
+		sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
+		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_CDSC);
+	}
+
 	if (host->top_base) {
 		writel(0, host->top_base + EMMC_TOP_CONTROL);
 		writel(0, host->top_base + EMMC_TOP_CMD);
@@ -1580,6 +1598,11 @@ static void msdc_init_hw(struct msdc_host *host)
 static void msdc_deinit_hw(struct msdc_host *host)
 {
 	u32 val;
+
+	/* Disabled card-detect */
+	sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
+	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_INSWKUP);
+
 	/* Disable and clear all interrupts */
 	writel(0, host->base + MSDC_INTEN);
 
@@ -2078,13 +2101,31 @@ static void msdc_ack_sdio_irq(struct mmc_host *mmc)
 	__msdc_enable_sdio_irq(mmc, 1);
 }
 
+static int msdc_get_cd(struct mmc_host *mmc)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	int val;
+
+	if (mmc->caps & MMC_CAP_NONREMOVABLE)
+		return 1;
+
+	if (!host->internal_cd)
+		return mmc_gpio_get_cd(mmc);
+
+	val = readl(host->base + MSDC_PS) & MSDC_PS_CDSTS;
+	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
+		return !!val;
+	else
+		return !val;
+}
+
 static const struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
 	.request = msdc_ops_request,
 	.set_ios = msdc_ops_set_ios,
 	.get_ro = mmc_gpio_get_ro,
-	.get_cd = mmc_gpio_get_cd,
+	.get_cd = msdc_get_cd,
 	.enable_sdio_irq = msdc_enable_sdio_irq,
 	.ack_sdio_irq = msdc_ack_sdio_irq,
 	.start_signal_voltage_switch = msdc_ops_switch_volt,
@@ -2206,6 +2247,15 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		goto host_free;
 	}
 
+	if (!(mmc->caps & MMC_CAP_NONREMOVABLE) &&
+	    !mmc_can_gpio_cd(mmc)) {
+		/*
+		 * Is removable but no GPIO declared, so
+		 * use internal functionality.
+		 */
+		host->internal_cd = true;
+	}
+
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;


