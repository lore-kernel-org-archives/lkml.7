Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74292C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A62C271ED
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="trPL41iT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfFCPXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:23:55 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48054 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfFCPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559575431; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=rEM7uFRBofy0jSEvYX92cgcANNvP4RB/CXYuPIY+nu4=;
        b=trPL41iTv6Ea33wmCa3q4NAYuQyVVrKTE2r1DIcnYeqd6biw5yZhFizqumpF8moEeaxuKk
        RkehIoWBRSkrmnpc4+bvCMd4ZxqGU61kvYBvV5hNbZviLpEqP1JAvdWkM70d9cwz5hUXzy
        RSBkCNDmvZ+YI3eztwhi1df9hcAMU9A=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v5 1/2] dt-bindings: Add doc for the Ingenic JZ47xx LCD controller driver
Date:   Mon,  3 Jun 2019 17:23:30 +0200
Message-Id: <20190603152331.23160-1-paul@crapouillou.net>
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
    
    v5: No change

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

