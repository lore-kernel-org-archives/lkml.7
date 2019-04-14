Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6135C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C0521473
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="M3DdPF8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfDNUIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:08:34 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35650 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNUIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555272510; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=lLW8/OLEHvWSCDNtDKW8ODkzAI+4uhciGZEy33h1JNo=;
        b=M3DdPF8tqhTOsiaRw/mCzNcL7KEDmLBGw4X4qnIeU5WmLEULXCBoy4FxDpRWOxJGB24sqD
        lHazFs9Hpg6FIBXWOMFbJhToq04Xofgh0ayuPCA9RYdXxptJ+1Gs+Nv1zz7drH2u1u2esS
        rZS1NX3Yj4kwXq/XQPHWCrlGUr2lyxo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/3] dt-bindings: Add doc for the ingenic-drm driver
Date:   Sun, 14 Apr 2019 22:08:22 +0200
Message-Id: <20190414200824.28348-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the devicetree bindings of the DRM driver for the
JZ47xx family of SoCs from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: Remove ingenic,panel property.
    
    v3: - Rename compatible strings from ingenic,jz47XX-drm to ingenic,jz47XX-lcd
        - The ingenic,lcd-mode property is now read from the panel node instead
    	  of from the driver node

 .../devicetree/bindings/display/ingenic,drm.txt    | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,drm.txt

diff --git a/Documentation/devicetree/bindings/display/ingenic,drm.txt b/Documentation/devicetree/bindings/display/ingenic,drm.txt
new file mode 100644
index 000000000000..9de47db8a515
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic,drm.txt
@@ -0,0 +1,53 @@
+Ingenic JZ47xx DRM driver
+
+Required properties:
+- compatible: one of:
+  * ingenic,jz4740-lcd
+  * ingenic,jz4725b-lcd
+- reg: LCD registers location and length
+- clocks: LCD pixclock and device clock specifiers.
+	   The device clock is only required on the JZ4740.
+- clock-names: "lcd_pclk" and "lcd"
+- interrupts: Specifies the interrupt line the LCD controller is connected to.
+
+Optional properties in the panel mode:
+- ingenic,lcd-mode: LCD mode to use with the display panel.
+		    See <dt-bindings/display/ingenic,drm.h> for all the
+		    possible values.
+
+Example:
+
+#include <dt-bindings/display/ingenic,drm.h>
+
+panel {
+	compatible = "sharp,ls020b1dd01d", "simple-panel";
+
+	backlight = <&backlight>;
+	power-supply = <&vcc>;
+
+	ingenic,lcd-mode = <JZ_LCD_SPECIAL_TFT_2>;
+
+	port {
+		panel_input: endpoint {
+			remote-endpoint = <&panel_output>;
+		};
+	};
+};
+
+
+lcd: lcd-controller@13050000 {
+	compatible = "ingenic,jz4725b-lcd";
+	reg = <0x13050000 0x1000>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <31>;
+
+	clocks = <&cgu JZ4725B_CLK_LCD>;
+	clock-names = "lcd";
+
+	port {
+		panel_output: endpoint {
+			remote-endpoint = <&panel_input>;
+		};
+	};
+};
-- 
2.11.0

