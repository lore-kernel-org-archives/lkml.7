Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0EA22CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBubEr9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfHSXEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:04:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37976 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbfHSXDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id m12so1691168plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BGaZCHgDYd2hveQf3FIs87y4ItjrwpXVDJprgquPOWQ=;
        b=PBubEr9VLwe1O9i3u/1JpUbVWWVRe1sxgiti5t0bnIge4DbaYL+kNfFfr3IABo14vj
         Ncm9oya3aCG/2Y3Ey3oeC9b/qL8vZmHf8ia/uSGf57tOM6njQfvPd6r9duKDKQ3D3pqH
         rWidoMoYtbrsmy0PsZWEPMlTynETHD2DplN8jFwztf/vFyYlPEYFe3t9SuTcTCW0G1ic
         094wbNixvL8via6KTKj5jJFwHa9ktPlmrWCXOT2RwqThxjXSgVg2M8WxXD1vFvACKL4W
         OiqlUl0/TaN8fRgAGqXjKANQz5oaahR15ABy6uRTbkvplNTXlOuT3Qbv9L7iyzjaSIDr
         T6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BGaZCHgDYd2hveQf3FIs87y4ItjrwpXVDJprgquPOWQ=;
        b=ea6aO7Q4b2LBOT4yjRTFd5Q7r6CXW5b4CU+S48PS0SPQvyhG6ocIxS2hAg3RqM69iS
         RjjlMbf/9lr/0a2hP1NDpC5tTZhrxHN8EPCyZPt4KemZ1TsD/OIQQ+uvEvQHrTrADy54
         ptK3+rinYhTvPbYAubY26gJhIWtN9LRlN6WhSgthUxdrr1FV9lVIoge+yGIazu6O1VPn
         mQs+6qipQ5ZeVBEiI9KVdjJ5A42F4oCtvk1m/SSoTWYQGwP1bn3YgOwWf2IgQHOwD0qi
         EtxXW2oDrtS9Tz1Y+Dq7FAv49GQIgnqywPhG30/gHQWB4+KKGlAhUm0DHuRQd9qkljcq
         bmZw==
X-Gm-Message-State: APjAAAU7PLRODSo2JhV7568x1yLy9A2ts6p3kIxMThz9pCEoAm5okzYL
        SMS/nXcbpbAbkvTRML0J7TVJVmD0G48=
X-Google-Smtp-Source: APXvYqz71dgcZoZ4RdSSvpDEAXlxbSAJ9jAS4G7wNm+chbPz8rUdCZt5PGcwWvgDU8KRYoVLnakEBQ==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr16581568plc.331.1566255829603;
        Mon, 19 Aug 2019 16:03:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:48 -0700 (PDT)
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
Subject: [PATCH v4 16/25] drm: kirin: Move plane number and primay plane in driver data
Date:   Mon, 19 Aug 2019 23:03:12 +0000
Message-Id: <20190819230321.56480-17-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 21 ++++++++++++-------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  2 ++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 4001f060e580..8b1f3580cbd6 100644
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

