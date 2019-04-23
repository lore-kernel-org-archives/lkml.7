Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F32FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2064D21909
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsh6amFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfDWXVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:21:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37231 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfDWXVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so8260154pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3w6o3fIq2iIb7WJJVP20Z4EfqmYB1pkBjh2u5OeFpHE=;
        b=nsh6amFfhd4Ifw8Uob3BkzyqOpMWuM5rJhtKKK0K9SUaDGzpNqrP6Lnc++KtbbEF3h
         LIMAIvD+l3blZ+t0HETDRB0yQXT7NQnHsqLQw8dDMjbWsjm906Q/cB/TSShSRYBftQZO
         mZ3LbYAg4Cm+ma8lYjL98QaSTKq2IIJAS3weMwVpv69FnsZJ4o75c3NXktFKh1/FE0bF
         YR5Lkrlg0WpXi7dRsarHuft1+QdTWcJj6RXKCUfYuizv1dR4mhJWqoOu7wxTz1A3JdQq
         UabNV8mgRAODM/JiiZggCXDfQNl1oEUaK8LCz1dtOoMoQV8IiKCHyTXldR0RMTF95++N
         TscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3w6o3fIq2iIb7WJJVP20Z4EfqmYB1pkBjh2u5OeFpHE=;
        b=raopaSFmDMAiAdeTlORSq63TXc12V/XIvHodaNF2C9bVbTzOH2KzkN522KI55on5tW
         lpoQyIYs/5yHHWqhi0nrjUQkV+vZCH4nhDdey80d2mK7x+b5ffsjJGHkCK4qnl0NB4Uq
         avA1pcYhwA+xBuKAkKmcgkCdSTFbh4DSj3cH2zLzMYj2Fcy4ozQ5SGKmHTYuJmJRaOsU
         SJVByFSMfS2qhlBgG+Gb91WYHdjzxXI/uU9+KTmZBMTj/S1wkGpZVbGYK093mg2pf8Vc
         DMycGAk0n1HEgWMhlhZ3g0U08bMxX4TmN8wMAXQe/HQlQJp/iTTGvb7i7NBH9Ek4Diuy
         ZJqw==
X-Gm-Message-State: APjAAAWRqM1hmkoSuvrFXi7tB0UYNhQbpdMxsGt+MTa5MfGPWOWSo39H
        dMxfJSqLZY2vASDk4HcwMDnpBcv0u1w=
X-Google-Smtp-Source: APXvYqwUCGfe++hbxuKspqGxqH+ClR1wU0pXlx9MmWXqxBNFEBl3f+cwivJTEk5ptc68rsDcine/YA==
X-Received: by 2002:a65:6414:: with SMTP id a20mr3518840pgv.217.1556061680604;
        Tue, 23 Apr 2019 16:21:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:19 -0700 (PDT)
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
Subject: [PATCH 14/25] drm: kirin: Move channel formats to driver data
Date:   Tue, 23 Apr 2019 16:20:45 -0700
Message-Id: <1556061656-1733-15-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
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
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 30 ++++++-------------------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h |  3 +++
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 6aa529f..0ebe715 100644
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
index 05161ff..f688612 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -39,6 +39,9 @@ struct kirin_plane {
 
 /* display controller init/cleanup ops */
 struct kirin_drm_data {
+	const u32 *channel_formats;
+	u32 channel_formats_cnt;
+
 	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
 	const struct drm_crtc_funcs *crtc_funcs;
 	const struct drm_plane_helper_funcs *plane_helper_funcs;
-- 
2.7.4

