Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5031FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CA22168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="TlmWQr2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404444AbfJPJ7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:59:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34944 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfJPJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:59:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id p30so13992900pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UHiq+bpKpYTZfFCDKz/wHMdPBwb8otM78+THN0Zfxc=;
        b=TlmWQr2oZsXsdXMZxuaRHpzO0t6KpXZ1HsiWTKX2m54q+A2Rp1yOdP46uEcRqDOXZD
         Xx8ePK9bNrndXkfM9xbnC4y12z4SanvCtLaaC2LUSSbWP8Zl23hxd9xv9v6/ci+aPu7Q
         N9rrDEtQTuizJjcWieCFpLFZhhFfbwiCIfzTORLJlrHH0CO52xbwMnoQFzDpIh6tt1CT
         2Cc4GWp7DpYFv6A3MoRmmsXBxm0I5lEv09a4FfO66c0SCjlnzYkI16LjJObsM1WQyQpY
         my8enjoqkUcKPq7wjcu1dOuI1tLps2cIVHwUn0V4r3i37N74svEicLAiYZv0xCHWTilB
         gD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UHiq+bpKpYTZfFCDKz/wHMdPBwb8otM78+THN0Zfxc=;
        b=QsuYJrTvoRtPBO4kNbApGRPrQHXhuxeTfc4aUe5K0FWF+xqOcQk0qkNm4rHIs+56V9
         ROidezQbD+1vxakvvxe/MZQWbEOUiMw3sZO/4kJhMllNCYX2SqRPH61jFrJ+EL4MV7T7
         ZELAjfrdHWQU/Ia8jKqSCVnTETPE1sxVhiV1GUempw6pckhIXSAHQkDvyOfA6eKXbbCg
         Vhlp2GSwoHEMXNvWQ1hTGSH74awNT7NT9mr8vlvrF6BHoQByK1+rVNbXI+riXax1svvC
         vwd783Ko4ag4uZdwGLy6h8g5MAgcSiYCevZTYAiXRv+TWk0HjXBwhEbMUgeVQNh8YDGI
         caXQ==
X-Gm-Message-State: APjAAAVYRVYsSmrjOFjtQJ4jSbV4rB0gLgq4KLRwDnfKbv6iFWrasCdx
        r5+ewh21fW4TvCAWdFE69ED37g==
X-Google-Smtp-Source: APXvYqyuTfvDzxNwI9kalDMU0iywh8UZbVEiS7QPebJLB/GNw2tf4Ez9bgFTGBHDoNZGPFzSDcggRQ==
X-Received: by 2002:aa7:87d9:: with SMTP id i25mr4990873pfo.244.1571219975917;
        Wed, 16 Oct 2019 02:59:35 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id p17sm23021423pfn.50.2019.10.16.02.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 02:59:35 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ramalingam C <ramalingam.c@intel.com>,
        Uma Shankar <uma.shankar@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] drm/i915/hdmi: enable resolution 3840x2160 for type 1 HDMI
Date:   Wed, 16 Oct 2019 17:57:58 +0800
Message-Id: <20191016095757.4919-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type 1 HDMI may be version 1.3 or upper, which supports higher max TMDS
clock for higher resolutions, like 3840x2160. This patch sets max TMDS
clock according to the chip, if the adapter is type 1 HDMI.

Buglink: https://bugs.freedesktop.org/show_bug.cgi?id=112018
Fixes: b1ba124d8e95 ("drm/i915: Respect DP++ adaptor TMDS clock limit")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index e02f0faecf02..74e4426ffcad 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2454,6 +2454,7 @@ intel_hdmi_dp_dual_mode_detect(struct drm_connector *connector, bool has_edid)
 {
 	struct drm_i915_private *dev_priv = to_i915(connector->dev);
 	struct intel_hdmi *hdmi = intel_attached_hdmi(connector);
+	struct intel_encoder *encoder = &hdmi_to_dig_port(hdmi)->base;
 	enum port port = hdmi_to_dig_port(hdmi)->base.port;
 	struct i2c_adapter *adapter =
 		intel_gmbus_get_adapter(dev_priv, hdmi->ddc_bus);
@@ -2488,8 +2489,16 @@ intel_hdmi_dp_dual_mode_detect(struct drm_connector *connector, bool has_edid)
 		return;
 
 	hdmi->dp_dual_mode.type = type;
-	hdmi->dp_dual_mode.max_tmds_clock =
-		drm_dp_dual_mode_max_tmds_clock(type, adapter);
+	/* Type 1 HDMI may be version 1.3 or upper, which supports higher max
+	 * TMDS clock for higher resolutions, like 3840x2160. So, set it
+	 * according to the chip, if the adapter is type 1 HDMI.
+	 */
+	if (type == DRM_DP_DUAL_MODE_TYPE1_HDMI)
+		hdmi->dp_dual_mode.max_tmds_clock =
+			intel_hdmi_source_max_tmds_clock(encoder);
+	else
+		hdmi->dp_dual_mode.max_tmds_clock =
+			drm_dp_dual_mode_max_tmds_clock(type, adapter);
 
 	DRM_DEBUG_KMS("DP dual mode adaptor (%s) detected (max TMDS clock: %d kHz)\n",
 		      drm_dp_get_dual_mode_type_name(type),
-- 
2.23.0

