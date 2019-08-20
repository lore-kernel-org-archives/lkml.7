Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0874CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C587C22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2BWi2Jq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfHTIl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:27 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41928 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbfHTIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:25 -0400
Received: by mail-wr1-f51.google.com with SMTP id j16so11457562wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7CqeKSTem021QoPp6JMnzxB9YluOu4hz8452YyClyt8=;
        b=2BWi2Jq51jt3oPw7UPWuxQyqpGWZKI70o4EjJXih00uU8MIkxMjYRAWRXzAKWwJwM3
         GaeHHXClhv1khlSjvruQwPO5tR2CE8TwMygb4TMdXoMnwtKaKSr8Yk5YhBWfpL0jGRGB
         YjBJiUbK8BUfb3g0ykPqVihuxE5NzQs3qcyPOfgjEUBl85xR+q8B9qRwAVxGqWTSQmKp
         U6+RmYehn7/s90A+vHmqOYmglQp8Nz/SRe0te9BBhKvYVI/ogOufQtOEfQBpoEPE6bHt
         iKkjhxc6x0DT72d+apRYr9yPu2N4tD305l++30hathlf6pZxh7KXz1MJ2POltmnwg+ik
         V3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CqeKSTem021QoPp6JMnzxB9YluOu4hz8452YyClyt8=;
        b=HTuNtysm/Ww4F93qpOxAWxeObjUGILbaJT95tUV50Sbrpl3TxH0761Rt1WG8Mi8O+N
         /FyTuq8HnVIUQ6GzFnp08eicOBOF+pGs1UBqpWY5HhsviAmbQsIyJZvV48vOsmqW7kGJ
         RFnVIO5f5NdXwAdIFqR3VqghNFJLgiCku7TydUJjIDlJN9fPKDMj4eZcdLezQGZVxnM8
         pdDZOUM3e6/4rHvqcHvd+zHMfIA7Q+xJfZAsZIrM7tU2QGZPIWpnkOxpMhxrBLGtTr37
         NmyHr7C5njKiLLVbBK9sm4SChE/zUs5UbGa1WtY+9yMarPQGjC7o+PlAZNlIeYS+XXM+
         lKGw==
X-Gm-Message-State: APjAAAXpkLrGk8IN0oswhMETWtohGqs1duRApLU4nCeYbdqL+YXyUu/c
        KLBHg1DX63mSFo6FAY7qwWIE/w==
X-Google-Smtp-Source: APXvYqyeY205T67m+BbcYhK3smYHwphV4Tyn7CKS0K7OP65pmIueJKbfUILQJODLQ0EjvD26NCVBYw==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr32742798wro.337.1566290483453;
        Tue, 20 Aug 2019 01:41:23 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 09/11] drm/meson: venc: add support for YUV420 setup
Date:   Tue, 20 Aug 2019 10:41:07 +0200
Message-Id: <20190820084109.24616-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds encoding support for the YUV420 output from the
Amlogic Meson SoCs Video Processing Unit to the HDMI Controller.

The YUV420 is obtained by generating a YUV444 pixel stream like
the classic HDMI display modes, but then the Video Encoder output
can be configured to down-sample the YUV444 pixel stream to a YUV420
stream.

In addition if pixel stream down-sampling, the Y Cb Cr components must
also be mapped differently to align with the HDMI2.0 specifications.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c |  3 ++-
 drivers/gpu/drm/meson/meson_venc.c    |  6 ++++--
 drivers/gpu/drm/meson/meson_venc.h    | 11 +++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index fb09592eba3e..2b278ee75100 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -719,7 +719,8 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_bridge *bridge,
 	DRM_DEBUG_DRIVER("\"%s\" vic %d\n", mode->name, vic);
 
 	/* VENC + VENC-DVI Mode setup */
-	meson_venc_hdmi_mode_set(priv, vic, mode);
+	meson_venc_hdmi_mode_set(priv, vic, ycrcb_map, false,
+				 MESON_VENC_MAP_CB_Y_CR);
 
 	/* VCLK Set clock */
 	dw_hdmi_set_vclk(dw_hdmi, mode);
diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index c8e9840ad450..ec2723822552 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -946,6 +946,8 @@ bool meson_venc_hdmi_venc_repeat(int vic)
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
 
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
+			      unsigned int ycrcb_map,
+			      bool yuv420_mode,
 			      const struct drm_display_mode *mode)
 {
 	union meson_hdmi_venc_mode *vmode = NULL;
@@ -1496,8 +1498,8 @@ void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
 	writel_relaxed((use_enci ? 1 : 2) |
 		       (mode->flags & DRM_MODE_FLAG_PHSYNC ? 1 << 2 : 0) |
 		       (mode->flags & DRM_MODE_FLAG_PVSYNC ? 1 << 3 : 0) |
-		       4 << 5 |
-		       (venc_repeat ? 1 << 8 : 0) |
+		       (ycrcb_map << 5) |
+		       (venc_repeat || yuv420_mode ? 1 << 8 : 0) |
 		       (hdmi_repeat ? 1 << 12 : 0),
 		       priv->io_base + _REG(VPU_HDMI_SETTING));
 
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 1abdcbdf51c0..88ded5451c49 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -23,6 +23,15 @@ enum {
 	MESON_VENC_MODE_HDMI,
 };
 
+enum {
+	MESON_VENC_MAP_CR_Y_CB = 0,
+	MESON_VENC_MAP_Y_CB_CR,
+	MESON_VENC_MAP_Y_CR_CB,
+	MESON_VENC_MAP_CB_CR_Y,
+	MESON_VENC_MAP_CB_Y_CR,
+	MESON_VENC_MAP_CR_CB_Y,
+};
+
 struct meson_cvbs_enci_mode {
 	unsigned int mode_tag;
 	unsigned int hso_begin; /* HSO begin position */
@@ -60,6 +69,8 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
 void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			       struct meson_cvbs_enci_mode *mode);
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
+			      unsigned int ycrcb_map,
+			      bool yuv420_mode,
 			      const struct drm_display_mode *mode);
 unsigned int meson_venci_get_field(struct meson_drm *priv);
 
-- 
2.22.0

