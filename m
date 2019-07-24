Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA14C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD11229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfGXPwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:52:40 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:33598 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfGXPwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:52:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 23793FB04;
        Wed, 24 Jul 2019 17:52:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id peRBQktrt7Wu; Wed, 24 Jul 2019 17:52:29 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0958343419; Wed, 24 Jul 2019 17:52:26 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH 2/3] dt-bindings: display/bridge: Add binding for IMX NWL mipi dsi host controller
Date:   Wed, 24 Jul 2019 17:52:25 +0200
Message-Id: <70a5c6617936a4a095e7608b96e3f9fae5ddfbb1.1563983037.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1563983037.git.agx@sigxcpu.org>
References: <cover.1563983037.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../bindings/display/bridge/imx-nwl-dsi.txt   | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt b/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
new file mode 100644
index 000000000000..288fdb726d5a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
@@ -0,0 +1,89 @@
+Northwest Logic MIPI-DSI on imx SoCs
+=====================================
+
+NWL MIPI-DSI host controller found on i.MX8 platforms. This is a
+dsi bridge for the for the NWL MIPI-DSI host.
+
+Required properties:
+- compatible: 		"fsl,<chip>-nwl-dsi"
+	The following strings are expected:
+			"fsl,imx8mq-nwl-dsi"
+- reg: 			the register range of the MIPI-DSI controller
+- interrupts: 		the interrupt number for this module
+- clock, clock-names: 	phandles to the MIPI-DSI clocks
+	The following clocks are expected on all platforms:
+		"core"    - DSI core clock
+		"tx_esc"  - TX_ESC clock (used in escape mode)
+		"rx_esc"  - RX_ESC clock (used in escape mode)
+		"phy_ref" - PHY_REF clock. Clock is managed by the phy. Only
+                            used to read the clock rate.
+- assigned-clocks:	phandles to clocks that require initial configuration
+- assigned-clock-rates:	rates of the clocks that require initial configuration
+	The following clocks need to have an initial configuration:
+	"tx_esc" (20 MHz) and "rx_esc" (80 Mhz).
+- phys: 		phandle to the phy module representing the DPHY
+			inside the MIPI-DSI IP block
+- phy-names: 		should be "dphy"
+
+Optional properties:
+- power-domains 	phandle to the power domain
+- src			phandle to the system reset controller (required on
+			i.MX8MQ)
+- mux-sel		phandle to the MUX register set (required on i.MX8MQ)
+- assigned-clock-parents phandles to parent clocks that needs to be assigned as
+			parents to clocks defined in assigned-clocks
+
+Example:
+	mipi_dsi: mipi_dsi@30a00000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,imx8mq-nwl-dsi";
+		reg = <0x30A00000 0x300>;
+		clocks = <&clk IMX8MQ_CLK_DSI_CORE>,
+			 <&clk IMX8MQ_CLK_DSI_AHB>,
+			 <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
+			 <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+		clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
+		assigned-clocks = <&clk IMX8MQ_CLK_DSI_AHB>,
+				  <&clk IMX8MQ_CLK_DSI_CORE>,
+				  <&clk IMX8MQ_CLK_DSI_IPG_DIV>;
+		assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>,
+					 <&clk IMX8MQ_SYS1_PLL_266M>;
+		assigned-clock-rates = <80000000>,
+				       <266000000>,
+				       <20000000>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&pgc_mipi>;
+		src = <&src>;
+		mux-sel = <&iomuxc_gpr>;
+		phys = <&dphy>;
+		phy-names = "dphy";
+		status = "okay";
+
+		panel@0 {
+			compatible = "...";
+			port {
+			     panel_in: endpoint {
+				       remote-endpoint = <&mipi_dsi_out>;
+			     };
+			};
+		};
+
+		ports {
+		      #address-cells = <1>;
+		      #size-cells = <0>;
+
+		      port@0 {
+			     reg = <0>;
+			     mipi_dsi_in: endpoint {
+					  remote-endpoint = <&dcss_disp0_mipi_dsi>;
+			     };
+		      };
+		      port@1 {
+			     reg = <1>;
+			     mipi_dsi_out: endpoint {
+					   remote-endpoint = <&panel_in>;
+			     };
+		      };
+		};
+	};
-- 
2.20.1

