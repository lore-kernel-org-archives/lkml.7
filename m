Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916AF2341C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrhNpyBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfHTXGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34475 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfHTXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so103085pfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YJTcSCEwUYf2TN3oxKMWFSLC+lpczIvjHDBU/TsB0vU=;
        b=UrhNpyBEvkRLJlD1lnBou+mHZTRhB/m1n9p81ZBPRjW2VIAdtZdw5G0LZ73UkYTk7i
         8yb8acrI/FprbY7QYWmu7hrInIgXo6Q1U8sBIfwpWF6Jy+T4/aDjI79bJ85+QDN/sb/z
         ph8+8gU5w39ZCU6HCOMXwXJJrQLlN1jMDhQhLpbJI/SR0eJW+vRZUfrV6gHu2tQKgSut
         Hrrs0dG0CzItmrae/ljTZN8Up+KIoi65kBrgp/exBe0g7+nLaiN8C2hjX0TAHvVDTsOu
         LOyowmqfp9OsBg3NCxiOwij812jVpq+HVLhQ8CDdigZTZIBOwxSUySP4EobC2wg3MqFh
         p/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YJTcSCEwUYf2TN3oxKMWFSLC+lpczIvjHDBU/TsB0vU=;
        b=fFNLyYHKrxDShGgLtJrIWXqbm9x6GDredBWRt3hijjpgNx5XiKnYRWYnzZS9bw9Hu7
         wyq4KNZhX58+qZwYNruME3V1zG2Y6Z04VVvtyINqm5hRnOAUP1rCvwmPyPObebPTII4g
         AeNXY/ab8ko2btBWxq9UZFtg0IoRReR1enLu3u3zX0c4t6b27RVIf5fT75e2H5P5t088
         c+Q4yOMYcSsL//OTJuIQPsj5scpt7HSD4nxdhYuMFtSibtmSor1izGMBGXEco18OEgQM
         9T7FJZ/mZtujpkObrPUfr31riQvLOGXQ7ZrVd6QXeggorkDi1IyhKM2p8mwQTgRwHrJI
         TNag==
X-Gm-Message-State: APjAAAUAkZmxsehAJLKIhne2uy83uIEZnGoSmKY5NfInmmTyp+NAnzUF
        oGmUxbJqa2gqeE8LPociF5VDt5p3A/g=
X-Google-Smtp-Source: APXvYqzWSCAXbwKwbbCD16y0knYnO0K/isFTQTyNGy5wU9rDTJP8Lzw67+HLeQDhCU/xG3ibZb6+cw==
X-Received: by 2002:a17:90a:b016:: with SMTP id x22mr2454039pjq.116.1566342409877;
        Tue, 20 Aug 2019 16:06:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:49 -0700 (PDT)
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
Subject: [PATCH v5 14/25] drm: kirin: Move channel formats to driver data
Date:   Tue, 20 Aug 2019 23:06:15 +0000
Message-Id: <20190820230626.23253-15-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 30 +++++--------------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  3 ++
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index a1a79f372bcd..0489b6378e01 100644
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
-				       ade_driver_data.plane_funcs, fmts,
-				       fmts_cnt, NULL, type, NULL);
+				       ade_driver_data.plane_funcs,
+				       ade_driver_data.channel_formats,
+				       ade_driver_data.channel_formats_cnt,
+				       NULL, type, NULL);
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

