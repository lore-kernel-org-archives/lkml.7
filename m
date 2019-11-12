Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD19C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BDC222BD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKLR7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:59:45 -0500
Received: from verein.lst.de ([213.95.11.211]:57158 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfKLR7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:59:45 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id DB8AF68BE1; Tue, 12 Nov 2019 18:59:40 +0100 (CET)
Date:   Tue, 12 Nov 2019 18:59:40 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: fix anx6345 compilation for v5.5
Message-ID: <20191112175940.GA13539@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The anx6345 driver originally was copied from anx78xx.c, which has meanwhile
seen a few changes. In particular, the removal of drm_dp_link helpers and the
discontinuation to include drm_bridge.h from drm_crtc.h breaks compilation
in linux-5.5. Apply equivalents of these changes to anx6345.c.

Signed-off-by: Torsten Duwe <duwe@suse.de>

---

The commits in question are ff1e8fb68ea06 and ee68c743f8d07, but I guess the
next rebase will change these. next-20191112 plus the anx6345-v5a series plus
this patch compile cleanly on arm64.

--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_dp_helper.h>
@@ -49,7 +50,6 @@ struct anx6345 {
 	struct i2c_client *client;
 	struct edid *edid;
 	struct drm_connector connector;
-	struct drm_dp_link link;
 	struct drm_panel *panel;
 	struct regulator *dvdd12;
 	struct regulator *dvdd25;
@@ -96,7 +96,7 @@ static ssize_t anx6345_aux_transfer(stru
 static int anx6345_dp_link_training(struct anx6345 *anx6345)
 {
 	unsigned int value;
-	u8 dp_bw;
+	u8 dp_bw, dpcd[2];
 	int err;
 
 	err = anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM],
@@ -144,18 +143,34 @@ static int anx6345_dp_link_training(stru
 	if (err)
 		return err;
 
-	/* Check link capabilities */
-	err = drm_dp_link_probe(&anx6345->aux, &anx6345->link);
-	if (err < 0) {
-		DRM_ERROR("Failed to probe link capabilities: %d\n", err);
-		return err;
-	}
+	/*
+	 * Power up the sink (DP_SET_POWER register is only available on DPCD
+	 * v1.1 and later).
+	 */
+	if (anx6345->dpcd[DP_DPCD_REV] >= 0x11) {
+		err = drm_dp_dpcd_readb(&anx6345->aux, DP_SET_POWER, &dpcd[0]);
+		if (err < 0) {
+			DRM_ERROR("Failed to read DP_SET_POWER register: %d\n",
+				  err);
+			return err;
+		}
+
+		dpcd[0] &= ~DP_SET_POWER_MASK;
+		dpcd[0] |= DP_SET_POWER_D0;
+
+		err = drm_dp_dpcd_writeb(&anx6345->aux, DP_SET_POWER, dpcd[0]);
+		if (err < 0) {
+			DRM_ERROR("Failed to power up DisplayPort link: %d\n",
+				  err);
+			return err;
+		}
 
-	/* Power up the sink */
-	err = drm_dp_link_power_up(&anx6345->aux, &anx6345->link);
-	if (err < 0) {
-		DRM_ERROR("Failed to power up DisplayPort link: %d\n", err);
-		return err;
+		/*
+		 * According to the DP 1.1 specification, a "Sink Device must
+		 * exit the power saving state within 1 ms" (Section 2.5.3.1,
+		 * Table 5-52, "Sink Control Field" (register 0x600).
+		 */
+		usleep_range(1000, 2000);
 	}
 
 	/* Possibly enable downspread on the sink */
@@ -194,20 +209,28 @@ static int anx6345_dp_link_training(stru
 	if (err)
 		return err;
 
-	value = drm_dp_link_rate_to_bw_code(anx6345->link.rate);
+	dpcd[0] = drm_dp_max_link_rate(anx6345->dpcd);
+	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
 	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
-			   SP_DP_MAIN_LINK_BW_SET_REG, value);
+			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
 	if (err)
 		return err;
 
+	dpcd[1] = drm_dp_max_lane_count(anx6345->dpcd);
+
 	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
-			   SP_DP_LANE_COUNT_SET_REG, anx6345->link.num_lanes);
+			   SP_DP_LANE_COUNT_SET_REG, dpcd[1]);
 	if (err)
 		return err;
 
-	err = drm_dp_link_configure(&anx6345->aux, &anx6345->link);
+	if (drm_dp_enhanced_frame_cap(anx6345->dpcd))
+		dpcd[1] |= DP_LANE_COUNT_ENHANCED_FRAME_EN;
+
+	err = drm_dp_dpcd_write(&anx6345->aux, DP_LINK_BW_SET, dpcd,
+				sizeof(dpcd));
+
 	if (err < 0) {
-		DRM_ERROR("Failed to configure DisplayPort link: %d\n", err);
+		DRM_ERROR("Failed to configure link: %d\n", err);
 		return err;
 	}
 
