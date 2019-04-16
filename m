Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91368C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658942075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfDPEsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:48:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:59614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfDPEsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:48:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E29BEAF40;
        Tue, 16 Apr 2019 04:48:35 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Tue, 16 Apr 2019 14:47:29 +1000
Subject: [PATCH 5/5] mmc: mtk-sd: enable internal write-protect logic.
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155539004934.25108.642381572389480964.stgit@noble.brown>
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

The mtk-sd silicon has integrated write-protect detection logic.

If the sdhci isn't marked no-write-protect and doesn't have a
ro-gpio configured, assume the internal wp logic should be used.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/host/mtk-sd.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 341cf5f03429..d63d6b62f49a 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -433,6 +433,7 @@ struct msdc_host {
 				 /* cmd response sample selection for HS400 */
 	bool hs400_mode;	/* current eMMC will run at hs400 mode */
 	bool internal_cd;	/* Use internal card-detect logic */
+	bool internal_ro;	/* Use internal write-protect logic */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 	struct msdc_tune_para def_tune_para; /* default tune setting */
 	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
@@ -2119,12 +2120,30 @@ static int msdc_get_cd(struct mmc_host *mmc)
 		return !val;
 }
 
+static int msdc_get_ro(struct mmc_host *mmc)
+{
+	struct msdc_host *host = mmc_priv(mmc);
+	int val;
+
+	if (mmc->caps2 & MMC_CAP2_NO_WRITE_PROTECT)
+		return 0;
+
+	if (!host->internal_ro)
+		return mmc_gpio_get_ro(mmc);
+
+	val = readl(host->base + MSDC_PS) & MSDC_PS_WP;
+	if (mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH)
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
-	.get_ro = mmc_gpio_get_ro,
+	.get_ro = msdc_get_ro,
 	.get_cd = msdc_get_cd,
 	.enable_sdio_irq = msdc_enable_sdio_irq,
 	.ack_sdio_irq = msdc_ack_sdio_irq,
@@ -2256,6 +2275,15 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		host->internal_cd = true;
 	}
 
+	if (!(mmc->caps2 & MMC_CAP2_NO_WRITE_PROTECT) &&
+	    !mmc_can_gpio_ro(mmc)) {
+		/*
+		 * Has write-protect but no GPIO declared, so
+		 * use internal functionality.
+		 */
+		host->internal_ro = true;
+	}
+
 	msdc_of_property_parse(pdev, host);
 
 	host->dev = &pdev->dev;


