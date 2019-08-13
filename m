Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BAEC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C354C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfHMJa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:30:56 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:39160 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfHMJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:30:56 -0400
Received: from ramsan ([84.194.98.4])
        by michel.telenet-ops.be with bizsmtp
        id oZWn2000Y05gfCL06ZWnvJ; Tue, 13 Aug 2019 11:30:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hxT8h-0001Ef-Ny; Tue, 13 Aug 2019 11:30:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hxT8h-0001Iz-KD; Tue, 13 Aug 2019 11:30:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/bridge: dumb-vga-dac: Fix dereferencing -ENODEV DDC channel
Date:   Tue, 13 Aug 2019 11:30:46 +0200
Message-Id: <20190813093046.4976-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the VGA connector has no DDC channel, an error pointer will be
dereferenced, e.g. on Salvator-XS:

    Unable to handle kernel NULL pointer dereference at virtual address 000000000000017d
    ...
    Call trace:
     sysfs_do_create_link_sd.isra.0+0x40/0x108
     sysfs_create_link+0x20/0x40
     drm_sysfs_connector_add+0xa8/0xc8
     drm_connector_register.part.3+0x54/0xb0
     drm_connector_register_all+0xb0/0xd0
     drm_modeset_register_all+0x54/0x88
     drm_dev_register+0x18c/0x1d8
     rcar_du_probe+0xe4/0x150
     ...

This happens because vga->ddc either contains a valid DDC channel
pointer, or -ENODEV, and drm_connector_init_with_ddc() expects a valid
DDC channel pointer, or NULL.

Fix this by resetting vga->ddc to NULL in case of -ENODEV, and replacing
the existing error checks by non-NULL checks.
This is similar to what the HDMI connector driver does.

Fixes: a4f9087e85de141e ("drm/bridge: dumb-vga-dac: Provide ddc symlink in connector sysfs directory")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
An alternative would be to check if vga->ddc contains an error pointer,
and calling drm_connector_init() instead of
drm_connector_init_with_ddc(), like before.
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 8ef6539ae78a6eb3..7aa789c358829b05 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -42,7 +42,7 @@ static int dumb_vga_get_modes(struct drm_connector *connector)
 	struct edid *edid;
 	int ret;
 
-	if (IS_ERR(vga->ddc))
+	if (!vga->ddc)
 		goto fallback;
 
 	edid = drm_get_edid(connector, vga->ddc);
@@ -84,7 +84,7 @@ dumb_vga_connector_detect(struct drm_connector *connector, bool force)
 	 * wire the DDC pins, or the I2C bus might not be working at
 	 * all.
 	 */
-	if (!IS_ERR(vga->ddc) && drm_probe_ddc(vga->ddc))
+	if (vga->ddc && drm_probe_ddc(vga->ddc))
 		return connector_status_connected;
 
 	return connector_status_unknown;
@@ -197,6 +197,7 @@ static int dumb_vga_probe(struct platform_device *pdev)
 		if (PTR_ERR(vga->ddc) == -ENODEV) {
 			dev_dbg(&pdev->dev,
 				"No i2c bus specified. Disabling EDID readout\n");
+			vga->ddc = NULL;
 		} else {
 			dev_err(&pdev->dev, "Couldn't retrieve i2c bus\n");
 			return PTR_ERR(vga->ddc);
@@ -218,7 +219,7 @@ static int dumb_vga_remove(struct platform_device *pdev)
 
 	drm_bridge_remove(&vga->bridge);
 
-	if (!IS_ERR(vga->ddc))
+	if (vga->ddc)
 		i2c_put_adapter(vga->ddc);
 
 	return 0;
-- 
2.17.1

