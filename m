Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E572CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C98A21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505186AbfJRPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501966AbfJRPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:39 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3DFj-1iK6Hu39zx-003dRY; Fri, 18 Oct 2019 17:42:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH 23/46] ARM: pxa: z2: use gpio lookup for audio device
Date:   Fri, 18 Oct 2019 17:41:38 +0200
Message-Id: <20191018154201.1276638-23-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cjdBav0l0UpRWDnSxUWkeDULSGZ8131Ss2R6vA9ICOozyyA8AhI
 J5Ms+VvXLMgtLTNHoEmTdyk5htB1jeqWROYYFpYKK92TY0sCB8KDTXPAfSCu4TbSNDVy0Dj
 pytBDXhGT4cEPIQR7K0nFk70ecqjXtCh1vFO13koPRhe4AEigqyQUR+Mxh8qQbBcYBVmR2d
 tc22pWqr8BrPuhAyHqu8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8XXhRh5ZtT4=:pyBU5Wnn9fBZIQssW2sBRM
 LQKG1YHO95Ch5/RxCLc4I2/v4WNemH1r5UOwxDPTfP5kH9YdiSRsebMm6QknjTzAEmaT95mZY
 4gso8AtuwYMoEhA46FLqN59kzOjCemQ/+rhJMPyzYI3HjTv1qMD06IeMGyCRfjStJi4EDe9bc
 4XSmwehrv6tUidpUuAmqHwjPEb9PD+x/MmNejMy0BUoOqwAa4XLxVXLzOl8Dl6io7c66NXBHf
 9s33QoXoYAMNLqEYPQ2DqD0/nVH6rKbfcj7O7sM+4vbiPm5wLGPkNjAPqIXc1zkIshzhl5hJo
 hsPCCX0Y9qBCBOPt4lX3h5/eo/SLRY4M04Gzhh0GlCyXlTsaSyCmbXEK51gZY+PbDctQAgWgA
 kC6qJPi0qwb4ZWYqh/U7ZWsrr7LH05EgvwQp8Lmi4cDnPN+rBSA9r1FSS7sLb3h7Q/mXb0fqF
 4i8ZC+KSy17rZVO06Mpxko0Uqm2gc8D4nEJT3Wfdkx9VKqnZAsrJuycZA1t5SVSm0Wto70GXm
 Bd7YwJC8MD2nuR93nmKsZF0EK1VsKtDXcuq93YmFLm6n+yua+BDkEABgRmOmITDaqbD7lJsiD
 yXBG6iRDstwTb33S2GnQOQLXiYpaTzEqYfZEdXKAMm5Qe4KC7aTMa/c5U2xRNJabnJr7ksuca
 UwuNUg2q4KutVNub5Yxw2OFNUuokjAVheS/FkwR3JpJcDCzp//Hx72P0p6X4HockU6asBBh4Q
 oQxmyb2MpMwcazyB9u6msoUa1hlIpGY5LednMwHVeNmfbh+evEqo0QeSM0ZJGMrI3U5ZJW0T+
 vIvsYzj+VN1mzMlk31z84peCwOKo50NkTMj/k/vpEW/a6j49MsRhjcDIxIK0s099VokJaFNUo
 Uj7PuFz1pjsU4yoNmG4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio device is allocated by the audio driver, and it uses a gpio
number from the mach/z2.h header file.

Change it to use a gpio lookup table for the device allocated by the
driver to keep the header file local to the machine.

Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/z2.c | 11 +++++++++++
 sound/soc/pxa/z2.c     |  5 ++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 900cefc4c5ea..874bdd49ad43 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -623,6 +623,15 @@ static void __init z2_spi_init(void)
 static inline void z2_spi_init(void) {}
 #endif
 
+static struct gpiod_lookup_table z2_audio_gpio_table = {
+	.dev_id = "soc-audio",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", GPIO37_ZIPITZ2_HEADSET_DETECT,
+			    "hsdet-gpio", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /******************************************************************************
  * Core power regulator
  ******************************************************************************/
@@ -727,6 +736,8 @@ static void __init z2_init(void)
 	z2_keys_init();
 	z2_pmic_init();
 
+	gpiod_add_lookup_table(&z2_audio_gpio_table);
+
 	pm_power_off = z2_power_off;
 }
 
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index 1fb3e7ac42fa..5147ed60fcd0 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -13,7 +13,7 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -22,7 +22,6 @@
 
 #include <asm/mach-types.h>
 #include <linux/platform_data/asoc-pxa.h>
-#include <mach/z2.h>
 
 #include "../codecs/wm8750.h"
 #include "pxa2xx-i2s.h"
@@ -89,7 +88,6 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
 /* Headset jack detection gpios */
 static struct snd_soc_jack_gpio hs_jack_gpios[] = {
 	{
-		.gpio		= GPIO37_ZIPITZ2_HEADSET_DETECT,
 		.name		= "hsdet-gpio",
 		.report		= SND_JACK_HEADSET,
 		.debounce_time	= 200,
@@ -195,6 +193,7 @@ static int __init z2_init(void)
 	if (!z2_snd_device)
 		return -ENOMEM;
 
+	hs_jack_gpios[0].gpiod_dev = &z2_snd_device->dev;
 	platform_set_drvdata(z2_snd_device, &snd_soc_z2);
 	ret = platform_device_add(z2_snd_device);
 
-- 
2.20.0

