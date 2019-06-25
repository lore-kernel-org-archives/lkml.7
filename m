Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F300CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C898320665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfFYHLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:11:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37438 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbfFYHLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:11:45 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C219E1A0F30;
        Tue, 25 Jun 2019 09:11:43 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BB8A11A0F67;
        Tue, 25 Jun 2019 09:11:43 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 45494205E5;
        Tue, 25 Jun 2019 09:11:43 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: display: panel: Add support for Raydium RM67191 panel
Date:   Tue, 25 Jun 2019 10:11:13 +0300
Message-Id: <1561446674-25084-2-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561446674-25084-1-git-send-email-robert.chiras@nxp.com>
References: <1561446674-25084-1-git-send-email-robert.chiras@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings documentation for Raydium RM67191 DSI panel.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/display/panel/raydium,rm67191.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
new file mode 100644
index 0000000..1042469
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
@@ -0,0 +1,41 @@
+Raydium RM67171 OLED LCD panel with MIPI-DSI protocol
+
+Required properties:
+- compatible: 		"raydium,rm67191"
+- reg:			virtual channel for MIPI-DSI protocol
+			must be <0>
+- dsi-lanes:		number of DSI lanes to be used
+			must be <3> or <4>
+- port: 		input port node with endpoint definition as
+			defined in Documentation/devicetree/bindings/graph.txt;
+			the input port should be connected to a MIPI-DSI device
+			driver
+
+Optional properties:
+- reset-gpios:		a GPIO spec for the RST_B GPIO pin
+- v3p3-supply:		phandle to 3.3V regulator that powers the VDD_3V3 pin
+- v1p8-supply:		phandle to 1.8V regulator that powers the VDD_1V8 pin
+- width-mm:		see panel-common.txt
+- height-mm:		see panel-common.txt
+- video-mode:		0 - burst-mode
+			1 - non-burst with sync event
+			2 - non-burst with sync pulse
+
+Example:
+
+	panel@0 {
+		compatible = "raydium,rm67191";
+		reg = <0>;
+		pinctrl-0 = <&pinctrl_mipi_dsi_0_1_en>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		dsi-lanes = <4>;
+		width-mm = <68>;
+		height-mm = <121>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mipi_out>;
+			};
+		};
+	};
-- 
2.7.4

