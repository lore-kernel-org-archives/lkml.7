Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABF9ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9912190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbfJAOWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:22:17 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388894AbfJAOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:22:15 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfHIb-1hdFVk2Qsl-00gpsk; Tue, 01 Oct 2019 16:21:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link failure
Date:   Tue,  1 Oct 2019 16:20:55 +0200
Message-Id: <20191001142116.1172290-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+NFFLFJ3uAstZ1v7XE2zMOHO+xPwR8CCKuSDvkVLAs/dyvEYV3F
 aaVJU2YkvLHOqLAuS7f9B4FjeRy1ETJZw1B302gdLNKywdIJI+RHoRz829Uot1Xqu5n044o
 QDcIQIsRro/+0s1ix2XUe/LSCIcgkeSVbGW7ySGKqzSalU5mdCbZOP7CNNnpJVyM5u+p3wZ
 otEMA5Wodj9hFYD6bq/gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nYhBuPR5Iho=:ywwtGfzj2glibkVf1yv+gi
 4DmdK8oqUXYdcCXJg3dN4ao1auIJ7AoklVMPqXSk/ASTz2mL0PLYizTJwV7BjfkihoLUh6Rmv
 gRaA29X3chqm9b2h2HCkJAtzoqkI+MdFw+DFakAUqJHjwVKtaD1B5iK4vcwDQSGF3sKKK48Vn
 nBmhc5OwHOrYWL5qaHUF7W4h8K0BGDRQOtzWx0CVAkKdg/I5Xrbd814iywOfdzKxspYPuZ6zw
 41RjVQdSMCKa7rz/A0bVPGfA6Hb9ksfWfqMJK5Gmzlh8xzisujMCBPGjxkfmWxHgnjDFelVlS
 AHzS0a2B7ClTvXIlZ8Z6h9evppl4mCSjpioDFzzo9tk8yL6peEDWUbTwBABFbZ9vcO4toPwql
 4JLP5+nRC5qaeDPJhGs2ndvbNJsnRJYdQ/vN0yXQR+BFHcPvN/mg8DFevnbOJLLXDIi1o/nwK
 L6c9geQnbF9WBynAIo26Vzx9XbYDxAhLCwrSMcOfK0eFxxjaT7Igur2ZIsKKzcKGYz03lAz+h
 Drp2B/kIsjfgxR8oVoY7R3rhOKGGTaag7KkeiHTGe6Klv3B2883391qk/m6l8lfnn9YrYSfVD
 ySiKlqfnENrqraZsrxcryA4IpXnirQfUIqZPTUvookUNafdlET8LIFvPhDcGqjr+19Cb1G8Yv
 oOMefwPdLKX6oo8FyfrrobfB25WEL2laYKjxwbmjBmBOP82IZssbaHWSDFUvpH4cuaqhF2Dn+
 UZNAUt0yKZaP4fmpNMt879HOaqhwi3vk63z1kWPYXWueVrqayPKcAbKN7xl2dX2TBXiX5OxON
 xb2I1BdJnYNtZsLCKWtYjIyHK1k6DE5IutltpsdfFQecZkMafzDOFmuBQmD5PURSV2aXgh12e
 V4PLmfYOqg71TeZg6aeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ssc audio driver can call into both pdc and dma backends.  With the
latest rework, the logic to do this in a safe way avoiding link errors
was removed, bringing back link errors that were fixed long ago in commit
061981ff8cc8 ("ASoC: atmel: properly select dma driver state") such as

sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
atmel_ssc_dai.c:(.text+0xac): undefined reference to `atmel_pcm_pdc_platform_register'

Fix it this time using Makefile hacks and a comment to prevent this
from accidentally getting removed again rather than Kconfig hacks.

Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/atmel/Kconfig  |  4 ++--
 sound/soc/atmel/Makefile | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index f118c229ed82..25c31bf64936 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -10,11 +10,11 @@ config SND_ATMEL_SOC
 if SND_ATMEL_SOC
 
 config SND_ATMEL_SOC_PDC
-	tristate
+	bool
 	depends on HAS_DMA
 
 config SND_ATMEL_SOC_DMA
-	tristate
+	bool
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_ATMEL_SOC_SSC
diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
index 1f6890ed3738..c7d2989791be 100644
--- a/sound/soc/atmel/Makefile
+++ b/sound/soc/atmel/Makefile
@@ -6,8 +6,14 @@ snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
 snd-soc-atmel-i2s-objs := atmel-i2s.o
 snd-soc-mchp-i2s-mcc-objs := mchp-i2s-mcc.o
 
-obj-$(CONFIG_SND_ATMEL_SOC_PDC) += snd-soc-atmel-pcm-pdc.o
-obj-$(CONFIG_SND_ATMEL_SOC_DMA) += snd-soc-atmel-pcm-dma.o
+# pdc and dma need to both be built-in if any user of
+# ssc is built-in.
+ifdef CONFIG_SND_ATMEL_SOC_PDC
+obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel-pcm-pdc.o
+endif
+ifdef CONFIG_SND_ATMEL_SOC_DMA
+obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel-pcm-dma.o
+endif
 obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o
 obj-$(CONFIG_SND_ATMEL_SOC_I2S) += snd-soc-atmel-i2s.o
 obj-$(CONFIG_SND_MCHP_SOC_I2S_MCC) += snd-soc-mchp-i2s-mcc.o
-- 
2.20.0

