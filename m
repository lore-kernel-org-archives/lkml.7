Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA983C742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD9921019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MhB4/1cU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfGKUpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:45:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36693 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbfGKUpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:45:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so3299673pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLdzftGH/gFul7iiOHMklLGxy/NCS/NGh67QDWN64SU=;
        b=MhB4/1cUL+NhY0J5GWsbsrd3eTLDSU+tbUVIlifszTmidPxecNapqdD0z5bq8OPmcV
         BD68gn+Iz22nEW6WBNmOGATWc/CmyRFYE6uwNsJd4YRbbIoj+oXWV9pGjQI8zCvdS4eS
         GRdqJ9Y1/ZJi4k0YQnQV7MG0weCWBo9tc0g6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLdzftGH/gFul7iiOHMklLGxy/NCS/NGh67QDWN64SU=;
        b=balrMMCVhawdhzFgjhdizQpJJJbH56fljtUV7sUFw/rxvh3q1U9xMYyjHIrw3HYn0S
         KReqTrHeHdfnWrKQFIssmgExxy6Qsw7qi+/km3+5Kvpl3KCanNrBQkiikZAB0B/zxtJ2
         iPi/ryBqvIfcPpdTWRXmMIznQrwQWdmzfDDHuOfGltAPauy3hINAVcfu/TVcKkyt9HTn
         GazlSkqXDgDhXkPOkbtLDhBrfuiSDJhdZHk7g+5aPQVmOfbt7KxNroaXV1kELwvY/aNz
         I1rOd36Ow5kHavb8wbUtcsvzzPFhqqAdj+MqVNLPqcAs9plr3RrVIjNP3MJEFbyEYZk2
         ORPA==
X-Gm-Message-State: APjAAAV5dymM8ckwhv3Fr8iyenjZ+F9Qno/kV3N1HqmrvEIoOTuK/ItS
        zQrTa6aRzJXIfdhWmFzo/EV9vQ==
X-Google-Smtp-Source: APXvYqwroM5R2J8TNfLYHSWaQlIk+XkN1UktVue3p11E50fR61dSB3pcJ91/MyRyFDfLxvoJmMQjww==
X-Received: by 2002:a63:c20e:: with SMTP id b14mr6295215pgd.96.1562877903778;
        Thu, 11 Jul 2019 13:45:03 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f17sm5320110pgv.16.2019.07.11.13.45.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 13:45:03 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        mka@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v6 3/3] drm/panel: simple: Use display_timing for AUO b101ean01
Date:   Thu, 11 Jul 2019 13:34:55 -0700
Message-Id: <20190711203455.125667-4-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711203455.125667-1-dianders@chromium.org>
References: <20190711203455.125667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the AUO b101ean01 from using a fixed mode to specifying a
display timing with min/typ/max values.

The AUO b101ean01's datasheet says:
* Vertical blanking min is 12
* Horizontal blanking min is 60
* Pixel clock is between 65.3 MHz and 75 MHz

The goal here is to be able to specify the proper timing in device
tree to use on rk3288-veyron-minnie to match what the downstream
kernel is using so that it can used the fixed PLL.

Changes in v4:
 - display_timing for AUO b101ean01 new for v4.
Changes in v6:
 - Rebased to drm-misc next
 - Added tags

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---

 drivers/gpu/drm/panel/panel-simple.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 602809f6da6a..226f068fb679 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -595,22 +595,21 @@ static const struct panel_desc auo_b101aw03 = {
 	},
 };
 
-static const struct drm_display_mode auo_b101ean01_mode = {
-	.clock = 72500,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 119,
-	.hsync_end = 1280 + 119 + 32,
-	.htotal = 1280 + 119 + 32 + 21,
-	.vdisplay = 800,
-	.vsync_start = 800 + 4,
-	.vsync_end = 800 + 4 + 20,
-	.vtotal = 800 + 4 + 20 + 8,
-	.vrefresh = 60,
+static const struct display_timing auo_b101ean01_timing = {
+	.pixelclock = { 65300000, 72500000, 75000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 18, 119, 119 },
+	.hback_porch = { 21, 21, 21 },
+	.hsync_len = { 32, 32, 32 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 4, 4, 4 },
+	.vback_porch = { 8, 8, 8 },
+	.vsync_len = { 18, 20, 20 },
 };
 
 static const struct panel_desc auo_b101ean01 = {
-	.modes = &auo_b101ean01_mode,
-	.num_modes = 1,
+	.timings = &auo_b101ean01_timing,
+	.num_timings = 1,
 	.bpc = 6,
 	.size = {
 		.width = 217,
-- 
2.22.0.410.gd8fdbe21b5-goog

