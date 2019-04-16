Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B64C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105362075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDPEs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:48:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:59548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfDPEsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:48:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC756AFDB;
        Tue, 16 Apr 2019 04:48:22 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Tue, 16 Apr 2019 14:47:29 +1000
Subject: [PATCH 3/5] mmc: mtk-sd: add support for config found in mt7620
 family SOCs.
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155539004927.25108.8723794030985494935.stgit@noble.brown>
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

mt7620 family MIPS SOCs contain the mtk-sd silicon.
Add support for this.

Signed-off-by: NeilBrown <neil@brown.name>

# Conflicts:
#	drivers/mmc/host/mtk-sd.c
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1 +
 drivers/mmc/host/mtk-sd.c                        |   12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index ed61cd5a5b8f..b6daa9773b25 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -15,6 +15,7 @@ Required properties:
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 	"mediatek,mt7622-mmc": for MT7622 SoC
 	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
+	"ralink,mt7620-sdhci", for MT7621 SoC (and others)
 
 - reg: physical base address of the controller and length
 - interrupts: Should contain MSDC interrupt number
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 14e048239143..d379f2ece305 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -517,6 +517,17 @@ static const struct mtk_mmc_compatible mt8516_compat = {
 	.stop_clk_fix = true,
 };
 
+static const struct mtk_mmc_compatible mt7620_compat = {
+	.clk_div_bits = 8,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE,
+	.async_fifo = false,
+	.data_tune = false,
+	.busy_check = false,
+	.stop_clk_fix = false,
+	.enhance_rx = false,
+};
+
 static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
@@ -525,6 +536,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
 	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
 	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
+	{ .compatible = "ralink,mt7620-sdhci", .data = &mt7620_compat},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);


