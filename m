Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EB7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72002071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfKTPYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:24:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47046 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfKTPYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:24:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BF9442910DD
Received: by earth.universe (Postfix, from userid 1000)
        id 254543C0C78; Wed, 20 Nov 2019 16:24:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 2/6] ASoC: da7213: Add regulator support
Date:   Wed, 20 Nov 2019 16:24:02 +0100
Message-Id: <20191120152406.2744-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120152406.2744-1-sebastian.reichel@collabora.com>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for most regulators of da7212 for improved
power management. The only thing skipped was the speaker supply,
which has some undocumented dependencies. It's supposed to be
either always-enabled or always-disabled.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/sound/da7213.txt      |  4 +
 sound/soc/codecs/da7213.c                     | 79 ++++++++++++++++++-
 sound/soc/codecs/da7213.h                     |  9 +++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/da7213.txt b/Documentation/devicetree/bindings/sound/da7213.txt
index 759bb04e0283..cc8200b7d748 100644
--- a/Documentation/devicetree/bindings/sound/da7213.txt
+++ b/Documentation/devicetree/bindings/sound/da7213.txt
@@ -21,6 +21,10 @@ Optional properties:
 - dlg,dmic-clkrate : DMIC clock frequency (Hz).
 	[<1500000>, <3000000>]
 
+ - VDDA-supply : Regulator phandle for Analogue power supply
+ - VDDMIC-supply : Regulator phandle for Mic Bias
+ - VDDIO-supply : Regulator phandle for I/O power supply
+
 ======
 
 Example:
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index aff306bb58df..0359249118d0 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <linux/pm_runtime.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -806,6 +807,11 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
  */
 
 static const struct snd_soc_dapm_widget da7213_dapm_widgets[] = {
+	/*
+	 * Power Supply
+	 */
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDMIC", 0, 0),
+
 	/*
 	 * Input & Output
 	 */
@@ -932,6 +938,9 @@ static const struct snd_soc_dapm_route da7213_audio_map[] = {
 	/* Dest       Connecting Widget    source */
 
 	/* Input path */
+	{"Mic Bias 1", NULL, "VDDMIC"},
+	{"Mic Bias 2", NULL, "VDDMIC"},
+
 	{"MIC1", NULL, "Mic Bias 1"},
 	{"MIC2", NULL, "Mic Bias 2"},
 
@@ -1691,6 +1700,8 @@ static int da7213_probe(struct snd_soc_component *component)
 {
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
 
+	pm_runtime_get_sync(component->dev);
+
 	/* Default to using ALC auto offset calibration mode. */
 	snd_soc_component_update_bits(component, DA7213_ALC_CTRL1,
 			    DA7213_ALC_CALIB_MODE_MAN, 0);
@@ -1811,6 +1822,8 @@ static int da7213_probe(struct snd_soc_component *component)
 				    DA7213_DMIC_CLK_RATE_MASK, dmic_cfg);
 	}
 
+	pm_runtime_put_sync(component->dev);
+
 	/* Check if MCLK provided */
 	da7213->mclk = devm_clk_get(component->dev, "mclk");
 	if (IS_ERR(da7213->mclk)) {
@@ -1848,11 +1861,22 @@ static const struct regmap_config da7213_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static void da7213_power_off(void *data)
+{
+	struct da7213_priv *da7213 = data;
+	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
+}
+
+static const char *da7213_supply_names[DA7213_NUM_SUPPLIES] = {
+	[DA7213_SUPPLY_VDDA] = "VDDA",
+	[DA7213_SUPPLY_VDDIO] = "VDDIO",
+};
+
 static int da7213_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct da7213_priv *da7213;
-	int ret;
+	int i, ret;
 
 	da7213 = devm_kzalloc(&i2c->dev, sizeof(*da7213), GFP_KERNEL);
 	if (!da7213)
@@ -1860,6 +1884,25 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, da7213);
 
+	/* Get required supplies */
+	for (i = 0; i < DA7213_NUM_SUPPLIES; ++i)
+		da7213->supplies[i].supply = da7213_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, DA7213_NUM_SUPPLIES,
+				      da7213->supplies);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to get supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&i2c->dev, da7213_power_off, da7213);
+	if (ret < 0)
+		return ret;
+
 	da7213->regmap = devm_regmap_init_i2c(i2c, &da7213_regmap_config);
 	if (IS_ERR(da7213->regmap)) {
 		ret = PTR_ERR(da7213->regmap);
@@ -1867,6 +1910,11 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	pm_runtime_set_autosuspend_delay(&i2c->dev, 100);
+	pm_runtime_use_autosuspend(&i2c->dev);
+	pm_runtime_set_active(&i2c->dev);
+	pm_runtime_enable(&i2c->dev);
+
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_da7213, &da7213_dai, 1);
 	if (ret < 0) {
@@ -1876,6 +1924,34 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
+static int __maybe_unused da7213_runtime_suspend(struct device *dev)
+{
+	struct da7213_priv *da7213 = dev_get_drvdata(dev);
+
+	regcache_cache_only(da7213->regmap, true);
+	regcache_mark_dirty(da7213->regmap);
+	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
+
+	return 0;
+}
+
+static int __maybe_unused da7213_runtime_resume(struct device *dev)
+{
+	struct da7213_priv *da7213 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
+	if (ret < 0)
+		return ret;
+	regcache_cache_only(da7213->regmap, false);
+	regcache_sync(da7213->regmap);
+	return 0;
+}
+
+static const struct dev_pm_ops da7213_pm = {
+	SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
+};
+
 static const struct i2c_device_id da7213_i2c_id[] = {
 	{ "da7213", 0 },
 	{ }
@@ -1888,6 +1964,7 @@ static struct i2c_driver da7213_i2c_driver = {
 		.name = "da7213",
 		.of_match_table = of_match_ptr(da7213_of_match),
 		.acpi_match_table = ACPI_PTR(da7213_acpi_match),
+		.pm = &da7213_pm,
 	},
 	.probe		= da7213_i2c_probe,
 	.id_table	= da7213_i2c_id,
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 3250a3821fcc..3890829dfb6e 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <sound/da7213.h>
 
 /*
@@ -521,9 +522,17 @@ enum da7213_sys_clk {
 	DA7213_SYSCLK_PLL_32KHZ
 };
 
+/* Regulators */
+enum da7213_supplies {
+	DA7213_SUPPLY_VDDA = 0,
+	DA7213_SUPPLY_VDDIO,
+	DA7213_NUM_SUPPLIES,
+};
+
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
+	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
 	struct clk *mclk;
 	unsigned int mclk_rate;
 	int clk_src;
-- 
2.24.0

