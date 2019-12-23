Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE34C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CBB2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="OQheLzYK";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="OQheLzYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLWPsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:48:02 -0500
Received: from node.akkea.ca ([192.155.83.177]:38992 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfLWPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:47:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id A26024E201A;
        Mon, 23 Dec 2019 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1577116074; bh=WqmvSpCpKdfEKGMrhNPJ7uiAMSHmxyw8X3Se1/YVDR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OQheLzYKE9s1TnbenSYyXx03UE/6UOn2CCyMI4T/mbVfdzkd4u2rjMOV+MKqt5yim
         AtPEgyto7OeFqdkjr3306FXxQM4C1MA5bYZqjerTPr6qBo08H+Gm2IQrObiBWt8Q3k
         TMec4N1J32ByymT/QeeBi/Enptz8ZX+61ABIr32E=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W_oXF-J36k12; Mon, 23 Dec 2019 15:47:54 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 1AD9E4E2006;
        Mon, 23 Dec 2019 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1577116074; bh=WqmvSpCpKdfEKGMrhNPJ7uiAMSHmxyw8X3Se1/YVDR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OQheLzYKE9s1TnbenSYyXx03UE/6UOn2CCyMI4T/mbVfdzkd4u2rjMOV+MKqt5yim
         AtPEgyto7OeFqdkjr3306FXxQM4C1MA5bYZqjerTPr6qBo08H+Gm2IQrObiBWt8Q3k
         TMec4N1J32ByymT/QeeBi/Enptz8ZX+61ABIr32E=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     broonie@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm, robh@kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v4 1/2] ASoC: gtm601: add Broadmobi bm818 sound profile
Date:   Mon, 23 Dec 2019 07:47:11 -0800
Message-Id: <20191223154712.18581-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223154712.18581-1-angus@akkea.ca>
References: <20191223154712.18581-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadmobi bm818 uses stereo sound at 48Khz sample rate

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 sound/soc/codecs/gtm601.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index d454294c8d06..7f05ebcb88d1 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/device.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
@@ -47,6 +47,24 @@ static struct snd_soc_dai_driver gtm601_dai = {
 	},
 };
 
+static struct snd_soc_dai_driver bm818_dai = {
+	.name = "bm818",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
 static const struct snd_soc_component_driver soc_component_dev_gtm601 = {
 	.dapm_widgets		= gtm601_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(gtm601_dapm_widgets),
@@ -60,13 +78,19 @@ static const struct snd_soc_component_driver soc_component_dev_gtm601 = {
 
 static int gtm601_platform_probe(struct platform_device *pdev)
 {
+	const struct snd_soc_dai_driver *dai_driver;
+
+	dai_driver = of_device_get_match_data(&pdev->dev);
+
 	return devm_snd_soc_register_component(&pdev->dev,
-			&soc_component_dev_gtm601, &gtm601_dai, 1);
+			&soc_component_dev_gtm601,
+			(struct snd_soc_dai_driver *)dai_driver, 1);
 }
 
 #if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
-	{ .compatible = "option,gtm601", },
+	{ .compatible = "option,gtm601", .data = (void *)&gtm601_dai },
+	{ .compatible = "broadmobi,bm818", .data = (void *)&bm818_dai },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
-- 
2.17.1

