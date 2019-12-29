Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41306C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 06:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108A920748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 06:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaJlyE8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfL2GJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 01:09:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46967 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfL2GJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 01:09:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so16525658pgb.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 22:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQEq/pXQPWAm+/HQqqVHlxrLAblqW9jzRSmCcXe+hVc=;
        b=vaJlyE8bstbxQxnAUBACLIH9E3AWWNJirhpiyq4G61nllSMb7fqBJhsL9F3KeEOwSG
         GrpZeXpXFWSPSeprwkFVen/PpkmbfPpGCEMIB43ySWQZdVELEtmoqMM6Y8K8m1YR/fk0
         Rh7YqKJjTcIVPTYI/fqj+SqV2qoeE4HlSQkCGuTgqXa5WOjpoc6YDLVPoiuz/XumWGfe
         8AEMcQmx1SSiV03YR8UidnRFZA6suwkC0MM34oCdketkOXtN8PwfbD9TEkc8iNDm5OjD
         FVulASlJ1fCdn2I2A/S7vlcVg9gDmXRDJUvJrHIHgxk/JU8G/dRwrG6/eJWXXtVD8+0/
         aX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQEq/pXQPWAm+/HQqqVHlxrLAblqW9jzRSmCcXe+hVc=;
        b=Alau6TJRgm/8S+XoD12Cf9eRRNw3CdPqCqDI9VGErBpH9z6l27pWTrKRux9AdEqJLC
         7IArhGfOny42ta5wGRlRDljUP+MkMrIIlXb7GDv9tu2W5q+eWdNbEBUuiZVroIH0fSBi
         btsPaX0Mgf35thDL6s/O3LlFZPgje7tz2xdD7tHGPJ/gfBkJIdJKy1Np0pBSp1mEnpZ/
         X0p6bIC2a3Nsd6MHRIiaXANPEyiVaRPuFXIPXSazRLq02SjV1JvRRRfK0Gz+sFhSU+fV
         5iRogzHCwlHOdpQYbyHl/lPVEPfrtE1btmtpEMdCwJApzNjGyMnQYynmZFiHCeYhi1BP
         YKLw==
X-Gm-Message-State: APjAAAX8cx7lhfDvX1dgp8Ey1XwYf4pLjNOe54INrOEuOnIIVMzosjsd
        SEv4xowAljHPbaylVUxU5c5I3h8naNI=
X-Google-Smtp-Source: APXvYqwEIg9C9X4H9fXSdY40cModg6G+r8GR11cJ+V73bUm6nsOiyCNuD5QFmcFq/H7Btsgk2mIxrQ==
X-Received: by 2002:a62:4e0a:: with SMTP id c10mr54791833pfb.181.1577599740493;
        Sat, 28 Dec 2019 22:09:00 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s131sm28316795pfs.135.2019.12.28.22.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 22:08:59 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH] panel: simple: Add BOE NV133FHM-N61
Date:   Sat, 28 Dec 2019 22:08:23 -0800
Message-Id: <20191229060823.746255-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BOE NV133FHM-N61 panel is a 13.3" 1920x1080 eDP panel, add support
for it in panel-simple.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d7ae0ede2b6e..3c25e10b719d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1008,6 +1008,33 @@ static const struct panel_desc boe_nv101wxmn51 = {
 	},
 };
 
+static const struct drm_display_mode boe_nv133fhm_n61_modes = {
+	.clock = 147840,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 48,
+	.hsync_end = 1920 + 48 + 32,
+	.htotal = 1920 + 48 + 32 + 200,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 3,
+	.vsync_end = 1080 + 3 + 6,
+	.vtotal = 1080 + 3 + 6 + 31,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc boe_nv133fhm_n61 = {
+	.modes = &boe_nv133fhm_n61_modes,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 300,
+		.height = 187,
+	},
+	.delay = {
+		.hpd_absent_delay = 200,
+		.unprepare = 500,
+	},
+};
+
 static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -3195,6 +3222,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
+	}, {
+		.compatible = "boe,nv133fhm-n61",
+		.data = &boe_nv133fhm_n61,
 	}, {
 		.compatible = "cdtech,s043wq26h-ct7",
 		.data = &cdtech_s043wq26h_ct7,
-- 
2.24.0

