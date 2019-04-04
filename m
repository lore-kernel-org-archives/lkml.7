Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F248DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ADE20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfDDDv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:51:28 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:48596 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfDDDv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:51:28 -0400
Received: from sugar.zhang?rock-chips.com (unknown [192.168.167.228])
        by regular1.263xmail.com (Postfix) with ESMTP id 47DA43E9;
        Thu,  4 Apr 2019 11:51:25 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P10068T139956624271104S1554349882632874_;
        Thu, 04 Apr 2019 11:51:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <884880fc7e9e10ed45848acbefede9f0>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     heiko@sntech.de, broonie@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: [PATCH v1 06/12] ASoC: rockchip: pdm: fixup pdm fractional div
Date:   Thu,  4 Apr 2019 11:51:09 +0800
Message-Id: <1554349869-23623-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support fractional div for rk3308.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_pdm.c | 172 ++++++++++++++++++++++++++++----------
 sound/soc/rockchip/rockchip_pdm.h |   9 ++
 2 files changed, 139 insertions(+), 42 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index c50494b..4f93a74 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -17,14 +17,23 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/rational.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 
 #include "rockchip_pdm.h"
 
 #define PDM_DMA_BURST_SIZE	(8) /* size * width: 8*4 = 32 bytes */
+#define PDM_SIGNOFF_CLK_RATE	(100000000)
+
+enum rk_pdm_version {
+	RK_PDM_RK3229,
+	RK_PDM_RK3308,
+};
 
 struct rk_pdm_dev {
 	struct device *dev;
@@ -32,22 +41,51 @@ struct rk_pdm_dev {
 	struct clk *hclk;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
+	struct reset_control *reset;
+	enum rk_pdm_version version;
 };
 
 struct rk_pdm_clkref {
 	unsigned int sr;
 	unsigned int clk;
+	unsigned int clk_out;
+};
+
+struct rk_pdm_ds_ratio {
+	unsigned int ratio;
+	unsigned int sr;
 };
 
 static struct rk_pdm_clkref clkref[] = {
-	{ 8000, 40960000 },
-	{ 11025, 56448000 },
-	{ 12000, 61440000 },
+	{ 8000, 40960000, 2048000 },
+	{ 11025, 56448000, 2822400 },
+	{ 12000, 61440000, 3072000 },
+	{ 8000, 98304000, 2048000 },
+	{ 12000, 98304000, 3072000 },
+};
+
+static struct rk_pdm_ds_ratio ds_ratio[] = {
+	{ 0, 192000 },
+	{ 0, 176400 },
+	{ 0, 128000 },
+	{ 1, 96000 },
+	{ 1, 88200 },
+	{ 1, 64000 },
+	{ 2, 48000 },
+	{ 2, 44100 },
+	{ 2, 32000 },
+	{ 3, 24000 },
+	{ 3, 22050 },
+	{ 3, 16000 },
+	{ 4, 12000 },
+	{ 4, 11025 },
+	{ 4, 8000 },
 };
 
-static unsigned int get_pdm_clk(unsigned int sr)
+static unsigned int get_pdm_clk(struct rk_pdm_dev *pdm, unsigned int sr,
+				unsigned int *clk_src, unsigned int *clk_out)
 {
-	unsigned int i, count, clk, div;
+	unsigned int i, count, clk, div, rate;
 
 	clk = 0;
 	if (!sr)
@@ -59,14 +97,39 @@ static unsigned int get_pdm_clk(unsigned int sr)
 			continue;
 		div = sr / clkref[i].sr;
 		if ((div & (div - 1)) == 0) {
+			*clk_out = clkref[i].clk_out;
+			rate = clk_round_rate(pdm->clk, clkref[i].clk);
+			if (rate != clkref[i].clk)
+				continue;
 			clk = clkref[i].clk;
+			*clk_src = clkref[i].clk;
 			break;
 		}
 	}
 
+	if (!clk) {
+		clk = clk_round_rate(pdm->clk, PDM_SIGNOFF_CLK_RATE);
+		*clk_src = clk;
+	}
 	return clk;
 }
 
+static unsigned int get_pdm_ds_ratio(unsigned int sr)
+{
+	unsigned int i, count, ratio;
+
+	ratio = 0;
+	if (!sr)
+		return ratio;
+
+	count = ARRAY_SIZE(ds_ratio);
+	for (i = 0; i < count; i++) {
+		if (sr == ds_ratio[i].sr)
+			ratio = ds_ratio[i].ratio;
+	}
+	return ratio;
+}
+
 static inline struct rk_pdm_dev *to_info(struct snd_soc_dai *dai)
 {
 	return snd_soc_dai_get_drvdata(dai);
@@ -95,40 +158,52 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 	struct rk_pdm_dev *pdm = to_info(dai);
 	unsigned int val = 0;
 	unsigned int clk_rate, clk_div, samplerate;
+	unsigned int clk_src, clk_out;
+	unsigned long m, n;
+	bool change;
 	int ret;
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
 	samplerate = params_rate(params);
-	clk_rate = get_pdm_clk(samplerate);
+	clk_rate = get_pdm_clk(pdm, samplerate, &clk_src, &clk_out);
 	if (!clk_rate)
 		return -EINVAL;
 
-	ret = clk_set_rate(pdm->clk, clk_rate);
+	ret = clk_set_rate(pdm->clk, clk_src);
 	if (ret)
 		return -EINVAL;
 
-	clk_div = DIV_ROUND_CLOSEST(clk_rate, samplerate);
-
-	switch (clk_div) {
-	case 320:
-		val = PDM_CLK_320FS;
-		break;
-	case 640:
-		val = PDM_CLK_640FS;
-		break;
-	case 1280:
-		val = PDM_CLK_1280FS;
-		break;
-	case 2560:
-		val = PDM_CLK_2560FS;
-		break;
-	case 5120:
-		val = PDM_CLK_5120FS;
-		break;
-	default:
-		dev_err(pdm->dev, "unsupported div: %d\n", clk_div);
-		return -EINVAL;
+	if (pdm->version == RK_PDM_RK3308) {
+		rational_best_approximation(clk_out, clk_src,
+					    GENMASK(16 - 1, 0),
+					    GENMASK(16 - 1, 0),
+					    &m, &n);
+
+		val = (m << PDM_FD_NUMERATOR_SFT) |
+			(n << PDM_FD_DENOMINATOR_SFT);
+		regmap_update_bits_check(pdm->regmap, PDM_CTRL1,
+					 PDM_FD_NUMERATOR_MSK |
+					 PDM_FD_DENOMINATOR_MSK,
+					 val, &change);
+		if (change) {
+			reset_control_assert(pdm->reset);
+			reset_control_deassert(pdm->reset);
+			rockchip_pdm_rxctrl(pdm, 0);
+		}
+		clk_div = n / m;
+		if (clk_div >= 40)
+			val = PDM_CLK_FD_RATIO_40;
+		else if (clk_div <= 35)
+			val = PDM_CLK_FD_RATIO_35;
+		else
+			return -EINVAL;
+		regmap_update_bits(pdm->regmap, PDM_CLK_CTRL,
+				   PDM_CLK_FD_RATIO_MSK,
+				   val);
 	}
-
+	val = get_pdm_ds_ratio(samplerate);
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, PDM_DS_RATIO_MSK, val);
 	regmap_update_bits(pdm->regmap, PDM_HPF_CTRL,
 			   PDM_HPF_CF_MSK, PDM_HPF_60HZ);
@@ -177,13 +252,11 @@ static int rockchip_pdm_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
-		regmap_update_bits(pdm->regmap, PDM_CTRL0,
-				   PDM_PATH_MSK | PDM_VDW_MSK,
-				   val);
-		regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
-				   PDM_DMA_RDL(16));
-	}
+	regmap_update_bits(pdm->regmap, PDM_CTRL0,
+			   PDM_PATH_MSK | PDM_VDW_MSK,
+			   val);
+	regmap_update_bits(pdm->regmap, PDM_DMA_CTRL, PDM_DMA_RDL_MSK,
+			   PDM_DMA_RDL(16));
 
 	return 0;
 }
@@ -380,8 +453,19 @@ static const struct regmap_config rockchip_pdm_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
+static const struct of_device_id rockchip_pdm_match[] = {
+	{ .compatible = "rockchip,pdm", },
+	{ .compatible = "rockchip,px30-pdm",
+	  .data = (void *)RK_PDM_RK3308 },
+	{ .compatible = "rockchip,rk3308-pdm",
+	  .data = (void *)RK_PDM_RK3308 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rockchip_pdm_match);
+
 static int rockchip_pdm_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct rk_pdm_dev *pdm;
 	struct resource *res;
 	void __iomem *regs;
@@ -391,6 +475,16 @@ static int rockchip_pdm_probe(struct platform_device *pdev)
 	if (!pdm)
 		return -ENOMEM;
 
+	match = of_match_device(rockchip_pdm_match, &pdev->dev);
+	if (match)
+		pdm->version = (enum rk_pdm_version)match->data;
+
+	if (pdm->version == RK_PDM_RK3308) {
+		pdm->reset = devm_reset_control_get(&pdev->dev, "pdm-m");
+		if (IS_ERR(pdm->reset))
+			return PTR_ERR(pdm->reset);
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(regs))
@@ -503,12 +597,6 @@ static const struct dev_pm_ops rockchip_pdm_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(rockchip_pdm_suspend, rockchip_pdm_resume)
 };
 
-static const struct of_device_id rockchip_pdm_match[] = {
-	{ .compatible = "rockchip,pdm", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, rockchip_pdm_match);
-
 static struct platform_driver rockchip_pdm_driver = {
 	.probe  = rockchip_pdm_probe,
 	.remove = rockchip_pdm_remove,
diff --git a/sound/soc/rockchip/rockchip_pdm.h b/sound/soc/rockchip/rockchip_pdm.h
index 00a8fa1..ae88644 100644
--- a/sound/soc/rockchip/rockchip_pdm.h
+++ b/sound/soc/rockchip/rockchip_pdm.h
@@ -53,7 +53,16 @@
 #define PDM_VDW_MSK		(0x1f << 0)
 #define PDM_VDW(X)		((X - 1) << 0)
 
+/* PDM CTRL1 */
+#define PDM_FD_NUMERATOR_SFT	16
+#define PDM_FD_NUMERATOR_MSK	GENMASK(31, 16)
+#define PDM_FD_DENOMINATOR_SFT	0
+#define PDM_FD_DENOMINATOR_MSK	GENMASK(15, 0)
+
 /* PDM CLK CTRL */
+#define PDM_CLK_FD_RATIO_MSK	BIT(6)
+#define PDM_CLK_FD_RATIO_40	(0X0 << 6)
+#define PDM_CLK_FD_RATIO_35	BIT(6)
 #define PDM_CLK_MSK		BIT(5)
 #define PDM_CLK_EN		BIT(5)
 #define PDM_CLK_DIS		(0x0 << 5)
-- 
2.7.4



