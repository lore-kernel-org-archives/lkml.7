Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0166C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B18233A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJQNBGk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfHTXHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42953 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfHTXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so146287pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nc0HKvLqdfxQ4XGBrfjKvfOMJNdfixijHmLsJLYaeJM=;
        b=GJQNBGk5r/2vcoEMF2xMvysOdEQINWPzyB68OUdnEgdsP+PFQgWLf5Gk+wnqCbVE3k
         MHW9uNhKC7xDRdBUuUzVDyuppOCKAyTs6CRisMkdUpzHFAuqEWKBVDHtGCQ8HUDezlrm
         5jNCCeZINejwuo60CoS7OfL08l3Ip/8ixVny4TedC7prbf+I6rV2ycGv1kNC5akcGW/f
         zJUOz4A7khwYlnW4oHgw/iOjwONpuAcsAxi3clf0DSahsstYfsa+zMdU6XE9zKWSmv8g
         Rn6ljFFKO6eCX3Fh0fQZ//J1FNyRJaWvKVWfgYX2522ZXI197xHpgSjgFi/ZKJImjSOM
         H7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nc0HKvLqdfxQ4XGBrfjKvfOMJNdfixijHmLsJLYaeJM=;
        b=dcnCAWdjvsHHM+31si6BgTtXV/sMlHIpopRcxywxLLQ5jciKSWSIyAieymVgPHJJtu
         eCI+WFGvhXWO0n1sdTCcPROKcRQWVSEIPoiuOy623e+4Fty1SA87skUnkBzMo7yzZvcy
         25/YHZAAJrLhD1dySL1yv2LXRZAnSxuhoYWUd/4dywCWEOEeAyk9v1yGSLY6vZeXjNxW
         aitPizZhqoP16VPJoYdazDSynp8MwTLDFAnRHaU0x/0pfy6P3dob2znDPHxNhiXkmq4+
         0zpQSYwRq4YvhpSX526qxD3KUrqbhPWrKqojHqkZ//vMUM2dQqlZiOw98/Uf7gL9j3cc
         ArzQ==
X-Gm-Message-State: APjAAAX9+bi3WA8RWrcy5fXpHYERurgImobXLVMSVWLyttj0Tk59yKVn
        SPKdAr/xeco69Uj+eCHeUbHAzzHzwGk=
X-Google-Smtp-Source: APXvYqyycOrj5QO/qCGc2tAh0Oxqq8tIKtAZe2eG52cV3l89piP4mv+qYGEtbuNk91J/oP8Yz4OZrg==
X-Received: by 2002:a63:121b:: with SMTP id h27mr451417pgl.335.1566342415194;
        Tue, 20 Aug 2019 16:06:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:53 -0700 (PDT)
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
Subject: [PATCH v5 17/25] drm: kirin: Move config max_width and max_height to driver data
Date:   Tue, 20 Aug 2019 23:06:18 +0000
Message-Id: <20190820230626.23253-18-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  2 ++
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 17 +++++------------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  2 ++
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index a74b2623dbbb..a4cf122375ea 100644
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
index 25191824b64e..2ab32c2e3f95 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -40,17 +40,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
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
@@ -59,7 +48,11 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 
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
index 2b660df60293..43be65f82a03 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -37,6 +37,8 @@ struct kirin_plane {
 struct kirin_drm_data {
 	const u32 *channel_formats;
 	u32 channel_formats_cnt;
+	int config_max_width;
+	int config_max_height;
 	u32 num_planes;
 	u32 prim_plane;
 
-- 
2.17.1

