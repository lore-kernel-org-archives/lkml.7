Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB935C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2C822DD3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+7JlJtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfHSXEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:04:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33510 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbfHSXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so2049188pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5xXqlqGWu5A581PxcE1TU9HQN3Deqwd26JfZ6CBJo3I=;
        b=i+7JlJtdwvhF0sU+zkXbFNUp/U9CGl0fhE6aCXvRQ6LAEgcqtBgbtAwFQz/f4UShbr
         o1CilFSSiyAlklLCS4XbjMea207NHBunBUsC+CyfYie1eHyQ1s++OXJaLWv6KBpF0RtQ
         8MV7AeU1PYnGdfYWDPHg3znzttuK89H8oFUoaN7yfFQoPktS+rX9t4yajotfrLNMrBZ+
         fC6f1ALQ1sfh81EerbqgsD/GIvBQV5XpD2yaFU6CBT0OeBvhgWlcAGfVc5tf5DEDBvWW
         J1ttv4bZm9XEjn8k5xoz/VUbWv2c1udxvDVfb4s7xSgW8Wc9dRQyAX85EJzy165ScrLr
         Dg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5xXqlqGWu5A581PxcE1TU9HQN3Deqwd26JfZ6CBJo3I=;
        b=lCbcGOiRwroYJiXulp9uwCVcYqiKXOJtKgig7da2l143S04D1EIkDZS1L8jDYw2N/a
         4blxyEWnhKS/B5trtEVvVtUDIXFyiiiPoMrygdz4zKJ4iil3CXDGU6ROjmudOjqdutwF
         XCzXuBi+/saRKvjcmGz9M4nHASaqRsh7GkE5J2iAz/jS9GlIvVM1/fo8S8xfOfwMo333
         bt92wIm4DmWLwWfc3VDhu7ZamSsINGvvQVO8R7wxaTepiEyLwYporq0r+ueWf3VNNPQr
         qO4+UBZL+3pQRHVLpCGBjPNYy0n0fS2Qf360weZX5lJ41ql4Au8sbDlBE/M+R/ukc9xy
         5Gng==
X-Gm-Message-State: APjAAAXYe+JtyY2dQ7ZOTDMXGQOpvt5EXwMgPrI5Mw4JV1nogq/uHXd1
        +dKgrxTTlPlsh02puEKJbOqpN9JimFA=
X-Google-Smtp-Source: APXvYqwfhm7llbkVctWlSDwtfdAvwLhY+YVSQI6Ko11Wl1U5THXL/MpzMgH47+N+G/aXeDPuN1xZxQ==
X-Received: by 2002:a17:90a:9f46:: with SMTP id q6mr22468018pjv.110.1566255836335;
        Mon, 19 Aug 2019 16:03:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:55 -0700 (PDT)
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
Subject: [PATCH v4 20/25] drm: kirin: Rename plane_init and crtc_init
Date:   Mon, 19 Aug 2019 23:03:16 +0000
Message-Id: <20190819230321.56480-21-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 5f39249fd83e..a0cc1285512b 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -571,7 +571,7 @@ static const struct drm_crtc_funcs ade_crtc_funcs = {
 	.disable_vblank	= ade_crtc_disable_vblank,
 };
 
-static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
+static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 			 struct drm_plane *plane)
 {
 	struct device_node *port;
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
 
@@ -1024,13 +1025,13 @@ static int ade_drm_init(struct platform_device *pdev)
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		ret = ade_plane_init(dev, kplane, type);
+		ret = kirin_drm_plane_init(dev, kplane, type);
 		if (ret)
 			return ret;
 	}
 
 	/* crtc init */
-	ret = ade_crtc_init(dev, &kcrtc->base,
+	ret = kirin_drm_crtc_init(dev, &kcrtc->base,
 				&ade->planes[ade_driver_data.prim_plane].base);
 	if (ret)
 		return ret;
-- 
2.17.1

