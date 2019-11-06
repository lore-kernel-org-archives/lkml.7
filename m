Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61784C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9D62187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="TbMptQRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfKFRBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:01:06 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:23826 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732141AbfKFRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573059664;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=EeS87K2j7Au0Fo7/boVudqSloB+oM7kXBhKYEZ0FXrc=;
        b=TbMptQRob4903bE/cVygbq2bBP6xB3yi7vshXOyqF3vCdNwyE5B1JGGKHkAiOA6Asa
        dOP+aekSVvLj2C7DaIrWZNFMyiHTWiTj3iXHX8vVapG/3iHehr2NEInannRygRn0Ftxt
        wuMOuCfZ0rFJMi55Fbvw0lO/cZjwR/FnbsgPOBDf4obCUc8M5Py2xImW0CIwRLc1570a
        XTe0eEM1JhRzNFLC7ChKIGyCt9HOnVZL2JrRFZTHr/vuXn77cEZIHK7MgWImFO361nOg
        guquEt3shAzPcwvDyl28/bgXpyDY4SRIRYapKSponmBxYerWXH5uXeUx3jI8UFAN77qO
        BZkg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6H13hLs
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:01:03 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/7] drm/mcde: Fix frame sync setup for video mode panels
Date:   Wed,  6 Nov 2019 17:58:30 +0100
Message-Id: <20191106165835.2863-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106165835.2863-1-stephan@gerhold.net>
References: <20191106165835.2863-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCDE driver differentiates only between "te_sync"
(for hardware TE0 sync) and software sync
(i.e. manually triggered updates) at the moment.

However, none of these options work correctly for video mode panels.
Therefore, we need to make some changes to make them work correctly:

  - Select hardware sync coming from the (DSI) formatter.
  - Keep the FIFO permanently enabled (otherwise MCDE will stop
    feeding data to the panel).
  - Skip manual software sync (this is not necessary in video mode).

Automatically detect if the connected panel is using video mode
and enable the necessary changes in that case.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/gpu/drm/mcde/mcde_display.c | 32 ++++++++++++++++-------------
 drivers/gpu/drm/mcde/mcde_drm.h     |  1 +
 drivers/gpu/drm/mcde/mcde_drv.c     |  2 --
 drivers/gpu/drm/mcde/mcde_dsi.c     | 13 ++++++++++--
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index 65522481b367..a3375a974caf 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -498,24 +498,20 @@ static void mcde_configure_channel(struct mcde *mcde, enum mcde_channel ch,
 	}
 
 	/* Set up channel 0 sync (based on chnl_update_registers()) */
-	if (mcde->te_sync) {
-		/*
-		 * Turn on hardware TE0 synchronization
-		 */
+	if (mcde->video_mode || mcde->te_sync)
 		val = MCDE_CHNLXSYNCHMOD_SRC_SYNCH_HARDWARE
 			<< MCDE_CHNLXSYNCHMOD_SRC_SYNCH_SHIFT;
-		val |= MCDE_CHNLXSYNCHMOD_OUT_SYNCH_SRC_TE0
-			<< MCDE_CHNLXSYNCHMOD_OUT_SYNCH_SRC_SHIFT;
-	} else {
-		/*
-		 * Set up sync source to software, out sync formatter
-		 * Code mostly from mcde_hw.c chnl_update_registers()
-		 */
+	else
 		val = MCDE_CHNLXSYNCHMOD_SRC_SYNCH_SOFTWARE
 			<< MCDE_CHNLXSYNCHMOD_SRC_SYNCH_SHIFT;
+
+	if (mcde->te_sync)
+		val |= MCDE_CHNLXSYNCHMOD_OUT_SYNCH_SRC_TE0
+			<< MCDE_CHNLXSYNCHMOD_OUT_SYNCH_SRC_SHIFT;
+	else
 		val |= MCDE_CHNLXSYNCHMOD_OUT_SYNCH_SRC_FORMATTER
 			<< MCDE_CHNLXSYNCHMOD_OUT_SYNCH_SRC_SHIFT;
-	}
+
 	writel(val, mcde->regs + sync);
 
 	/* Set up pixels per line and lines per frame */
@@ -938,6 +934,13 @@ static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
 
 	drm_crtc_vblank_on(crtc);
 
+	if (mcde->video_mode)
+		/*
+		 * Keep FIFO permanently enabled in video mode,
+		 * otherwise MCDE will stop feeding data to the panel.
+		 */
+		mcde_enable_fifo(mcde, MCDE_FIFO_A);
+
 	dev_info(drm->dev, "MCDE display is enabled\n");
 }
 
@@ -1047,8 +1050,9 @@ static void mcde_display_update(struct drm_simple_display_pipe *pipe,
 	 */
 	if (fb) {
 		mcde_set_extsrc(mcde, drm_fb_cma_get_gem_addr(fb, pstate, 0));
-		/* Send a single frame using software sync */
-		mcde_display_send_one_frame(mcde);
+		if (!mcde->video_mode)
+			/* Send a single frame using software sync */
+			mcde_display_send_one_frame(mcde);
 		dev_info_once(mcde->dev, "sent first display update\n");
 	} else {
 		/*
diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
index dab4db021231..80edd6628979 100644
--- a/drivers/gpu/drm/mcde/mcde_drm.h
+++ b/drivers/gpu/drm/mcde/mcde_drm.h
@@ -19,6 +19,7 @@ struct mcde {
 	struct mipi_dsi_device *mdsi;
 	s16 stride;
 	bool te_sync;
+	bool video_mode;
 	bool oneshot_mode;
 	unsigned int flow_active;
 	spinlock_t flow_lock; /* Locks the channel flow control */
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 0ccd3b0308c2..9008ddcfc528 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -331,8 +331,6 @@ static int mcde_probe(struct platform_device *pdev)
 	drm->dev_private = mcde;
 	platform_set_drvdata(pdev, drm);
 
-	/* Enable use of the TE signal and interrupt */
-	mcde->te_sync = true;
 	/* Enable continuous updates: this is what Linux' framebuffer expects */
 	mcde->oneshot_mode = false;
 	drm->dev_private = mcde;
diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index d6214d3c8b33..ffd2e0b64628 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -130,6 +130,15 @@ bool mcde_dsi_irq(struct mipi_dsi_device *mdsi)
 	return te_received;
 }
 
+static void mcde_dsi_attach_to_mcde(struct mcde_dsi *d)
+{
+	d->mcde->mdsi = d->mdsi;
+
+	d->mcde->video_mode = !!(d->mdsi->mode_flags & MIPI_DSI_MODE_VIDEO);
+	/* Enable use of the TE signal for all command mode panels */
+	d->mcde->te_sync = !d->mcde->video_mode;
+}
+
 static int mcde_dsi_host_attach(struct mipi_dsi_host *host,
 				struct mipi_dsi_device *mdsi)
 {
@@ -148,7 +157,7 @@ static int mcde_dsi_host_attach(struct mipi_dsi_host *host,
 
 	d->mdsi = mdsi;
 	if (d->mcde)
-		d->mcde->mdsi = mdsi;
+		mcde_dsi_attach_to_mcde(d);
 
 	return 0;
 }
@@ -901,7 +910,7 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 	d->mcde = mcde;
 	/* If the display attached before binding, set this up */
 	if (d->mdsi)
-		d->mcde->mdsi = d->mdsi;
+		mcde_dsi_attach_to_mcde(d);
 
 	/* Obtain the clocks */
 	d->hs_clk = devm_clk_get(dev, "hs");
-- 
2.23.0

