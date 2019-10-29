Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31684CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11759208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbfJ2Pjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:39:55 -0400
Received: from verein.lst.de ([213.95.11.211]:40678 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390129AbfJ2Pju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:39:50 -0400
Received: by verein.lst.de (Postfix, from userid 2005)
        id 6E30B68CFC; Tue, 29 Oct 2019 16:39:47 +0100 (CET)
In-Reply-To: <20191029153815.C631668C4E@verein.lst.de>
References: <20191029153815.C631668C4E@verein.lst.de>
From:   Torsten Duwe <duwe@lst.de>
Date:   Tue, 29 Oct 2019 13:16:57 +0100
Subject: [PATCH v4 4/7] drm/bridge: Prepare Analogix anx6345 support
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <20191029153947.6E30B68CFC@verein.lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bit definitions required for the anx6345 and add a
sanity check in anx_dp_aux_transfer.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c     | 2 +-
 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h     | 8 ++++++++
 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
index 60707bb5afe7..fe40bab21530 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
@@ -116,7 +116,7 @@ ssize_t anx_dp_aux_transfer(struct regmap *map_dptx,
 	else	/* For non-zero-sized set the length field. */
 		ctrl1 |= (msg->size - 1) << SP_AUX_LENGTH_SHIFT;
 
-	if ((msg->request & DP_AUX_I2C_READ) == 0) {
+	if ((msg->size > 0) && ((msg->request & DP_AUX_I2C_READ) == 0)) {
 		/* When WRITE | MOT write values to data buffer */
 		err = regmap_bulk_write(map_dptx,
 					SP_DP_BUF_DATA0_REG, buffer,
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
index 430a039c10cd..24bc67ac5479 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
@@ -74,7 +74,11 @@
 #define SP_CHA_STA			BIT(2)
 /* Bits for DP System Control Register 3 */
 #define SP_HPD_STATUS			BIT(6)
+#define SP_HPD_FORCE			BIT(5)
+#define SP_HPD_CTRL			BIT(4)
 #define SP_STRM_VALID			BIT(2)
+#define SP_STRM_FORCE			BIT(1)
+#define SP_STRM_CTRL			BIT(0)
 /* Bits for DP System Control Register 4 */
 #define SP_ENHANCED_MODE		BIT(3)
 
@@ -119,6 +123,9 @@
 #define SP_LINK_BW_SET_MASK		0x1f
 #define SP_INITIAL_SLIM_M_AUD_SEL	BIT(5)
 
+/* DP Lane Count Setting Register */
+#define SP_DP_LANE_COUNT_SET_REG	0xa1
+
 /* DP Training Pattern Set Register */
 #define SP_DP_TRAINING_PATTERN_SET_REG	0xa2
 
@@ -132,6 +139,7 @@
 
 /* DP Link Training Control Register */
 #define SP_DP_LT_CTRL_REG		0xa8
+#define SP_DP_LT_INPROGRESS		0x80
 #define SP_LT_ERROR_TYPE_MASK		0x70
 #  define SP_LT_NO_ERROR		0x00
 #  define SP_LT_AUX_WRITE_ERROR		0x01
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h b/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
index c1030e0f74cc..9fa6f426f990 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
@@ -179,6 +179,9 @@
 #define SP_VBIT				BIT(1)
 #define SP_AUDIO_LAYOUT			BIT(0)
 
+/* Analog Debug Register 1 */
+#define SP_ANALOG_DEBUG1_REG		0xdc
+
 /* Analog Debug Register 2 */
 #define SP_ANALOG_DEBUG2_REG		0xdd
 #define SP_FORCE_SW_OFF_BYPASS		0x20
-- 
2.16.4

