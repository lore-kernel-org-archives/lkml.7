Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E76C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF7C21D81
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ+Ybj30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443220AbfIYSmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:42:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43261 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439865AbfIYSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:42:51 -0400
Received: by mail-io1-f68.google.com with SMTP id v2so1365465iob.10;
        Wed, 25 Sep 2019 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TlBz3qIS+SsSa9e31MzD37WA3jnWQII7/YaRfP4QoxA=;
        b=kZ+Ybj30bvqckN6rb/SACnDIb4xG59DbEkq3eHDObPzpjFkXjVVFMUQBwYc1kAbkeE
         Kgh0+IxBjigbjgM6B7AbBXRE6oy7WhHs36DHJYR99VCaHljp3LGe5eFyAi7GTLRQPdvd
         L0u0XMSneeu6M3IU9vQQbLcwTh/ZL/gPTpUtVn+XY+OPZixePvJ0aGgYWiN3iIKWeU8o
         jwytacPXg2gu7mC2rzxiY/QieHd4BPakPmpRhNy+KAb4ufMWSjcUj+ujEBPA/MfepyFV
         hcPG4+pjU2nc1aJBZI31/DaoIo2WbWC1zOOQH0SiQA5100AhuJ8QaLpAYhz11rvYZ0dO
         x2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlBz3qIS+SsSa9e31MzD37WA3jnWQII7/YaRfP4QoxA=;
        b=Iki/xnseyKM2oDL81vL45mr0imYChTCsiGCYlyHstLJZqULV3kWqxV28TUVw9WFDK0
         wi3UmfWfrLA6g2HbWX4lXgqgdMlh9cQG554LX1okcrU65DCYxQ023dUj9w89NGAB/Qic
         myU/6VtpXTHsOHucIkjIjfO/3c5w8DJ8t/zbe6wVXzkRZ2tzGKI3gw/uSVnmw1OD5ZbP
         fSJqYTlKFmilm9S71bivkdDtlC27IvmERAqigJCVKowZBIIEM2aPxmKcr+L4pZsdIBzG
         PDIDTtL3t1DiAdz05jdLklZJDCwERTmJ/cTQTdTsW36r7+lg+LM4IxcTLPGaAzL2WdZU
         uSYg==
X-Gm-Message-State: APjAAAV2h0e96hFOqs62CmAwVWVXkgBueJEI72XEobhSwKFUF8jdAZRe
        2S1O7KuzA08VYO9gofgrdSs=
X-Google-Smtp-Source: APXvYqyWcbpkHZhyO2HSgyh99GMG9XDCNmg1b/77oJptfWakBsJXv7WLdgEZwob3RcTKaT6HbwJRhQ==
X-Received: by 2002:a05:6602:1ce:: with SMTP id w14mr915623iot.137.1569436970815;
        Wed, 25 Sep 2019 11:42:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id q17sm337511ile.5.2019.09.25.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 11:42:49 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] drm/panel: simple: Add Logic PD Type 28 display support
Date:   Wed, 25 Sep 2019 13:42:36 -0500
Message-Id: <20190925184239.22330-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, there was an omap panel-dpi driver that would
read generic timings from the device tree and set the display
timing accordingly.  This driver was removed so the screen
no longer functions.  This patch modifies the panel-simple
file to setup the timings to the same values previously used.

Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
V3:  No change
V2:  No change

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 28fa6ba7b767..8abb31f83ffc 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2048,6 +2048,40 @@ static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
 	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 };
 
+static const struct drm_display_mode logicpd_type_28_mode = {
+	.clock = 9000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 3,
+	.hsync_end = 480 + 3 + 42,
+	.htotal = 480 + 3 + 42 + 2,
+
+	.vdisplay = 272,
+	.vsync_start = 272 + 2,
+	.vsync_end = 272 + 2 + 11,
+	.vtotal = 272 + 2 + 11 + 3,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc logicpd_type_28 = {
+	.modes = &logicpd_type_28_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 105,
+		.height = 67,
+	},
+	.delay = {
+		.prepare = 200,
+		.enable = 200,
+		.unprepare = 200,
+		.disable = 200,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE,
+};
+
 static const struct panel_desc mitsubishi_aa070mc01 = {
 	.modes = &mitsubishi_aa070mc01_mode,
 	.num_modes = 1,
@@ -3264,6 +3298,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "lg,lp129qe",
 		.data = &lg_lp129qe,
+	}, {
+		.compatible = "logicpd,type28",
+		.data = &logicpd_type_28,
 	}, {
 		.compatible = "mitsubishi,aa070mc01-ca1",
 		.data = &mitsubishi_aa070mc01,
-- 
2.17.1

