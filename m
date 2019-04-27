Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F260C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312C6214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329136;
	bh=b6Y+v7GfqHgL1n17+OYWjET6ppeO7s472YVNnOFtXrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hNT7sX0mNHOickt0Y5bMn0NESmyUzjVlisZOu3F1FDnGWS33yGLYUceQnQWnrwQwv
	 IwS0FHZqi6W3x3CVyYXPd6OdKgdDC8ZTn8G886K/DeJAO917mBRUl96vly1oMbtXu9
	 8EV+631NKWTXxkn/BQ4YYf8ZfbPoZo/jw60ZZavk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfD0Biz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbfD0Biv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD62A212F5;
        Sat, 27 Apr 2019 01:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329130;
        bh=b6Y+v7GfqHgL1n17+OYWjET6ppeO7s472YVNnOFtXrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVs+a7VXuUWYl83dJPk8CUhkPaoUA2Rt8ywThEjqwsNf5Kijs085w8H8TtBsRtIxt
         oPL4sq/a94adhI4VhPKypX06KA/ePJ+a42c8O3XLfvgsfM12wUMLlfMqKmJOgXUm4c
         TI6nqAd++zuEM7nNUCv4Wp0b2KZx6aoZodtzcLVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Hsu <KCHSU0@nuvoton.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 11/79] ASoC: nau8824: fix the issue of the widget with prefix name
Date:   Fri, 26 Apr 2019 21:37:30 -0400
Message-Id: <20190427013838.6596-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hsu <KCHSU0@nuvoton.com>

[ Upstream commit 844a4a362dbec166b44d6b9b3dd45b08cb273703 ]

The driver has two issues when machine add prefix name for codec.
(1)The stream name of DAI can't find the AIF widgets.
(2)The drivr can enable/disalbe the MICBIAS and SAR widgets.

The patch will fix these issues caused by prefixed name added.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8824.c | 46 +++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 468d5143e2c4..663a208c2f78 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -681,8 +681,8 @@ static const struct snd_soc_dapm_widget nau8824_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("ADCR", NULL, NAU8824_REG_ANALOG_ADC_2,
 		NAU8824_ADCR_EN_SFT, 0),
 
-	SND_SOC_DAPM_AIF_OUT("AIFTX", "HiFi Capture", 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_IN("AIFRX", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIFTX", "Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIFRX", "Playback", 0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_DAC("DACL", NULL, NAU8824_REG_RDAC,
 		NAU8824_DACL_EN_SFT, 0),
@@ -831,6 +831,36 @@ static void nau8824_int_status_clear_all(struct regmap *regmap)
 	}
 }
 
+static void nau8824_dapm_disable_pin(struct nau8824 *nau8824, const char *pin)
+{
+	struct snd_soc_dapm_context *dapm = nau8824->dapm;
+	const char *prefix = dapm->component->name_prefix;
+	char prefixed_pin[80];
+
+	if (prefix) {
+		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
+			 prefix, pin);
+		snd_soc_dapm_disable_pin(dapm, prefixed_pin);
+	} else {
+		snd_soc_dapm_disable_pin(dapm, pin);
+	}
+}
+
+static void nau8824_dapm_enable_pin(struct nau8824 *nau8824, const char *pin)
+{
+	struct snd_soc_dapm_context *dapm = nau8824->dapm;
+	const char *prefix = dapm->component->name_prefix;
+	char prefixed_pin[80];
+
+	if (prefix) {
+		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
+			 prefix, pin);
+		snd_soc_dapm_force_enable_pin(dapm, prefixed_pin);
+	} else {
+		snd_soc_dapm_force_enable_pin(dapm, pin);
+	}
+}
+
 static void nau8824_eject_jack(struct nau8824 *nau8824)
 {
 	struct snd_soc_dapm_context *dapm = nau8824->dapm;
@@ -839,8 +869,8 @@ static void nau8824_eject_jack(struct nau8824 *nau8824)
 	/* Clear all interruption status */
 	nau8824_int_status_clear_all(regmap);
 
-	snd_soc_dapm_disable_pin(dapm, "SAR");
-	snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+	nau8824_dapm_disable_pin(nau8824, "SAR");
+	nau8824_dapm_disable_pin(nau8824, "MICBIAS");
 	snd_soc_dapm_sync(dapm);
 
 	/* Enable the insertion interruption, disable the ejection
@@ -870,8 +900,8 @@ static void nau8824_jdet_work(struct work_struct *work)
 	struct regmap *regmap = nau8824->regmap;
 	int adc_value, event = 0, event_mask = 0;
 
-	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
-	snd_soc_dapm_force_enable_pin(dapm, "SAR");
+	nau8824_dapm_enable_pin(nau8824, "MICBIAS");
+	nau8824_dapm_enable_pin(nau8824, "SAR");
 	snd_soc_dapm_sync(dapm);
 
 	msleep(100);
@@ -882,8 +912,8 @@ static void nau8824_jdet_work(struct work_struct *work)
 	if (adc_value < HEADSET_SARADC_THD) {
 		event |= SND_JACK_HEADPHONE;
 
-		snd_soc_dapm_disable_pin(dapm, "SAR");
-		snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+		nau8824_dapm_disable_pin(nau8824, "SAR");
+		nau8824_dapm_disable_pin(nau8824, "MICBIAS");
 		snd_soc_dapm_sync(dapm);
 	} else {
 		event |= SND_JACK_HEADSET;
-- 
2.19.1

