Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B52B2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfDPLRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:17:24 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:33290 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728147AbfDPLRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:17:23 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x3GAka43014005;
        Tue, 16 Apr 2019 13:46:36 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id D5A2563001; Tue, 16 Apr 2019 14:16:32 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     gregkh@linuxfoundation.org, arnd@arnd.de, robh+dt@kernel.org,
        mark.rutland@arm.com, yuenn@google.com, venture@google.com,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 1/2] dt-binding: misc: Add common LPC snoop documentation
Date:   Tue, 16 Apr 2019 14:16:30 +0300
Message-Id: <20190416111631.356803-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190416111631.356803-1-tmaimon77@gmail.com>
References: <20190416111631.356803-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM BIOS Post Code (BPC) and Apeed AST2500 LPC snoop.
The LPC snoop monitoring two configurable I/O addresses
written by the host on Low Pin Count (LPC) bus.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../devicetree/bindings/misc/lpc-snoop.txt         | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/lpc-snoop.txt

diff --git a/Documentation/devicetree/bindings/misc/lpc-snoop.txt b/Documentation/devicetree/bindings/misc/lpc-snoop.txt
new file mode 100644
index 000000000000..c21cb8df4ffb
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/lpc-snoop.txt
@@ -0,0 +1,27 @@
+LPC snoop interface
+
+The LPC snoop (BIOS Post Code) interface can monitor
+two configurable I/O addresses written by the host on
+the Low Pin Count (LPC) bus.
+
+Nuvoton NPCM7xx LPC snoop supports capture double words,
+when using capture double word only I/O address 1 is monitored.
+
+Required properties for lpc-snoop node
+- compatible   : "nuvoton,npcm750-lpc-bpc-snoop" for Poleg NPCM7XX
+                 "aspeed,ast2500-lpc-snoop" for Aspeed AST2500.
+- reg          : specifies physical base address and size of the registers.
+- interrupts   : contain the LPC snoop interrupt with flags for falling edge.
+- snoop-ports  : contain monitor I/O addresses, at least one monitor I/O
+                 address required
+
+Optional property for NPCM7xx lpc-snoop node
+- nuvoton,lpc-en-dwcapture : enable capture double words support.
+
+Example:
+	lpc-snoop: lpc_snoop@f0007040 {
+		compatible = "nuvoton,npcm750-lpc-bpc-snoop";
+		reg = <0xf0007040 0x14>;
+		snoop-ports = <0x80>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
2.14.1

