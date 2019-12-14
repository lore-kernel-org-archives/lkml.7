Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D54C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 23:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F81C206E5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 23:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="bGI6A9XL";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="bGI6A9XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLNX4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 18:56:11 -0500
Received: from node.akkea.ca ([192.155.83.177]:38590 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfLNX4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 18:56:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 7475F4E201A;
        Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576367770; bh=BO3TEYl21sA/wMKA0yRtarf1F3XV3vT6Pf1Un5gTO5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bGI6A9XLGa6MrFrHhC6w/It3fZHvDUlVHSpv4YH6UM5fB8ANQqkwUddkNT6j6jelp
         uQuj/bSMwKUWYQp0eC7K9dq6NWoCoVvxlFDe8OQWbc0bWgRDd8pVfwDmVaOyTYyY37
         1i4dDF9W1EHREi8eiYhxD96w1Tctfebkff6ep59A=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JAx7lS-p9mz6; Sat, 14 Dec 2019 23:56:10 +0000 (UTC)
Received: from thinkpad-tablet.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id EFB2D4E2006;
        Sat, 14 Dec 2019 23:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576367770; bh=BO3TEYl21sA/wMKA0yRtarf1F3XV3vT6Pf1Un5gTO5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bGI6A9XLGa6MrFrHhC6w/It3fZHvDUlVHSpv4YH6UM5fB8ANQqkwUddkNT6j6jelp
         uQuj/bSMwKUWYQp0eC7K9dq6NWoCoVvxlFDe8OQWbc0bWgRDd8pVfwDmVaOyTYyY37
         1i4dDF9W1EHREi8eiYhxD96w1Tctfebkff6ep59A=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v2 1/2] sound: codecs: gtm601: add Broadmobi bm818 sound profile
Date:   Sat, 14 Dec 2019 15:55:49 -0800
Message-Id: <20191214235550.31257-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214235550.31257-1-angus@akkea.ca>
References: <20191214235550.31257-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadmobi bm818 uses stereo sound at 48Khz sample rate

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 sound/soc/codecs/gtm601.c | 46 ++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index d454294c8d06..44cdbd016761 100644
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
@@ -58,20 +76,32 @@ static const struct snd_soc_component_driver soc_component_dev_gtm601 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static int gtm601_platform_probe(struct platform_device *pdev)
-{
-	return devm_snd_soc_register_component(&pdev->dev,
-			&soc_component_dev_gtm601, &gtm601_dai, 1);
-}
-
 #if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
-	{ .compatible = "option,gtm601", },
+	{ .compatible = "option,gtm601", .data = (void *)&gtm601_dai },
+	{ .compatible = "broadmobi,bm818", .data = (void *)&bm818_dai },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
 #endif
 
+static int gtm601_platform_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct snd_soc_dai_driver *dai_driver = &gtm601_dai;
+	const struct of_device_id *id;
+
+#if defined(CONFIG_OF)
+	if (np) {
+		id = of_match_node(gtm601_codec_of_match, pdev->dev.of_node);
+		dai_driver = id->data;
+	}
+#endif
+
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_gtm601, dai_driver, 1);
+}
+
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
 		.name = "gtm601",
-- 
2.17.1

