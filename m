Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD38CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8823022CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdEltd1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfHSXDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45730 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfHSXDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so2026756pgp.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HLpBk6XUcRfuXdq52l7Aj6EvNRXsKiox2i7zRtdxggg=;
        b=VdEltd1nXZPR7DXTC3NOclmsoKQLEe6kXHPtTLjmLu2N/X61XZZY3vOgkdjnrBqUic
         42+OUZZiChiJOxT0JN7pP7poX8DIkNMqbvOGrjMJN3zHQ2DBvicSZFdSQlnL2y9sNMyU
         WbizA8J8R1WTSjv4sLnqZRpRhunA7IidducUX67xTDkOJaQk9qRH0kJ1O08n4TZG5w/6
         TXoc1VWk2NcoWGv0YroeT9MA0hepLh37DUMSAAR2KiS4JUs8ZNaCafwRhX0eqARtemwu
         2ZRG2GjpflYIl2qLSzgbyiVeHn+WXP9ggrZmQSuz82p24q1htNqVqnoRJBOc5H6eChrk
         8i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HLpBk6XUcRfuXdq52l7Aj6EvNRXsKiox2i7zRtdxggg=;
        b=ngrc0oOiyLMXEA7HH6pRX439ScNj9q3jk/lpruSrXGD9Bq//9p16F4TSqfOMO8ck/S
         94EpLTqFee0jo/RcZh1LxNPRMjpTlkDyftUKQdmZQOzc8wBtfz+lUiAzO9lcOMCY/sJo
         glCoR9d2KVXAjQjd7aqXB2M2axl0PAYRsC1CDojscy+4kYYVV7iQskNnHR6YeEyYiqOQ
         UOjaogsDcPzY++e2j65UwgOPTQPASSHujB1mPzjg7V1cPQOI0NoMcczk5H1W6SdTPf/a
         P5rTBhZuyzn2oyZ6BK0KWW07YIJO1XquLg8PisgqRXGuLOlv9QB9TiTTBcwadKemO7C6
         TMcA==
X-Gm-Message-State: APjAAAW5XT6dQN9QUIFmSJfoDYFuH2+sujUcnafL9xthIL4uveHq4Ie3
        DkqZhQ2Lzy8iN9EP0/T8hNpHsOQ0Vd8=
X-Google-Smtp-Source: APXvYqzNux6JkEwwJx7Pcle4eFyI1S63fNUUdGAfzJyqSQpDPqNectpDOgcDpdSBFDpjrMe7me7M9g==
X-Received: by 2002:a17:90a:bb01:: with SMTP id u1mr22678933pjr.92.1566255826646;
        Mon, 19 Aug 2019 16:03:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:45 -0700 (PDT)
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
Subject: [PATCH v4 14/25] drm: kirin: Move channel formats to driver data
Date:   Mon, 19 Aug 2019 23:03:10 +0000
Message-Id: <20190819230321.56480-15-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
index 016a6057c5f6..cf542430a659 100644
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

