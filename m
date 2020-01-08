Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4C7C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D04C206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPF9IFGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgAHX6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:58:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35250 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgAHX6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:58:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1774817plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 15:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=st0ckcOqaRV+ZvHstV7I6k7aAc3QTXy2/XaWGPv2J64=;
        b=NPF9IFGSgMgntYLD6eWINkS4FKHUSk00e/FB68oqFvCSHcAakBezDXHUmFl6VYX6g8
         P2S8OwhJpgLtI3zEIzpifr7SprtaswE5E0UT/3kAU9EZO+2dAayA9AIcabxaZSb97/TU
         tTQ8WFonFasx12Yg/WorXmtif23vQWiQVPa1v8YhyPLwOyi6V6zz7LqBofcU2hP3cp+T
         fJWgtSriHjZkyUjNz43jDTJi0s2WDsSot9zwI8q8zbagZtBYkmzDy8NeH9v+bsXRgESM
         DT+dUw5uwy4Resyzl6LgkzzTfg3LNDZzfRfQrsecipDNFwhTI6J/KtXff+ys8SniwTUI
         /0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=st0ckcOqaRV+ZvHstV7I6k7aAc3QTXy2/XaWGPv2J64=;
        b=rrbXNTuH9QGVBzvbG3tv3cbrhxFh1Urr7AW4J2duuFCsggmTs3ey1Pbumrz6E4itoe
         HbqPxkaDCXGrJlVf9lHxQRSloTZpQkRc1h2qvdAAlIRBS80cmwa5rF+bIsZIuJmZCvr5
         wohqLZNRjQ49IZhs55MxpmBVQWiFx5eBwDuJp5MJtQ/thlX20IFXyCpk9ioUC+PsrxS2
         Y0NkmBSFJext9lqrPpwqMbThPa9NjYN53bBn3gQUOtUvHb0JBoFi+K4EmfNvpKLMlx/T
         8AOIh8XSCriX5/VOMX7jnJ55mBEOsBzzIokzHIqO0kgQEvNlVb6AGVhds0gBWOQdSsvj
         VB2g==
X-Gm-Message-State: APjAAAWBSZIBeTzPn9NuVOTw1YqUySvXpNflMJ2W7VcWUCoMNCUyLGSQ
        uGddNbUM7Ve/Ov/denXRMvs=
X-Google-Smtp-Source: APXvYqy+t3SaP+IB09BU86n962/2WWP+4/lU9dArW8bBU/fPKZ26xI0HntnvHYQAgnvnpjp4sKLdIg==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr1558940pjn.61.1578527904251;
        Wed, 08 Jan 2020 15:58:24 -0800 (PST)
Received: from localhost ([100.118.89.215])
        by smtp.gmail.com with ESMTPSA id e14sm5202366pfm.97.2020.01.08.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 15:58:23 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/panel: Add support for AUO B116XAK01 panel
Date:   Wed,  8 Jan 2020 15:53:56 -0800
Message-Id: <20200108235356.918189-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108235356.918189-1-robdclark@gmail.com>
References: <20200108235356.918189-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ba3f85f36c2f..0c3444c62014 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -629,6 +629,35 @@ static const struct panel_desc auo_b101xtn01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b116xak01_mode = {
+	.clock = 69300,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 48,
+	.hsync_end = 1366 + 48 + 32,
+	.htotal = 1366 + 48 + 32 + 10,
+	.vdisplay = 768,
+	.vsync_start = 768 + 4,
+	.vsync_end = 768 + 4 + 6,
+	.vtotal = 768 + 4 + 6 + 15,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc auo_b116xak01 = {
+	.modes = &auo_b116xak01_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 256,
+		.height = 144,
+	},
+	.delay = {
+		.hpd_absent_delay = 200,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct drm_display_mode auo_b116xw03_mode = {
 	.clock = 70589,
 	.hdisplay = 1366,
@@ -3125,6 +3154,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,b101xtn01",
 		.data = &auo_b101xtn01,
+	}, {
+		.compatible = "auo,b116xa01",
+		.data = &auo_b116xak01,
 	}, {
 		.compatible = "auo,b116xw03",
 		.data = &auo_b116xw03,
-- 
2.24.1

