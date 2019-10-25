Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CEC21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FkUSFr19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504749AbfJYNbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:31:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46378 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440405AbfJYNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:31:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id b25so1571039pfi.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkuQyVXMMyDZQEt3+CjrZIj+e3tZqkaRw9M9fK6dE0A=;
        b=FkUSFr19U5KiA2qhu5pPmrV/ZY3HrBv7vjJg0Wwe8AaE8M1PUpa9xnHOTXOUZE4xB1
         HFKCiPCrF+GU4ZFfCgL9nza4rfRQc8wRxfNAKRq7jSnbcsfLqlwk2aohnXe3wMuvrCGz
         ldWZJPNk0j6Qc0UMX62VQjJeC6YjNt7KNPLbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkuQyVXMMyDZQEt3+CjrZIj+e3tZqkaRw9M9fK6dE0A=;
        b=Ep3Cj84SRoEtfG0Zu+WAfkgRmoXNR7KfBLlD9xg/ylAmHJWwEATQstoBRWD0BiTpiC
         DNdwBAQoshNBCMLEaYm14zDbncd50dwtKz30Znj2ZBHkTJYAQzHj0G5LT3PKaY6HPxx8
         Of7LNqs0QVw01PyAQle+RH36aulSixXbHqP6JgG3Fw1nWEE2SW3cC4HgEiOQp0iCUdaj
         Kr5ELSQgek45pa9sDbu0F81+n1HQ8SLJw0UNOu9bNe5R+4XGDpoT8Qbf8VIhHtMO8bs8
         pK9WKT+vFIhTuMOe3fMaqISQXMGKcX1OyzP/4/8YEWPAPjQZ7aeUyGQ/6CBWekE4ZVi2
         lEtA==
X-Gm-Message-State: APjAAAWuTM5f1I41Gk9odVB9U1Fpo5V570N0lLyijqi2DjJjefajT/E9
        cGei7yi3o3EX+IiIB05RMYr2pnbVkXiL6Q==
X-Google-Smtp-Source: APXvYqypx1iOOLXyzbMO61gMPyKWIWC+7EwZjaBPtphFD0tkNUyB/PtgGJIIMnLo6epNgm/8d1yPOA==
X-Received: by 2002:a63:4304:: with SMTP id q4mr4294927pga.218.1572010268293;
        Fri, 25 Oct 2019 06:31:08 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id q33sm2430940pgm.50.2019.10.25.06.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 06:31:07 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v8 4/6] ASoC: rockchip_max98090: Add HDMI jack support
Date:   Fri, 25 Oct 2019 21:30:05 +0800
Message-Id: <20191025133007.11190-5-cychiang@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025133007.11190-1-cychiang@chromium.org>
References: <20191025133007.11190-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In machine driver, create a jack and let hdmi-codec report jack status.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/Kconfig             |  3 ++-
 sound/soc/rockchip/rockchip_max98090.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index b43657e6e655..d610b553ea3b 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -40,9 +40,10 @@ config SND_SOC_ROCKCHIP_MAX98090
 	select SND_SOC_ROCKCHIP_I2S
 	select SND_SOC_MAX98090
 	select SND_SOC_TS3A227E
+	select SND_SOC_HDMI_CODEC
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
-	  boards using the MAX98090 codec, such as Veyron.
+	  boards using the MAX98090 codec and HDMI codec, such as Veyron.
 
 config SND_SOC_ROCKCHIP_RT5645
 	tristate "ASoC support for Rockchip boards using a RT5645/RT5650 codec"
diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 550e57789719..fdd1d9921a4e 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -230,6 +230,25 @@ enum {
 	DAILINK_HDMI,
 };
 
+static struct snd_soc_jack rk_hdmi_jack;
+
+static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_component *component = runtime->codec_dai->component;
+	int ret;
+
+	/* enable jack detection */
+	ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &rk_hdmi_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
+		return ret;
+	}
+
+	return hdmi_codec_set_jack_detect(component, &rk_hdmi_jack);
+}
+
 /* max98090 dai_link */
 static struct snd_soc_dai_link rk_max98090_dailinks[] = {
 	{
@@ -249,6 +268,7 @@ static struct snd_soc_dai_link rk_hdmi_dailinks[] = {
 	{
 		.name = "HDMI",
 		.stream_name = "HDMI",
+		.init = rk_hdmi_init,
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
@@ -271,6 +291,7 @@ static struct snd_soc_dai_link rk_max98090_hdmi_dailinks[] = {
 	[DAILINK_HDMI] = {
 		.name = "HDMI",
 		.stream_name = "HDMI",
+		.init = rk_hdmi_init,
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
-- 
2.24.0.rc0.303.g954a862665-goog

