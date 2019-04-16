Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D63C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAED20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="HsgUrLum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfDPK1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:27:05 -0400
Received: from chill.innovation.ch ([216.218.245.220]:43104 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfDPK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:27:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 03664640142;
        Tue, 16 Apr 2019 03:27:03 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lwFPgy72jBJI; Tue, 16 Apr 2019 03:27:01 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch A00F664012F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555410421;
        bh=Gv1xgHW+RE56+HzqhEhxQY+ro1F8Hy2d5+/lEBcnuM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsgUrLumz9vAlNl70+mcgOWIl5Ri33Ggk8byBfI/PdQRpHludX5vyLcCUvwaip4Km
         f/jPoLfK4iXil2WogUb6yMs1WG/IrdeEpNxpgjVa3GGTV8PTFAG+dPauMvM+S7qar4
         fTDG9+SWjYf5OTmLTxWFGYt8hIIr1H9H7tuRYrwmRsFctfXtAWnTDBTaY1BF7L5Hh6
         DOj0xR9B5HrO1r1xyT/mTfw4yrBtTVLl2Z+hjelxXdlLEQ29/6TSQ0VyNQtIVuhVbN
         rXxyGHtpPpxlj1IzYu56MOG6kJ/+PBuo6zBhqbd6SdVeR8TGNbhROZnorUGbNOmFZq
         sroOf8g2HFOsg==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] drm/bridge: sil_sii8620: make remote control optional.
Date:   Tue, 16 Apr 2019 03:26:46 -0700
Message-Id: <20190416102647.5602-2-ronald@innovation.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416102647.5602-1-ronald@innovation.ch>
References: <20190416102647.5602-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
of RC_CORE) changed the driver to select both RC_CORE and INPUT.
However, this causes problems with other drivers, in particular an input
driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
commit):

  drivers/clk/Kconfig:9:error: recursive dependency detected!
  drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
  drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
  drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
  drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
  drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
  drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
  drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
  drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK

According to the docs and general consensus, select should only be used
for non user-visible symbols, but both RC_CORE and INPUT are
user-visible. Furthermore almost all other references to INPUT
throughout the kernel config are depends, not selects. For this reason
the first part of this change reverts commit d6abe6df706c.

In order to address the original reason for commit d6abe6df706c, namely
that not all boards use the remote controller functionality and hence
should not need have to deal with RC_CORE, the second part of this
change now makes the remote control support in the driver optional and
contingent on RC_CORE being defined. And with this the hard dependency
on INPUT also goes away as that is only needed if RC_CORE is defined
(which in turn already depends on INPUT).

CC: Inki Dae <inki.dae@samsung.com>
CC: Andrzej Hajda <a.hajda@samsung.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/Kconfig       |  3 +--
 drivers/gpu/drm/bridge/sil-sii8620.c | 10 +++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 2fee47b0d50b..9cf07105b73a 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -85,8 +85,7 @@ config DRM_SIL_SII8620
 	depends on OF
 	select DRM_KMS_HELPER
 	imply EXTCON
-	select INPUT
-	select RC_CORE
+	imply RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
 
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index a6e8f4591e63..cff3131aae6c 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -1763,10 +1763,8 @@ static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
 
 	scancode &= MHL_RCP_KEY_ID_MASK;
 
-	if (!ctx->rc_dev) {
-		dev_dbg(ctx->dev, "RCP input device not initialized\n");
+	if (!IS_ENABLED(CONFIG_RC_CORE) || !ctx->rc_dev)
 		return false;
-	}
 
 	if (pressed)
 		rc_keydown(ctx->rc_dev, RC_PROTO_CEC, scancode, 0);
@@ -2103,6 +2101,9 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
 	struct rc_dev *rc_dev;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_RC_CORE))
+		return;
+
 	rc_dev = rc_allocate_device(RC_DRIVER_SCANCODE);
 	if (!rc_dev) {
 		dev_err(ctx->dev, "Failed to allocate RC device\n");
@@ -2217,6 +2218,9 @@ static void sii8620_detach(struct drm_bridge *bridge)
 {
 	struct sii8620 *ctx = bridge_to_sii8620(bridge);
 
+	if (!IS_ENABLED(CONFIG_RC_CORE))
+		return;
+
 	rc_unregister_device(ctx->rc_dev);
 }
 
-- 
2.20.1

