Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF017C73C75
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D40D2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RjICyuOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfGJHIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:08:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42714 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfGJHIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:08:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so757170pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=opTBgfSTSFi3V1ce9YlYEnYQO/1kKdgFofPaGYJTBOY=;
        b=RjICyuOquidt6LyqOASElFqobDNn4mo6EWt1hQsD6iwRx26+bMSTRwY0lCmMrVaHSG
         6a47JWfUcXiJfqoCtNQ7lq7rjKXQcz2UUkE2pHMU2JgLeyFB7HyoZ+a4e8q03awEvrPl
         4wQTV2TDpVxnBFrbqJ7OGM83LJNpTu4ZxCalU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=opTBgfSTSFi3V1ce9YlYEnYQO/1kKdgFofPaGYJTBOY=;
        b=I7MnTbz5sniFwkqV1Mh6OwO9e552ihQ5EcKlaktUK3mYS6ZRMwTnaSsk35Sr2xjgdc
         7CTeiK8RxIt6N58WsCBlJf6uGcQlyrzZHKAyPmAb/MxooTLFX1NBd/8d/Xzwtw7ZJw5I
         1vaWPd1U9tQOdt6p3l0KlrdvA/3ewZFoiwbHBFkZLZPPB3CzT/ZczU3N3BpIwPKSo5K6
         2KRQNLE4+RdO+cNcECDxIZlMjLSyNmnx4UAQWYq3UKZEIoD+B1XxVHdsuQR39VNoPKDf
         XFawhx6adtT4M9KZO8+0us9E1cSfmH9lWDJFIrlrjq/msmdjZg2pcych5jq56eY/s6rE
         ZfFg==
X-Gm-Message-State: APjAAAWLLqXmW7Yo20+6MinBl41DGtnCFyJQsP2FiywA85hlds+EglR3
        Q3fO0ho2y7XdIxKG2fQOQTCUpJlhgDc=
X-Google-Smtp-Source: APXvYqyla6Le8Sl5C5IFq+BMbhDM8PgxLabMwmqWmWurGv0zA2QcXauHAgdORrx2hOafDqZMEhT1zA==
X-Received: by 2002:a65:4045:: with SMTP id h5mr36503650pgp.247.1562742532604;
        Wed, 10 Jul 2019 00:08:52 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id b36sm3319370pjc.16.2019.07.10.00.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 00:08:52 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 4/4] ASoC: rockchip_max98090: Add HDMI jack support
Date:   Wed, 10 Jul 2019 15:07:51 +0800
Message-Id: <20190710070751.260061-5-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190710070751.260061-1-cychiang@chromium.org>
References: <20190710070751.260061-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In machine driver, create a jack and let hdmi-codec report jack status.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 3617012692ea..177c8a7ec8de 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -15,6 +15,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/hdmi-codec.h>
 
 #include "rockchip_i2s.h"
 #include "../codecs/ts3a227e.h"
@@ -133,6 +134,25 @@ enum {
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
 /* max98090 and HDMI codec dai_link */
 static struct snd_soc_dai_link rk_dailinks[] = {
 	[DAILINK_MAX98090] = {
@@ -150,6 +170,7 @@ static struct snd_soc_dai_link rk_dailinks[] = {
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+		.init = rk_hdmi_init,
 		SND_SOC_DAILINK_REG(hdmi),
 	}
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

