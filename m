Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04078C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8D120684
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Of/kzTfg";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Of/kzTfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfLBRso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:48:44 -0500
Received: from node.akkea.ca ([192.155.83.177]:34728 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfLBRsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:48:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id AB3454E201A;
        Mon,  2 Dec 2019 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575308921; bh=G5vaGCDrjN3o6pi2NVpdKXh0OAe+GAhoowcjoaH2b54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Of/kzTfgYvw4remviMNGT6ec9GPUDfmztvI21zCw3Yty2/9Zhj0MhTDBj6guJDf6k
         vn1pJbt3kKR8OaPp9ufsybizx73RazGUnF3IYFs4bJ26PH/SS7Zu8rHjW4ge5L0shz
         mr2gYYt5B+Q6Tsbsl4oqm7l5HT5DVqmdDiBhd8qU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qiB4KwjmIXlp; Mon,  2 Dec 2019 17:48:41 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
        by node.akkea.ca (Postfix) with ESMTPSA id 904B64E2006;
        Mon,  2 Dec 2019 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575308921; bh=G5vaGCDrjN3o6pi2NVpdKXh0OAe+GAhoowcjoaH2b54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Of/kzTfgYvw4remviMNGT6ec9GPUDfmztvI21zCw3Yty2/9Zhj0MhTDBj6guJDf6k
         vn1pJbt3kKR8OaPp9ufsybizx73RazGUnF3IYFs4bJ26PH/SS7Zu8rHjW4ge5L0shz
         mr2gYYt5B+Q6Tsbsl4oqm7l5HT5DVqmdDiBhd8qU=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 1/2] sound: codecs: gtm601: add Broadmobi bm818 sound profile
Date:   Mon,  2 Dec 2019 10:48:30 -0700
Message-Id: <20191202174831.13638-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202174831.13638-1-angus@akkea.ca>
References: <20191202174831.13638-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadmobi bm818 uses stereo sound at 48Khz sample rate

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 sound/soc/codecs/gtm601.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index d454294c8d06..302569bc46ff 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -37,7 +37,7 @@ static struct snd_soc_dai_driver gtm601_dai = {
 		.channels_max = 1,
 		.rates = SNDRV_PCM_RATE_8000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-		},
+	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
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
@@ -60,13 +78,20 @@ static const struct snd_soc_component_driver soc_component_dev_gtm601 = {
 
 static int gtm601_platform_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
+	struct snd_soc_dai_driver *dai_driver = &gtm601_dai;
+
+	if (np && of_device_is_compatible(np, "broadmobi,bm818"))
+		dai_driver = &bm818_dai;
+
 	return devm_snd_soc_register_component(&pdev->dev,
-			&soc_component_dev_gtm601, &gtm601_dai, 1);
+			&soc_component_dev_gtm601, dai_driver, 1);
 }
 
 #if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
 	{ .compatible = "option,gtm601", },
+	{ .compatible = "broadmobi,bm818", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
-- 
2.17.1

