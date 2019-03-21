Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF47C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB41218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stgr0XbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfCUAPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:15:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39655 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfCUAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:15:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so3551560edc.6;
        Wed, 20 Mar 2019 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2gmLGJ4vQN/k7ohWxy1pugeNlW0+fmahjpUGJcf7onA=;
        b=Stgr0XbKKLDoruo+DsABjsnuLf6ain1AvNNo6ODIY4C03zYFN5XypwKhg2G+ICLVl8
         MdpnRpqzuCkHPZEDEjaQKRjzw9YPYAdfDasd214Kbwek9zDenV+THZL4GND2jjuNR9I4
         BrkuUcjtc3WRRIYxhg39JJ8NgwjmR8rMyElUjIDTTvuX0yfHHWFmVfrRBba1MAKd8pN1
         XT5SvirvjGyIX9vJOe+SoSihcEs3Td5yZl4ALtc6hnrouwqSGFYrGM/i56cgXtWeOIII
         Pc/TQ10D+8KtxdOdqVnZBnrX155oETtuzq6GsiGfjCoLil13w4K3mCzF8INhnGpYT2FG
         amCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2gmLGJ4vQN/k7ohWxy1pugeNlW0+fmahjpUGJcf7onA=;
        b=oPK3qcnDcPjJguWFo9u+jZaAjCKZ+XcvGXl86/RClH16DonaerKeb6NkKJa/TjHsi6
         KFu2U7p6iEB/AlNHEEuTY+HB7DHo+9r/Ou9ic7HswyDp1Kddv0TD3yzOFMlxGN2gEs8M
         qE2MuEGNfWZDJHDbRcrDJ9dXdQ+XOOwUUg3GpUBtQS8MYgNpFLw34SSwW6tWGlrlY+PS
         DlCsAOIhiEZtOBNlukOMox9MT5xdopNZSs9iD4flx7aB8bBdHruZOPsaAR9hvJ0aveOk
         wPZEuJ4WKNz/X8Py/PqV5mRCtdLUCiCO/fb0+3lBcqA/QcfWUGD2bVAI4s3Sy1Ws9sJs
         74Xg==
X-Gm-Message-State: APjAAAVdA5f8jXr/EdBkQO1JRKEbsHuciI/UnTlW/WrAd4+p2u9gu5SC
        qCA7INK49CRTzAgBLds1BlM=
X-Google-Smtp-Source: APXvYqx1ASfFSYpHyfhpgM6DZrA2N9rMOFFJG7tJYsGIRPGNIvUm29wNJZaBL3/HM/RKn14POok8IA==
X-Received: by 2002:a17:906:4e58:: with SMTP id g24mr529326ejw.190.1553127299210;
        Wed, 20 Mar 2019 17:14:59 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j34sm1107660edb.30.2019.03.20.17.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:14:58 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] drm: rockchip: add fixed screen size DVI-D support for rk3066 hdmi
Date:   Thu, 21 Mar 2019 01:14:40 +0100
Message-Id: <20190321001440.31057-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190321001440.31057-1-jbx6244@gmail.com>
References: <20190321001440.31057-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fixed screen size DVI-D support
for rk3066 hdmi with an extra patch.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index ff8f86152..f656da769 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -349,11 +349,12 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 	if (hdmi->hdmi_data.sink_is_hdmi) {
 		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK,
 			  HDMI_VIDEO_MODE_HDMI);
-		rk3066_hdmi_config_avi(hdmi, mode);
 	} else {
 		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK, 0);
 	}
 
+	rk3066_hdmi_config_avi(hdmi, mode);
+
 	rk3066_hdmi_config_phy(hdmi);
 
 	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_E);
@@ -462,15 +463,26 @@ rk3066_hdmi_connector_detect(struct drm_connector *connector, bool force)
 		connector_status_connected : connector_status_disconnected;
 }
 
+static const struct drm_display_mode edid_cea_modes[] = {
+	/* 4 - 1280x720@60Hz 16:9 */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74250, 1280, 1390,
+		   1430, 1650, 0, 720, 725, 730, 750, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+};
+
 static int rk3066_hdmi_connector_get_modes(struct drm_connector *connector)
 {
 	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
+	struct drm_display_mode *mode = NULL;
 	struct edid *edid;
 	int ret = 0;
 
 	if (!hdmi->ddc)
 		return 0;
 
+	hdmi->hdmi_data.sink_is_hdmi = false;
+
 	edid = drm_get_edid(connector, hdmi->ddc);
 	if (edid) {
 		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
@@ -479,6 +491,17 @@ static int rk3066_hdmi_connector_get_modes(struct drm_connector *connector)
 		kfree(edid);
 	}
 
+	if ((ret == 0) || (hdmi->hdmi_data.sink_is_hdmi == false)) {
+		hdmi->hdmi_data.sink_is_hdmi = false;
+
+		mode = drm_mode_duplicate(hdmi->drm_dev, &edid_cea_modes[0]);
+		if (!mode)
+			return ret;
+		mode->type |= DRM_MODE_TYPE_PREFERRED;
+		drm_mode_probed_add(connector, mode);
+		ret++;
+	}
+
 	return ret;
 }
 
-- 
2.11.0

