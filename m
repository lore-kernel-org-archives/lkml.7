Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBCBCA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E702C21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633957AbfJRPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:43:50 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55125 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505207AbfJRPmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:45 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McpS0-1hmhsG1gOI-00ZwWl; Fri, 18 Oct 2019 17:42:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 19/46] ARM: pxa: hx4700: use gpio descriptors for audio
Date:   Fri, 18 Oct 2019 17:41:34 +0200
Message-Id: <20191018154201.1276638-19-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VTDetqiA3IUPd37iiTjF8wmf8is9z0ii2hZFyGnfpBo7v9YzRzf
 eLPjN/VpyDbNNgQqFV9CrvQZZGL4LvF9qcdU1Wow93cSHhGzpdK2nq9u5Wx/PYPamq+3re6
 Sk/nIeH15eZgiayt6b8hOpI8KxPD9zRBZ9hEYEH+Pnp6QXXjHK5Q0mab6YaTZX96iJ0we8Q
 z9m8F5M9ZSmiBlVV9yRSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z5MPd9t3zuc=:f31rOBD3gYLsiOgUZCPLvb
 K/Wd1JvNV7F6gIvfl3p6iza//HPWorhTW38CfK+6SD/pXEIcjcuo8qh7NrKL//HaIuM2gm2qR
 n6KBMgZZ4gIQwhIeexa569uM8xBZIpXoPd5czCtWdFgb5jax+Jq+D6dvPUTUzXXfNETAYw+/R
 8DM9MHZFBhn2V8HoEk1okYWzovOFgYq8Ej/sALgYoaHYw2cKJWPkboR3eieBuXUXKHkWoHxr7
 9kNcaaaUDCiIuN1wtSTf/6hLoNwmqohiHuWcRulQG+mM3AuTdJQJE4FR886KE1MJq9CteBU9G
 iHYZuBp19msfHtU6hsmpOBWo86zga2Z8W1cIN04vewk3IvdMJEoefkwFTfMyhB8sfaLSKFxn2
 L1QhyoN0sr1Or430sUqOiyHLUAqNFq2BeGa7tTfzwflAGHiSkmthybx3qJSL9O8xkbtlA///T
 48YpjyVOYwOAB3bUSSpZO7hELaEMOz77+htSfhnJqUfCwz+119BJs6AIOjjqGooDKwjNnXGoU
 JWct38hOLypaQ1ZGwNhe1jFW0/sAGoZQSfS+5dE0kBASWFMqcJj4G4TDb6/m5WTu6R1IdMEBk
 9JhqiaK6b6cdNsnRXh9t1+oRdbADOHwgtNtvwrEBxvmYY93WuFFD6qnBZjBJNRz5P9dnEEAUb
 jaVTvl1DLADz26gL1VgGIvr4pFZjiA++Dz6/6DxjEW1NRakOZElbomRh0z8n2pphk/x9YzkXh
 KC/0sM/qf2pUjNc9Tcs/8s9vj0SGEAyj9IbyEXCl/k80SNVXG4nOcG6zJ4sSa4UjuuUYel277
 q2H2zM4VdnjppDQGBoVCF2kseF2BCbxh9dB0SZMRZTfz/4NJPKyivdMwg6BLXj07q/21+BlqZ
 SsdEOLWB8auzGCvIdxew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio driver should not use a hardwired gpio number
from the header. Change it to use a lookup table.

Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/hx4700-pcmcia.c             |  2 +-
 arch/arm/mach-pxa/hx4700.c                    | 16 ++++++++-
 arch/arm/mach-pxa/{include/mach => }/hx4700.h |  2 +-
 sound/soc/pxa/hx4700.c                        | 34 ++++++++-----------
 4 files changed, 31 insertions(+), 23 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/hx4700.h (99%)

diff --git a/arch/arm/mach-pxa/hx4700-pcmcia.c b/arch/arm/mach-pxa/hx4700-pcmcia.c
index e8acbfc9ef6c..e2331dfe427d 100644
--- a/arch/arm/mach-pxa/hx4700-pcmcia.c
+++ b/arch/arm/mach-pxa/hx4700-pcmcia.c
@@ -10,7 +10,7 @@
 #include <linux/irq.h>
 
 #include <asm/mach-types.h>
-#include <mach/hx4700.h>
+#include "hx4700.h"
 
 #include <pcmcia/soc_common.h>
 
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index b3dcbe291e13..84383d14bf64 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -42,7 +42,7 @@
 
 #include "pxa27x.h"
 #include "addr-map.h"
-#include <mach/hx4700.h>
+#include "hx4700.h"
 #include <linux/platform_data/irda-pxaficp.h>
 
 #include <sound/ak4641.h>
@@ -823,6 +823,19 @@ static struct i2c_board_info i2c_board_info[] __initdata = {
 	},
 };
 
+static struct gpiod_lookup_table hx4700_audio_gpio_table = {
+	.dev_id = "hx4700-audio",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO75_HX4700_EARPHONE_nDET,
+			    "earphone-ndet", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO92_HX4700_HP_DRIVER,
+			    "hp-driver", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO107_HX4700_SPK_nSD,
+			    "spk-nsd", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct platform_device audio = {
 	.name	= "hx4700-audio",
 	.id	= -1,
@@ -883,6 +896,7 @@ static void __init hx4700_init(void)
 	pxa_set_stuart_info(NULL);
 
 	gpiod_add_lookup_table(&bq24022_gpiod_table);
+	gpiod_add_lookup_table(&hx4700_audio_gpio_table);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
 
diff --git a/arch/arm/mach-pxa/include/mach/hx4700.h b/arch/arm/mach-pxa/hx4700.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/hx4700.h
rename to arch/arm/mach-pxa/hx4700.h
index 0c30e6d9c660..ce2db33989e1 100644
--- a/arch/arm/mach-pxa/include/mach/hx4700.h
+++ b/arch/arm/mach-pxa/hx4700.h
@@ -10,7 +10,7 @@
 
 #include <linux/gpio.h>
 #include <linux/mfd/asic3.h>
-#include "irqs.h" /* PXA_NR_BUILTIN_GPIO */
+#include <mach/irqs.h> /* PXA_NR_BUILTIN_GPIO */
 
 #define HX4700_ASIC3_GPIO_BASE	PXA_NR_BUILTIN_GPIO
 #define HX4700_EGPIO_BASE	(HX4700_ASIC3_GPIO_BASE + ASIC3_NUM_GPIOS)
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 0139343dbcce..2fae601f0844 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -10,7 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/core.h>
 #include <sound/jack.h>
@@ -18,10 +18,10 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <mach/hx4700.h>
 #include <asm/mach-types.h>
 #include "pxa2xx-i2s.h"
 
+static struct gpio_desc *gpiod_hp_driver, *gpiod_spk_nsd;
 static struct snd_soc_jack hs_jack;
 
 /* Headphones jack detection DAPM pin */
@@ -40,9 +40,8 @@ static struct snd_soc_jack_pin hs_jack_pin[] = {
 
 /* Headphones jack detection GPIO */
 static struct snd_soc_jack_gpio hs_jack_gpio = {
-	.gpio		= GPIO75_HX4700_EARPHONE_nDET,
 	.invert		= true,
-	.name		= "hp-gpio",
+	.name		= "earphone-ndet",
 	.report		= SND_JACK_HEADPHONE,
 	.debounce_time	= 200,
 };
@@ -81,14 +80,14 @@ static const struct snd_soc_ops hx4700_ops = {
 static int hx4700_spk_power(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(GPIO107_HX4700_SPK_nSD, !!SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value(gpiod_spk_nsd, !!SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
 static int hx4700_hp_power(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(GPIO92_HX4700_HP_DRIVER, !!SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value(gpiod_hp_driver, !!SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
@@ -162,11 +161,6 @@ static struct snd_soc_card snd_soc_card_hx4700 = {
 	.fully_routed		= true,
 };
 
-static struct gpio hx4700_audio_gpios[] = {
-	{ GPIO107_HX4700_SPK_nSD, GPIOF_OUT_INIT_HIGH, "SPK_POWER" },
-	{ GPIO92_HX4700_HP_DRIVER, GPIOF_OUT_INIT_LOW, "EP_POWER" },
-};
-
 static int hx4700_audio_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -174,26 +168,26 @@ static int hx4700_audio_probe(struct platform_device *pdev)
 	if (!machine_is_h4700())
 		return -ENODEV;
 
-	ret = gpio_request_array(hx4700_audio_gpios,
-				ARRAY_SIZE(hx4700_audio_gpios));
+	gpiod_hp_driver = devm_gpiod_get(&pdev->dev, "hp-driver", GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(gpiod_hp_driver);
+	if (ret)
+		return ret;
+	gpiod_spk_nsd = devm_gpiod_get(&pdev->dev, "spk-nsd", GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(gpiod_spk_nsd);
 	if (ret)
 		return ret;
 
+	hs_jack_gpio.gpiod_dev = &pdev->dev;
 	snd_soc_card_hx4700.dev = &pdev->dev;
 	ret = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_hx4700);
-	if (ret)
-		gpio_free_array(hx4700_audio_gpios,
-				ARRAY_SIZE(hx4700_audio_gpios));
 
 	return ret;
 }
 
 static int hx4700_audio_remove(struct platform_device *pdev)
 {
-	gpio_set_value(GPIO92_HX4700_HP_DRIVER, 0);
-	gpio_set_value(GPIO107_HX4700_SPK_nSD, 0);
-
-	gpio_free_array(hx4700_audio_gpios, ARRAY_SIZE(hx4700_audio_gpios));
+	gpiod_set_value(gpiod_hp_driver, 0);
+	gpiod_set_value(gpiod_spk_nsd, 0);
 	return 0;
 }
 
-- 
2.20.0

