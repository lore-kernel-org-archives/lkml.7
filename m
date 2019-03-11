Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4843720857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qaoboe2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfCKKwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:52:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54125 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfCKKv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:51:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so3907761wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peSRsbfOmjVTwUEyAQd40V9br3sdhQuxqD1H4smBkrQ=;
        b=qaoboe2uDxXan4CgNXHztQPft8XCti+aOfn2z5WY5Z7ucMfM2EPMCTSZEqh5PzZ7Cn
         B856u78SnJZ/ueeKwAL6VmSIIlH3i++zQ5lqEZvIEbThk3JN/+hz2S0D7h9/PTWWrNCc
         qLpx7KZt5BG9GZsqZT1wwsfHT14/bBkLzF1L0XHBQgwsHwq/N4dfaMR0e7hUUyA7Fx7D
         IiEZ8V0hR1Qu/DqKCQUMn+wNFnQzT+/h38Y0ohnr816/HhpKTfQqZfCZlNvQwKXqxVOw
         /NMFNMlkrdOy54ESEUgYSUVyJmwRXWzLO3V3vGjNL1xRFS50RfAYi1H5c/xLI9FvDd8d
         Sqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peSRsbfOmjVTwUEyAQd40V9br3sdhQuxqD1H4smBkrQ=;
        b=cg1cEv2RTxKXg0gU85HwZW4kBT95qECBrup8yYeXzXE46qRo40T36haePoFCSJr+hL
         l2OD2xakqTZFdaaxHjDYz6YaaQFokBEISbMXC4AuUQwwxUk5/26TpBFiWo1ZDrcCJdXx
         jzbIFgdIk4dxDtoRI+UbHIj5KdISFpKpzHPl4TkLbbiKa0fjevCS+V/GGLpq4fvpeHcq
         hrSmCh+At4CQIgMm04+kfagVRXgH81F0SPBDTdUJXQY5Eor27WhVc8Qd823BgSjrgn1O
         rQiayZfU2W395RpINU80qNS4cVC0JFJ7SnA1t80WQfwkbUb8qMfrCc0PLd710xpIAY3L
         jzrA==
X-Gm-Message-State: APjAAAXB5eTBK9CzJmvOpBHqd0JKtVG5idn39B5Z5/exov/NI/x9LnFE
        S+PliByPcEZIEGFCrC7yKJqTDw==
X-Google-Smtp-Source: APXvYqw76OmewvxNbM6YZy55hgg7OFCuITAd1vfEpVU1NkEfqe6b75M9UNAGyrsjSRO39Lo784KJZg==
X-Received: by 2002:a7b:c0c3:: with SMTP id s3mr16102958wmh.141.1552301513434;
        Mon, 11 Mar 2019 03:51:53 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id c21sm6902640wre.35.2019.03.11.03.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 03:51:52 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/meson: exclusively use the canvas provider module
Date:   Mon, 11 Mar 2019 11:51:44 +0100
Message-Id: <20190311105144.7276-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190311105144.7276-1-mjourdan@baylibre.com>
References: <20190311105144.7276-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the DMC register range is no longer in the bindings, remove any
mention towards it and exclusively use the meson-canvas module.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/gpu/drm/meson/Makefile        |  2 +-
 drivers/gpu/drm/meson/meson_canvas.c  | 73 -----------------------
 drivers/gpu/drm/meson/meson_canvas.h  | 51 ----------------
 drivers/gpu/drm/meson/meson_crtc.c    | 84 ++++++++-------------------
 drivers/gpu/drm/meson/meson_drv.c     | 68 ++++++++--------------
 drivers/gpu/drm/meson/meson_drv.h     |  1 -
 drivers/gpu/drm/meson/meson_overlay.c |  8 ---
 drivers/gpu/drm/meson/meson_plane.c   |  6 +-
 drivers/gpu/drm/meson/meson_viu.c     |  1 -
 9 files changed, 51 insertions(+), 243 deletions(-)
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h

diff --git a/drivers/gpu/drm/meson/Makefile b/drivers/gpu/drm/meson/Makefile
index 7709f2fbb9f7..d4ea82fc493b 100644
--- a/drivers/gpu/drm/meson/Makefile
+++ b/drivers/gpu/drm/meson/Makefile
@@ -1,5 +1,5 @@
 meson-drm-y := meson_drv.o meson_plane.o meson_crtc.o meson_venc_cvbs.o
-meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o meson_canvas.o meson_overlay.o
+meson-drm-y += meson_viu.o meson_vpp.o meson_venc.o meson_vclk.o meson_overlay.o
 
 obj-$(CONFIG_DRM_MESON) += meson-drm.o
 obj-$(CONFIG_DRM_MESON_DW_HDMI) += meson_dw_hdmi.o
diff --git a/drivers/gpu/drm/meson/meson_canvas.c b/drivers/gpu/drm/meson/meson_canvas.c
deleted file mode 100644
index 5de11aa7c775..000000000000
--- a/drivers/gpu/drm/meson/meson_canvas.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * Copyright (C) 2016 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- * Copyright (C) 2015 Amlogic, Inc. All rights reserved.
- * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include "meson_drv.h"
-#include "meson_canvas.h"
-#include "meson_registers.h"
-
-/**
- * DOC: Canvas
- *
- * CANVAS is a memory zone where physical memory frames information
- * are stored for the VIU to scanout.
- */
-
-/* DMC Registers */
-#define DMC_CAV_LUT_DATAL	0x48 /* 0x12 offset in data sheet */
-#define CANVAS_WIDTH_LBIT	29
-#define CANVAS_WIDTH_LWID       3
-#define DMC_CAV_LUT_DATAH	0x4c /* 0x13 offset in data sheet */
-#define CANVAS_WIDTH_HBIT       0
-#define CANVAS_HEIGHT_BIT       9
-#define CANVAS_BLKMODE_BIT      24
-#define CANVAS_ENDIAN_BIT	26
-#define DMC_CAV_LUT_ADDR	0x50 /* 0x14 offset in data sheet */
-#define CANVAS_LUT_WR_EN        (0x2 << 8)
-#define CANVAS_LUT_RD_EN        (0x1 << 8)
-
-void meson_canvas_setup(struct meson_drm *priv,
-			uint32_t canvas_index, uint32_t addr,
-			uint32_t stride, uint32_t height,
-			unsigned int wrap,
-			unsigned int blkmode,
-			unsigned int endian)
-{
-	unsigned int val;
-
-	regmap_write(priv->dmc, DMC_CAV_LUT_DATAL,
-		(((addr + 7) >> 3)) |
-		(((stride + 7) >> 3) << CANVAS_WIDTH_LBIT));
-
-	regmap_write(priv->dmc, DMC_CAV_LUT_DATAH,
-		((((stride + 7) >> 3) >> CANVAS_WIDTH_LWID) <<
-						CANVAS_WIDTH_HBIT) |
-		(height << CANVAS_HEIGHT_BIT) |
-		(wrap << 22) |
-		(blkmode << CANVAS_BLKMODE_BIT) |
-		(endian << CANVAS_ENDIAN_BIT));
-
-	regmap_write(priv->dmc, DMC_CAV_LUT_ADDR,
-			CANVAS_LUT_WR_EN | canvas_index);
-
-	/* Force a read-back to make sure everything is flushed. */
-	regmap_read(priv->dmc, DMC_CAV_LUT_DATAH, &val);
-}
diff --git a/drivers/gpu/drm/meson/meson_canvas.h b/drivers/gpu/drm/meson/meson_canvas.h
deleted file mode 100644
index 85dbf26e2826..000000000000
--- a/drivers/gpu/drm/meson/meson_canvas.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * Copyright (C) 2016 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- * Copyright (C) 2014 Endless Mobile
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-/* Canvas LUT Memory */
-
-#ifndef __MESON_CANVAS_H
-#define __MESON_CANVAS_H
-
-#define MESON_CANVAS_ID_OSD1	0x4e
-#define MESON_CANVAS_ID_VD1_0	0x60
-#define MESON_CANVAS_ID_VD1_1	0x61
-#define MESON_CANVAS_ID_VD1_2	0x62
-
-/* Canvas configuration. */
-#define MESON_CANVAS_WRAP_NONE	0x00
-#define	MESON_CANVAS_WRAP_X	0x01
-#define	MESON_CANVAS_WRAP_Y	0x02
-
-#define	MESON_CANVAS_BLKMODE_LINEAR	0x00
-#define	MESON_CANVAS_BLKMODE_32x32	0x01
-#define	MESON_CANVAS_BLKMODE_64x64	0x02
-
-#define MESON_CANVAS_ENDIAN_SWAP16	0x1
-#define MESON_CANVAS_ENDIAN_SWAP32	0x3
-#define MESON_CANVAS_ENDIAN_SWAP64	0x7
-#define MESON_CANVAS_ENDIAN_SWAP128	0xf
-
-void meson_canvas_setup(struct meson_drm *priv,
-			uint32_t canvas_index, uint32_t addr,
-			uint32_t stride, uint32_t height,
-			unsigned int wrap,
-			unsigned int blkmode,
-			unsigned int endian);
-
-#endif /* __MESON_CANVAS_H */
diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index 4f5c67f70c4d..37c70641bcdf 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -37,7 +37,6 @@
 #include "meson_venc.h"
 #include "meson_vpp.h"
 #include "meson_viu.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 /* CRTC definition */
@@ -214,13 +213,7 @@ void meson_crtc_irq(struct meson_drm *priv)
 		writel_relaxed(priv->viu.osd_sc_v_ctrl0,
 				priv->io_base + _REG(VPP_OSD_VSC_CTRL0));
 
-		if (priv->canvas)
-			meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
-				priv->viu.osd1_addr, priv->viu.osd1_stride,
-				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
-				MESON_CANVAS_BLKMODE_LINEAR, 0);
-		else
-			meson_canvas_setup(priv, MESON_CANVAS_ID_OSD1,
+		meson_canvas_config(priv->canvas, priv->canvas_id_osd1,
 				priv->viu.osd1_addr, priv->viu.osd1_stride,
 				priv->viu.osd1_height, MESON_CANVAS_WRAP_NONE,
 				MESON_CANVAS_BLKMODE_LINEAR, 0);
@@ -237,61 +230,34 @@ void meson_crtc_irq(struct meson_drm *priv)
 
 		switch (priv->viu.vd1_planes) {
 		case 3:
-			if (priv->canvas)
-				meson_canvas_config(priv->canvas,
-						    priv->canvas_id_vd1_2,
-						    priv->viu.vd1_addr2,
-						    priv->viu.vd1_stride2,
-						    priv->viu.vd1_height2,
-						    MESON_CANVAS_WRAP_NONE,
-						    MESON_CANVAS_BLKMODE_LINEAR,
-						    MESON_CANVAS_ENDIAN_SWAP64);
-			else
-				meson_canvas_setup(priv, MESON_CANVAS_ID_VD1_2,
-						   priv->viu.vd1_addr2,
-						   priv->viu.vd1_stride2,
-						   priv->viu.vd1_height2,
-						   MESON_CANVAS_WRAP_NONE,
-						   MESON_CANVAS_BLKMODE_LINEAR,
-						   MESON_CANVAS_ENDIAN_SWAP64);
+			meson_canvas_config(priv->canvas,
+					    priv->canvas_id_vd1_2,
+					    priv->viu.vd1_addr2,
+					    priv->viu.vd1_stride2,
+					    priv->viu.vd1_height2,
+					    MESON_CANVAS_WRAP_NONE,
+					    MESON_CANVAS_BLKMODE_LINEAR,
+					    MESON_CANVAS_ENDIAN_SWAP64);
 		/* fallthrough */
 		case 2:
-			if (priv->canvas)
-				meson_canvas_config(priv->canvas,
-						    priv->canvas_id_vd1_1,
-						    priv->viu.vd1_addr1,
-						    priv->viu.vd1_stride1,
-						    priv->viu.vd1_height1,
-						    MESON_CANVAS_WRAP_NONE,
-						    MESON_CANVAS_BLKMODE_LINEAR,
-						    MESON_CANVAS_ENDIAN_SWAP64);
-			else
-				meson_canvas_setup(priv, MESON_CANVAS_ID_VD1_1,
-						   priv->viu.vd1_addr2,
-						   priv->viu.vd1_stride2,
-						   priv->viu.vd1_height2,
-						   MESON_CANVAS_WRAP_NONE,
-						   MESON_CANVAS_BLKMODE_LINEAR,
-						   MESON_CANVAS_ENDIAN_SWAP64);
+			meson_canvas_config(priv->canvas,
+					    priv->canvas_id_vd1_1,
+					    priv->viu.vd1_addr1,
+					    priv->viu.vd1_stride1,
+					    priv->viu.vd1_height1,
+					    MESON_CANVAS_WRAP_NONE,
+					    MESON_CANVAS_BLKMODE_LINEAR,
+					    MESON_CANVAS_ENDIAN_SWAP64);
 		/* fallthrough */
 		case 1:
-			if (priv->canvas)
-				meson_canvas_config(priv->canvas,
-						    priv->canvas_id_vd1_0,
-						    priv->viu.vd1_addr0,
-						    priv->viu.vd1_stride0,
-						    priv->viu.vd1_height0,
-						    MESON_CANVAS_WRAP_NONE,
-						    MESON_CANVAS_BLKMODE_LINEAR,
-						    MESON_CANVAS_ENDIAN_SWAP64);
-			else
-				meson_canvas_setup(priv, MESON_CANVAS_ID_VD1_0,
-						   priv->viu.vd1_addr2,
-						   priv->viu.vd1_stride2,
-						   priv->viu.vd1_height2,
-						   MESON_CANVAS_WRAP_NONE,
-						   MESON_CANVAS_BLKMODE_LINEAR,
-						   MESON_CANVAS_ENDIAN_SWAP64);
+			meson_canvas_config(priv->canvas,
+					    priv->canvas_id_vd1_0,
+					    priv->viu.vd1_addr0,
+					    priv->viu.vd1_stride0,
+					    priv->viu.vd1_height0,
+					    MESON_CANVAS_WRAP_NONE,
+					    MESON_CANVAS_BLKMODE_LINEAR,
+					    MESON_CANVAS_ENDIAN_SWAP64);
 		};
 
 		writel_relaxed(priv->viu.vd1_if0_gen_reg,
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 12ff47b13668..7913983f2981 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -48,7 +48,6 @@
 #include "meson_vpp.h"
 #include "meson_viu.h"
 #include "meson_venc.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 #define DRIVER_NAME "meson"
@@ -214,50 +213,31 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	}
 
 	priv->canvas = meson_canvas_get(dev);
-	if (!IS_ERR(priv->canvas)) {
-		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
-		if (ret)
-			goto free_drm;
-		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_0);
-		if (ret) {
-			meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
-			goto free_drm;
-		}
-		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_1);
-		if (ret) {
-			meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
-			meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
-			goto free_drm;
-		}
-		ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_2);
-		if (ret) {
-			meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
-			meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
-			meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
-			goto free_drm;
-		}
-	} else {
-		priv->canvas = NULL;
-
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
-		if (!res) {
-			ret = -EINVAL;
-			goto free_drm;
-		}
-		/* Simply ioremap since it may be a shared register zone */
-		regs = devm_ioremap(dev, res->start, resource_size(res));
-		if (!regs) {
-			ret = -EADDRNOTAVAIL;
-			goto free_drm;
-		}
+	if (IS_ERR(priv->canvas)) {
+		ret = PTR_ERR(priv->canvas);
+		goto free_drm;
+	}
 
-		priv->dmc = devm_regmap_init_mmio(dev, regs,
-						  &meson_regmap_config);
-		if (IS_ERR(priv->dmc)) {
-			dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
-			ret = PTR_ERR(priv->dmc);
-			goto free_drm;
-		}
+	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
+	if (ret)
+		goto free_drm;
+	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_0);
+	if (ret) {
+		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
+		goto free_drm;
+	}
+	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_1);
+	if (ret) {
+		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
+		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
+		goto free_drm;
+	}
+	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_2);
+	if (ret) {
+		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
+		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
+		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
+		goto free_drm;
 	}
 
 	priv->vsync_irq = platform_get_irq(pdev, 0);
diff --git a/drivers/gpu/drm/meson/meson_drv.h b/drivers/gpu/drm/meson/meson_drv.h
index 4dccf4cd042a..214a7cb18ce2 100644
--- a/drivers/gpu/drm/meson/meson_drv.h
+++ b/drivers/gpu/drm/meson/meson_drv.h
@@ -29,7 +29,6 @@ struct meson_drm {
 	struct device *dev;
 	void __iomem *io_base;
 	struct regmap *hhi;
-	struct regmap *dmc;
 	int vsync_irq;
 
 	struct meson_canvas *canvas;
diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index 691a9fd16b36..b54a22e483b9 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -22,7 +22,6 @@
 #include "meson_overlay.h"
 #include "meson_vpp.h"
 #include "meson_viu.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 /* VD1_IF0_GEN_REG */
@@ -350,13 +349,6 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
 
 	DRM_DEBUG_DRIVER("\n");
 
-	/* Fallback is canvas provider is not available */
-	if (!priv->canvas) {
-		priv->canvas_id_vd1_0 = MESON_CANVAS_ID_VD1_0;
-		priv->canvas_id_vd1_1 = MESON_CANVAS_ID_VD1_1;
-		priv->canvas_id_vd1_2 = MESON_CANVAS_ID_VD1_2;
-	}
-
 	interlace_mode = state->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE;
 
 	spin_lock_irqsave(&priv->drm->event_lock, flags);
diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index 6119a0224278..b7786218cb10 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -38,7 +38,6 @@
 #include "meson_plane.h"
 #include "meson_vpp.h"
 #include "meson_viu.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 /* OSD_SCI_WH_M1 */
@@ -148,10 +147,7 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 				   (0xFF << OSD_GLOBAL_ALPHA_SHIFT) |
 				   OSD_BLK0_ENABLE;
 
-	if (priv->canvas)
-		canvas_id_osd1 = priv->canvas_id_osd1;
-	else
-		canvas_id_osd1 = MESON_CANVAS_ID_OSD1;
+	canvas_id_osd1 = priv->canvas_id_osd1;
 
 	/* Set up BLK0 to point to the right canvas */
 	priv->viu.osd1_blk0_cfg[0] = ((canvas_id_osd1 << OSD_CANVAS_SEL) |
diff --git a/drivers/gpu/drm/meson/meson_viu.c b/drivers/gpu/drm/meson/meson_viu.c
index e46e05f50bad..ac0f3687e09a 100644
--- a/drivers/gpu/drm/meson/meson_viu.c
+++ b/drivers/gpu/drm/meson/meson_viu.c
@@ -25,7 +25,6 @@
 #include "meson_viu.h"
 #include "meson_vpp.h"
 #include "meson_venc.h"
-#include "meson_canvas.h"
 #include "meson_registers.h"
 
 /**
-- 
2.21.0

