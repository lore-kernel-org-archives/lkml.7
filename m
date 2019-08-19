Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1A2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D3D22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MaIepbIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfHSXD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37977 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfHSXDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so1691200plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pasDqukoiYcSf22vVHmDhWNQxAqGGHKv3xKncmQla0E=;
        b=MaIepbInPrEkRgUnMBZxjlCw5OmylHzsQ0+yPqVTi9f3WOcTkgdKCOoNExu6/g5ads
         pwEJAhHKG3TAEsR9Dvi//KxBFG5p8Fk6+2VKznr1QllWCmyAphraoXUFE8ZocbZK2GfD
         fV7SqiAUaLg7Xl7APe5JcIEG6H+KYJLZYvUg1KIW8gYqxsdrO5JkWEitvJE5sCgprJtx
         ArMfpqBfeE9sQQHpRdCht6GYqczqGDNlX7M3niyiAXRZYg//ClWPJ7edADMX+ZkBxnNX
         vR/MBzNFRqj5mM0M6puKoHpfPXbiHk80T77hpv81PisrE5iccXEB4ophP/9d7THQ3KhM
         AweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pasDqukoiYcSf22vVHmDhWNQxAqGGHKv3xKncmQla0E=;
        b=rkR7MNiESlrvBD+ObIVQ7hLAZmQlyKiDx1CSL1NkRkcmRHlIsudgdOaeSxpj+9EE/+
         Pfrf7u4D7NRhPT0O0Nd/L/Lu2G6Ty+JERtWMiZB/HI/6j0x2X7Eh6ilbpBC28+R1lrXx
         unYt7jrN9xnHISeIgGeM1Mmb23DETJ107jjUOpHOpBbsl8vjalH+4Yl2CEGxKLSIaJ2+
         FYD9wsdReEzsKnF2rn3fytTWK2k04oFhPhcDlhgzMJgI5+iRTwYZMRa1I/ii0VbArhG4
         DQIzuCql+MdBYaOS78XAM7Eu1bB4AJlJ9y02WvLKCgIWUJY2lkWEWUc9JEBNCkEBh1Co
         Wphw==
X-Gm-Message-State: APjAAAWTcCFLLxyRRaprmf3jd3JgUHhukqUr+Th9OougYA5H9wjXX7E3
        mXEJEVf+hYJ3VBW73pefghi5SRiYUq4=
X-Google-Smtp-Source: APXvYqxmNKHRR9HjEo8ageeD5qMzRLwGanqDZgORsFklVz8zOiAWKY3P3qK1pJR7eCNHFKezoWuVTg==
X-Received: by 2002:a17:902:12d:: with SMTP id 42mr23814196plb.187.1566255831340;
        Mon, 19 Aug 2019 16:03:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:50 -0700 (PDT)
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
Subject: [PATCH v4 17/25] drm: kirin: Move config max_width and max_height to driver data
Date:   Mon, 19 Aug 2019 23:03:13 +0000
Message-Id: <20190819230321.56480-18-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
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
index 8b1f3580cbd6..2e29a228f3f4 100644
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

