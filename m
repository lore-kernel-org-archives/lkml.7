Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B229C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560B820856
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NQaaID67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGEE0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:26:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40889 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGEE0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:26:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so3691024pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 21:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfAso7efMu/aA+eHOC+kWuha2DdRu+sIyUVZpYri0wk=;
        b=NQaaID67Y+LZwPST2LvJBza5Z0GadFPix/sAuAKZfbGHz2qYjWAokPh73WmpEZVBX+
         ovAj5OC9r9vmp+giPJWm6aGtvcx9wCAxNasdbMQrs46bEhkDxQItAQ/gc7xQSOMGIiwi
         y1c+dcnmFLnIFj+8Cj21PpTCMX3HNEnakazQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfAso7efMu/aA+eHOC+kWuha2DdRu+sIyUVZpYri0wk=;
        b=dI5gezWEk7HesuU0m7RoE1e6y3XcDrALqsefMZOypJffJIVLsXfTpKcLnIXJ7k/1qi
         6hgBahUsFmjvarNukLFI0wnIkk18Cl5p15XMQlBNCzWPfjmScjcXTVj5MlK/9TKUlh6U
         zc57WudIzn64Ap5pgVLs10y51NcC256k7lK/N49zpP0yhzVpYNWX/DMSwa3CowJfsntM
         2jnJOogDiQpi+gDYcmakFSETaw6yfoDYjLUy4FbskgzIfaY2WmK7vOyW8M2pHixBDc3w
         +dxmeJkBxh8EC2Kn/FanofkXAcknDf1A0QMI+26jDSrZOZYAC0WZby3M+vDDeD5DbQH6
         KN7A==
X-Gm-Message-State: APjAAAWsq8qSLym4eTdiVesvWWjEtZKNT/gwAOOkMJ3KR+hvtETb8GQm
        SJ1D5nsy7pYZ0AcTY6elR1mhCQLKQ1o=
X-Google-Smtp-Source: APXvYqwZbL+s761iX960bRQQcsfHBESYYHX6caI+DhUbiPV9OOsTfm5vhRVAxh6UChQM0IMk+bwDTw==
X-Received: by 2002:a63:24c1:: with SMTP id k184mr2425512pgk.120.1562300810605;
        Thu, 04 Jul 2019 21:26:50 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id h2sm6126547pgs.17.2019.07.04.21.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 21:26:50 -0700 (PDT)
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
Subject: [PATCH 2/4] drm: bridge: dw-hdmi: Report connector status using callback
Date:   Fri,  5 Jul 2019 12:26:21 +0800
Message-Id: <20190705042623.129541-3-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190705042623.129541-1-cychiang@chromium.org>
References: <20190705042623.129541-1-cychiang@chromium.org>
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

dw-hdmi implements set_plugged_cb op so platform device can register the
callback.

When connector plug/unplug event happens, report this event using the
callback.

Make sure that audio and drm are using the single source of truth for
connector status.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |  3 ++
 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 10 ++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 34 ++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
index 63b5756f463b..f523c590984e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
@@ -2,6 +2,8 @@
 #ifndef DW_HDMI_AUDIO_H
 #define DW_HDMI_AUDIO_H
 
+#include <sound/hdmi-codec.h>
+
 struct dw_hdmi;
 
 struct dw_hdmi_audio_data {
@@ -17,6 +19,7 @@ struct dw_hdmi_i2s_audio_data {
 
 	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read)(struct dw_hdmi *hdmi, int offset);
+	int (*set_plugged_cb)(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn);
 };
 
 #endif
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 5cbb71a866d5..7b93cf05c985 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -104,10 +104,20 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 	return -EINVAL;
 }
 
+static int dw_hdmi_i2s_hook_plugged_cb(struct device *dev, void *data,
+				       hdmi_codec_plugged_cb fn)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+	struct dw_hdmi *hdmi = audio->hdmi;
+
+	return audio->set_plugged_cb(hdmi, fn);
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
index 045b1b13fd0e..c69a399fc7ca 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -26,6 +26,8 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/bridge/dw_hdmi.h>
 
+#include <sound/hdmi-codec.h>
+
 #include <uapi/linux/media-bus-format.h>
 #include <uapi/linux/videodev2.h>
 
@@ -185,6 +187,9 @@ struct dw_hdmi {
 	void (*disable_audio)(struct dw_hdmi *hdmi);
 
 	struct cec_notifier *cec_notifier;
+
+	hdmi_codec_plugged_cb plugged_cb;
+	enum drm_connector_status last_connector_result;
 };
 
 #define HDMI_IH_PHY_STAT0_RX_SENSE \
@@ -209,6 +214,17 @@ static inline u8 hdmi_readb(struct dw_hdmi *hdmi, int offset)
 	return val;
 }
 
+static int hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn)
+{
+	mutex_lock(&hdmi->mutex);
+	hdmi->plugged_cb = fn;
+	if (hdmi->audio && !IS_ERR(hdmi->audio))
+		fn(hdmi->audio,
+		   hdmi->last_connector_result == connector_status_connected);
+	mutex_unlock(&hdmi->mutex);
+	return 0;
+}
+
 static void hdmi_modb(struct dw_hdmi *hdmi, u8 data, u8 mask, unsigned reg)
 {
 	regmap_update_bits(hdmi->regm, reg << hdmi->reg_shift, mask, data);
@@ -2044,6 +2060,7 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
+	enum drm_connector_status result;
 
 	mutex_lock(&hdmi->mutex);
 	hdmi->force = DRM_FORCE_UNSPECIFIED;
@@ -2051,7 +2068,20 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 
-	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+	result = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
+
+	mutex_lock(&hdmi->mutex);
+	if (result != hdmi->last_connector_result) {
+		dev_dbg(hdmi->dev, "read_hpd result: %d", result);
+		if (hdmi->plugged_cb && hdmi->audio && !IS_ERR(hdmi->audio)) {
+			hdmi->plugged_cb(hdmi->audio,
+					 result == connector_status_connected);
+			hdmi->last_connector_result = result;
+		}
+	}
+	mutex_unlock(&hdmi->mutex);
+
+	return result;
 }
 
 static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -2460,6 +2490,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->rxsense = true;
 	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
 	hdmi->mc_clkdis = 0x7f;
+	hdmi->last_connector_result = connector_status_disconnected;
 
 	mutex_init(&hdmi->mutex);
 	mutex_init(&hdmi->audio_mutex);
@@ -2653,6 +2684,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
 		audio.hdmi	= hdmi;
 		audio.write	= hdmi_writeb;
 		audio.read	= hdmi_readb;
+		audio.set_plugged_cb = hdmi_set_plugged_cb;
 		hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
 		hdmi->disable_audio = dw_hdmi_i2s_audio_disable;
 
-- 
2.22.0.410.gd8fdbe21b5-goog

