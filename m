Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E12173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD1HY0H2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfC2CAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:00:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45980 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfC2CAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:00:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so249203pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9mFNMPw/QqsPqy7z42cyHVgjXHf3L4n2v/4T6hDyU3k=;
        b=pD1HY0H2AkUwC5ez7LWSNW0wENVttMfNRkxe6ruo9yyVGmD8PQi8wHNodzbr2SrAz1
         Lv4Ip8Mjt2MduyXPjjBsSmnDMlezrBpSCAMh46/3CTRYAeoK8ryf8YyfDTpCsJaJrHcy
         9dwz1W+GWRRvv92gsSKBtAKux61AeF6pThB6VoCrTK/7xRWP32WnqB3Hl0fhrPyfSnPT
         8AKI85hZu4VCDCs/oeXSVAJsphIqTjd00Cyca2j9BK7YdE/i0Gptz66eIAAQ7RP2Szqq
         NWLAZ1r9bal69xAsmH7dQCsst2HKRXUosTCgN/nbrqYJNnsmengTTCduRCa0Cm1WiSUh
         u5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9mFNMPw/QqsPqy7z42cyHVgjXHf3L4n2v/4T6hDyU3k=;
        b=Hec2hKt827zvP7Eh904dKOydvltBgFbzlI1nJB/n9SRGkU5Iu5bfcdvWj/QEsGr3iW
         IdYLa2/bTj0aolbE8PbbmSvH62BfYC+bLASs5egtsfSx9IeWhWl4Tk7SMUqf2Z0v9Vkp
         EpiYPMinQn7Hk8mbvafzLUSg6FSeLbw+Z5cE926EnK+SkQP06dCJ5eC04z5ZzqMVtwG6
         I5qHVhIMmed15I/P7Zs5rKZ+qBxwdpAlx9UOLA8fsUODdeiSKkod0WFXf69nwqTu81hs
         ZZzlXcn2colPVgD6RqwqZIzWZgj91mNW8Z3Ou/hLCIgK9/rDnIMtOocMlzupXZO2z4Pc
         Ht1Q==
X-Gm-Message-State: APjAAAUbxgC2fNV7+1ztlF6VSKxvG40JZoJLdYvkD6zBHcCcRSnS9Gi4
        q6jPsmI+yCcyNtC+3tV03jU=
X-Google-Smtp-Source: APXvYqyA3faPZm9DPg6+5laCJz73cNffztZ6C2eQlqKFjP/jm2ipt+FFssxn/amc1zw9S88N/jbRRw==
X-Received: by 2002:aa7:9193:: with SMTP id x19mr35924480pfa.108.1553824832833;
        Thu, 28 Mar 2019 19:00:32 -0700 (PDT)
Received: from ubuntu.huaqin.com ([220.232.156.66])
        by smtp.gmail.com with ESMTPSA id n65sm666279pfb.160.2019.03.28.19.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 19:00:31 -0700 (PDT)
From:   tony.zou.hq@gmail.com
To:     alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org
Cc:     dbasehore@chromium.org,
        Tony Zou <zoutao@huaqin.corp-partner.google.com>
Subject: [PATCH] max98357a:add dai without triggered by pcm
Date:   Fri, 29 Mar 2019 09:51:59 +0800
Message-Id: <1553824319-2155-1-git-send-email-tony.zou.hq@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Zou <zoutao@huaqin.corp-partner.google.com>

max98357a's enable pin need setting independently
when max98357a is shared I2S with other codec.

add dai "max98357a-hifi" without pcm trigger,
and use "Spk PA Switch" to set the enable pin.

Signed-off-by: Tony Zou <zoutao@huaqin.corp-partner.google.com>
---
 sound/soc/codecs/max98357a.c |   94 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d469576..bd3e77b 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -51,12 +51,52 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static const char * const ext_spk_text[] = {
+	"Off", "On"
+};
+
+static const struct soc_enum ext_spk_enum =
+	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			ARRAY_SIZE(ext_spk_text), ext_spk_text);
+
+
+static const struct snd_kcontrol_new ext_spk_mux =
+	SOC_DAPM_ENUM("Spk PA Switch", ext_spk_enum);
+
+
+static int max98357a_enable_spk_pa(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct gpio_desc *sdmode = snd_soc_component_get_drvdata(cmpnt);
+
+	if (!sdmode)
+		return 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		gpiod_set_value(sdmode, 1);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		gpiod_set_value(sdmode, 0);
+		break;
+	}
+	return 0;
+}
+
+
 static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("Speaker"),
+	SND_SOC_DAPM_SPK("Spk PA", max98357a_enable_spk_pa),
+	SND_SOC_DAPM_MUX("Spk PA Switch", SND_SOC_NOPM, 0, 0,
+			&ext_spk_mux),
 };
 
 static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 	{"Speaker", NULL, "HiFi Playback"},
+	{"Speaker", NULL, "Spk PA"},
+	{"Spk PA", NULL, "Spk PA Switch"},
+	{"Spk PA Switch", "On", "HiFi Playback1"},
 };
 
 static int max98357a_component_probe(struct snd_soc_component *component)
@@ -88,30 +128,50 @@ static int max98357a_component_probe(struct snd_soc_component *component)
 	.trigger	= max98357a_daiops_trigger,
 };
 
-static struct snd_soc_dai_driver max98357a_dai_driver = {
-	.name = "HiFi",
-	.playback = {
-		.stream_name	= "HiFi Playback",
-		.formats	= SNDRV_PCM_FMTBIT_S16 |
-					SNDRV_PCM_FMTBIT_S24 |
-					SNDRV_PCM_FMTBIT_S32,
-		.rates		= SNDRV_PCM_RATE_8000 |
-					SNDRV_PCM_RATE_16000 |
-					SNDRV_PCM_RATE_48000 |
-					SNDRV_PCM_RATE_96000,
-		.rate_min	= 8000,
-		.rate_max	= 96000,
-		.channels_min	= 1,
-		.channels_max	= 2,
+static struct snd_soc_dai_driver max98357a_dai_driver[] = {
+	{
+		.name = "HiFi",
+		.playback = {
+			.stream_name	= "HiFi Playback",
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+						SNDRV_PCM_FMTBIT_S24 |
+						SNDRV_PCM_FMTBIT_S32,
+			.rates		= SNDRV_PCM_RATE_8000 |
+						SNDRV_PCM_RATE_16000 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_96000,
+			.rate_min	= 8000,
+			.rate_max	= 96000,
+			.channels_min	= 1,
+			.channels_max	= 2,
+		},
+		.ops    = &max98357a_dai_ops,
+	},
+	{
+		.name = "max98357a-hifi",
+		.playback = {
+			.stream_name	= "HiFi Playback1",
+			.formats	= SNDRV_PCM_FMTBIT_S16 |
+						SNDRV_PCM_FMTBIT_S24 |
+						SNDRV_PCM_FMTBIT_S32,
+			.rates		= SNDRV_PCM_RATE_8000 |
+						SNDRV_PCM_RATE_16000 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_96000,
+			.rate_min	= 8000,
+			.rate_max	= 96000,
+			.channels_min	= 1,
+			.channels_max	= 2,
+		},
+		.ops    = NULL,
 	},
-	.ops    = &max98357a_dai_ops,
 };
 
 static int max98357a_platform_probe(struct platform_device *pdev)
 {
 	return devm_snd_soc_register_component(&pdev->dev,
 			&max98357a_component_driver,
-			&max98357a_dai_driver, 1);
+			max98357a_dai_driver, ARRAY_SIZE(max98357a_dai_driver));
 }
 
 static int max98357a_platform_remove(struct platform_device *pdev)
-- 
1.7.9.5

