Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E434CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA9D21783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390490AbfJ1Py4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:54:56 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:43560 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390213AbfJ1Pyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:54:55 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x9SFs4Qe001373;
        Mon, 28 Oct 2019 17:54:05 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id D081560275; Mon, 28 Oct 2019 17:54:04 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 1/3] dt-binding: reset: add NPCM reset controller documentation
Date:   Mon, 28 Oct 2019 17:54:01 +0200
Message-Id: <20191028155403.134126-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191028155403.134126-1-tmaimon77@gmail.com>
References: <20191028155403.134126-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM reset controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/reset/nuvoton,npcm-reset.txt     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
new file mode 100644
index 000000000000..94793285a2ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
@@ -0,0 +1,35 @@
+Nuvoton NPCM Reset controller
+
+In the NPCM Reset controller boot the USB PHY, USB host
+and USB device initialize.
+
+Required properties:
+- compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
+- reg : specifies physical base address and size of the register.
+- #reset-cells: must be set to 1
+
+Optional property:
+- nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
+  NPCM7xx contain four software reset that represent numbers 1 to 4.
+
+  If 'nuvoton,sw-reset-number' is not specfied software reset is disabled.
+
+Example:
+	rstc: rstc@f0801000 {
+		compatible = "nuvoton,npcm750-reset";
+		reg = <0xf0801000 0x70>;
+		#reset-cells = <1>;
+		nuvoton,sw-reset-number = <2>;
+	};
+
+Specifying reset lines connected to IP NPCM7XX modules
+======================================================
+example:
+
+        spi0: spi@..... {
+                ...
+                resets = <&rstc NPCM7XX_RESET_PSPI1>;
+                ...
+        };
+
+The index could be found in <dt-bindings/reset/nuvoton,npcm7xx-reset.h>.
-- 
2.22.0

