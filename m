Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAED5C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA13216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8HG/tRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfHNSri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34759 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbfHNSrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id b24so3596422pfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f7xcuRX/1vBOSp3204JRR3FGT/MGHZqTKrSmOwFZnf4=;
        b=g8HG/tRxey5TUfBHN6Wyf9GMHW1PjL30NIA/P1GlCecHTr5xSmbZzb5clD16Ntw9A5
         eMeWcPBdGnfp+XOYG/bjsc1UAXqNG8yEiDHnIP6BLc8hq8a8lCg/TgKr+Ga5R6fH8NuR
         M7Qzm8QZZxECjgZiWLkk9dpNYbti7ep5G2GAJmDCDKtTf7Og7CtA2H1Wfun+4CCSDTxP
         Wsf0bfYcJ91GIOWkRdGcHRLeYTwjHUnnU9aXalI2kgE58/iIWf+PnUqqZPM4qlrHV2NG
         XIG7tsVSJWmF3xGJcWKS1RFMsJt1KsQU3Y549DRMhjD/DVrf1Al1vn2vw1C+fk7l5Nf8
         S8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f7xcuRX/1vBOSp3204JRR3FGT/MGHZqTKrSmOwFZnf4=;
        b=qJE4kEgOTM7PtmESKqroSfVCinrEVhp1Odfs+NqbdbE2DAI0wR6QEaYuKzOqfCgd+8
         qH6BlYaLqTCkSYTJ9vxhIpc4Qw/Q+SBH0DZXNHvOJdCerfRcLaD1QoevwHoYSwDDk2f/
         7Kzgf5ulRs0aw6KIX/5YpCvh8Jny7tpA7Wkuu5LNeH9SJf7psFx4zdCO8YsmAtW8nSVW
         r3kSGfZvdt/bZRJCneDBlOneD+FSO7KI+pLHcJ5c8IoJ1UGjZGV7L7Fgv/4lQU7qc2OM
         W2tWEb8J0ZCZlSnwlqmR+zcov7pde97UElCZ4rlSwXe2pXEicWzFQeVNjz7AkA0EdFDc
         RXWQ==
X-Gm-Message-State: APjAAAVFS+vjSrdEBdlgnSdonYSS956VtmXFzTu24X7kCx27JuKnScuf
        dwhUGAEMDKjC+hccRAUUauUrqoJVN4g=
X-Google-Smtp-Source: APXvYqwOJ5gF01XhACt/fu5chx2S5A7OH6nw2xpAfmT3vkaJgq5qP2DrY09y93lww3VSrJsXoZ6Oig==
X-Received: by 2002:a63:5c7:: with SMTP id 190mr474913pgf.67.1565808454735;
        Wed, 14 Aug 2019 11:47:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:33 -0700 (PDT)
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
Subject: [RESEND][PATCH v3 18/26] drm: kirin: Move config max_width and max_height to driver data
Date:   Wed, 14 Aug 2019 18:46:54 +0000
Message-Id: <20190814184702.54275-19-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
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
index fc0f4c04d1c9..68efd508d86b 100644
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
index bf1e601fb367..7956d698d368 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -39,17 +39,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
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
@@ -58,7 +47,11 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 
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

