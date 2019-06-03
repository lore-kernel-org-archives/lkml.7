Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166CEC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D606C2791F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="NVRF1jRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfFCP00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:26:26 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50356 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfFCP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559575583; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=HE4CQPY/zjM71d5YcrWnITVnnDDo1P+pXVsHmG+Q88g=;
        b=NVRF1jROkqVnmc5j86acG8s6j6Skd1JiciZ3tvJqM4lFS9EEo22F3D4zHJ8NUUz+ESg8/n
        0ZukzBeFUYugLS8cq2KlIOhuIwSGOh7s9XXDBsES2KjEjA2gaw2fik+vmNMme7k2hRjJft
        pXB5W+QLoqeYswOVmuMt/0YnIk2fdXM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/2] dt-bindings: display: Add King Display KD035G6-54NT panel documentation
Date:   Mon,  3 Jun 2019 17:25:54 +0200
Message-Id: <20190603152555.23527-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KD035G6-54NT is a 3.5" 320x240 24-bit TFT LCD panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: - Add an address to the panel node
    	- Add information about SPI properties
    	- Add information about the 'port' sub-node

 .../panel/kingdisplay,kd035g6-54nt.txt        | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt

diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
new file mode 100644
index 000000000000..fa9596082e44
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
@@ -0,0 +1,42 @@
+King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
+
+Required properties:
+- compatible: should be "kingdisplay,kd035g6-54nt"
+- power-supply: See panel-common.txt
+- reset-gpios: See panel-common.txt
+
+Optional properties:
+- backlight: see panel-common.txt
+
+The generic bindings for the SPI slaves documented in [1] also apply.
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in [2]. This
+node should describe panel's video bus.
+
+[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
+[2]: Documentation/devicetree/bindings/graph.txt
+
+Example:
+
+&spi {
+	panel@0 {
+		compatible = "kingdisplay,kd035g6-54nt";
+		reg = <0>;
+
+		spi-max-frequency = <3125000>;
+		spi-3wire;
+		spi-cs-high;
+
+		reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+		backlight = <&backlight>;
+		power-supply = <&ldo6>;
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&panel_output>;
+			};
+		};
+	};
+};
-- 
2.21.0.593.g511ec345e18

