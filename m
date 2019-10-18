Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717ADCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4809721852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406044AbfJRPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:45:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40199 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505135AbfJRPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:39 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N63JO-1hx5qr2yfg-016PlV; Fri, 18 Oct 2019 17:42:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH 17/46] ARM: pxa: poodle: use platform data for poodle asoc driver
Date:   Fri, 18 Oct 2019 17:41:32 +0200
Message-Id: <20191018154201.1276638-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p9ZrRDHwCnKDBluK8hkqbIJa9HiEsmbCOZpQY8Mh+exqEux633r
 DZRxCBw9sMWxqdqgBGczIR+z7mwPWtziPTHrh12OtwvaLaf2RNlYqcykLvTJi0KcVSxmGoh
 rhj/qwo8gxEs8NxXN1DaJ0HzXd/AAzxvGUB/pGCGkLmNB2XbDIvGNWbDS4qHtyEL8WYXkJU
 uocSZU2bYNFxoP37Nc7Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WAOOIPnScUM=:9Eaw5bkBpyAoqkstz5gVM4
 E7/ZdztdXyDuWYH4h4FLGsUr4tPlBUW+LVP2JZcezjI71bxVYKQ+lCLxC6qhN+fGahELtAmIR
 cOzf2qkP++9ojwfonDfU9PCp4GsIYw30OY4s12K23FSgo5yuOHz3wqbfoogZwPWQUYqRnEvju
 z5tE1dAHFEaQs0c8RFlFNwxzLj6NIrFk/StaumS8C+gb+5L0ElpljtFSMDNT3ZnXA2WhaN4p5
 9U3xVZvQ5DwRoGPtSh0exjBsmkmVNKG7Mpci41hFnQdD/apiizlXXDqJyI60YiKqlVXdC4QSP
 fYtmEXbjteMmh9E2TFJhrbJjeOS2818VyK1WpZ2dijPUvaVOqJzolVHBZyN6o61UiaXYKUgpJ
 EWhwpkITNOXDEM3gwSqtmetTIqJ12M1sFD0sda+PdnhvM1GOurMU8FpVE7KQ9Toar8ZRCcVRu
 23UrtofaXJbiFvEPvEJ4ZY0WjNy5AvHOQ8+7xckLWW7CQaeFQhPcw/YcB8k/qrVFcTXYK5HeB
 bdPYGBnwyZ5EeFaQJaDZrjVntsnRxid/TNUXCbNGZORhnneKJoEqaDBSlpsVmAclYh9OfzS+z
 QBYJAtBfLUT/qNqdn57tqcoEOnD1bQG28r3Aw+nJmtF74JxB5xZTRCm9dD/1yut9tEUh6xJUf
 ToH28uYuVJ6/2JpxBaPj/akU+2z+sdtY1hqVwkkpd4HiJOOAi/AfyU4gmjQ3jL+urB4pGeMoH
 8m1kRo8ZSsvvAd/1jfFmXlEjWxeUBuQFOn1jzQhdqpk2D7rkeZeYMCc2uUaz6c56vy7Uir130
 b7NBIxHqnWHusuHFIIaJgO8ruFFOoc/ELslpzy7Yf5QutDJAN733oFp/1WwXgBXuITvJmyNcE
 Vd5/RLwxLiSuzIGkuf5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The poodle audio driver shows its age by using a custom
gpio api for the "locomo" support chip.

In a perfect world, this would get converted to use gpiolib
and a gpio lookup table.

As the world is not perfect, just pass all the required data
in a custom platform_data structure. to avoid the globally
visible mach/poodle.h header.

Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/poodle.c                    | 30 ++++++++----
 arch/arm/mach-pxa/{include/mach => }/poodle.h |  4 +-
 include/linux/platform_data/asoc-poodle.h     | 16 ++++++
 sound/soc/pxa/poodle.c                        | 49 ++++++++++---------
 4 files changed, 63 insertions(+), 36 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/poodle.h (97%)
 create mode 100644 include/linux/platform_data/asoc-poodle.h

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 8dd791ee49bf..7709fe026c33 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -39,11 +39,13 @@
 #include <asm/mach/irq.h>
 
 #include "pxa25x.h"
-#include <linux/platform_data/mmc-pxamci.h>
 #include "udc.h"
+#include "poodle.h"
+
+#include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/irda-pxaficp.h>
-#include <mach/poodle.h>
 #include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/asoc-poodle.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/hardware/locomo.h>
@@ -155,12 +157,6 @@ static struct scoop_pcmcia_config poodle_pcmcia_config = {
 
 EXPORT_SYMBOL(poodle_scoop_device);
 
-
-static struct platform_device poodle_audio_device = {
-	.name	= "poodle-audio",
-	.id	= -1,
-};
-
 /* LoCoMo device */
 static struct resource locomo_resources[] = {
 	[0] = {
@@ -179,7 +175,7 @@ static struct locomo_platform_data locomo_info = {
 	.irq_base	= IRQ_BOARD_START,
 };
 
-struct platform_device poodle_locomo_device = {
+static struct platform_device poodle_locomo_device = {
 	.name		= "locomo",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(locomo_resources),
@@ -189,7 +185,21 @@ struct platform_device poodle_locomo_device = {
 	},
 };
 
-EXPORT_SYMBOL(poodle_locomo_device);
+static struct poodle_audio_platform_data poodle_audio_pdata = {
+	.locomo_dev	= &poodle_locomo_device.dev,
+
+	.gpio_amp_on   	= POODLE_LOCOMO_GPIO_AMP_ON,
+	.gpio_mute_l   	= POODLE_LOCOMO_GPIO_MUTE_L,
+	.gpio_mute_r   	= POODLE_LOCOMO_GPIO_MUTE_R,
+	.gpio_232vcc_on	= POODLE_LOCOMO_GPIO_232VCC_ON,
+	.gpio_jk_b     	= POODLE_LOCOMO_GPIO_JK_B,
+};
+
+static struct platform_device poodle_audio_device = {
+	.name	= "poodle-audio",
+	.id	= -1,
+	.dev.platform_data = &poodle_audio_pdata,
+};
 
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
 static struct pxa2xx_spi_controller poodle_spi_info = {
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/poodle.h
similarity index 97%
rename from arch/arm/mach-pxa/include/mach/poodle.h
rename to arch/arm/mach-pxa/poodle.h
index b56b19351a03..e675a3d1aa18 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/poodle.h
@@ -15,7 +15,7 @@
 #ifndef __ASM_ARCH_POODLE_H
 #define __ASM_ARCH_POODLE_H  1
 
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 /*
  * GPIOs
@@ -89,6 +89,4 @@
 
 #define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
 
-extern struct platform_device poodle_locomo_device;
-
 #endif /* __ASM_ARCH_POODLE_H  */
diff --git a/include/linux/platform_data/asoc-poodle.h b/include/linux/platform_data/asoc-poodle.h
new file mode 100644
index 000000000000..2052fad55c5c
--- /dev/null
+++ b/include/linux/platform_data/asoc-poodle.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PLATFORM_DATA_POODLE_AUDIO
+#define __LINUX_PLATFORM_DATA_POODLE_AUDIO
+
+/* locomo is not a proper gpio driver, and uses its own api */
+struct poodle_audio_platform_data {
+	struct device	*locomo_dev;
+
+	int		gpio_amp_on;
+	int		gpio_mute_l;
+	int		gpio_mute_r;
+	int		gpio_232vcc_on;
+	int		gpio_jk_b;
+};
+
+#endif
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index f289c089aede..39768288b80c 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -21,8 +21,8 @@
 
 #include <asm/mach-types.h>
 #include <asm/hardware/locomo.h>
-#include <mach/poodle.h>
 #include <linux/platform_data/asoc-pxa.h>
+#include <linux/platform_data/asoc-poodle.h>
 
 #include "../codecs/wm8731.h"
 #include "pxa2xx-i2s.h"
@@ -38,21 +38,23 @@
 static int poodle_jack_func;
 static int poodle_spk_func;
 
+static struct poodle_audio_platform_data *poodle_pdata;
+
 static void poodle_ext_control(struct snd_soc_dapm_context *dapm)
 {
 	/* set up jack connection */
 	if (poodle_jack_func == POODLE_HP) {
 		/* set = unmute headphone */
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_L, 1);
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_R, 1);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_mute_l, 1);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_mute_r, 1);
 		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	} else {
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_L, 0);
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_R, 0);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_mute_l, 0);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_mute_r, 0);
 		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 	}
 
@@ -80,10 +82,10 @@ static int poodle_startup(struct snd_pcm_substream *substream)
 static void poodle_shutdown(struct snd_pcm_substream *substream)
 {
 	/* set = unmute headphone */
-	locomo_gpio_write(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_L, 1);
-	locomo_gpio_write(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_R, 1);
+	locomo_gpio_write(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_mute_l, 1);
+	locomo_gpio_write(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_mute_r, 1);
 }
 
 static int poodle_hw_params(struct snd_pcm_substream *substream,
@@ -174,11 +176,11 @@ static int poodle_amp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_AMP_ON, 0);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_amp_on, 0);
 	else
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_AMP_ON, 1);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_amp_on, 1);
 
 	return 0;
 }
@@ -254,13 +256,14 @@ static int poodle_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &poodle;
 	int ret;
 
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_AMP_ON, 0);
+	poodle_pdata = pdev->dev.platform_data;
+	locomo_gpio_set_dir(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_amp_on, 0);
 	/* should we mute HP at startup - burning power ?*/
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_L, 0);
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_R, 0);
+	locomo_gpio_set_dir(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_mute_l, 0);
+	locomo_gpio_set_dir(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_mute_r, 0);
 
 	card->dev = &pdev->dev;
 
-- 
2.20.0

