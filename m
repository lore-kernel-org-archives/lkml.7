Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09865C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC542073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ExtEv7m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgAHVIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:08:04 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:31007 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbgAHVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=rEkBwwf1QWNXjn8vIYFhzi7wIguJy4lc2BpbKmg9n80=;
        b=ExtEv7m/RAJq48j005pEANu6aNs1Gq7zxmk5UqQ6DrLoHO7wasJoaaImLxrYyUvi8nHA
        Qxx5vK0kJJQ0+qk/iRz94ypFdYZbpeZdfWm/jfhHz5ZYX3IJweaiM/FMJxTR5ymBa52mW7
        vW17b+kOPBOsyERsPwJjpBKHwK3mSMao8=
Received: by filterdrecv-p3mdw1-56c97568b5-fkvrs with SMTP id filterdrecv-p3mdw1-56c97568b5-fkvrs-20-5E1644A8-11
        2020-01-08 21:07:52.195374981 +0000 UTC m=+1974283.569941188
Received: from bionic.localdomain (unknown [98.128.173.80])
        by ismtpd0005p1lon1.sendgrid.net (SG) with ESMTP id 3JS0NgZZRJK82Mp4YUQcKA
        Wed, 08 Jan 2020 21:07:51.991 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 12/14] drm/rockchip: dw-hdmi: limit tmds to 340mhz on
 rk3228/rk3328
Date:   Wed, 08 Jan 2020 21:07:52 +0000 (UTC)
Message-Id: <20200108210740.28769-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
References: <20200108210740.28769-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h3yBhIbMTagqfT2zR?=
 =?us-ascii?Q?8DIjW=2Fj=2FX3Egb+8hajJVedi0tMDpE8GNB2sMY0q?=
 =?us-ascii?Q?enYQZ0se4WGjtVgc7msZY8iqJ7ZbMq6r5A3RuSc?=
 =?us-ascii?Q?d6Lyyvl0HKI1n9urcJkbolT7ci2MuOJL193jOeJ?=
 =?us-ascii?Q?0GuTjykpcpjd6bvwLDwwPWtVL8MZ4RjTiENSyyI?=
 =?us-ascii?Q?lTmbckgBTEuzFr9aiz6SQ=3D=3D?=
To:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3228/RK3328 does not provide a stable hdmi signal at TMDS rates
above 371.25MHz (340MHz pixel clock).

Limit the pixel clock rate to 340MHz to provide a stable signal.
Also limit the pixel clock to the display reported max tmds clock.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 22 +++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 45fcdce3f27f..66c14df4a680 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -237,6 +237,24 @@ dw_hdmi_rockchip_mode_valid(struct drm_connector *connector,
 	return (valid) ? MODE_OK : MODE_BAD;
 }
 
+static enum drm_mode_status
+dw_hdmi_rk3228_mode_valid(struct drm_connector *connector,
+			  const struct drm_display_mode *mode)
+{
+	struct drm_display_info *info = &connector->display_info;
+	int max_tmds_clock = max(info->max_tmds_clock, 165000);
+	int clock = mode->clock;
+
+	if (connector->ycbcr_420_allowed && drm_mode_is_420(info, mode) &&
+	    (info->color_formats & DRM_COLOR_FORMAT_YCRCB420))
+		clock /= 2;
+
+	if (clock > max_tmds_clock || clock > 340000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static const struct drm_encoder_funcs dw_hdmi_rockchip_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
@@ -424,7 +442,7 @@ static struct rockchip_hdmi_chip_data rk3228_chip_data = {
 };
 
 static const struct dw_hdmi_plat_data rk3228_hdmi_drv_data = {
-	.mode_valid = dw_hdmi_rockchip_mode_valid,
+	.mode_valid = dw_hdmi_rk3228_mode_valid,
 	.mpll_cfg = rockchip_mpll_cfg,
 	.cur_ctr = rockchip_cur_ctr,
 	.phy_config = rockchip_phy_config,
@@ -461,7 +479,7 @@ static struct rockchip_hdmi_chip_data rk3328_chip_data = {
 };
 
 static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
-	.mode_valid = dw_hdmi_rockchip_mode_valid,
+	.mode_valid = dw_hdmi_rk3228_mode_valid,
 	.mpll_cfg = rockchip_mpll_cfg,
 	.cur_ctr = rockchip_cur_ctr,
 	.phy_config = rockchip_phy_config,
-- 
2.17.1

