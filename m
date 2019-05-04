Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C463C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491A32086A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfEDKZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:25:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbfEDKZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:25:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29B7CAF03;
        Sat,  4 May 2019 10:25:55 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Sat, 04 May 2019 20:24:56 +1000
Subject: [PATCH 2/4] mmc: mtk-sd: add support for config found in mt7620
 family SOCs.
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155696549676.8632.14384982012480111613.stgit@noble.brown>
In-Reply-To: <155696540998.8632.5242582397805128125.stgit@noble.brown>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
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
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1 +
 drivers/mmc/host/mtk-sd.c                        |   12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index 91a2ec59e497..8a532f4453f2 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -16,6 +16,7 @@ Required properties:
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 	"mediatek,mt7622-mmc": for MT7622 SoC
 	"mediatek,mt7623-mmc", "mediatek,mt2701-mmc": for MT7623 SoC
+	"mediatek,mt7620-mmc", for MT7621 SoC (and others)
 
 - reg: physical base address of the controller and length
 - interrupts: Should contain MSDC interrupt number
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 469d4a717175..0c2be4f54b1f 100644
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
+	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);


