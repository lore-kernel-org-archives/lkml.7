Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CD9C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E14C20409
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RRaXPEPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfLHRTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:19:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39549 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLHRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 12:19:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so12367729wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 09:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/08gW13TofccXenPvhotNWPtw70ZwPRo+rtrcdU/+VA=;
        b=RRaXPEPB4QQdctB7WfH81TtTfrknUORtdviB7JWOyEw4ddrTwxWAKUr3grmdAiKVw7
         GWjQ6C7MkW8YZYcXN39l2E1cWuLIQnoJkYmORRJp7eWCBwkJKcoXzs+PmgeTyE+pXBLU
         aG1d51PbsZEKMUB3H/e7dLI2xSgV8bgmB1jvLVLbIhn9qaJl8QEbHwVACTBejtCdtM0v
         6xqXG2FnHAAgE671NQJx2ElfdheX1Gzh0NT67meKI/W6X9Z9TytDRj/MNCfcwmzSABdc
         PPiH01A88ITC3kjCyiLrtDI0xVDprYxkRJanqvoVHjconPk8EK/bEBUh2HKW/TgW5q0e
         o7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/08gW13TofccXenPvhotNWPtw70ZwPRo+rtrcdU/+VA=;
        b=Z1SR8xV+0hy/QP/YlKWg901opQMQ+uSh2okRiKV7ixWGn9KvxaG6q4una1kLtyUPvu
         jFcmtEZJDvw3cE/r0wQrR86ZIIBR7Ne0pF9WTLlpyY0aeue1XjgjiNTzcoGX+++At08n
         SCfazxy0lcDJd7eJWAClUUPAEWHOFU7M6DArDV6vqxdmMitme+fhq3/x+0lE9PpKe+lE
         yhQ0b7h++5OmGrHZYHaeIm11Ubfex7ZqG4Wc7IvRvZvBgpBvAoDHcuuKlTtVwnJ5N/fU
         frhNEPRbMKNHMG8VeWz88e4xCTt4HzB/7sNz4PgZuR4QOlqnYo6dMbVYMhfInoWP2FrK
         XQig==
X-Gm-Message-State: APjAAAX8S7HISC3JBVyMgVP6w9r7eZcQxwJL8R6WyOYzP4Cvi+Rgu117
        FtxUmQUfAQz0JwiHz/1MqSM=
X-Google-Smtp-Source: APXvYqzl065F05Yt2j+aTRbWAW7DyJzxv18Zx1ZqmxuQS7SJlPzVCkEImtiMCQ5YaYB9e0PK14tHWg==
X-Received: by 2002:a1c:9e49:: with SMTP id h70mr22066604wme.79.1575825540738;
        Sun, 08 Dec 2019 09:19:00 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id g25sm11791383wmh.3.2019.12.08.09.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 09:18:59 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] drm: meson: venc: cvbs: deduplicate the meson_cvbs_mode lookup code
Date:   Sun,  8 Dec 2019 18:18:31 +0100
Message-Id: <20191208171832.1064772-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191208171832.1064772-1-martin.blumenstingl@googlemail.com>
References: <20191208171832.1064772-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a utility function to remove a bit of code duplication between
meson_venc_cvbs_encoder_atomic_check() and
meson_venc_cvbs_encoder_mode_set(). Both need to look up the struct
meson_venc_cvbs based on a drm_display_mode.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/meson/meson_venc_cvbs.c | 44 +++++++++++++------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index 9ab27aecfcf3..6b8a074e4ff4 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -64,6 +64,21 @@ struct meson_cvbs_mode meson_cvbs_modes[MESON_CVBS_MODES_COUNT] = {
 	},
 };
 
+static const struct meson_cvbs_mode *
+meson_cvbs_get_mode(const struct drm_display_mode *req_mode)
+{
+	int i;
+
+	for (i = 0; i < MESON_CVBS_MODES_COUNT; ++i) {
+		struct meson_cvbs_mode *meson_mode = &meson_cvbs_modes[i];
+
+		if (drm_mode_equal(req_mode, &meson_mode->mode))
+			return meson_mode;
+	}
+
+	return NULL;
+}
+
 /* Connector */
 
 static void meson_cvbs_connector_destroy(struct drm_connector *connector)
@@ -136,14 +151,8 @@ static int meson_venc_cvbs_encoder_atomic_check(struct drm_encoder *encoder,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
 {
-	int i;
-
-	for (i = 0; i < MESON_CVBS_MODES_COUNT; ++i) {
-		struct meson_cvbs_mode *meson_mode = &meson_cvbs_modes[i];
-
-		if (drm_mode_equal(&crtc_state->mode, &meson_mode->mode))
-			return 0;
-	}
+	if (meson_cvbs_get_mode(&crtc_state->mode))
+		return 0;
 
 	return -EINVAL;
 }
@@ -191,24 +200,17 @@ static void meson_venc_cvbs_encoder_mode_set(struct drm_encoder *encoder,
 				   struct drm_display_mode *mode,
 				   struct drm_display_mode *adjusted_mode)
 {
+	const struct meson_cvbs_mode *meson_mode = meson_cvbs_get_mode(mode);
 	struct meson_venc_cvbs *meson_venc_cvbs =
 					encoder_to_meson_venc_cvbs(encoder);
 	struct meson_drm *priv = meson_venc_cvbs->priv;
-	int i;
 
-	for (i = 0; i < MESON_CVBS_MODES_COUNT; ++i) {
-		struct meson_cvbs_mode *meson_mode = &meson_cvbs_modes[i];
+	if (meson_mode) {
+		meson_venci_cvbs_mode_set(priv, meson_mode->enci);
 
-		if (drm_mode_equal(mode, &meson_mode->mode)) {
-			meson_venci_cvbs_mode_set(priv,
-						  meson_mode->enci);
-
-			/* Setup 27MHz vclk2 for ENCI and VDAC */
-			meson_vclk_setup(priv, MESON_VCLK_TARGET_CVBS,
-					 MESON_VCLK_CVBS, MESON_VCLK_CVBS,
-					 MESON_VCLK_CVBS, true);
-			break;
-		}
+		/* Setup 27MHz vclk2 for ENCI and VDAC */
+		meson_vclk_setup(priv, MESON_VCLK_TARGET_CVBS, MESON_VCLK_CVBS,
+				 MESON_VCLK_CVBS, MESON_VCLK_CVBS, true);
 	}
 }
 
-- 
2.24.0

