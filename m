Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46683C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B41120856
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hbexc+aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfGEE1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:27:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42379 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGEE1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:27:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so3685719pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 21:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mt+OhzkdZXuABUeOm3oIQQxV+A0uMRzmq60uCRJmAJE=;
        b=Hbexc+aCBum/RZ12dI3r5/XyzyiK+MvJQgQ2XO3/HVioP3PM/nCddAlz1xrMohN7M1
         S0TUfchH1at/5Y1i17XhZAcSUqCKCip2aybO7YsuTVjIwJXSYImaa+d0n/+JHH0FYNkL
         NI0/aW8eXuQCvg6kpGPrNaIfIBqJ7QUDBMvFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mt+OhzkdZXuABUeOm3oIQQxV+A0uMRzmq60uCRJmAJE=;
        b=FtaXE/yQEiSDhqispDFZYWqn6WF7cMbVUXeqt5cij0AgEQGP88P2koWJvfMv69mmYb
         NqPzd7YlcmuLXUFxB2SH4tPhPNePWx0zVYtCgO3cNd1euUfHVmrMbLc6wawEULX2xl9f
         G2hMl2QJwWVdw9cWcp6brchgY6uQDaGyZgxVluZzPv22uXiHed79961aSZ/75vyyZTc/
         jCbGqpWLTkRDroYdyI25jXFlFvBit1bVM4PgqmFb5r+6kmwKjCvpB2XvzkbBOEW4nl4B
         Cs8keeDa3mNqtBxw4jawkjz++TrA5A+3GwaCujULM14S/MI1q88aOeasT4/UFlTlSzJu
         l0Bg==
X-Gm-Message-State: APjAAAU8+njoTh0Qgms7M5GK8rUsWj4j7rCPVQz7sYImKUaZ2SYQ3W0H
        kt3n0s3Uf8kvTljYfpaeg+fuA7JmRX0=
X-Google-Smtp-Source: APXvYqywd4tkamYO1Fai6BvXNjXkhsYojIRkBX4/rKYkl5GdlfV7TnbJIDpy2ZVfWAPldm8d1RwzHA==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr2081909pjo.94.1562300823498;
        Thu, 04 Jul 2019 21:27:03 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id t10sm6811920pjr.13.2019.07.04.21.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 21:27:02 -0700 (PDT)
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
Subject: [PATCH 4/4] ASoC: rockchip_max98090: Add HDMI jack support
Date:   Fri,  5 Jul 2019 12:26:23 +0800
Message-Id: <20190705042623.129541-5-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190705042623.129541-1-cychiang@chromium.org>
References: <20190705042623.129541-1-cychiang@chromium.org>
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
index 195309d1225a..c0e430ca4d12 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -15,6 +15,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/hdmi-codec.h>
 
 #include "rockchip_i2s.h"
 #include "../codecs/ts3a227e.h"
@@ -129,6 +130,25 @@ enum {
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
@@ -146,6 +166,7 @@ static struct snd_soc_dai_link rk_dailinks[] = {
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+		.init = rk_hdmi_init,
 		SND_SOC_DAILINK_REG(hdmi),
 	}
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

