Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CCCC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDAD2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C9GqNB7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfH0IOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:14:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41798 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfH0IOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:14:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so17793648wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fwLgPt/sy0VRW5cHDJyRotay9sWSMyISJ5IvQ5QQMA=;
        b=C9GqNB7Zx2gcvaVzTdzCbkKaigQKRB7taaAM92mqpg588P/+1/L5odJieFPNb0LTwN
         8RczG1CjJ/RyL5OyJlcfTqSew2yax0JYZJh/l4Y+UzzRSp+ANIfP7SuSkrWustPY4+Hn
         6RV1d5TbNu7JaqsqYlY6hA8inCmFL8gan4+a+SNE0xAC7sYznX0dy3LZPVLvgtfu1YOf
         Nm9n7/2lm6kIyvnOk45RNmGIvQKdiozzb6wQDVoBIvrcdt9EbEoNaJ6Rv1wXxZ8eSLBq
         9qktKeEvuLDRO2wI+b/aPcWoljP8SN7KpIkah35+Ca945fvXDNHjsexq3DlTPS0lUDnE
         S/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fwLgPt/sy0VRW5cHDJyRotay9sWSMyISJ5IvQ5QQMA=;
        b=pJoQlXS6XSaiQbZJ9UfnCpCpIS3mRAF/4kvf6G00se/R0Vr1pAJacww/di3eiSCEZ0
         bmhPwwRft25FH8SlgnOeJR1vq2qVizc+YlbPHx8ybI89QeYNG46lI1Jdrm837E8Tj7H8
         hGudcLx66vEZYk3dupFL36LbncWDBX+WmlMJCGWE0qgUYrZow9XLkPDdHa09p55JGwjj
         XKN0cBSevy/WZkgjDi5L/mDZiJ2QZhC2AsVkdA07a4CHJY3fw0XPdVgMDZ+ZLZRlrC4q
         VNeFgWnf9vLup/oIUAd28RSL54BuEUtHB2xADvD9o5ON+a3JydgkX9TYeJ7+8ie7mwNK
         vhpQ==
X-Gm-Message-State: APjAAAUZxPTHNz0Jw7OsNng7MQjBS8O4B8HQvXSuXil25HbMDFH/1Oz6
        WLwnqDs7WkzK2AiALbeDqf7XPQ==
X-Google-Smtp-Source: APXvYqztWS6qzctrIjcT+AV41CNogqI+Ep6+I+AnpQFdQmvtAHxf1STFdqtf+tvOdN6+ooP8EYCImA==
X-Received: by 2002:a5d:658b:: with SMTP id q11mr2210567wru.211.1566893669171;
        Tue, 27 Aug 2019 01:14:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f18sm11911792wrx.85.2019.08.27.01.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 01:14:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 1/8] drm/meson: venc: make drm_display_mode const
Date:   Tue, 27 Aug 2019 10:14:18 +0200
Message-Id: <20190827081425.15011-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827081425.15011-1-narmstrong@baylibre.com>
References: <20190827081425.15011-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before switching to bridge funcs, make sure drm_display_mode is passed
as const to the venc functions.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 2 +-
 drivers/gpu/drm/meson/meson_venc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 679d2274531c..d2d4c3ebf46b 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -946,7 +946,7 @@ bool meson_venc_hdmi_venc_repeat(int vic)
 EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
 
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
-			      struct drm_display_mode *mode)
+			      const struct drm_display_mode *mode)
 {
 	union meson_hdmi_venc_mode *vmode = NULL;
 	union meson_hdmi_venc_mode vmode_dmt;
diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
index 576768bdd08d..1abdcbdf51c0 100644
--- a/drivers/gpu/drm/meson/meson_venc.h
+++ b/drivers/gpu/drm/meson/meson_venc.h
@@ -60,7 +60,7 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
 void meson_venci_cvbs_mode_set(struct meson_drm *priv,
 			       struct meson_cvbs_enci_mode *mode);
 void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
-			      struct drm_display_mode *mode);
+			      const struct drm_display_mode *mode);
 unsigned int meson_venci_get_field(struct meson_drm *priv);
 
 void meson_venc_enable_vsync(struct meson_drm *priv);
-- 
2.22.0

