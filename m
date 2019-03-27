Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BFCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1391D2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfC0IUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:20:14 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:51162 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731571AbfC0IUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:20:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id AD51EFB02;
        Wed, 27 Mar 2019 09:20:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5qRjwJHkDXJQ; Wed, 27 Mar 2019 09:20:05 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id EE04842B11; Wed, 27 Mar 2019 09:20:01 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH RESEND v7 2/3] dt-bindings: phy: Add documentation for mixel dphy
Date:   Wed, 27 Mar 2019 09:20:00 +0100
Message-Id: <3319783f60fedd7f0029dd60a51c76a75003fe05.1553674604.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1553674604.git.agx@sigxcpu.org>
References: <cover.1553674604.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MIXEL DPHY IP as found in the NXP's i.MX8MQ.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../bindings/phy/mixel,mipi-dsi-phy.txt       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
new file mode 100644
index 000000000000..d3646580412a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
@@ -0,0 +1,29 @@
+Mixel DSI PHY for i.MX8
+
+The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
+MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
+electrical signals for DSI.
+
+Required properties:
+- compatible: Must be:
+  - "mixel,imx8mq-mipi-dphy"
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Must contain the following entries:
+  - "phy_ref": phandle and specifier referring to the DPHY ref clock
+- reg: the register range of the PHY controller
+- #phy-cells: number of cells in PHY, as defined in
+  Documentation/devicetree/bindings/phy/phy-bindings.txt
+  this must be <0>
+
+Optional properties:
+- power-domains: phandle to power domain
+
+Example:
+	mipi_dphy: mipi_dphy@30A0030 {
+		compatible = "mixel,imx8mq-mipi-dphy";
+		clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
+		clock-names = "phy_ref";
+		reg = <0x30A00300 0x100>;
+		power-domains = <&pd_mipi0>;
+		#phy-cells = <0>;
+        };
-- 
2.20.1

