Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EB9C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BE621874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbfHHNPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:15:36 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:40655 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733010AbfHHNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:15:36 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x78DEoSS024396;
        Thu, 8 Aug 2019 16:14:50 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 3ACA862A57; Thu,  8 Aug 2019 16:14:50 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        vigneshr@ti.com, bbrezillon@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 1/2] dt-binding: spi: add NPCM FIU controller
Date:   Thu,  8 Aug 2019 16:14:47 +0300
Message-Id: <20190808131448.349161-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190808131448.349161-1-tmaimon77@gmail.com>
References: <20190808131448.349161-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM Flash Interface Unit(FIU) SPI master controller
using SPI-MEM interface.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/spi/nuvoton,npcm-fiu.txt         | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
new file mode 100644
index 000000000000..ab37aae91d19
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
@@ -0,0 +1,47 @@
+* Nuvoton FLASH Interface Unit (FIU) SPI Controller
+
+NPCM FIU supports single, dual and quad communication interface.
+
+The NPCM7XX supports three FIU modules,
+FIU0 and FIUx supports two chip selects,
+FIU3 support four chip select.
+
+Required properties:
+  - compatible : "nuvoton,npcm750-fiu" for the NPCM7XX BMC
+  - #address-cells : should be 1.
+  - #size-cells : should be 0.
+  - reg : the first contains the register location and length,
+          the second contains the memory mapping address and length
+  - reg-names: Should contain the reg names "control" and "memory"
+  - clocks : phandle of FIU reference clock.
+
+Required properties in case the pins can be muxed:
+  - pinctrl-names : a pinctrl state named "default" must be defined.
+  - pinctrl-0 : phandle referencing pin configuration of the device.
+
+Optional property:
+  - spix-mode: enable spix-mode for an expansion bus to an ASIC or CPLD.
+
+Aliases:
+- All the FIU controller nodes should be represented in the aliases node using
+  the following format 'fiu{n}' where n is a unique number for the alias.
+  In the NPCM7XX BMC:
+  		fiu0 represent fiu 0 controller
+  		fiu1 represent fiu 3 controller
+  		fiu2 represent fiu x controller
+
+Example:
+fiu3: fiu@c00000000 {
+	compatible = "nuvoton,npcm750-fiu";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0xfb000000 0x1000>, <0x80000000 0x10000000>;
+	reg-names = "control", "memory";
+	clocks = <&clk NPCM7XX_CLK_AHB>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi3_pins>;
+	spi-nor@0 {
+			...
+	};
+};
+
-- 
2.18.0

