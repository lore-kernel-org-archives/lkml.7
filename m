Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFDC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF64721882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="CsIoJ7y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbfKFRBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:01:17 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:17104 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732363AbfKFRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573059665;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=sZdoB36F5UBdckaG8aj1GzQtE3+0zrTPGHer5Xs7ohg=;
        b=CsIoJ7y4Wlj/BHrw9+Ve8Bwq2n0bAI1sFjGVuB2Ml0K3wAi27eaBfDr7/78em8BDZR
        YcFskSeIbrEjWGZGelFSNlvoJTuwPvgU5H7RdqE6lP/kwvY/A7npmwsVeVnuwCnRf3zd
        CQViIbEAj9KgZKflJmyXkieYnsnSZ7dppImuECFg1HSj/i21TLG+XQ0IuM6TjmPXBx4k
        g5VW6zG0zw5VOppirWuaDm1b+WA+3/P8uNTkYuA5jvUeS5YDvvcLMpNBC6NJ3w4VLTtt
        EudMZFckOFgabfhC89MaSRZhuxUeCLCx8xz3U6Rwauw5sJSS0nszLIJj9WBXx6MuqhW/
        Lz8g==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6H15hLw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:01:05 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 6/7] drm/mcde: dsi: Enable clocks in pre_enable() instead of mode_set()
Date:   Wed,  6 Nov 2019 17:58:34 +0100
Message-Id: <20191106165835.2863-7-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106165835.2863-1-stephan@gerhold.net>
References: <20191106165835.2863-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI initialization sequence incorrectly assumes that the mode_set()
function of the DRM bridge is always called when (re-)enabling the display.
This is not necessarily the case.

Keeping the device idle in the framebuffer console for a while results
in the display being turned off using the disable() function. However,
as soon as any key is pressed only (pre_)enable() are called.
mode_set() is skipped because the mode has not been changed.

In this case, the DSI HS/LP clocks are never turned back on,
preventing the display from working.

Fix this by moving a part of the initialization sequence from
mode_set() to pre_enable(). Keep most of the video mode setup in
mode_set() since most of the registers are only dependent on the mode
that is set for the panel - there is no need to write them again each
time we re-enable the display.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 67 ++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index df963e078c35..03896a1f339a 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -562,21 +562,6 @@ static void mcde_dsi_setup_video_mode(struct mcde_dsi *d,
 		DSI_VID_VCA_SETTING2_EXACT_BURST_LIMIT_SHIFT;
 	writel(val, d->regs + DSI_VID_VCA_SETTING2);
 
-	/* Put IF1 into video mode */
-	val = readl(d->regs + DSI_MCTL_MAIN_DATA_CTL);
-	val |= DSI_MCTL_MAIN_DATA_CTL_IF1_MODE;
-	writel(val, d->regs + DSI_MCTL_MAIN_DATA_CTL);
-
-	/* Disable command mode on IF1 */
-	val = readl(d->regs + DSI_CMD_MODE_CTL);
-	val &= ~DSI_CMD_MODE_CTL_IF1_LP_EN;
-	writel(val, d->regs + DSI_CMD_MODE_CTL);
-
-	/* Enable some error interrupts */
-	val = readl(d->regs + DSI_VID_MODE_STS_CTL);
-	val |= DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC;
-	val |= DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA;
-	writel(val, d->regs + DSI_VID_MODE_STS_CTL);
 }
 
 static void mcde_dsi_start(struct mcde_dsi *d)
@@ -700,26 +685,13 @@ static void mcde_dsi_bridge_enable(struct drm_bridge *bridge)
 	dev_info(d->dev, "enable DSI master\n");
 };
 
-static void mcde_dsi_bridge_mode_set(struct drm_bridge *bridge,
-				     const struct drm_display_mode *mode,
-				     const struct drm_display_mode *adj)
+static void mcde_dsi_bridge_pre_enable(struct drm_bridge *bridge)
 {
 	struct mcde_dsi *d = bridge_to_mcde_dsi(bridge);
-	unsigned long pixel_clock_hz = mode->clock * 1000;
 	unsigned long hs_freq, lp_freq;
 	u32 val;
 	int ret;
 
-	if (!d->mdsi) {
-		dev_err(d->dev, "no DSI device attached to encoder!\n");
-		return;
-	}
-
-	dev_info(d->dev, "set DSI master to %dx%d %lu Hz %s mode\n",
-		 mode->hdisplay, mode->vdisplay, pixel_clock_hz,
-		 (d->mdsi->mode_flags & MIPI_DSI_MODE_VIDEO) ? "VIDEO" : "CMD"
-		);
-
 	/* Copy maximum clock frequencies */
 	if (d->mdsi->lp_rate)
 		lp_freq = d->mdsi->lp_rate;
@@ -758,7 +730,21 @@ static void mcde_dsi_bridge_mode_set(struct drm_bridge *bridge,
 			 d->hs_freq);
 
 	if (d->mdsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		mcde_dsi_setup_video_mode(d, mode);
+		/* Put IF1 into video mode */
+		val = readl(d->regs + DSI_MCTL_MAIN_DATA_CTL);
+		val |= DSI_MCTL_MAIN_DATA_CTL_IF1_MODE;
+		writel(val, d->regs + DSI_MCTL_MAIN_DATA_CTL);
+
+		/* Disable command mode on IF1 */
+		val = readl(d->regs + DSI_CMD_MODE_CTL);
+		val &= ~DSI_CMD_MODE_CTL_IF1_LP_EN;
+		writel(val, d->regs + DSI_CMD_MODE_CTL);
+
+		/* Enable some error interrupts */
+		val = readl(d->regs + DSI_VID_MODE_STS_CTL);
+		val |= DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC;
+		val |= DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA;
+		writel(val, d->regs + DSI_VID_MODE_STS_CTL);
 	} else {
 		/* Command mode, clear IF1 ID */
 		val = readl(d->regs + DSI_CMD_MODE_CTL);
@@ -772,6 +758,26 @@ static void mcde_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	}
 }
 
+static void mcde_dsi_bridge_mode_set(struct drm_bridge *bridge,
+				     const struct drm_display_mode *mode,
+				     const struct drm_display_mode *adj)
+{
+	struct mcde_dsi *d = bridge_to_mcde_dsi(bridge);
+
+	if (!d->mdsi) {
+		dev_err(d->dev, "no DSI device attached to encoder!\n");
+		return;
+	}
+
+	dev_info(d->dev, "set DSI master to %dx%d %u Hz %s mode\n",
+		 mode->hdisplay, mode->vdisplay, mode->clock * 1000,
+		 (d->mdsi->mode_flags & MIPI_DSI_MODE_VIDEO) ? "VIDEO" : "CMD"
+		);
+
+	if (d->mdsi->mode_flags & MIPI_DSI_MODE_VIDEO)
+		mcde_dsi_setup_video_mode(d, mode);
+}
+
 static void mcde_dsi_wait_for_command_mode_stop(struct mcde_dsi *d)
 {
 	u32 val;
@@ -863,6 +869,7 @@ static const struct drm_bridge_funcs mcde_dsi_bridge_funcs = {
 	.mode_set = mcde_dsi_bridge_mode_set,
 	.disable = mcde_dsi_bridge_disable,
 	.enable = mcde_dsi_bridge_enable,
+	.pre_enable = mcde_dsi_bridge_pre_enable,
 };
 
 static int mcde_dsi_bind(struct device *dev, struct device *master,
-- 
2.23.0

