Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A169C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ED621721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GwbrlVUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbfGPL5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:57:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32813 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPL5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:57:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so9019841pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 04:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1lZlgjuZ5YsBXGxwN2O98iHO8VeuCQpmfUBorVzSdU=;
        b=GwbrlVUpqaazjMVXn3NHzFyLVGKnk5Rg7RVnQHuNsGAtO8mPXKnye9uCoeX+vauFhd
         Hw2SkT+i+QuJraXbKv2XEc3SuAwDKqG5cUArnRb3n8L7O+QTcAN2UhePVXZNV8C4oGrZ
         5snHHzRo+mHxLKKPztCoau+UurTH8royt7fqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1lZlgjuZ5YsBXGxwN2O98iHO8VeuCQpmfUBorVzSdU=;
        b=ZGtxcOaHdMWyEpgMckM5KOrVJmgzuJwwO0QB/f9kiO20KpgAhAj1YsRsrpiziZRZpX
         lZ7M0VP6P2fOqreU0BV7FKAGxb8DkUiw4fU17JMG1ORWrSdO+BJ8P88KBsCSXFaI8RPF
         2PzaQtRAL40/1uFdyWV3N6JaJUIOwheSJoXkbizT1/S8doxCQwKVytQoVLgk5a6hA9dl
         VGNgtX7jLm2ygwRU0ry1sTsQ6LURJ9x4+hynF4vwx0idQV50jCUmG9SexjHzg2lTFuQd
         Sk1nNa9SxacYjKyIw3iezuXSJdbQLBL0mVpUAUlda5X1TW+1Y6zU0tjuOdUNwlAf0YsK
         pwuQ==
X-Gm-Message-State: APjAAAV5DkfzAMuPUBu6RXglzv8g0Lu9x+Flrha5maADTAFRK1FZ7YLO
        aIi8rPamUONA/woRmbqPrQqXGgzeZ6M=
X-Google-Smtp-Source: APXvYqwRqTsipX5V0CzKFsaRZ7PNY/CFKVh68u/8qEjLmqFbIU1wRLPapWu6EB84nXV7PuTo0kHOVw==
X-Received: by 2002:a63:66c5:: with SMTP id a188mr32864395pgc.127.1563278272115;
        Tue, 16 Jul 2019 04:57:52 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id a3sm21924234pfi.63.2019.07.16.04.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 04:57:51 -0700 (PDT)
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
Subject: [PATCH v4 2/5] drm: bridge: dw-hdmi: Report connector status using callback
Date:   Tue, 16 Jul 2019 19:57:22 +0800
Message-Id: <20190716115725.66558-3-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716115725.66558-1-cychiang@chromium.org>
References: <20190716115725.66558-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow codec driver register callback function for plug event.

The callback registration flow:
dw-hdmi <--- hw-hdmi-i2s-audio <--- hdmi-codec

dw-hdmi-i2s-audio implements hook_plugged_cb op
so codec driver can register the callback.

dw-hdmi exports a function dw_hdmi_set_plugged_cb so platform device
can register the callback.

When connector plug/unplug event happens, report this event using the
callback.

Make sure that audio and drm are using the single source of truth for
connector status.

Change the Kconfig of DRM_DW_HDMI so it selects SND_SOC_HDMI_CODEC.
This is for the typedef of hdmi_codec_plugged_cb to be used in dw-hdmi.c.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 drivers/gpu/drm/bridge/synopsys/Kconfig       |  2 +-
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 11 +++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 41 ++++++++++++++++++-
 include/drm/bridge/dw_hdmi.h                  |  4 ++
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
index 21a1be3ced0f..309da052db97 100644
--- a/drivers/gpu/drm/bridge/synopsys/Kconfig
+++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
@@ -4,6 +4,7 @@ config DRM_DW_HDMI
 	select DRM_KMS_HELPER
 	select REGMAP_MMIO
 	select CEC_CORE if CEC_NOTIFIER
+	select SND_SOC_HDMI_CODEC
 
 config DRM_DW_HDMI_AHB_AUDIO
 	tristate "Synopsys Designware AHB Audio interface"
@@ -20,7 +21,6 @@ config DRM_DW_HDMI_I2S_AUDIO
 	tristate "Synopsys Designware I2S Audio interface"
 	depends on SND_SOC
 	depends on DRM_DW_HDMI
-	select SND_SOC_HDMI_CODEC
 	help
 	  Support the I2S Audio interface which is part of the Synopsys
 	  Designware HDMI block.
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 5cbb71a866d5..ca56783fae47 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -104,10 +104,21 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 	return -EINVAL;
 }
 
+static int dw_hdmi_i2s_hook_plugged_cb(struct device *dev, void *data,
+				       hdmi_codec_plugged_cb fn,
+				       struct device *codec_dev)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+	struct dw_hdmi *hdmi = audio->hdmi;
+
+	return dw_hdmi_set_plugged_cb(hdmi, fn, codec_dev);
+}
+
 static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
 	.hw_params	= dw_hdmi_i2s_hw_params,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
 	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
+	.hook_plugged_cb = dw_hdmi_i2s_hook_plugged_cb,
 };
 
 static int snd_dw_hdmi_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 045b1b13fd0e..f32c66a6873d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -185,6 +185,10 @@ struct dw_hdmi {
 	void (*disable_audio)(struct dw_hdmi *hdmi);
 
 	struct cec_notifier *cec_notifier;
+
+	hdmi_codec_plugged_cb plugged_cb;
+	struct device *codec_dev;
+	enum drm_connector_status last_connector_result;
 };
 
 #define HDMI_IH_PHY_STAT0_RX_SENSE \
@@ -209,6 +213,28 @@ static inline u8 hdmi_readb(struct dw_hdmi *hdmi, int offset)
 	return val;
 }
 
+static void handle_plugged_change(struct dw_hdmi *hdmi, bool plugged)
+{
+	if (hdmi->plugged_cb && hdmi->codec_dev)
+		hdmi->plugged_cb(hdmi->codec_dev, plugged);
+}
+
+int dw_hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn,
+			   struct device *codec_dev)
+{
+	bool plugged;
+
+	mutex_lock(&hdmi->mutex);
+	hdmi->plugged_cb = fn;
+	hdmi->codec_dev = codec_dev;
+	plugged = hdmi->last_connector_result == connector_status_connected;
+	handle_plugged_change(hdmi, plugged);
+	mutex_unlock(&hdmi->mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_set_plugged_cb);
+
 static void hdmi_modb(struct dw_hdmi *hdmi, u8 data, u8 mask, unsigned reg)
 {
 	regmap_update_bits(hdmi->regm, reg << hdmi->reg_shift, mask, data);
@@ -2044,6 +2070,7 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
+	enum drm_connector_status result;
 
 	mutex_lock(&hdmi->mutex);
 	hdmi->force = DRM_FORCE_UNSPECIFIED;
@@ -2051,7 +2078,18 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 
-	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+	result = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+
+	mutex_lock(&hdmi->mutex);
+	if (result != hdmi->last_connector_result) {
+		dev_dbg(hdmi->dev, "read_hpd result: %d", result);
+		handle_plugged_change(hdmi,
+				      result == connector_status_connected);
+		hdmi->last_connector_result = result;
+	}
+	mutex_unlock(&hdmi->mutex);
+
+	return result;
 }
 
 static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -2460,6 +2498,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->rxsense = true;
 	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
 	hdmi->mc_clkdis = 0x7f;
+	hdmi->last_connector_result = connector_status_disconnected;
 
 	mutex_init(&hdmi->mutex);
 	mutex_init(&hdmi->audio_mutex);
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index b4ca970a5b75..d6c925236c55 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -6,6 +6,8 @@
 #ifndef __DW_HDMI__
 #define __DW_HDMI__
 
+#include <sound/hdmi-codec.h>
+
 struct drm_connector;
 struct drm_display_mode;
 struct drm_encoder;
@@ -152,6 +154,8 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 
 void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 
+int dw_hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn,
+			   struct device *codec_dev);
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
 void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
-- 
2.22.0.510.g264f2c817a-goog

