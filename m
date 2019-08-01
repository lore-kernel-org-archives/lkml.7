Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42290C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E97214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ml5jZwzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfHADp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40979 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbfHADpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so22925392pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQGpl/nhmhJMZKv4Vo2Ohuy0f7yCwYFz4OhCfH7eIeY=;
        b=Ml5jZwzgL9rml4OFZjIub8zA/hmbDsOyOb5pgnwxP8CMB7+tMg38nXgrLV9QItM0En
         qKnXPeARSc4hO5vYz3U72ZS+AbG/jki8te5+3Pa36+Hi5RXUTdXBYD+4DT3Lht1i1d9I
         IgweV9STmp3PcjCZXgsTo+4sQj/B5CBB6+Ke8iqJqTokeJMdeN633a0emO7H0aLkXTGr
         Rs1GxKc91yTpK7K8rqrAOot9Lc9/qJal+/7iafr7L03c2VHcbKHxv5l8+Q+byqBX7JXK
         S1l68eVlYRWBEQAMu3OLAuLVld+I8FgFipQTXxzEL7CloNqZ0dbQ9uTV3RX1C/NH6qq2
         CLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQGpl/nhmhJMZKv4Vo2Ohuy0f7yCwYFz4OhCfH7eIeY=;
        b=tWND+1XNJNBehw1Pwm8GLPKz17eVPIN3j1WpG+F2t5U4i1nhQ2VOnzodU0m4Z9enh8
         1IPMjDNUa0htOWEEO+1Uk70AOQqBkjtixqbjIq9Uu9BqLwuN0IZlkwySuFngjqzKpVF0
         Tes7Z0YObD9BGh2Csg66mYUic5o+U0cvwWmiAe2uUHdYtwE6S4KI/fnh7EIEoHKOlLwX
         Bf9Etqt29dmxyVrP1hn2jAeazJPNCRnHy28C1XDgL2+pKT5Z/m3HBzp42Lwlou1PMuHw
         Y7/WCwz+Dr061Le0QmBRAaClryGC26QnlXroCsQhXGiccHGXlzAO8hLQEHYNz3eDz8l3
         Jkkw==
X-Gm-Message-State: APjAAAWFhY4ElTlp12B8XzcBldzb7s2xlkVDYVej0yM2JzmjLaWKJrSr
        7gFvXmRrspDScGhb4HclNj5Aw4vBbYA=
X-Google-Smtp-Source: APXvYqyE9OksfN4t4uiO+wXMjLvxL1N0wCPPp8i87h6D2b8CP8sDMRKmHanTkkY//Kt3QIQTtMyLOw==
X-Received: by 2002:aa7:93bb:: with SMTP id x27mr52443201pff.10.1564631113669;
        Wed, 31 Jul 2019 20:45:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:12 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 18/26] drm: kirin: Move config max_width and max_height to driver data
Date:   Thu,  1 Aug 2019 03:44:31 +0000
Message-Id: <20190801034439.98227-19-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
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

