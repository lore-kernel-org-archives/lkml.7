Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D325EC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A670423402
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GC2fVtAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfHTXHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40807 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfHTXHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:07:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so88709pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JH6TFWi2jRebxYBXOLzwh9NRdxn767CmjdWSOdZnLUU=;
        b=GC2fVtAj+YBtwyiQU4cD88uREHFeALuT3jPKkf8NTz0iGw8Wn45nLFCbMqPGUz+2dR
         0gYKQJqIdjnrUwKlDMh3JQNLyAQPfpQIJ0mbXhKdYCF34TcU4rL7NEwrJjlfkgvdxVeA
         JpzkBkNn2MGzGd6UFO9KJQ9vXawjOin0EzUFazRkDOP/RBzQrZx7ZVs9/WRzf/DlTV1M
         p+5dzeM3+dZMhN2NYANr/FFQrs2gEWumdlchLmteC2QYvcqcTG6CesD+zF+zSirYUhrK
         pMhrfC8OLgH1wTLcf3F6DdT9i27AVAOGptJ+gua88BWMmlylsC3d1ePlRZjH0F6viva5
         N6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JH6TFWi2jRebxYBXOLzwh9NRdxn767CmjdWSOdZnLUU=;
        b=JyjNGfJjcKxzpcJ/+uLE98hDwePNCo/9MBf5nN1hmFGh80xwKNY7o5bWgaFA8wY7f1
         9hcHKZKTo2IHtrBeHNmK/T/aJUC1lKx9i4YZnadgcEobvZgERXWRmbbMpboyrR8/gkXA
         8fjGTd9TkaVD6NHMRYS0BIQ4KbamSHySMA6eZ6vGf3DXdJvX3pSofDlMff9asDIo5rlw
         bpLXFmmcP+jKcksZ5kGARWYe8CKfXUgGhi3ScvIKom98KP7OTOrVXrE1t2nJDxJgCcRY
         Mpncl2xjSQUpsRPk/pFc0dU+V35RK4CBtK/BWkLfQIStv3KK1JzTWk/6cB5p3cXOupO4
         7d7A==
X-Gm-Message-State: APjAAAVK9V9w08dGZjVdUs5CNzlPhduPqDCVp5HHR+iYHmsA4FEz4Qvc
        wOyoPBdxQg/a8Z6OX0elXcoQ2M6mkmk=
X-Google-Smtp-Source: APXvYqxcb1Obks0yFE+u7vU6fyhH13cugDVkKCNHFU9sRO/6BWUGpIIRt3iT73604AGLIwuXrrmSpw==
X-Received: by 2002:a62:ab0a:: with SMTP id p10mr32526186pff.144.1566342422333;
        Tue, 20 Aug 2019 16:07:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:59 -0700 (PDT)
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
Subject: [PATCH v5 20/25] drm: kirin: Rename plane_init and crtc_init
Date:   Tue, 20 Aug 2019 23:06:21 +0000
Message-Id: <20190820230626.23253-21-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch renames
ade_crtc/plane_init kirin_plane/crtc_init, as they will later be
moved to kirin drm drv and shared with the kirin960 hardware
support.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v5: checkpatch --strict whitespace fixups noticed by Sam
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 89bdc0388138..e390b1b657b8 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -571,8 +571,8 @@ static const struct drm_crtc_funcs ade_crtc_funcs = {
 	.disable_vblank	= ade_crtc_disable_vblank,
 };
 
-static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-			 struct drm_plane *plane)
+static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
+			       struct drm_plane *plane)
 {
 	struct device_node *port;
 	int ret;
@@ -892,8 +892,9 @@ static struct drm_plane_funcs ade_plane_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
-static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
-			  enum drm_plane_type type)
+static int kirin_drm_plane_init(struct drm_device *dev,
+				struct kirin_plane *kplane,
+				enum drm_plane_type type)
 {
 	int ret = 0;
 
@@ -989,6 +990,7 @@ static int ade_drm_init(struct platform_device *pdev)
 	struct kirin_crtc *kcrtc;
 	struct kirin_plane *kplane;
 	enum drm_plane_type type;
+	int prim_plane;
 	int ret;
 	u32 ch;
 
@@ -1024,14 +1026,15 @@ static int ade_drm_init(struct platform_device *pdev)
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		ret = ade_plane_init(dev, kplane, type);
+		ret = kirin_drm_plane_init(dev, kplane, type);
 		if (ret)
 			return ret;
 	}
 
 	/* crtc init */
-	ret = ade_crtc_init(dev, &kcrtc->base,
-			    &ade->planes[ade_driver_data.prim_plane].base);
+	prim_plane = ade_driver_data.prim_plane;
+	ret = kirin_drm_crtc_init(dev, &kcrtc->base,
+				  &ade->planes[prim_plane].base);
 	if (ret)
 		return ret;
 
-- 
2.17.1

