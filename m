Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A204C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C235821726
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBUfraRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfHADpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38974 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbfHADpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so33274495pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6qZv0NvjQC+of1GCo/KYasdnS8lE77yp0QRLPQskL4=;
        b=LBUfraRwXQ6hIm+t+I/z/szQ5a8tgSCA4WdSllvNls0e5Nmk1uCQ2OME2rTVKCxaFd
         fngthY7x8jwqxMzhlDSSAPuf7WZ/nRF64rC4vBNmFt1GkBc12ggTPnQ09OsaW5LTRiWr
         x82tyGYfkY6Y0pm6An9Iy3boW/JM1v+63ieHcOcRDe9sTqNCyHocXaIithN1zPNnjO6F
         LSxl8VHiwJTxo1qKuN9yWyqIgv27CRxkW4enkqZuYxbfrLwwl6AD744a7bnYyMT22jJN
         Vpv8LCFdZCA8Max387n4rr8xtsDps7DxU9Jw5g1CzEMtVoAxbfuGn4h0tSUa40Vf7FYP
         QA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6qZv0NvjQC+of1GCo/KYasdnS8lE77yp0QRLPQskL4=;
        b=E9W+yZSJHzFG2Zja8L9mAbdWGWtgqU3evJ1EwPR15aaErNFg112L/Cvgm3MHgQOHo3
         90kh9AJS+h8JkyE9M2rzMguI/L+Iy1ewumv5HniMip/llZ3vcymMe3AxbalzEs1fj36B
         cylxlTJG6tBDkdBvEaXZaOlDlz00TM2FOXrY5J5W2Tt04fHE++dQSBozHbreTkwB6IwJ
         9yd7glLQ9yzdrk92Ly/r/nZ6ERZqm4LtxB9kVXMNKEb/YvM4CLd/VXjshpaFYG6F0YE6
         nQ87PBRLX/xSA6wixB7Co6YaBnuGobZX2ul1Pkqqpi3WjDittxlPWQ0B4waUlahmfx5k
         vqmA==
X-Gm-Message-State: APjAAAUwFzlrIZyk8d2oZaR0G0FzZGm4w6Y2SQO/HPZ+MX5U9tOI/Qig
        GQGJL9n+xSpeBuIVnwoumVC7TATZdRM=
X-Google-Smtp-Source: APXvYqxUEZw4Ikiw5sPRlsiT0HMzQNoep47eydFV0J+SZ+HRTQlJnXdxw75yrCSKiMMwJ0sb6ZaAkQ==
X-Received: by 2002:aa7:858b:: with SMTP id w11mr48729384pfn.68.1564631103854;
        Wed, 31 Jul 2019 20:45:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:03 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 12/26] drm: kirin: Move kirin_crtc, kirin_plane, kirin_format to kirin_drm_drv.h
Date:   Thu,  1 Aug 2019 03:44:25 +0000
Message-Id: <20190801034439.98227-13-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves some shared
structures and helpers to the common kirin_drm_drv.h

These structures will later used by both kirin620 and
future kirin960 driver

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 27 ++-----------------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   | 24 +++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index ec4857e45b6e..3ad1e290bf58 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -38,12 +38,6 @@
 #define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
 #define ADE_DEBUG	1
 
-#define to_kirin_crtc(crtc) \
-	container_of(crtc, struct kirin_crtc, base)
-
-#define to_kirin_plane(plane) \
-	container_of(plane, struct kirin_plane, base)
-
 
 struct ade_hw_ctx {
 	void __iomem  *base;
@@ -59,18 +53,6 @@ struct ade_hw_ctx {
 	struct drm_crtc *crtc;
 };
 
-struct kirin_crtc {
-	struct drm_crtc base;
-	void *hw_ctx;
-	bool enable;
-};
-
-struct kirin_plane {
-	struct drm_plane base;
-	void *hw_ctx;
-	u32 ch;
-};
-
 struct ade_data {
 	struct kirin_crtc crtc;
 	struct kirin_plane planes[ADE_CH_NUM];
@@ -78,12 +60,7 @@ struct ade_data {
 };
 
 /* ade-format info: */
-struct ade_format {
-	u32 pixel_format;
-	enum ade_fb_format ade_format;
-};
-
-static const struct ade_format ade_formats[] = {
+static const struct kirin_format ade_formats[] = {
 	/* 16bpp RGB: */
 	{ DRM_FORMAT_RGB565, ADE_RGB_565 },
 	{ DRM_FORMAT_BGR565, ADE_BGR_565 },
@@ -127,7 +104,7 @@ static u32 ade_get_format(u32 pixel_format)
 
 	for (i = 0; i < ARRAY_SIZE(ade_formats); i++)
 		if (ade_formats[i].pixel_format == pixel_format)
-			return ade_formats[i].ade_format;
+			return ade_formats[i].hw_format;
 
 	/* not found */
 	DRM_ERROR("Not found pixel format!!fourcc_format= %d\n",
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 22d1291668cd..d47cbb427979 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -9,6 +9,30 @@
 
 #define MAX_CRTC	2
 
+#define to_kirin_crtc(crtc) \
+	container_of(crtc, struct kirin_crtc, base)
+
+#define to_kirin_plane(plane) \
+	container_of(plane, struct kirin_plane, base)
+
+/* kirin-format translate table */
+struct kirin_format {
+	u32 pixel_format;
+	u32 hw_format;
+};
+
+struct kirin_crtc {
+	struct drm_crtc base;
+	void *hw_ctx;
+	bool enable;
+};
+
+struct kirin_plane {
+	struct drm_plane base;
+	void *hw_ctx;
+	u32 ch;
+};
+
 /* display controller init/cleanup ops */
 struct kirin_dc_ops {
 	int (*init)(struct platform_device *pdev);
-- 
2.17.1

