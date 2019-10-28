Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409E3CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AED20862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yo43dKTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbfJ1HVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:21:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35787 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbfJ1HVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:21:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id c8so6306682pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUhk5jTAsWRL5Pgp1XZmlvQGKoI7BAgOCvrW+D56pp8=;
        b=Yo43dKTsLFI2tpCk/GgsHgDLpV+n2oMVkqjTgO+WYW98xLPnu23m035x0k0FFAwWD/
         gczA73kwm3uhx7jLU5FLzQZw/Ubg0uP8yeTUVnnyhEvFgMAEQNKsSnuElq/670f6y+Ku
         z3qyMCqSVAu4461D9BPtH/1Axex3l9sm48Zgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUhk5jTAsWRL5Pgp1XZmlvQGKoI7BAgOCvrW+D56pp8=;
        b=LCgvZaVZeVeGTzeiBYFqNDdR1Tr7OnetMYk6zvSfHJr54SccljEvQ0rI+GDUpVZ/Yh
         BvfM+1jVrut5jEbKUevjiLhDIrIHKOt+A38vfuhrMqD2ruYd0LWmysuG3PxYzXku0MgY
         zkXqWLAVZ7RzgEbWez7v1vyC98YmfeOBITvd8XMmsTUdAc2JusOnZxJzbGkuD2vydhXM
         yEQGDk6ITYwv9XehrK2buCdBiK6N+NxUASiIvNtAfeLnVOHShQSXFmqrz8TIJvLfD/LA
         3pq+3A/A6LrAJTk34fjtXXuZjkVsUf4xpCv0IAouoJRyhmuK08QgDsOMWUHonv+LLjXr
         XbUA==
X-Gm-Message-State: APjAAAWzDoobOSb5vuSrgkPkf2uDQbxt4KTswSzCYWsRQbaPR6g1FBVS
        NQ1ryAs1189D2hJFpXquAMdsh4gJl+87+g==
X-Google-Smtp-Source: APXvYqy6ZYQwqRKjHWv8HOFkIQORoUhla1Awdt24VrWxKo9d5Y3WupcjPEJUg0uuNFjLJP2Twq29Cw==
X-Received: by 2002:a63:734e:: with SMTP id d14mr12627496pgn.357.1572247275466;
        Mon, 28 Oct 2019 00:21:15 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id r28sm9256164pfl.37.2019.10.28.00.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 00:21:14 -0700 (PDT)
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
Subject: [PATCH v9 4/6] ASoC: rockchip_max98090: Add HDMI jack support
Date:   Mon, 28 Oct 2019 15:19:28 +0800
Message-Id: <20191028071930.145899-5-cychiang@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191028071930.145899-1-cychiang@chromium.org>
References: <20191028071930.145899-1-cychiang@chromium.org>
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
 sound/soc/rockchip/rockchip_max98090.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

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
index 50ef9b8e7ce4..5c2504a465f4 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -12,6 +12,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <sound/core.h>
+#include <sound/hdmi-codec.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -218,6 +219,25 @@ enum {
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
@@ -237,6 +257,7 @@ static struct snd_soc_dai_link rk_hdmi_dailinks[] = {
 	{
 		.name = "HDMI",
 		.stream_name = "HDMI",
+		.init = rk_hdmi_init,
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
@@ -259,6 +280,7 @@ static struct snd_soc_dai_link rk_max98090_hdmi_dailinks[] = {
 	[DAILINK_HDMI] = {
 		.name = "HDMI",
 		.stream_name = "HDMI",
+		.init = rk_hdmi_init,
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
-- 
2.24.0.rc0.303.g954a862665-goog

