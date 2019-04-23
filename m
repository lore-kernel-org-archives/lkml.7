Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC933C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7190218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTy8g/79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfDWXWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40370 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfDWXVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so8361526pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uz24bMZkViIyZeft57rxEgaLGT+lil7nI2PxrW42mfI=;
        b=fTy8g/79O0qRKYvKP2RA0bslJG7zvilBCVnEtjN2gYOP06t2CbJd8WhLxUF6wP+avC
         OA4zDKjq6w/qLqnBAyMmLXGoolHASn1fHzgNoFF4jjFWNN+ixU5A8hHC2X8jljvHZbvK
         c9vZWThmvpr5SHcmFje/wJEGzWf2M2AnoqigE4QKOwbIMcYPLIBSE7ZsA05BjnhHGGqE
         Y2rZMgViwnDm+lYCCrABRCAlhPjbcmc13D2EIV16Tct6u54mQi3yCdguIAmtGTO9832/
         ut767RhEY0yZcBpSaI9KiekMCnaank+ZjmFwGEk/c56yqj0FHkyudqNvF+G3gMGjhde6
         rdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uz24bMZkViIyZeft57rxEgaLGT+lil7nI2PxrW42mfI=;
        b=CbhHTcCsBEwDh6smI0aZdzWaNiWknzPOKOaExTKOr91B7P/AcdR/mkwQ5JTheOeyJO
         6wDwqG6hZXMMbbYc+qpRFYBfGJFkoht9fgYuwOX0d2sMbxVmaawnsEMHb/yZsGKhBmRa
         1pGLZQ8CB2BoUs1DuncZsRJ2vRxfD+qaTCNtGDbZJlzNGZFENAM5m0DNzB/JtfXTkOoV
         a8hz+xdqCPtYLHIdVFXkPJQduBCm67YqmGsWLEWvS1cTPfKQgnkWh+A1DwkzME1iNj9z
         kKZqbfIprDk/VVuo44s3/xj4ggPV/dYXY/VJ3JH02b6rEOGKp3wipFlt2cJ9SxpLOMTq
         dMWg==
X-Gm-Message-State: APjAAAV0HhCj2rHjZKfKtSXGnt8ShEcJRlUDLwZuCsgjaVAX39p2PNKG
        WK+d/6TToT9+kDyJ5PV9QEdNhEjVJhg=
X-Google-Smtp-Source: APXvYqzaQtp/hoCTDB1oJS8t8WWJg3hNjFooU0vTdyY+fPoz4HEer+IeO5PcJE0YZVOjw5Sj4j0vrA==
X-Received: by 2002:a62:6807:: with SMTP id d7mr29014610pfc.75.1556061684829;
        Tue, 23 Apr 2019 16:21:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:24 -0700 (PDT)
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
Subject: [PATCH 17/25] drm: kirin: Move config max_width and max_height to driver data
Date:   Tue, 23 Apr 2019 16:20:48 -0700
Message-Id: <1556061656-1733-18-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the max_width
and max_height values used in kirin_drm_mode_config_inita to
hardware specific driver data.

This will make it easier to add support for new devices
via a new kirin_drm_data structure.

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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  2 ++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 17 +++++------------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  2 ++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index b6b1da6..8f15269 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -1054,6 +1054,8 @@ struct kirin_drm_data ade_driver_data = {
 	.prim_plane = ADE_CH1,
 	.channel_formats = channel_formats,
 	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
+	.config_max_width = 2048,
+	.config_max_height = 2048,
 	.crtc_helper_funcs = &ade_crtc_helper_funcs,
 	.crtc_funcs = &ade_crtc_funcs,
 	.plane_helper_funcs = &ade_plane_helper_funcs,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 4b210ea..70fee30 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -41,17 +41,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 	return 0;
 }
 
-static void kirin_drm_mode_config_init(struct drm_device *dev)
-{
-	dev->mode_config.min_width = 0;
-	dev->mode_config.min_height = 0;
-
-	dev->mode_config.max_width = 2048;
-	dev->mode_config.max_height = 2048;
-
-	dev->mode_config.funcs = driver_data->mode_config_funcs;
-}
-
 static int kirin_drm_kms_init(struct drm_device *dev)
 {
 	int ret;
@@ -60,7 +49,11 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 
 	/* dev->mode_config initialization */
 	drm_mode_config_init(dev);
-	kirin_drm_mode_config_init(dev);
+	dev->mode_config.min_width = 0;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.max_width = driver_data->config_max_width;
+	dev->mode_config.max_height = driver_data->config_max_width;
+	dev->mode_config.funcs = driver_data->mode_config_funcs;
 
 	/* display controller init */
 	ret = driver_data->init(to_platform_device(dev->dev));
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 59fc888..af27acc 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -41,6 +41,8 @@ struct kirin_plane {
 struct kirin_drm_data {
 	const u32 *channel_formats;
 	u32 channel_formats_cnt;
+	int config_max_width;
+	int config_max_height;
 	u32 num_planes;
 	u32 prim_plane;
 
-- 
2.7.4

