Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6B2218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nsduvsR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfC2VvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:51:04 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36294 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbfC2VvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553896259; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TtEmpZMZnbpdUHF6uM8vaeS8qnRXYao2ZAuXyJwcNZc=;
        b=nsduvsR2E6JDtcSPkRV4gIlYkXjJGNTbWClPHWRHbPnUqk1gDXc+/a1+bKHJCb1XSZgArG
        OzCKYzXv88UTtbByxAiYtE/3EjvoEU/kPDEjsWK6G/DeTuq26XNV71N/3piESCVnNkKm0A
        TaoCWfT+zWatUjoU93T/wlYeV4/gHZ0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] ASoC: Intel: bytcht_es8316: Add quirk for inverted jack detect
Date:   Fri, 29 Mar 2019 22:50:44 +0100
Message-Id: <20190329215045.6254-2-paul@crapouillou.net>
In-Reply-To: <20190329215045.6254-1-paul@crapouillou.net>
References: <20190329215045.6254-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk to support boards whose jack detection mechanism is
inverted.

It will set the 'everest,jack-detect-inverted' boolean device property
for the es8316 codec driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/intel/boards/bytcht_es8316.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index d2a7e6ba11ae..e59ef61e1fd0 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -40,6 +40,9 @@
 #include "../atom/sst-atom-controls.h"
 #include "../common/sst-dsp.h"
 
+/* jd-inv + terminating entry */
+#define MAX_NO_PROPS 2
+
 struct byt_cht_es8316_private {
 	struct clk *mclk;
 	struct snd_soc_jack jack;
@@ -55,6 +58,7 @@ enum {
 #define BYT_CHT_ES8316_MAP(quirk)		((quirk) & GENMASK(3, 0))
 #define BYT_CHT_ES8316_SSP0			BIT(16)
 #define BYT_CHT_ES8316_MONO_SPEAKER		BIT(17)
+#define BYT_CHT_ES8316_JD_INVERTED		BIT(18)
 
 static int quirk;
 
@@ -72,6 +76,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk SSP0 enabled");
 	if (quirk & BYT_CHT_ES8316_MONO_SPEAKER)
 		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
+	if (quirk & BYT_CHT_ES8316_JD_INVERTED)
+		dev_info(dev, "quirk JD_INVERTED enabled\n");
 }
 
 static int byt_cht_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
@@ -438,12 +444,14 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
 	static const char * const mic_name[] = { "in1", "in2" };
+	struct property_entry props[MAX_NO_PROPS] = {};
 	struct byt_cht_es8316_private *priv;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
 	const char *platform_name;
 	const char *i2c_name = NULL;
 	struct device *codec_dev;
+	unsigned int cnt = 0;
 	int dai_index = 0;
 	int i;
 	int ret = 0;
@@ -512,6 +520,15 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	if (!codec_dev)
 		return -EPROBE_DEFER;
 
+	if (quirk & BYT_CHT_ES8316_JD_INVERTED)
+		props[cnt++] = PROPERTY_ENTRY_BOOL("everest,jack-detect-inverted");
+
+	if (cnt) {
+		ret = device_add_properties(codec_dev, props);
+		if (ret)
+			return ret;
+	}
+
 	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
 	priv->speaker_en_gpio =
 		gpiod_get_index(codec_dev, "speaker-enable", 0,
-- 
2.11.0

