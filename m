Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7AC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3D820854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfD3Sw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:52:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37796 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfD3SwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:52:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1132DAD3A;
        Tue, 30 Apr 2019 18:52:24 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: net: wiznet: add w5x00 support
Date:   Tue, 30 Apr 2019 20:52:14 +0200
Message-Id: <20190430185215.21685-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430185215.21685-1-nsaenzjulienne@suse.de>
References: <20190430185215.21685-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Wiznet's w5x00 series of SPI interfaced Ethernet chips.

Based on the bindings for microchip,enc28j60.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../devicetree/bindings/net/wiznet,w5x00.txt  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wiznet,w5x00.txt

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
new file mode 100644
index 000000000000..2cbedefb1607
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
@@ -0,0 +1,48 @@
+* Wiznet w5x00
+
+This is a standalone 10/100 MBit Ethernet controller with SPI interface.
+
+For each device connected to a SPI bus, define a child node within
+the SPI master node.
+
+Required properties:
+- compatible: Should be "wiznet,w5100", "wiznet,w5200" or "wiznet,w5500"
+- reg: Specify the SPI chip select the chip is wired to.
+- interrupts: Specify the interrupt index within the interrupt controller (referred
+              to above in interrupt-parent) and interrupt type. w5x00 natively
+              generates falling edge interrupts, however, additional board logic
+              might invert the signal.
+- pinctrl-names: List of assigned state names, see pinctrl binding documentation.
+- pinctrl-0: List of phandles to configure the GPIO pin used as interrupt line,
+             see also generic and your platform specific pinctrl binding
+             documentation.
+
+Optional properties:
+- spi-max-frequency: Maximum frequency of the SPI bus when accessing the w5500.
+  According to the w5500 datasheet, the chip allows a maximum of 80 MHz, however,
+  board designs may need to limit this value.
+- local-mac-address: See ethernet.txt in the same directory.
+
+
+Example (for Raspberry Pi with pin control stuff for GPIO irq):
+
+&spi {
+	eth1: w5500@0 {
+		compatible = "wiznet,w5500";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&eth1_pins>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <30000000>;
+	};
+};
+
+&gpio {
+	eth1_pins: eth1_pins {
+		brcm,pins = <25>;
+		brcm,function = <0>; /* in */
+		brcm,pull = <0>; /* none */
+	};
+};
+
-- 
2.21.0

