Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0BFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238D521744
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rv+Gl8eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfHNSro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36642 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfHNSrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so6314plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jr0LHNXFLRr/YgSdWt3cOqmTd6edKKK0IXkakE1rRaM=;
        b=Rv+Gl8eCcK5oQSZmfccdJupNqiSkL5PLZeiuBMuUviSXpb018SThybZruQCixf9sc+
         5T+plvMnfu8014K2hxyhCEeEiSTQfuOG5dkABwYp4wGXGWaYhQy7FxfUsejxGvAyiJJU
         bNgQ9/UXRNO/cUtGhoO1Fg/xSrXtLjA6FU8Q2TVLyunHqshmY0QE5/6+/eRFgs/1A0yY
         4dlbRdiymYQSL72JNwf1JCBPeXaSEGipD7/SPNiZrMZ0vIa4yBLJ1r1Y3Q0DZNYVWGZJ
         WiDByytAZVSJpM8gWUIT1HLUk05RwvQ/7jVEu0mbAHdj41nVdfiRd2tYCHRvJ0nrqQhw
         NsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jr0LHNXFLRr/YgSdWt3cOqmTd6edKKK0IXkakE1rRaM=;
        b=cHFvj1vd0Ep7332lPsZ76X7zaMXS/iN5qUYgnzu2EqZPdF9m7uY9i+ecRIOmJnuBFz
         A6SNtReO54PXphdNDQNglJqo3FL+5scB00COAYY1E+dlKP3kD+tgLl/ETm1FRKXVCQ1/
         +mpXdx6iRt9a7Ia44SNdgtV31/mQY0w8/HMxB7T+UQff7JWr9VzpbQ81ao8ZhBsASVQU
         UB0iR4N6ZLITLmA2eHP1+aZhAuLRHsqQKlCpr+70P0zYGQmES4UVm7fE0xrSqUnGrrAb
         0EVHTdaPdiKx+sRH2ZFexMXCkba6bKKNKnx7egVJAVygVUgAGRSTI88Pje52lQ7GGzQn
         La4g==
X-Gm-Message-State: APjAAAW2KzHuSG0n+S6ah9MXCcba65veyp+TkSsRZb/IOeka2EDA8DPz
        T9MaU+iSzkvq52plJM6GAP7t3qOaFGc=
X-Google-Smtp-Source: APXvYqzo/mdKFHRoq5DJ0COo3YXh5eNMJS7NWWZWkEwSch3MmurQnHJAW/u19PUU2WoblQ7z19983Q==
X-Received: by 2002:a17:902:9a8d:: with SMTP id w13mr736590plp.157.1565808459554;
        Wed, 14 Aug 2019 11:47:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:38 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 21/26] drm: kirin: Rename plane_init and crtc_init
Date:   Wed, 14 Aug 2019 18:46:57 +0000
Message-Id: <20190814184702.54275-22-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 66434c0cce6e..0bdcac981d8b 100644
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

