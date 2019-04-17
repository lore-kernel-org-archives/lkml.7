Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A1FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41140206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc3SoDER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbfDQXjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:39:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37172 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQXjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:39:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so519346wrm.4;
        Wed, 17 Apr 2019 16:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iG88dsLdU6IZnlQ4L3FwNOgnptWrNyC1YsTsGsePccc=;
        b=Sc3SoDERFueILE7RZvQGGWk/lDE+YVu3OIFNICSWzVbemWHBQVsKEBOLAIrH+iQvRk
         ZR9nJcezBAUdCUalzeBDR4Ou7QkenxmR2bIjO46XStRuuiK+Jp5ghX0ZfMTey3LJSaR5
         pqAHK6AzHxdf1UD1WOcQ8vq5XIkxwsZZlXMZ0thXu7Hu6TQnkO8sOJ6/fN1wY3VDDIAe
         zdjf5v01jPg5XXnFGuKBv+pVM9prAG35K1ClbpJ8os6rOAoWwOyXcllCEtZJXNmWTHP4
         m9y4aLyl+R/OLOJdu83s8oW5E72yCSr40tNi7FtmSPf4z4YUDfyeQEkpJWgCQxzV2Btb
         ShSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iG88dsLdU6IZnlQ4L3FwNOgnptWrNyC1YsTsGsePccc=;
        b=UNKXJFoWARR9CYskF47sSNWMgSIErCYjA8evhOEUJYoWEbBBf0fk2AAOVt2PqTfgGY
         WBdfVxM/jxfK9ruPGHVUjHaUpk6e8NO6Kb4aEQgagG3XKnUnclHDZPmPFO1oC/iK1Mdg
         YFNUhbqrBEvF+LLRwanbDgNN9h/630PoqZJEKyu/nUP5+Ei8s1lB79cniYPFVyyKoCSJ
         gvoAidDTAyRq2f4fXEPaq5hN+rhM3pNTOTe7e7RFLjH1FL6m2nf9tGre9guHCMNELgu0
         0SZZxoFlQ6M9zrYZWMp0AAzxXNfILCe50XDkyF8lqUgOOVdWZwbtgqfnGtYA4iB3mKNU
         7q/Q==
X-Gm-Message-State: APjAAAW2uEonN8Rzf9KU2dReP0hDum4wVgCCFqguChXl5po4JGPjV8Kv
        b4dboU2CFb8IlsFpTlYDHZNBXLv4mX8=
X-Google-Smtp-Source: APXvYqwEGmXxhWGUQZQmz1ys1md/7EbrC0jhir3FE+TifbH283+rlbxSi8m0xgD9aRMzgFO2p0TLCg==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr4735832wrv.142.1555544369509;
        Wed, 17 Apr 2019 16:39:29 -0700 (PDT)
Received: from flb-GL552VW.home ([2a00:23c5:d2a0:d300:5d68:d3ac:d79d:ec90])
        by smtp.googlemail.com with ESMTPSA id k2sm241259wrx.21.2019.04.17.16.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:39:28 -0700 (PDT)
From:   Florent TOMASIN <tomasin.florent@gmail.com>
Cc:     tomasin.florent@gmail.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panel: add panel CDTech S050WV43-CT5 to panel-simple
Date:   Thu, 18 Apr 2019 00:38:45 +0100
Message-Id: <20190417233846.11880-2-tomasin.florent@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417233846.11880-1-tomasin.florent@gmail.com>
References: <20190417233846.11880-1-tomasin.florent@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for CDTech S050WV43-CT5 800x480 5" panel to DRM
simple panel driver.

Signed-off-by: Florent TOMASIN <tomasin.florent@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9e8218f6a3f2..486f61d324fb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -917,6 +917,30 @@ static const struct panel_desc cdtech_s043wq26h_ct7 = {
 	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
 };
 
+static const struct drm_display_mode cdtech_s050wv43_ct5_mode = {
+	.clock = 30000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 48,
+	.htotal = 800 + 40 + 48 + 88,
+	.vdisplay = 480,
+	.vsync_start = 480 + 13,
+	.vsync_end = 480 + 13 + 3,
+	.vtotal = 480 + 13 + 3 + 32,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc cdtech_s050wv43_ct5 = {
+	.modes = &cdtech_s050wv43_ct5_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 108,
+		.height = 64,
+	},
+};
+
 static const struct drm_display_mode cdtech_s070wv95_ct16_mode = {
 	.clock = 35000,
 	.hdisplay = 800,
@@ -2598,6 +2622,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "cdtech,s043wq26h-ct7",
 		.data = &cdtech_s043wq26h_ct7,
+	}, {
+		.compatible = "cdtech,s050wv43-ct5",
+		.data = &cdtech_s050wv43_ct5,
 	}, {
 		.compatible = "cdtech,s070wv95-ct16",
 		.data = &cdtech_s070wv95_ct16,
-- 
2.17.1

