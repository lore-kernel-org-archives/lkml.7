Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE65C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1A7216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZzQFn1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfHNSr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37661 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfHNSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so22026pgp.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wKlIaA25olU11BOMfTs22yk2wQhbHWnGWzmK5Nr5c8g=;
        b=eZzQFn1vrMPxI+c/iYaHjDFjdZqtfub5KdhWWCpMgIT90qc4LcH6QPySnBMnKqR1RJ
         hWFUlAp61oTrgfMmqMwVWrLDY3uwozkSqtAfucJDuU6oeJex9OI7lG0TKSrZC8t/+sC7
         01P64SsD7fNSJ1fg1G5K9qXI0autzHTOrULBojThGkp/bgYTBYBa8OrdYy09/tid3Pnz
         BMO0eQKBVdfcT99VfcCVYGNbxzc0RsJc5lTLl6njbbQlHkgbOFN5RJPixCjbNmsdV0oT
         EJ46CZsKSnu+joJf8KYeWOviuK1PlsrCh7YHL94bkMPJNauTwDcq4UAB4xWnJYDqELDC
         GxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wKlIaA25olU11BOMfTs22yk2wQhbHWnGWzmK5Nr5c8g=;
        b=UNvXuQW3N/NNTJ9Cpx8wZ35JRfR8topvLGabJSWz/ZMRVJb3Xdi9essvt0rvc2pAlL
         DAk77KTtafFga07dVLd+rCAfblv92o3+QAYNgc0nS/nJ+9M7/YtJnwT1WPA0QFfgWber
         BUNjMRLtQF8f6PqUP7SjEtFguYfrX5PaS4gF+SRhea0RuYewMcM4SDczw23Pl3PRz5db
         r+KCPVKTfhKWhEf6WprAll/9Pn2JBjFJRypfraZVyVduXrTgLb4qlqFWm1B5sbGWGLxy
         +aaG0OqwQ8LVIWQkpLkU8VGY5KVhHxoL0o4ugM7WxKL8mc24hf7Snc3lQG20lEnKtlCG
         dHEQ==
X-Gm-Message-State: APjAAAUWquLR92gCJ6VEVrqoeK1bhW7JX5V85+lHknhW9IiUpUpVgM1a
        2k7vdwhORW1bQNjswD+CBbucczJ2qKc=
X-Google-Smtp-Source: APXvYqzHEij/L3W78cYXzvyGC77DpNrqOmQ3aeVR5dxILgGVVx40Tz9jy8wBE2fteMZvJQgodyXz5A==
X-Received: by 2002:a17:90a:1916:: with SMTP id 22mr695571pjg.62.1565808445560;
        Wed, 14 Aug 2019 11:47:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:24 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [RESEND][PATCH v3 12/26] drm: kirin: Move kirin_crtc, kirin_plane, kirin_format to kirin_drm_drv.h
Date:   Wed, 14 Aug 2019 18:46:48 +0000
Message-Id: <20190814184702.54275-13-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
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

