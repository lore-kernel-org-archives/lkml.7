Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140BFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 06:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53BB20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 06:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCYfy+Di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfL2GHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 01:07:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42393 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfL2GHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 01:07:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so16806397pfz.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 22:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bh9mEGHD8yEkETedFVdZfcZkqXbQcfH7QQFnd8PatL8=;
        b=wCYfy+DiqvTPeE4PuVoNL2FU1hG+FM4oPNtihtwX6YnVlimuXh+vhNDxWafNVR9xch
         eV5t0hy8laPj/2d5R+fh89/y9moyIaXH1t1gOsCiWP0RZS/akCygAFGjdwA3HymzELJW
         YEpOzjae8vfDX/23c3uj/yiMd+8vN3gbY9+90n1EhHVOZ+u6yEG6o+aM13rqXWofVenT
         fmjFMbLEHpmM/n0NsTefVDwWWg3c/9qQdjR9ZuqCA84Hwp0v9Z/UyjB8JZ9BZmba9lw3
         YSOeYrz/THMDq254XzNE1uzTgBBsHb0Q5fQbp/1nZ13a4Tjc85PTz7/93UmnCP61kLep
         FcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bh9mEGHD8yEkETedFVdZfcZkqXbQcfH7QQFnd8PatL8=;
        b=qt4/+HQu8M/39A1VPLLCynIzpfm0PNuitTQBU/iRBQ6X9gPF8XmKGyLwuvVKU66Q1O
         v1O6nhnx0dmmor2EWWNQZWRSW64BrpW91BG0cqpV81UcB0zVgRyeil/CDomRH4aOT1GZ
         Qz+L/nE//yra16quqxKMJJ0FMM5Jn8Brh9bG98hB9CwLUeSDoGwAnBGjWd1uHIteYv68
         n9Iicpzr9QG6pKibOxtYySXcOGQJFSA4+oqa1c9qUAl7co+3/bVH+efriueeGVojDIHa
         15W+TG9bPj2ltkfIVrauLnmsTX2CIoR6Zmz68p9e+uekvvhcdg+dPstagUe9TGlDpn4M
         r9+w==
X-Gm-Message-State: APjAAAVn4+lhB8Wqyq0qvazZlpj3jsHhtS4mxttw7wW7R9wdHq99ECIs
        fBv/HF2v3OpdC8Y8M5kCBvzxUQ==
X-Google-Smtp-Source: APXvYqw7T3nji34vO/btgtEenzlUjOnI1rtxZ6ocaf//g8wgqa3384y+RhDo98oPa4usrISA1a3G8Q==
X-Received: by 2002:a63:774a:: with SMTP id s71mr64704696pgc.57.1577599655541;
        Sat, 28 Dec 2019 22:07:35 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b193sm37899600pfb.57.2019.12.28.22.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 22:07:34 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH] panel: simple: Add Ivo M133NWF4 R0
Date:   Sat, 28 Dec 2019 22:06:58 -0800
Message-Id: <20191229060658.746189-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The InfoVision Optoelectronics M133NWF4 R0 panel is a 13.3" 1920x1080
eDP panel, add support for it in panel-simple.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ba3f85f36c2f..d7ae0ede2b6e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1806,6 +1806,34 @@ static const struct panel_desc innolux_zj070na_01p = {
 	},
 };
 
+static const struct drm_display_mode ivo_m133nwf4_r0_mode = {
+	.clock = 138778,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 24,
+	.hsync_end = 1920 + 24 + 48,
+	.htotal = 1920 + 24 + 48 + 88,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 12,
+	.vtotal = 1080 + 3 + 12 + 17,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc ivo_m133nwf4_r0 = {
+	.modes = &ivo_m133nwf4_r0_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 294,
+		.height = 165,
+	},
+	.delay = {
+		.hpd_absent_delay = 200,
+		.unprepare = 500,
+	},
+};
+
 static const struct display_timing koe_tx14d24vm1bpa_timing = {
 	.pixelclock = { 5580000, 5850000, 6200000 },
 	.hactive = { 320, 320, 320 },
@@ -3266,6 +3294,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,zj070na-01p",
 		.data = &innolux_zj070na_01p,
+	}, {
+		.compatible = "ivo,m133nwf4-r0",
+		.data = &ivo_m133nwf4_r0,
 	}, {
 		.compatible = "koe,tx14d24vm1bpa",
 		.data = &koe_tx14d24vm1bpa,
-- 
2.24.0

