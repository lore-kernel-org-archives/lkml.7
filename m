Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A70C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9873721841
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wym2MUS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfHADpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35868 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729314AbfHADpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so31520042plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HDJvJkGt16A9xh+oJ/V6cF1p90cprtRCL0cPwhoe3KU=;
        b=Wym2MUS5YK2BPc9KkQ7bWTa8b+pG1A+eWp2ZaWaawXbnATIPYTCjougDcNO1ggC5C1
         ePXAj6Pvjjtt40YpLKEKKb23byuUWI3VKusNx1KjeSgBi2Weq68ttAOWhrgnyAJN62CJ
         AVpUXrLXNBERAeKf6d5/fOpR1drsQta+SUPrNUzRoBwnc/SNuEA4ZWbdl6ZFdLpIPd2v
         IKRGJX6wh6cYpRIx6D5KRCTVLD2DGezV2k9z7Yq57cSzad1wthBhLmZ3X/xnVQ6J/xbh
         /vouDxjP4jImvR/uBuQQA8qL36pa0TUN3HL95BYb4QUnWG/QcATvsUOvoMvm9Vrgfblb
         FTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HDJvJkGt16A9xh+oJ/V6cF1p90cprtRCL0cPwhoe3KU=;
        b=JYTPbvEp5b7CjH8yulGQerGhEgwkPBwLWzufV6WmSVDXt8petgy+GBpexJBaKKxRMh
         IdWYAe5Smq2vMQK3E1oca+H+dDGW9ZYess1Ryf8ILyyp6X5fmWJQGyqu8XL6a3GPOuxX
         ZpszJG73M8dxufXIaZjmbBHHvuN8f37jw0sJ8TFrrwNgisCPRJjiHhMDdYJDJDBw/PBa
         1g/FwsqvZtHMqclLtXdBooc/EUWjUAZDJo2V5Wp8jA3P2XJiSsoMK91h995PrzYaXjHi
         shUKUyA18nebd8dlc1sm3MH+yr/rr1mVmREQZ7GGKrZdLGyPvkFgN8bt/ZbWNMRijtjn
         jrCQ==
X-Gm-Message-State: APjAAAWN0Mz/KK/MAFez5SP6UswqS1VmUAet+SGrxMZtEmb3qWs+dXHu
        pRn0FhUAaY8l3nMKXFS+2YSY+cwUbkk=
X-Google-Smtp-Source: APXvYqwyN9aTnd/ybC4ZOD7D2YlGwTywueZyug//Dj/lnSuPvgbMF+ELyqVChUrqIadiHW1xHsdSDA==
X-Received: by 2002:a17:902:306:: with SMTP id 6mr125220747pld.148.1564631108989;
        Wed, 31 Jul 2019 20:45:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:08 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 15/26] drm: kirin: Move channel formats to driver data
Date:   Thu,  1 Aug 2019 03:44:28 +0000
Message-Id: <20190801034439.98227-16-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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

