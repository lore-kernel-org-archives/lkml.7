Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE838C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848D121721
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JCgKaHji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfHLMHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfHLMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so11932629wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc9/cSBhIwTuXPvQDL6txYFXAJblot8ynaeVI0KB+kI=;
        b=JCgKaHjiK9nXytoYeRJc1oNQnDr/iTA4L8Cs/nMSQTvwrHCjI8V6q/fMKElW1iq4kH
         QVfNygjYCJLIR2X+73dkH1YWR5jd4IZKoHby+j8qpmF4XhZajY4Kjk0JETHWN8nefT3I
         BfO806OgbneAJNQFFiN1knQc1xLRpBUENeHPFywv44hICM1gob6lINnEr6lMqhzVnZI0
         45ko6hz6x7sRZ4R5nYlMEf5MlYQPrQ0o3lAqjqwFZ8KdHKkua1sCJd0NOmLrjZP+qAlF
         e2qBWgoDEBeqiW5bZLuERfieGV41O7+oENtJiTUejXx6Sj1XEVjw8F1jz4H8xldgpDiF
         UFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc9/cSBhIwTuXPvQDL6txYFXAJblot8ynaeVI0KB+kI=;
        b=AZOnZejPrJ7yvj5lPUuX2Xz+Xa/uKqZKACxShTfmiULZu4tktHDDiAI0COb1fDVzug
         Jz6eQ4FSSE0tXTWpaM6kLGddB3iIt5kmV/myJSXwwK63s7SxJ4wOfaicESBJUqdPXzYc
         8sDY8Rd95LAYrdWWfnMDweBuYzleOdRzZZXB6C7q608PlG0gW5HfOjxFzQ51ZpfJJezp
         zeEqwkNC1/jTZc40q+OYR9HShr33PjmCopO4DBWyzsiXZW7Qrs6k/vNbNTEE42S6GD8V
         j8eEQBalTS+laOlgmbvhEqaPVVZpUJd0pkEx91n7nfSu6C85DsH5y4zXZMCXfBbBDfji
         hSsQ==
X-Gm-Message-State: APjAAAV/9oYqzwbdE+W01EIW7IzvRSUkoNhN8hu+UDDEohQ+3RdCZRq0
        ysVNp0wABbW8tXmEA2BRirAoNw==
X-Google-Smtp-Source: APXvYqyA8FXUTAV5OWQlM4IOpnMuM4a1amICXKUVnbBgBqhQLoLXQVYGeXcaLrL4ghbO8MhHX2OFhw==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr28033074wmg.111.1565611657147;
        Mon, 12 Aug 2019 05:07:37 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j9sm1883415wrx.66.2019.08.12.05.07.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:07:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 8/8] drm/bridge: dw-hdmi-i2s: add .get_eld support
Date:   Mon, 12 Aug 2019 14:07:26 +0200
Message-Id: <20190812120726.1528-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812120726.1528-1-jbrunet@baylibre.com>
References: <20190812120726.1528-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the eld to the generic hdmi-codec driver.
This will let the driver enforce the maximum channel number and set the
channel allocation depending on the hdmi sink.

Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h     |  1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 11 +++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           |  1 +
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
index 63b5756f463b..cb07dc0da5a7 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
@@ -14,6 +14,7 @@ struct dw_hdmi_audio_data {
 
 struct dw_hdmi_i2s_audio_data {
 	struct dw_hdmi *hdmi;
+	u8 *eld;
 
 	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read)(struct dw_hdmi *hdmi, int offset);
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index b8ece9c1ba2c..62e737b81462 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 
 #include <drm/bridge/dw_hdmi.h>
+#include <drm/drm_crtc.h>
 
 #include <sound/hdmi-codec.h>
 
@@ -121,6 +122,15 @@ static void dw_hdmi_i2s_audio_shutdown(struct device *dev, void *data)
 	dw_hdmi_audio_disable(hdmi);
 }
 
+static int dw_hdmi_i2s_get_eld(struct device *dev, void *data, uint8_t *buf,
+			       size_t len)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+
+	memcpy(buf, audio->eld, min(sizeof(MAX_ELD_BYTES), len));
+	return 0;
+}
+
 static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 				  struct device_node *endpoint)
 {
@@ -144,6 +154,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
 	.hw_params	= dw_hdmi_i2s_hw_params,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
+	.get_eld	= dw_hdmi_i2s_get_eld,
 	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
 };
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index bed4bb017afd..8df69c9dbfad 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2797,6 +2797,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		struct dw_hdmi_i2s_audio_data audio;
 
 		audio.hdmi	= hdmi;
+		audio.eld	= hdmi->connector.eld;
 		audio.write	= hdmi_writeb;
 		audio.read	= hdmi_readb;
 		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
-- 
2.21.0

