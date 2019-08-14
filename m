Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A384FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAFA21743
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CER/jqqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfHNSsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:48:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbfHNSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id 129so7187583pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7WLovU9z58t+myBhWk3iYSpTP732yAw8/1ubIgKA+3A=;
        b=CER/jqqC2aPOLsLXBjxg7ht7MqkRyVbpCPa5548diH9GUIMpcKKp3Ab7dxu4JkRM4N
         QN6A4e5aHsk4ei+iWQrmACrD2/wR5JgFXd1lFFUdCl0FLIlhtTXA18FFWeQUkNP/3TgL
         fpGYfFfuSjbmScUfRlgx4700XHcpk4EJBYOKqwOONCgUDr1lkaG5HVGiZ5O4HlhPuGNX
         Lwdb2SVyX7FKnFopIbEkNXpRG91248q9PQB0b6bxOaRGkeSstBqBn2qMpFyZ2agAb0Rx
         x3M7tgDasQpoudyFE+yC64+qCgK738D2vMD4Z8ACW47e7JK2OMVk2/29ibZutteWt1BI
         058w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7WLovU9z58t+myBhWk3iYSpTP732yAw8/1ubIgKA+3A=;
        b=GYyNtRJyeLKtMZyq2s34nwIH5DWB2r0HddHiTy/0TpgjQar43rWrq3vpLXwxrjqwB3
         aLYSKkxEcmHJcfstA7HN1FV6rQWAARmm5VImLKK9oUCI4i6Ek3byZbuV/N/HUNUXZ/bT
         EpXsYM+gntvhEZiFUGLaxjMvTVw0wHUpCgZiHzLN9dWg8fKSYyFK2HOn1rq8oJV873WD
         Z1D3CW+94nJEw1EQiJqPGUgbQcLAdJd7U1+Uxs28+9FBM3g9S8cKgF2Ue1jLdrepvfSk
         cuSi4XcI0858IO6i3SV7AaDB9xmelwK3cZYb8cDhSl+GgOTxDXgZlnavERkKJNE1DuEn
         9oJw==
X-Gm-Message-State: APjAAAWMjhc3ehygw3zo/U1m3F3mFH9k4t3EFTSbQp0BLGSgRibDPV3K
        yFscefam+hwP2Ab6znDeLiY7YnKWR1o=
X-Google-Smtp-Source: APXvYqxj70kmciK+8+RpfO0Hyq2p8mFesfp+SwYXoNBXwfaJmOEIpApjYdaN0vMsGJxNRMUhNBzgDw==
X-Received: by 2002:a62:8f91:: with SMTP id n139mr1474420pfd.48.1565808448714;
        Wed, 14 Aug 2019 11:47:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:27 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 14/26] drm: kirin: Move ade crtc/plane help functions to driver_data
Date:   Wed, 14 Aug 2019 18:46:50 +0000
Message-Id: <20190814184702.54275-15-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 15 ++++++++++-----
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  5 +++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index acae2815eded..029733864aa8 100644
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
+					ade_driver_data.plane_funcs, fmts,
+					fmts_cnt, NULL, type, NULL);
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

