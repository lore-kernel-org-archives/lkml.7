Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C23C73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BB6214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXmFco6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfGIOxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:53:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36143 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:53:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so18442448qtc.3;
        Tue, 09 Jul 2019 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbsGaS1BVbJ+f3VVB6My2e8DPp6j8hXOIEffynol0Ok=;
        b=pXmFco6SOoagS7jQFlMht0LwTgnpY+87Ybjy0HLOGFQ+LsPExFi8j1H3T5RXHqDp2l
         UByeml2I0IuXGS6j8C1peLZYmsXYcbgF2233PzQK4HIvDX+muI9ED9zPcxazOC6PuB7q
         Dia4ZhKXjxJ0VE+nprtXPo7l4ZxpLvSy11veYqg/nMFp9VtydK5mmuCPmIlwTVc7/E3M
         mAd71PJ3xUJMW5RjVh+KL2zwfLB8bA79mnw8vUv/cVJCsnKOFnNCqPESPUll/og01Vs8
         OT6CJvNdtxgWVzhNWeA1wqmaJgpCFJqeNmQrHEF6AbqM+jbhTvbCTP4UHdTst1sPDSra
         7dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbsGaS1BVbJ+f3VVB6My2e8DPp6j8hXOIEffynol0Ok=;
        b=G6NxmtpFj5+RDpycaDCpDflg9dsXZ6g+ULztYq6E8q9IPN1FZCD1I61B0NsER6265h
         mXyMdMz9QXsjhWO+BNMfM9qRgKp3CEGot1awvAXrUNypNsFYI4VS8fguOKpYHGUv/mrV
         LqoWZaaTEXxV0Fli8SElCqQVu2ojy7hy9TtseZsWkpjHVin5//44PWuIR7V5uUpKpVJR
         1RDd6rZVkbDTPmoWVoQCENVa6fWWl3Usix8zYIi4zyxbV8ogK1EVi4qnme6DEM+q+W+e
         tbszROsHaC+udK7fE3zz+qP0OW4WpZGWjBkoP3Zlixb45E28TlRZl31wpBB1w1nhN0eR
         odiw==
X-Gm-Message-State: APjAAAWDksHKDhRPeNf49+IBhoeK36DYOf+hYNhF2LBwle2hZKyeSTzf
        b1Fjc+1P/zA5VPJqFM7IMrDqF+wq
X-Google-Smtp-Source: APXvYqwbU2+yK2jTnkJvrpeIWH19D9iyd+/+yn4kHi335O5rSYQCwV6LlRPM6TTPp5MXcPkWBRFuqQ==
X-Received: by 2002:a05:6214:3f0:: with SMTP id cf16mr19329542qvb.211.1562684002950;
        Tue, 09 Jul 2019 07:53:22 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id x46sm9667276qtx.96.2019.07.09.07.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 07:53:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/modes: Skip invalid cmdline mode
Date:   Tue,  9 Jul 2019 17:51:51 +0300
Message-Id: <20190709145151.23086-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The named mode could be invalid and then cmdline parser misses to validate
mode's dimensions, happily adding 0x0 mode as a valid mode. One case where
this happens is NVIDIA Tegra devices that are using downstream bootloader
which adds "video=tegrafb" to the kernel's cmdline and thus upstream Tegra
DRM driver fails to probe because of the invalid mode.

Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/drm_client_modeset.c | 3 ++-
 drivers/gpu/drm/drm_modes.c          | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index e95fceac8f8b..56d36779d213 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -180,7 +180,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
 
 create_mode:
 	mode = drm_mode_create_from_cmdline_mode(connector->dev, cmdline_mode);
-	list_add(&mode->head, &connector->modes);
+	if (mode)
+		list_add(&mode->head, &connector->modes);
 
 	return mode;
 }
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 910561d4f071..74a5739df506 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -158,6 +158,9 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
 	int interlace;
 	u64 tmp;
 
+	if (!hdisplay || !vdisplay)
+		return NULL;
+
 	/* allocate the drm_display_mode structure. If failure, we will
 	 * return directly
 	 */
@@ -392,6 +395,9 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
 	int hsync, hfront_porch, vodd_front_porch_lines;
 	unsigned int tmp1, tmp2;
 
+	if (!hdisplay || !vdisplay)
+		return NULL;
+
 	drm_mode = drm_mode_create(dev);
 	if (!drm_mode)
 		return NULL;
-- 
2.22.0

