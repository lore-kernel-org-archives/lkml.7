Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B0FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A070F21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505237AbfJRPmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505151AbfJRPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MTiLj-1iSrhB0H8v-00U4HI; Fri, 18 Oct 2019 17:42:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH 24/46] ARM: pxa: magician: use platform driver for audio
Date:   Fri, 18 Oct 2019 17:41:39 +0200
Message-Id: <20191018154201.1276638-24-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u2katV/LmSiKXDQedAs4tlsJvSfrK7Os+EoGt44jJ5GjNIXKxH5
 dJUynWvmbAn6d/zef06Cx+zYsJOC49+vB4lAIM5K/d7K6Hyh2dOIiNbc+1x62bARp8ooYCH
 P/hwxkNIGKpDLGY85X+lxlMWwr7HjwtfzG5FKdIWSX01YO8zQAwrW4fz9K+PJ9aKEmAvs/c
 KsAYYfTm27xvYvYti0Mxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S48uBYMxdbg=:7Py8YLfrE8bsznnbmS1yrt
 3hOtGX4e5m5nJw3oAKy5kzM1z39HPSfz/195l3WuRV1k51jUkqCnOmXJrD1uS9Y1qOvuPRkZc
 z65zBAI+okvs1jgv5U8aQK5HkoQJv/UjCOO5D1ScM/QoSW0+OHUahQgwdlswSP4niAh6J7jC0
 k0xlHHtRYwasIzveyVrJhUE7V8ol6NtY/874RIRvWbyVBZ+p2gJLwgu46qvB47Eq2Ap5V/xjU
 Zb5XQq7O+L90UOtiwuAc0txACvMlNA5DHAsUPKGuQi8cOsMNshjzJYCRqM2TPBkyoE3/PaVNC
 iZ5OzsLsp0+M4AU8Hfz0dTdWvZffb9AczcuvnZLdeWb1bEYCwAauJBYAurqtIrCQKn4NCvQ+P
 YyctDeXhbIpza9jAxeyiPcvbxJQXI4oQilT5WRQMuJ/zXSq32kdgiMCWURO54sGWl9S5fP67z
 XbyKVlZCgIUyo1UI+xRo413xLxmBL/8UZFBzQjjbrbur1sZglc/8t/ZheOHWm6lABt1Zt2D30
 lpSSEJobQx2z50wj2egB+XeSgoHtIpp7xG10hg4ZtvJwbRfPZwcoPa1nEC+soIDhFHbvGUYpV
 4rDMl1dMwTx3HNCyToXqCbcLtrG0XQSES8/7NRs60nQCtMmwqy4EjCX0a9WSnRE/ZrstUgApe
 nyRxKA1CPzCPIZmi4YYuBX8f0/3/UgwliZj0XeDKVS7mxVIHSuj27Pmf6MIa3x3WXzyzFkQvT
 yzOZUnF70C65y4lTQedZ1kU/FeJ9K4sfcRn6KVeseOkN9KQeo9mSaj1WgJezObDMcmF5iz4BJ
 PzwoYPaJkGwLjjC1Dz6iQXNJptLRoW5QHBsaEV2uXAPKFAOAesxD+UCB33pkWhtVOQS80/S78
 izqEKPJ5TUneMCtVlylg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The magician audio driver creates a codec device and gets
data from a board specific header file, both of which is
a bit suspicious. Move these into the board file itself,
using a gpio lookup table.

Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/magician.c |  50 +++++++++++++
 sound/soc/pxa/magician.c     | 141 +++++++++--------------------------
 2 files changed, 87 insertions(+), 104 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 31037679bf24..48ac4b96e5ce 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -54,6 +54,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/ads7846.h>
+#include <sound/uda1380.h>
 
 static unsigned long magician_pin_config[] __initdata = {
 
@@ -892,6 +893,53 @@ static struct platform_device strataflash = {
 	},
 };
 
+/*
+ * audio support
+ */
+static struct uda1380_platform_data uda1380_info = {
+	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
+	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
+	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
+};
+
+static struct i2c_board_info magician_audio_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("uda1380", 0x18),
+		.platform_data = &uda1380_info,
+	},
+};
+
+static struct gpiod_lookup_table magician_audio_gpio_table = {
+	.dev_id = "magician-audio",
+	.table = {
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_SPK_POWER - MAGICIAN_EGPIO_BASE,
+			    "SPK_POWER", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_EP_POWER - MAGICIAN_EGPIO_BASE,
+			    "EP_POWER", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_MIC_POWER - MAGICIAN_EGPIO_BASE,
+			    "MIC_POWER", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_IN_SEL0 - MAGICIAN_EGPIO_BASE,
+			    "IN_SEL0", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("htc-egpio-0",
+			    EGPIO_MAGICIAN_IN_SEL1 - MAGICIAN_EGPIO_BASE,
+			    "IN_SEL1", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static void magician_audio_init(void)
+{
+	i2c_register_board_info(0,
+		ARRAY_AND_SIZE(magician_audio_i2c_board_info));
+
+	gpiod_add_lookup_table(&magician_audio_gpio_table);
+	platform_device_register_simple("magician-audio", -1, NULL, 0);
+}
+
 /*
  * PXA I2C main controller
  */
@@ -1033,6 +1081,8 @@ static void __init magician_init(void)
 
 	gpiod_add_lookup_table(&bq24022_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(devices));
+
+	magician_audio_init();
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 6483cff5b73d..c5993a532cf0 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -14,16 +14,14 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/uda1380.h>
 
-#include <mach/magician.h>
 #include <asm/mach-types.h>
 #include "../codecs/uda1380.h"
 #include "pxa2xx-i2s.h"
@@ -36,6 +34,9 @@ static int magician_hp_switch;
 static int magician_spk_switch = 1;
 static int magician_in_sel = MAGICIAN_MIC;
 
+static struct gpio_desc *gpiod_spk_power, *gpiod_ep_power, *gpiod_mic_power;
+static struct gpio_desc *gpiod_in_sel0, *gpiod_in_sel1;
+
 static void magician_ext_control(struct snd_soc_dapm_context *dapm)
 {
 
@@ -215,10 +216,10 @@ static int magician_set_input(struct snd_kcontrol *kcontrol,
 
 	switch (magician_in_sel) {
 	case MAGICIAN_MIC:
-		gpio_set_value(EGPIO_MAGICIAN_IN_SEL1, 1);
+		gpiod_set_value(gpiod_in_sel1, 1);
 		break;
 	case MAGICIAN_MIC_EXT:
-		gpio_set_value(EGPIO_MAGICIAN_IN_SEL1, 0);
+		gpiod_set_value(gpiod_in_sel1, 0);
 	}
 
 	return 1;
@@ -227,21 +228,21 @@ static int magician_set_input(struct snd_kcontrol *kcontrol,
 static int magician_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(EGPIO_MAGICIAN_SPK_POWER, SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value(gpiod_spk_power, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
 static int magician_hp_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(EGPIO_MAGICIAN_EP_POWER, SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value(gpiod_ep_power, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
 static int magician_mic_bias(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(EGPIO_MAGICIAN_MIC_POWER, SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value(gpiod_mic_power, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
@@ -328,106 +329,38 @@ static struct snd_soc_card snd_soc_card_magician = {
 	.fully_routed = true,
 };
 
-static struct platform_device *magician_snd_device;
-
-/*
- * FIXME: move into magician board file once merged into the pxa tree
- */
-static struct uda1380_platform_data uda1380_info = {
-	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
-	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
-	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
-};
-
-static struct i2c_board_info i2c_board_info[] = {
-	{
-		I2C_BOARD_INFO("uda1380", 0x18),
-		.platform_data = &uda1380_info,
-	},
-};
-
-static int __init magician_init(void)
-{
-	int ret;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-
-	if (!machine_is_magician())
-		return -ENODEV;
-
-	adapter = i2c_get_adapter(0);
-	if (!adapter)
-		return -ENODEV;
-	client = i2c_new_device(adapter, i2c_board_info);
-	i2c_put_adapter(adapter);
-	if (!client)
-		return -ENODEV;
-
-	ret = gpio_request(EGPIO_MAGICIAN_SPK_POWER, "SPK_POWER");
-	if (ret)
-		goto err_request_spk;
-	ret = gpio_request(EGPIO_MAGICIAN_EP_POWER, "EP_POWER");
-	if (ret)
-		goto err_request_ep;
-	ret = gpio_request(EGPIO_MAGICIAN_MIC_POWER, "MIC_POWER");
-	if (ret)
-		goto err_request_mic;
-	ret = gpio_request(EGPIO_MAGICIAN_IN_SEL0, "IN_SEL0");
-	if (ret)
-		goto err_request_in_sel0;
-	ret = gpio_request(EGPIO_MAGICIAN_IN_SEL1, "IN_SEL1");
-	if (ret)
-		goto err_request_in_sel1;
-
-	gpio_set_value(EGPIO_MAGICIAN_IN_SEL0, 0);
-
-	magician_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!magician_snd_device) {
-		ret = -ENOMEM;
-		goto err_pdev;
-	}
-
-	platform_set_drvdata(magician_snd_device, &snd_soc_card_magician);
-	ret = platform_device_add(magician_snd_device);
-	if (ret) {
-		platform_device_put(magician_snd_device);
-		goto err_pdev;
-	}
-
-	return 0;
-
-err_pdev:
-	gpio_free(EGPIO_MAGICIAN_IN_SEL1);
-err_request_in_sel1:
-	gpio_free(EGPIO_MAGICIAN_IN_SEL0);
-err_request_in_sel0:
-	gpio_free(EGPIO_MAGICIAN_MIC_POWER);
-err_request_mic:
-	gpio_free(EGPIO_MAGICIAN_EP_POWER);
-err_request_ep:
-	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
-err_request_spk:
-	return ret;
-}
-
-static void __exit magician_exit(void)
+static int magician_audio_probe(struct platform_device *pdev)
 {
-	platform_device_unregister(magician_snd_device);
-
-	gpio_set_value(EGPIO_MAGICIAN_SPK_POWER, 0);
-	gpio_set_value(EGPIO_MAGICIAN_EP_POWER, 0);
-	gpio_set_value(EGPIO_MAGICIAN_MIC_POWER, 0);
-
-	gpio_free(EGPIO_MAGICIAN_IN_SEL1);
-	gpio_free(EGPIO_MAGICIAN_IN_SEL0);
-	gpio_free(EGPIO_MAGICIAN_MIC_POWER);
-	gpio_free(EGPIO_MAGICIAN_EP_POWER);
-	gpio_free(EGPIO_MAGICIAN_SPK_POWER);
+	struct device *dev = &pdev->dev;
+
+	gpiod_spk_power = devm_gpiod_get(dev, "SPK_POWER", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_spk_power))
+		return PTR_ERR(gpiod_spk_power);
+	gpiod_ep_power = devm_gpiod_get(dev, "EP_POWER", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ep_power))
+		return PTR_ERR(gpiod_ep_power);
+	gpiod_mic_power = devm_gpiod_get(dev, "MIC_POWER", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_mic_power))
+		return PTR_ERR(gpiod_mic_power);
+	gpiod_in_sel0 = devm_gpiod_get(dev, "IN_SEL0", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod_in_sel0))
+		return PTR_ERR(gpiod_in_sel0);
+	gpiod_in_sel1 = devm_gpiod_get(dev, "IN_SEL1", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_in_sel1))
+		return PTR_ERR(gpiod_in_sel1);
+
+	snd_soc_card_magician.dev = &pdev->dev;
+	return devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_magician);
 }
 
-module_init(magician_init);
-module_exit(magician_exit);
+static struct platform_driver magician_audio_driver = {
+	.driver.name = "magician-audio",
+	.driver.pm = &snd_soc_pm_ops,
+	.probe = magician_audio_probe,
+};
+module_platform_driver(magician_audio_driver);
 
 MODULE_AUTHOR("Philipp Zabel");
 MODULE_DESCRIPTION("ALSA SoC Magician");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:magician-audio");
-- 
2.20.0

