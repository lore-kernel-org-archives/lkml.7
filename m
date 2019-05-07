Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D632053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="edyEPa62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfEGNHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:07:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34393 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfEGNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:07:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so8305788pgt.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYIcefqUbtjO6efG05qDKL3HAKUE9dWz26q5t6PWQVk=;
        b=edyEPa62/tqOK5yYOgIKFbrNm5HJFRdrthDyG8k085PwYA7rMARCaKhtyT0spUv1lZ
         z80r7mktww84mBSrnXqBVlE03aT9WMA4HAZ4mqg/i8fZ1NPa02rZ+dxElXpGI3svX4yK
         Ag+W8uF1vfH5vDlvlyHmywP0gZ4a0qKxq5iBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYIcefqUbtjO6efG05qDKL3HAKUE9dWz26q5t6PWQVk=;
        b=JS+U8YBtQSZGFqoWFCg3vA0p/WLkjfMDeDIHMrWXCanSNnj3kogQGlSToC52+JNh9G
         0ik7oG9Dmx6SdU/kJJ7mPZHot/3ifmePWrEDp558U+odluqNlDIxNVFq/u9raXllgMZz
         ScovH+tc6LL6BGSthqaXrX0LErHhWc2Zx5r/t3oL9zOqBJu8JByaOu6V0WZLBcRd4VTN
         w9csu2G77tva01YVqbIGE32Spw1NI0sSDWV+unYdn1ZuKEwuP8Pb9rGmGChM3OAiL9lF
         Jx43XBbNCF6fnB+h2wIZrwBFExh+LjjV09NXXJl1Vch4gZSi7XUIA50SAcHSm3X5LE2L
         eyDw==
X-Gm-Message-State: APjAAAWDeIlLlhLj3oJTyGe+jWJICbZE6qzNuM7dcOmPLhNJzRnOXqmu
        2kVfGCXUdS4XngyJrXstwmsPiQ==
X-Google-Smtp-Source: APXvYqy2CKkQ9wX0prpKV/pt24cFsadXZXvMcaev7EfdOiJeDL66Kfub6iLEmQkBCbHk4BdoBKJpNg==
X-Received: by 2002:a63:fb56:: with SMTP id w22mr38503539pgj.354.1557234454717;
        Tue, 07 May 2019 06:07:34 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:3682:cdb6:452:ecda:bdfa:452e])
        by smtp.gmail.com with ESMTPSA id w190sm21889823pfb.101.2019.05.07.06.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 06:07:33 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/panel: simple: Add FriendlyELEC HD702E 800x1280 LCD panel
Date:   Tue,  7 May 2019 18:37:07 +0530
Message-Id: <20190507130708.11255-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190507130708.11255-1-jagan@amarulasolutions.com>
References: <20190507130708.11255-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HD702E lcd is FriendlyELEC developed eDP LCD panel with 800x1280
resolution. It has built in Goodix, GT9271 captive touchscreen
with backlight adjustable via PWM.

Add support for it.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- separate it from binding patch
- sort the match id and compatible 

 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9e8218f6a3f2..93274e270663 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1184,6 +1184,29 @@ static const struct panel_desc foxlink_fl500wvr00_a0t = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode friendlyarm_hd702e_mode = {
+	.clock		= 67185,
+	.hdisplay	= 800,
+	.hsync_start	= 800 + 20,
+	.hsync_end	= 800 + 20 + 24,
+	.htotal		= 800 + 20 + 24 + 20,
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 4,
+	.vsync_end	= 1280 + 4 + 8,
+	.vtotal		= 1280 + 4 + 8 + 4,
+	.vrefresh	= 60,
+	.flags		= DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc friendlyarm_hd702e = {
+	.modes = &friendlyarm_hd702e_mode,
+	.num_modes = 1,
+	.size = {
+		.width	= 94,
+		.height	= 151,
+	},
+};
+
 static const struct drm_display_mode giantplus_gpg482739qs5_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -2637,6 +2660,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "foxlink,fl500wvr00-a0t",
 		.data = &foxlink_fl500wvr00_a0t,
+	}, {
+		.compatible = "friendlyarm,hd702e",
+		.data = &friendlyarm_hd702e,
 	}, {
 		.compatible = "giantplus,gpg482739qs5",
 		.data = &giantplus_gpg482739qs5
-- 
2.18.0.321.gffc6fa0e3

