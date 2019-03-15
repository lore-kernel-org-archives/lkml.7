Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0542C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66189218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TkFIe20o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfCORHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:07:12 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:57706 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfCORHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552669629; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=qsaKtIob8bQ8OAPomflURD1cZZ8MG8ZYAqMs1vCldos=;
        b=TkFIe20odG9TNWCdcMdE6X19Zbcxfx4vdF3eHgPYVtGSw5eWMXfJHz/fK5OJQgMgEbjOI+
        7J+KtMO083opxt02GRldPo9RDqHanxF3p3NCmABIcvRYJGDwwSFMOKu68Ng5R4LbgScUz+
        qmGGwC1dmk1WZhqb8Rjy1023u+gX8lw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] dt-bindings: Add doc for the ingenic-drm driver
Date:   Fri, 15 Mar 2019 18:06:59 +0100
Message-Id: <20190315170701.29670-1-paul@crapouillou.net>
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

 .../devicetree/bindings/display/ingenic,drm.txt    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ingenic,drm.txt

diff --git a/Documentation/devicetree/bindings/display/ingenic,drm.txt b/Documentation/devicetree/bindings/display/ingenic,drm.txt
new file mode 100644
index 000000000000..f57a4ae0f7ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ingenic,drm.txt
@@ -0,0 +1,29 @@
+Ingenic JZ47xx DRM driver
+
+Required properties:
+- compatible: one of:
+  * ingenic,jz4740-drm
+  * ingenic,jz4725b-drm
+- reg: LCD registers location and length
+- clocks: LCD pixclock and device clock specifiers.
+	   The device clock is only required on the JZ4740.
+- clock-names: "lcd_pclk" and "lcd"
+- interrupts: Specifies the interrupt line the LCD controller is connected to.
+
+Optional properties:
+- ingenic,lcd-mode: LCD mode to use with the display panel.
+		    See <dt-bindings/display/ingenic,drm.h> for all the
+		    possible values.
+
+Example:
+
+lcd: lcd-controller@13050000 {
+	compatible = "ingenic,jz4725b-drm";
+	reg = <0x13050000 0x1000>;
+
+	interrupt-parent = <&intc>;
+	interrupts = <31>;
+
+	clocks = <&cgu JZ4725B_CLK_LCD>;
+	clock-names = "lcd";
+};
-- 
2.11.0

