Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D664B2339F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dh96VTcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfHTIlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40719 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfHTIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so11473425wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/P7EPY/5dFnAu48qok6WuTbpIx9NhM57Lx/BDC712I=;
        b=Dh96VTcdKSYsPtHoUVhk6WnhZCKFnnDXqYAmwZcjUGC7ZNgCjOEf2Nw6MfwCRFKwP7
         eyvQ1yz5Zo+b0UQ7cK3D0IK4GkzB2LcfCQAePhADH80JV2GfPBqHV3B+gosFO/mAZHlp
         n0S/fS5KDLYrxB3iqYsm9BIKpoUOYeOkIvetgOsmBqRPGIKiaFewZ1/2jiHQH16tX6Vr
         QodWkgcNycOgk5PpYLSJ9evdkceGKQ16vZi8PUrbGjvLORS/Zv4ONO6QOpsXEmqPiKBM
         mu+VcXUnTQkKGhOtVXwZUfy+msoASCTetYn4dFpELiaHzaa8ZtQ5VHFUgwP5bDbmfDw8
         nleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/P7EPY/5dFnAu48qok6WuTbpIx9NhM57Lx/BDC712I=;
        b=BZ/foXUj55ikls4rFm7DxvqzJOXijkekS3DdQEImuAMlLvJLUyScVm37/Chg5HZ4Zs
         9zAdCTdDdqpyO+2VsVM8Qk9AWGYiIOfWMuLd5HCJf3sqIhtrIqCdPouNlEebsoTS9qdI
         pWSyQ5I8ZRKqxPyWx4jWcbtZUDA8ScfnhH2Y54dQhvJmTAea1NCSF2F/emjnlYJHH5Fw
         EonEtlP8ayeiu314Z+n06vSOt9Qs5eNYFy6P8J1DCOcl7lB/RXfahG0M7zb7y0OUkGgl
         DkBxhrfoYqEwkZ3vdTVu2sg9HMby0LNNABsaeHziERcdIBrx9ciGWJ8meag3SFjSJSWD
         OyGg==
X-Gm-Message-State: APjAAAWdQcy5xQK4fHgiO8TmVqn1Jmf5JAAEH6CB2o5dfoQ5oCMmpS1a
        IygZYa9HRDDKTLiWmQkLlk/m7w==
X-Google-Smtp-Source: APXvYqyMi9fjn35RKMqKCT0Cl9gAsZF/NvpZhgd2Tspcloatig8wnB73W94dlxJXp3kNJjco7rN/Gw==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr25270321wrr.55.1566290477062;
        Tue, 20 Aug 2019 01:41:17 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 04/11] drm/bridge: synopsys: dw-hdmi: add basic bridge_atomic_check
Date:   Tue, 20 Aug 2019 10:41:02 +0200
Message-Id: <20190820084109.24616-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the supported input and output formats to the bridge
input_bus_caps and output_bus_caps, and add a very simple atomic check
implementation to negociate output and input bus formats.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 53 +++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index b4901b174a90..121c2167ee20 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -91,6 +91,24 @@ static const u16 csc_coeff_rgb_in_eitu709[3][4] = {
 	{ 0x6756, 0x78ab, 0x2000, 0x0200 }
 };
 
+static const u32 dw_hdmi_bus_fmts[] = {
+	MEDIA_BUS_FMT_RGB888_1X24,
+	MEDIA_BUS_FMT_RGB101010_1X30,
+	MEDIA_BUS_FMT_RGB121212_1X36,
+	MEDIA_BUS_FMT_RGB161616_1X48,
+	MEDIA_BUS_FMT_YUV8_1X24,
+	MEDIA_BUS_FMT_YUV10_1X30,
+	MEDIA_BUS_FMT_YUV12_1X36,
+	MEDIA_BUS_FMT_YUV16_1X48,
+	MEDIA_BUS_FMT_UYVY8_1X16,
+	MEDIA_BUS_FMT_UYVY10_1X20,
+	MEDIA_BUS_FMT_UYVY12_1X24,
+	MEDIA_BUS_FMT_UYYVYY8_0_5X24,
+	MEDIA_BUS_FMT_UYYVYY10_0_5X30,
+	MEDIA_BUS_FMT_UYYVYY12_0_5X36,
+	MEDIA_BUS_FMT_UYYVYY16_0_5X48,
+};
+
 struct hdmi_vmode {
 	bool mdataenablepolarity;
 
@@ -2190,6 +2208,33 @@ static const struct drm_connector_helper_funcs dw_hdmi_connector_helper_funcs =
 	.get_modes = dw_hdmi_connector_get_modes,
 };
 
+static int dw_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	struct dw_hdmi *hdmi = bridge->driver_private;
+	int ret;
+
+	ret = drm_atomic_bridge_choose_output_bus_cfg(bridge_state, crtc_state,
+						      conn_state);
+	if (ret)
+		return ret;
+
+	dev_dbg(hdmi->dev, "selected output format %x\n",
+			bridge_state->output_bus_cfg.fmt);
+
+	ret = drm_atomic_bridge_choose_input_bus_cfg(bridge_state, crtc_state,
+						      conn_state);
+	if (ret)
+		return ret;
+
+	dev_dbg(hdmi->dev, "selected input format %x\n",
+			bridge_state->input_bus_cfg.fmt);
+
+	return 0;
+}
+
 static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
 {
 	struct dw_hdmi *hdmi = bridge->driver_private;
@@ -2267,6 +2312,7 @@ static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
 
 static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
 	.attach = dw_hdmi_bridge_attach,
+	.atomic_check = dw_hdmi_bridge_atomic_check,
 	.enable = dw_hdmi_bridge_enable,
 	.disable = dw_hdmi_bridge_disable,
 	.mode_set = dw_hdmi_bridge_mode_set,
@@ -2733,6 +2779,13 @@ __dw_hdmi_probe(struct platform_device *pdev,
 
 	hdmi->bridge.driver_private = hdmi;
 	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
+	hdmi->bridge.input_bus_caps.supported_fmts = dw_hdmi_bus_fmts;
+	hdmi->bridge.input_bus_caps.num_supported_fmts =
+					ARRAY_SIZE(dw_hdmi_bus_fmts);
+	hdmi->bridge.output_bus_caps.supported_fmts = dw_hdmi_bus_fmts;
+	hdmi->bridge.output_bus_caps.num_supported_fmts =
+					ARRAY_SIZE(dw_hdmi_bus_fmts);
+
 #ifdef CONFIG_OF
 	hdmi->bridge.of_node = pdev->dev.of_node;
 #endif
-- 
2.22.0

