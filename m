Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0620C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D58206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pd7W1rH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfDZAxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:53:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43474 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730007AbfDZAxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556239999; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=xk9yOjcMwGU3tfqxXUFP4ZOgKkcN/lKAiztLyr/p1f8=;
        b=pd7W1rH5gZm5dxfCUBwfuFhyUkb2uz2O67xmHuqB+0/4yumMaSKANAGTy5hcLQGl9WE1wa
        ko5RQeo8Vtwnx+pGIClIjGAiACA82Oxp5d7sQFI2FXOkVS1P8DhXaSLcYAvvI/xBgr3Law
        Y8d+GRJjky3/W/yR7+chDYONAQjj8jo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v4 1/2] dt-bindings: Add doc for the Ingenic JZ47xx LCD controller driver
Date:   Fri, 26 Apr 2019 02:53:07 +0200
Message-Id: <20190426005308.27039-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the devicetree bindings of the LCD controller present in
the JZ47xx family of SoCs from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: Remove ingenic,panel property.
    
    v3: - Rename compatible strings from ingenic,jz47XX-drm to ingenic,jz47XX-lcd
        - The ingenic,lcd-mode property is now read from the panel node instead
    	  of from the driver node
    
    v4: Remove ingenic,lcd-mode property completely.

 .../bindings/display/ingenic,lcd.txt          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,lcd.txt

diff --git a/Documentation/devicetree/bindings/display/ingenic,lcd.txt b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
new file mode 100644
index 000000000000..7b536c8c6dde
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
@@ -0,0 +1,44 @@
+Ingenic JZ47xx LCD driver
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
+Example:
+
+panel {
+	compatible = "sharp,ls020b1dd01d";
+
+	backlight = <&backlight>;
+	power-supply = <&vcc>;
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
2.21.0.593.g511ec345e18

