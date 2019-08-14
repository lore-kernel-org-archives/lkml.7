Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F64CC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BE32084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRYla2J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfHNSrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36715 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfHNSrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so24680pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DPljuKj8Rrvaey+ZGnnQxT53Wa6yVLMni/ZPYwy7Ocs=;
        b=QRYla2J3YD94bct0XU/VHlhyLBX+vVhC+xrK/C+P82fiQdUTI0Nv6p2/JbYEJZOVP2
         irXIWpYYUC4X2OFt0YIfI+Z+sogCMa5Yr344yI0VBA1ygrw398u2/Rkrvf9xUHpR7rUA
         6zxlqnDtaevKn+NixPVJ3s3kLJqX5a4oA6MTSlZtGz43sUXt2Jpo5nDtOvINCQo8aFKH
         vnAIA8BYEpG9uji7lsh0fD2ywHOV6zNAvQIW2/Pmjd23ia5ctRBP/kcqlyyrjnPZQNyj
         pk2Y3KAIb6p1ap7SsTUjUnPTyWvpHnGKE75sq1g19cpd5bi3JAesWayUDirQ2c0VdZd9
         9U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DPljuKj8Rrvaey+ZGnnQxT53Wa6yVLMni/ZPYwy7Ocs=;
        b=ASyFyEE1V9ie218Hj3bzfRBhLgmToqMaSAXu8/XtJYH3RBFPfl/fG9VX1vB/6D+KPT
         NYli1QFE2jHviMWmOjATW1DJW3zkU+u7+j0pnqaNyW2jhIwhJLn/pOdJ+l18QhaOaZtT
         sb8SDLfJjxqE6YmV+GwFnzr4U0Bn9DjrDSqJehptJoN2J1lIEw8n9yF4HxumzevbarzE
         /UYxz+zqoUiV7mca0uoNa/PiysxJTOCMrQUZ8EoM857J2iaAUpVxxqIYWrMLxudIhS58
         X6leMr/1Vzjn9rUatVPsrv2pG2nGkA+eoulan/kWTNJCwAv2N8y2u9PTr8isAvxGQFEm
         vDqQ==
X-Gm-Message-State: APjAAAVbv+3rR9coCsAU9lysOI9X4C3KgnfePLSv/cAv6+nxpo4hGb1Y
        ixSv89YUCKtj5txyYRnt4o3EKsBz0+Y=
X-Google-Smtp-Source: APXvYqxzYdQ++BF6VEmmM3gRhlHFCARtDdNB9cW6qpH5aGj4/2Nec/UVjqlAUe+ZhaEJDq6QZq0a8g==
X-Received: by 2002:a63:60d1:: with SMTP id u200mr458559pgb.439.1565808450277;
        Wed, 14 Aug 2019 11:47:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:29 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 15/26] drm: kirin: Move channel formats to driver data
Date:   Wed, 14 Aug 2019 18:46:51 +0000
Message-Id: <20190814184702.54275-16-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the channel
format arrays into the kirin_drm_data structure.

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
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 30 +++++--------------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  3 ++
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 029733864aa8..99dfd15af771 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -76,7 +76,7 @@ static const struct kirin_format ade_formats[] = {
 	{ DRM_FORMAT_ABGR8888, ADE_ABGR_8888 },
 };
 
-static const u32 channel_formats1[] = {
+static const u32 channel_formats[] = {
 	/* channel 1,2,3,4 */
 	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
 	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
@@ -84,19 +84,6 @@ static const u32 channel_formats1[] = {
 	DRM_FORMAT_ABGR8888
 };
 
-u32 ade_get_channel_formats(u8 ch, const u32 **formats)
-{
-	switch (ch) {
-	case ADE_CH1:
-		*formats = channel_formats1;
-		return ARRAY_SIZE(channel_formats1);
-	default:
-		DRM_ERROR("no this channel %d\n", ch);
-		*formats = NULL;
-		return 0;
-	}
-}
-
 /* convert from fourcc format to ade format */
 static u32 ade_get_format(u32 pixel_format)
 {
@@ -908,18 +895,13 @@ static struct drm_plane_funcs ade_plane_funcs = {
 static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
 			  enum drm_plane_type type)
 {
-	const u32 *fmts;
-	u32 fmts_cnt;
 	int ret = 0;
 
-	/* get  properties */
-	fmts_cnt = ade_get_channel_formats(kplane->ch, &fmts);
-	if (ret)
-		return ret;
-
 	ret = drm_universal_plane_init(dev, &kplane->base, 1,
-					ade_driver_data.plane_funcs, fmts,
-					fmts_cnt, NULL, type, NULL);
+					ade_driver_data.plane_funcs,
+					ade_driver_data.channel_formats,
+					ade_driver_data.channel_formats_cnt,
+					NULL, type, NULL);
 	if (ret) {
 		DRM_ERROR("fail to init plane, ch=%d\n", kplane->ch);
 		return ret;
@@ -1057,6 +1039,8 @@ static void ade_drm_cleanup(struct platform_device *pdev)
 }
 
 struct kirin_drm_data ade_driver_data = {
+	.channel_formats = channel_formats,
+	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
 	.crtc_helper_funcs = &ade_crtc_helper_funcs,
 	.crtc_funcs = &ade_crtc_funcs,
 	.plane_helper_funcs = &ade_plane_helper_funcs,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 70b04e65789c..66916502a9e6 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -35,6 +35,9 @@ struct kirin_plane {
 
 /* display controller init/cleanup ops */
 struct kirin_drm_data {
+	const u32 *channel_formats;
+	u32 channel_formats_cnt;
+
 	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
 	const struct drm_crtc_funcs *crtc_funcs;
 	const struct drm_plane_helper_funcs *plane_helper_funcs;
-- 
2.17.1

