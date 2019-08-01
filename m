Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A65C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B001A21726
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpdAgIcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfHADqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:46:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43505 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbfHADpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so24505371pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvGyWsNyP9Bb7DvqACymLRZDyyMjKAZBXEluuc9xeZo=;
        b=CpdAgIcnEs1v23uEn8j393vhUG7E5P7b2dTor0b0ONtrkdl+hYKhIpnkkCubMGKMZV
         VOaAdqQKwfl87lx5n4WHIlP0bR4JOc2tetuKP68OFxD5m1APnFeoZCl3zU109lzr4Bm8
         mBifG3ZBmjOFszCeB/XiWO8Z+5KdbK+61O+hql3YC7yQdXicqiLW36RXNA/mOBnZSpPh
         mpuuaHrQ4I4LKbLf27A1tVEhOiAGSp5Uh5e5LN2vhwaKmyVhcIqto9sUnT+EEk/FFK9y
         ze/JyJmacR+OS8H4uTNBDIzhHJ15RX5wqmBMNO5XSZ3A6ZyqWIlaesIfCqWSggdvJBFX
         dvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lvGyWsNyP9Bb7DvqACymLRZDyyMjKAZBXEluuc9xeZo=;
        b=s+VXrEaM5lrt2UsyIYhrxo/RX6LqTTEGZv8D9BA2v9FwzVlOIIvnKHxQfr00Lw8iMC
         5WqVFTbOqKT+qcLknc3QjsZkAaUxS5yTbmis63WCn11SOa2f/cmtJsedy6vGObyJIDlm
         ghUROBDK2kNMQjhCSyw5aRiKpcQfCYRz7aO7sfRebfm9GPL5hd7vwRzv4/Psc7GuDWuo
         //prYQPSGthHRPfzZSaC1OWGyd+qwCMJKUDeGnLhOG27gJJre3e8dbjcwd31X63L+RXp
         XdoX9r+vXXww2I/Q6ycoxEuhbolUOtod3RdSmTBOQQbj0Njsf15UXN2gM2BG2Pmxa1B8
         pCew==
X-Gm-Message-State: APjAAAWKaVwfOAJNPO5GJrM+LhlqbS6IIH8TXwusQZw/83iSYhC1ud+m
        CO3RYrmao6bk7yP4k5e0VA9n0vBAqp8=
X-Google-Smtp-Source: APXvYqylc9ummDBci5gA3r5mxBzsQHl8bSaQwM8mWZUpp1YAXcP9uhE5n/+pzVs3T0qqoxO5HW5crw==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr115381435pll.298.1564631112233;
        Wed, 31 Jul 2019 20:45:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:11 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 17/26] drm: kirin: Move plane number and primay plane in driver data
Date:   Thu,  1 Aug 2019 03:44:30 +0000
Message-Id: <20190801034439.98227-18-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the number of
planes and the primary plane value to the kirin_drm_data
structure

This will make it easier to add support for new devices
via a new kirin_drm_data structure.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 21 ++++++++++++-------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  2 ++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index bca080e14009..fc0f4c04d1c9 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -35,7 +35,6 @@
 #include "kirin_drm_drv.h"
 #include "kirin_ade_reg.h"
 
-#define PRIMARY_CH	ADE_CH1 /* primary plane */
 #define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
 #define ADE_DEBUG	1
 
@@ -991,7 +990,7 @@ static int ade_drm_init(struct platform_device *pdev)
 	struct kirin_plane *kplane;
 	enum drm_plane_type type;
 	int ret;
-	int i;
+	u32 ch;
 
 	ade = devm_kzalloc(dev->dev, sizeof(*ade), GFP_KERNEL);
 	if (!ade) {
@@ -1015,12 +1014,15 @@ static int ade_drm_init(struct platform_device *pdev)
 	 * TODO: Now only support primary plane, overlay planes
 	 * need to do.
 	 */
-	for (i = 0; i < ADE_CH_NUM; i++) {
-		kplane = &ade->planes[i];
-		kplane->ch = i;
+	for (ch = 0; ch < ade_driver_data.num_planes; ch++) {
+		kplane = &ade->planes[ch];
+		kplane->ch = ch;
 		kplane->hw_ctx = ctx;
-		type = i == PRIMARY_CH ? DRM_PLANE_TYPE_PRIMARY :
-			DRM_PLANE_TYPE_OVERLAY;
+
+		if (ch == ade_driver_data.prim_plane)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
 
 		ret = ade_plane_init(dev, kplane, type);
 		if (ret)
@@ -1028,7 +1030,8 @@ static int ade_drm_init(struct platform_device *pdev)
 	}
 
 	/* crtc init */
-	ret = ade_crtc_init(dev, &kcrtc->base, &ade->planes[PRIMARY_CH].base);
+	ret = ade_crtc_init(dev, &kcrtc->base,
+				&ade->planes[ade_driver_data.prim_plane].base);
 	if (ret)
 		return ret;
 
@@ -1047,6 +1050,8 @@ static const struct drm_mode_config_funcs ade_mode_config_funcs = {
 };
 
 struct kirin_drm_data ade_driver_data = {
+	.num_planes = ADE_CH_NUM,
+	.prim_plane = ADE_CH1,
 	.channel_formats = channel_formats,
 	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
 	.crtc_helper_funcs = &ade_crtc_helper_funcs,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index ce9ddccc67a8..2b660df60293 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -37,6 +37,8 @@ struct kirin_plane {
 struct kirin_drm_data {
 	const u32 *channel_formats;
 	u32 channel_formats_cnt;
+	u32 num_planes;
+	u32 prim_plane;
 
 	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
 	const struct drm_crtc_funcs *crtc_funcs;
-- 
2.17.1

