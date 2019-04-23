Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20584C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0358218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrbjvLIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfDWXVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45301 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbfDWXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id o5so3927256pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/4HxndEudHwbox8bYtalM+RzpPcrsQmywphYVO0zYc=;
        b=wrbjvLIo7S8yefWAy6S+t5N9WVIMTHNi7nErLNj2JKhJMJl251rGYiIplpc1EiXgNM
         Cm8XYxORSs0TYxOCaR2AWcCv0fIBZy/FXBxGbysMh1iDK/LxOOHFbzsVWfxEq0GbMIk7
         GIG3qZDuYuMgTYYPlRATA2pucx+HITzMYtk5WQWPyTDUaQcSqeL37Om9XOS1jjNrFZT2
         ikZoyF1PFPXRmNB7xyMmZg7N95Yi0A5MS9w1+RqUKHQYLnNSvpJHsCfRrRJQ2VDLqF6r
         i7umYS2xIC9MeFswCLO7ecu4e4plaJruFjQwwVxSDXBhpFrgwqO5eVLpfQw78byznb7X
         f4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/4HxndEudHwbox8bYtalM+RzpPcrsQmywphYVO0zYc=;
        b=sZVbZwdtk7knNUEOZe/9ptUlGph33Crghd0tnAbqxEy2rY5V0Hb+dR/Ao7A4V96jqe
         nOz/idb1hdj8HUVWjS/+qpin3q7TLTQ7x3lsxTOj1Otx0LMyAFDYRlGjKXoP5bzZs08a
         LtDriPpB4XC0ZazWODlztKp/2SruuhjcGg9jh8P/KQoX9WY1cauuBtJ0keMS3BmOxLvy
         eGkY6zuEPvPqJgVA1JQ0nyGJ2dfpBgJAWYjKkZ0ne7KV7Uc8E3Enkr42zLAJRAXeHYRT
         v7UOBrKaVRuvCiN1W+c8TzV/7mPWZ2SgeG7Xlzc7Rgr0jQ93aYrI9rbsjJM+9yIFXJPg
         jNqg==
X-Gm-Message-State: APjAAAXySW7IlLzokgib+xYE/l8cDKTOnVVA7QL2vxGyZpslrysrq71G
        f63qb4k0gqKYoDsncgZIAJp6rf5/HKs=
X-Google-Smtp-Source: APXvYqznrvpDjtreESEdxVrYCapvLp99vt28Wwa/eBLgzR4YMg+4MxUeBU80XpmD1fo4NGrxwhOEHA==
X-Received: by 2002:a17:902:d701:: with SMTP id w1mr27423947ply.124.1556061688981;
        Tue, 23 Apr 2019 16:21:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:28 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 20/25] drm: kirin: Rename plane_init and crtc_init
Date:   Tue, 23 Apr 2019 16:20:51 -0700
Message-Id: <1556061656-1733-21-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
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

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index fcc01c2..21965ee 100644
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
2.7.4

