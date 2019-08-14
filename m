Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C8AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8FD2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYKzaRm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfHNSrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40568 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfHNSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id w16so1589899pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=86FCzQs5EG3Tlp7MWCnk0oCzxkL88DSF1TUkPvnf8Ag=;
        b=NYKzaRm17tP5zbPEJdxJV8mwLPa4e5F6FFGpOt3yTQLiQAG/kxDCQxbTypob4j35rW
         z8ZNOEVzhSocgML3gJgfbSA5/Rx1caZmF+NoSoovjCWQhuD0rFiY82dpCoBH762FA6X7
         MVyBpuXbahe5OCzxysaazjvgrx5Vnjco81ikU3d4hC5oEQ5KpRp3BcClPdaLlQYUe4Lx
         K4zv7eLn2yJEofJ2HLwi5DmAtnUJx1GGqSU8FBWvitObcf/3E/rk2Hn4dT66DhceO+/i
         hXjeAl3uGpnFt7KStap+luZW65gxRlqGYOjLG+Eq8bCw2LPtmLeJvt3Wh4pA+br0yPZV
         jWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=86FCzQs5EG3Tlp7MWCnk0oCzxkL88DSF1TUkPvnf8Ag=;
        b=qlJGybA/5cAdRuHHL8QAvr8OrCcGffBBsGayzGPr61+DAsnKClHeOoM0NPQRVfe5FM
         2JxPirVAjmijh6jj+27okpOqFZ9THd4coQneuiAE0VHdPvJJ50YXhGQQR0FReigeCEoS
         Q86ZXSOLLFTy829BWKqOHS0e2i5niDYcgm+2VXnZPUoP8jKBzeF1zB0wMkkAWQNldrFW
         AhYHd9MHlPP+55Ti4Z0UeZSvLJcfxb0YTOeBAJO25fpWrN9wunJaAKdMvIWtM1L7liI3
         b5Vp0o8r65MVvrQv6n4N3MzoaGE9h6VXKNphZHobK4CwHQgQL6kzpIUZkHmlgeeT2Vau
         lNKw==
X-Gm-Message-State: APjAAAXDM0uApq4ra0wi51DjNQ1z122ijvcPVIvLmF5vcQlQBquXKJUh
        i+iNdIsTz9ohX6dHfblz36XSQgTCkus=
X-Google-Smtp-Source: APXvYqwe46/m/Z3WR/Ofq33p037b8zteD+0TSjAkh8AWNOXb2hCjKVmejw7gKNT110OmXr2pzAGK5g==
X-Received: by 2002:aa7:8ad0:: with SMTP id b16mr1387941pfd.45.1565808453207;
        Wed, 14 Aug 2019 11:47:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:32 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 17/26] drm: kirin: Move plane number and primay plane in driver data
Date:   Wed, 14 Aug 2019 18:46:53 +0000
Message-Id: <20190814184702.54275-18-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
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

