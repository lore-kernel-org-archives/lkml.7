Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A73C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9016721882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="e3UVDyBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbfKFRBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:01:12 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:25683 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbfKFRBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573059665;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=uZcQk++YEkD2ap+7a/P9KdfqpT2ypee67VJ6/UFHXeA=;
        b=e3UVDyBmq66yy/OZMAN/KPIIIvY2IwTuzsv0GwVWt6ie7MvKI7vYAEDXuiOJ9ZG+Qw
        QDKeol282wSsWyr04ek2FyS9mm7wdVia55UhAHey7/aGhWSkEUaxUvxfiNJuPmNuHcFl
        b37JwrtbYfvt4g/pWd6rBZdOxL5eBbK8LwB8MhX9II7IPKjAVqPUJUtKa/L4Z4vz/OBZ
        BP+zAGCL72N+Ad6CYP4O/WOUFxL44jfoZQDC1oLtOvDGiaWdcx0lMCIjMrGp+EFBg+mN
        2s90pkm80xXcsHGQolyyPpcMKVRN8KD0xhRXapy9yuWAJjbeeaSZ+bQNzGRKtXLoxbPU
        rfQA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6H15hLv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:01:05 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 5/7] drm/mcde: dsi: Fix duplicated DSI connector
Date:   Wed,  6 Nov 2019 17:58:33 +0100
Message-Id: <20191106165835.2863-6-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106165835.2863-1-stephan@gerhold.net>
References: <20191106165835.2863-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a (single) DSI display with MCDE currently results in
two "connected" connectors:

  Connector: DSI-1
          id             : 34
          encoder id     : 0
          conn           : connected
          size           : 0x0 (mm)
          count_modes    : 0
          count_props    : 5
          props          : 1 2 5 6 4
          count_encoders : 1
          encoders       : 33
  Connector: DSI-2
          id             : 35
          encoder id     : 33
          conn           : connected
          size           : 53x89 (mm)
          count_modes    : 1
          count_props    : 5
          props          : 1 2 5 6 4
          count_encoders : 1
          encoders       : 33
    Mode: "480x800" 480x800 60

Although both show up as connected, the first one does not have
any size and no available modes. This confuses userspace tools
(e.g. kmscube) who look for available modes for the first connector.

The reason for the duplicated connector is that mcde_dsi.c and the
DRM panel bridge helper both set up a DSI connector, with more or less
the same code. The connector set up by the DRM panel bridge is the
one that is correctly set up in the example above.

Therefore we can just remove the connector setup from mcde_dsi.c
and let the DRM core handle all the hard work.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/gpu/drm/mcde/mcde_dsi.c | 52 +--------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index 4710f23b2966..df963e078c35 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -39,7 +39,6 @@ struct mcde_dsi {
 	struct device *dev;
 	struct mcde *mcde;
 	struct drm_bridge bridge;
-	struct drm_connector connector;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge_out;
 	struct mipi_dsi_host dsi_host;
@@ -64,11 +63,6 @@ static inline struct mcde_dsi *host_to_mcde_dsi(struct mipi_dsi_host *h)
 	return container_of(h, struct mcde_dsi, dsi_host);
 }
 
-static inline struct mcde_dsi *connector_to_mcde_dsi(struct drm_connector *c)
-{
-	return container_of(c, struct mcde_dsi, connector);
-}
-
 bool mcde_dsi_irq(struct mipi_dsi_device *mdsi)
 {
 	struct mcde_dsi *d;
@@ -843,67 +837,23 @@ static void mcde_dsi_bridge_disable(struct drm_bridge *bridge)
 	clk_disable_unprepare(d->lp_clk);
 }
 
-/*
- * This connector needs no special handling, just use the default
- * helpers for everything. It's pretty dummy.
- */
-static const struct drm_connector_funcs mcde_dsi_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-};
-
-static int mcde_dsi_get_modes(struct drm_connector *connector)
-{
-	struct mcde_dsi *d = connector_to_mcde_dsi(connector);
-
-	/* Just pass the question to the panel */
-	if (d->panel)
-		return drm_panel_get_modes(d->panel);
-
-	/* TODO: deal with bridges */
-
-	return 0;
-}
-
-static const struct drm_connector_helper_funcs
-mcde_dsi_connector_helper_funcs = {
-	.get_modes = mcde_dsi_get_modes,
-};
-
 static int mcde_dsi_bridge_attach(struct drm_bridge *bridge)
 {
 	struct mcde_dsi *d = bridge_to_mcde_dsi(bridge);
 	struct drm_device *drm = bridge->dev;
 	int ret;
 
-	drm_connector_helper_add(&d->connector,
-				 &mcde_dsi_connector_helper_funcs);
-
 	if (!drm_core_check_feature(drm, DRIVER_ATOMIC)) {
 		dev_err(d->dev, "we need atomic updates\n");
 		return -ENOTSUPP;
 	}
 
-	ret = drm_connector_init(drm, &d->connector,
-				 &mcde_dsi_connector_funcs,
-				 DRM_MODE_CONNECTOR_DSI);
-	if (ret) {
-		dev_err(d->dev, "failed to initialize DSI bridge connector\n");
-		return ret;
-	}
-	d->connector.polled = DRM_CONNECTOR_POLL_CONNECT;
-	/* The encoder in the bridge attached to the DSI bridge */
-	drm_connector_attach_encoder(&d->connector, bridge->encoder);
-	/* Then we attach the DSI bridge to the output (panel etc) bridge */
+	/* Attach the DSI bridge to the output (panel etc) bridge */
 	ret = drm_bridge_attach(bridge->encoder, d->bridge_out, bridge);
 	if (ret) {
 		dev_err(d->dev, "failed to attach the DSI bridge\n");
 		return ret;
 	}
-	d->connector.status = connector_status_connected;
 
 	return 0;
 }
-- 
2.23.0

