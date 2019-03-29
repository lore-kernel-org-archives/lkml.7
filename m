Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C36C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF730218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="hUbiP6/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfC2VvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:51:01 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36278 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfC2VvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553896257; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=wkpCQ/XRRAPuFOdrcQfHW7MIhSu/wQWwkPELiLIoap4=;
        b=hUbiP6/JIx6Mkv2WeovIt7OCcfk375+8w7aOoQllaquwx1WuJyLONg3eRi4dX+NkWTyewn
        vPBt9nxSSDzhqZhgsl3hVrTE5GsbdGlbg6XF+LqdBHst2HePSLPBhaBZyvsn3zuRv0jyxW
        k3NpV3waavpij0nEHHkNOmgUXIDTk5g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] ASoC: es8316: Add support for inverted jack detect
Date:   Fri, 29 Mar 2019 22:50:43 +0100
Message-Id: <20190329215045.6254-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some devices (Teclast X98+ II tablet, maybe others), the jack
detection has been wired backwards, so when the ES8316 reports
headphones being present it means they are actually not plugged.

Use a quirk around this incorrect behaviour, which can be enabled
through the 'everest,jack-detect-inverted' boolean device property.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/es8316.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 6d4a323f786b..ec2770b3f77d 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -43,6 +43,7 @@ struct es8316_priv {
 	unsigned int sysclk;
 	unsigned int allowed_rates[NR_SUPPORTED_MCLK_LRCK_RATIOS];
 	struct snd_pcm_hw_constraint_list sysclk_constraints;
+	bool jd_inverted;
 };
 
 /*
@@ -577,6 +578,9 @@ static irqreturn_t es8316_irq(int irq, void *data)
 	if (!es8316->jack)
 		goto out;
 
+	if (es8316->jd_inverted)
+		flags ^= ES8316_GPIO_FLAG_HP_NOT_INSERTED;
+
 	dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
 	if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
 		/* Jack removed, or spurious IRQ? */
@@ -592,6 +596,8 @@ static irqreturn_t es8316_irq(int irq, void *data)
 		/* Jack inserted, determine type */
 		es8316_enable_micbias_for_mic_gnd_short_detect(comp);
 		regmap_read(es8316->regmap, ES8316_GPIO_FLAG, &flags);
+		if (es8316->jd_inverted)
+			flags ^= ES8316_GPIO_FLAG_HP_NOT_INSERTED;
 		dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
 		if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
 			/* Jack unplugged underneath us */
@@ -633,6 +639,14 @@ static void es8316_enable_jack_detect(struct snd_soc_component *component,
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 
+	/*
+	 * Init es8316->jd_inverted here and not in the probe, as we cannot
+	 * guarantee that the bytchr-es8316 driver, which might set this
+	 * property, will probe before us.
+	 */
+	es8316->jd_inverted = device_property_read_bool(component->dev,
+							"everest,jack-detect-inverted");
+
 	mutex_lock(&es8316->lock);
 
 	es8316->jack = jack;
-- 
2.11.0

