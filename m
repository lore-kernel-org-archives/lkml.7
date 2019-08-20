Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9432342F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/W5hPjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfHTXGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38348 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfHTXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id e11so157265pga.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OE/knvVfD1cUvaltFYKP0JvLLCHD/efyGm+69Rc7xlw=;
        b=t/W5hPjchDYa6sGZVIGnHO6x84ep6oMs8OQM95dG6M/wiomHPHQuiTvqt+n3CZLObc
         O+QoVXcBg9FH5iWKGRWKWGKakOXamJ+A1YDSsmZ/eag5qxWoPNbpY0T/FrWTQM4fA4bA
         7a1CU2ujUC1Hcu2DpQygzwwEUXYz4SMH1LjAz7Lb/0cvZJQLByjhD8cu7uD48j0rDG8w
         OZig/Hnis2947iEqf9wJicr4akz0qfd58VRw9QeXmO0++iIIMihvCQLa+rg4497A7OlH
         dzqJVhg3Y7TS+g635mQguEl93U9enx9o+UtlHWnQjbKEsdI1sMNWx53aFsDToV8F/taD
         Yvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OE/knvVfD1cUvaltFYKP0JvLLCHD/efyGm+69Rc7xlw=;
        b=j7t0ryr+u/AqFVsKqARfbZMYcYujmK98vcmsRRoiA6UJp71qlJFwKFJM9iily+cMMR
         W4jCRnBSpmRHwfgXjUmer6/IHUoWYu8rcysBwGkDWL6lQisA5obfrZp7eQcL05A5gjzF
         07nivbpReQTZ6Yj2jDOU25xo76za7KCEiAOE7uD3Za3EM59g4CEhDldE2t3Py168mN4w
         v2X/OypdRz5fHEkD9t4188EzQPKVDoGzaiFsuZjXTPo9jGXx5yyF/M3b9wOj6dfEWzUg
         lLvXSUl34hBP286JP+dBCHR71dNcJXNZfwEmXUZR65ewWmBrG43TsqruPsZl6ENApdzN
         0rKg==
X-Gm-Message-State: APjAAAV7NScRdsTvUTJbTuEUwaAE4mEBI6GUMfIZLSmw1BI/g3QTABrC
        LlRdr1KM/4r23aOeCTclQHbeJm6hZxA=
X-Google-Smtp-Source: APXvYqy8NWxr4UsxAfs4ZFu3Qa6r1PCDzR/mO6PksK93ygC0/2OPDBqgbMjUaZPdEPsuXPjL9mXzYw==
X-Received: by 2002:a17:90a:9a90:: with SMTP id e16mr2401477pjp.71.1566342408627;
        Tue, 20 Aug 2019 16:06:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:47 -0700 (PDT)
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
Subject: [PATCH v5 13/25] drm: kirin: Move ade crtc/plane help functions to driver_data
Date:   Tue, 20 Aug 2019 23:06:14 +0000
Message-Id: <20190820230626.23253-14-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the crtc
and plane funcs/helper_funcs to the struct kirin_drm_data.

This will make it easier to add support for new devices
via a new kirin_drm_data structure.

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 15 ++++++++++-----
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  5 +++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 4c6646dfc465..a1a79f372bcd 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -602,13 +602,13 @@ static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 	crtc->port = port;
 
 	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
-					&ade_crtc_funcs, NULL);
+					ade_driver_data.crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("failed to init crtc.\n");
 		return ret;
 	}
 
-	drm_crtc_helper_add(crtc, &ade_crtc_helper_funcs);
+	drm_crtc_helper_add(crtc, ade_driver_data.crtc_helper_funcs);
 
 	return 0;
 }
@@ -917,14 +917,15 @@ static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
 	if (ret)
 		return ret;
 
-	ret = drm_universal_plane_init(dev, &kplane->base, 1, &ade_plane_funcs,
-				       fmts, fmts_cnt, NULL, type, NULL);
+	ret = drm_universal_plane_init(dev, &kplane->base, 1,
+				       ade_driver_data.plane_funcs, fmts,
+				       fmts_cnt, NULL, type, NULL);
 	if (ret) {
 		DRM_ERROR("fail to init plane, ch=%d\n", kplane->ch);
 		return ret;
 	}
 
-	drm_plane_helper_add(&kplane->base, &ade_plane_helper_funcs);
+	drm_plane_helper_add(&kplane->base, ade_driver_data.plane_helper_funcs);
 
 	return 0;
 }
@@ -1056,6 +1057,10 @@ static void ade_drm_cleanup(struct platform_device *pdev)
 }
 
 struct kirin_drm_data ade_driver_data = {
+	.crtc_helper_funcs = &ade_crtc_helper_funcs,
+	.crtc_funcs = &ade_crtc_funcs,
+	.plane_helper_funcs = &ade_plane_helper_funcs,
+	.plane_funcs = &ade_plane_funcs,
 	.init = ade_drm_init,
 	.cleanup = ade_drm_cleanup
 };
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index cd2eaa653db7..70b04e65789c 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -35,6 +35,11 @@ struct kirin_plane {
 
 /* display controller init/cleanup ops */
 struct kirin_drm_data {
+	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
+	const struct drm_crtc_funcs *crtc_funcs;
+	const struct drm_plane_helper_funcs *plane_helper_funcs;
+	const struct drm_plane_funcs  *plane_funcs;
+
 	int (*init)(struct platform_device *pdev);
 	void (*cleanup)(struct platform_device *pdev);
 };
-- 
2.17.1

