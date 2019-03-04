Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83240C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EFA2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="ZrYFiFHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfCDNGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:06:35 -0500
Received: from plaes.org ([188.166.43.21]:51628 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCDNGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:06:34 -0500
Received: from localhost (unknown [193.40.103.250])
        by plaes.org (Postfix) with ESMTPSA id EDBC840960;
        Mon,  4 Mar 2019 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1551704792; bh=F4Cj8QjZPj4Qdf1avfLjzBR1P6PcKWxJtjJWPwy7J5k=;
        h=From:To:Cc:Subject:Date:From;
        b=ZrYFiFHaepmU/we/IfrDK4OqYLCwm8X+GIBaoZ+S98j3ixqagi0dNxwUg4AepEA5G
         LqRTmBtdnwchPUaXD8s+KpVrEcdgtb66zUBa4a1sOUZ4INXgzet4K3CVUxXPKZroXr
         NwnSmIO9w5y7xqwv6MHOHO55d1ykjcNADUQe3Zg2D6OG0yW300u3GHNa1fo4cMhClb
         bfSVBhgk3aqrBzXankYIZCTRP4EV8GRbJzLva8eeY4CTgmWYXpmzh3VnSkdXkpW5ZC
         v9gurgJRoiY3LRe0r1cStaZxxFWnYY2UzyTve3c/zp2sHKhTsbYhy4JcGDm5Q9/K5n
         TtVRD0kFYLeyA==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Priit Laes <priit.laes@paf.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [RESEND PATCH] drm/sun4i: hdmi: Improve compatibility with hpd-less HDMI displays
Date:   Mon,  4 Mar 2019 15:06:16 +0200
Message-Id: <20190304130616.27525-1-plaes@plaes.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Priit Laes <priit.laes@paf.com>

Even though HDMI connector features hotplug detect pin (HPD), there
are older devices which do not support it. For these devices fall
back to additional check on I2C bus to probe for EDID data.

One known example is HDMI/DVI display with following edid:

$ xxd -p display.edid
00ffffffffffff0005a1e00301000000150f0103800f05780a0f6ea05748
9a2610474f200000010101010101010101010101010101012a08804520e0
0b1020004000953600000018000000fd0034441a2403000a202020202020
0000001000310a20202020202020202020200000001000002a4030701300
782d1100001e006b

$ edid-decode display.edid
EDID version: 1.3
Manufacturer: AMA Model 3e0 Serial Number 1
Digital display
Maximum image size: 15 cm x 5 cm
Gamma: 2.20
RGB color display
First detailed timing is preferred timing
Display x,y Chromaticity:
  Red:   0.6250, 0.3398
  Green: 0.2841, 0.6044
  Blue:  0.1494, 0.0644
  White: 0.2802, 0.3105

Established timings supported:
  640x480@60Hz 4:3 HorFreq: 31469 Hz Clock: 25.175 MHz
Standard timings supported:
Detailed mode: Clock 20.900 MHz, 149 mm x 54 mm
               640  672  672  709 hborder 0
               480  484  484  491 vborder 0
               -hsync -vsync
               VertFreq: 60 Hz, HorFreq: 29478 Hz
Monitor ranges (GTF): 52-68Hz V, 26-36kHz H, max dotclock 30MHz
Dummy block
Dummy block
Checksum: 0x6b (valid)

Now, current implementation is still flawed, as HDMI uses the
HPD signal to indicate that the source should re-read the EDID
due to change in device capabilities. With current HPD polling
implementation we would most certainly miss those notifications
as one can try just swapping two HDMI monitors really fast.

Proper fix would be skipping the HPD pin detection and relying
on just EDID fetching and acting on its changes.

CC: Russell King <linux@armlinux.org.uk>
Signed-off-by: Priit Laes <priit.laes@paf.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 416da5376701..44d5d50b7ada 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -242,14 +242,18 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
 	unsigned long reg;
 
-	if (readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
-			       reg & SUN4I_HDMI_HPD_HIGH,
-			       0, 500000)) {
-		cec_phys_addr_invalidate(hdmi->cec_adap);
-		return connector_status_disconnected;
-	}
-
-	return connector_status_connected;
+	/* TODO: Drop HPD polling and instead keep track of EDID changes */
+	if (!readl_poll_timeout(hdmi->base + SUN4I_HDMI_HPD_REG, reg,
+				reg & SUN4I_HDMI_HPD_HIGH,
+				0, 500000))
+		return connector_status_connected;
+
+	/* Fall back to EDID in case display does not support HPD */
+	if (!IS_ERR(hdmi->i2c) && drm_probe_ddc(hdmi->i2c))
+		return connector_status_connected;
+
+	cec_phys_addr_invalidate(hdmi->cec_adap);
+	return connector_status_disconnected;
 }
 
 static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
-- 
2.11.0

