Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B946C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33BC21655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFUPjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:39:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48358 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfFUPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:38:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 001852009FD;
        Fri, 21 Jun 2019 17:38:56 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E39D8200071;
        Fri, 21 Jun 2019 17:38:56 +0200 (CEST)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7482B20629;
        Fri, 21 Jun 2019 17:38:56 +0200 (CEST)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        alexandru.marginean@nxp.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 5/6] dt-bindings: net: Add DT bindings for Microsemi Felix Switch
Date:   Fri, 21 Jun 2019 18:38:51 +0300
Message-Id: <1561131532-14860-6-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561131532-14860-1-git-send-email-claudiu.manoil@nxp.com>
References: <1561131532-14860-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT bindings for the Felix ethernet switch, consisting of the
VSC9959 switch core integrated as a PCIe endpoint device.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 .../devicetree/bindings/net/mscc-felix.txt    | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mscc-felix.txt

diff --git a/Documentation/devicetree/bindings/net/mscc-felix.txt b/Documentation/devicetree/bindings/net/mscc-felix.txt
new file mode 100644
index 000000000000..c91c63ba524c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-felix.txt
@@ -0,0 +1,77 @@
+Microsemi Felix network Switch
+==============================
+
+The Felix switch device is the Microsemi VSC9959 gigabit ethernet
+switch core integrated as a PCIe endpoint device.
+
+Required properties:
+- compatible	: Should be "mscc,felix-switch"
+- reg		: Specifies PCIe Device Number and Function
+		  Number of the integrated endpoint device,
+		  according to parent node bindings.
+- ethernet-ports: A container of child nodes representing
+		  switch ports.
+
+"ethernet-ports" container has the following required properties:
+- #address-cells: Must be 1
+- #size-cells	: Must be 0
+
+A list of child nodes representing switch ports is expected.
+Each child port node must have the following mandatory property:
+- reg		: port id (address) in the switch (0..N-1)
+
+Port nodes may also contain the following optional standardised
+properties, described in corresponding binding documents:
+
+- phy-handle	: Phandle to a PHY on a MDIO bus. See
+		  Documentation/devicetree/bindings/net/ethernet.txt
+
+or,
+- fixed-link	: "fixed-link" node, for internal ports or external
+		  fixed-link connections. See
+		  Documentation/devicetree/bindings/net/fixed-link.txt
+
+Example:
+
+	switch@0,5 {
+		compatible = "mscc,felix-switch"
+		reg = <0x000500 0 0 0 0>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* external ports */
+			switch_port0: port@0 {
+				reg = <0>;
+				phy-handle = <&phy0>;
+			};
+			switch_port1: port@1 {
+				reg = <1>;
+				phy-handle = <&phy1>;
+			};
+			switch_port2: port@2 {
+				reg = <2>;
+				phy-handle = <&phy2>;
+			};
+			switch_port3: port@3 {
+				reg = <3>;
+				phy-handle = <&phy3>;
+			};
+			/* internal to-cpu ports */
+			port@4 {
+				reg = <4>;
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+			port@5 {
+				reg = <5>;
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
-- 
2.17.1

