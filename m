Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD2FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F18A20863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfEUG6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:58:41 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:45415 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfEUG6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:58:39 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x4L6vvQf093632;
        Tue, 21 May 2019 14:57:59 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com
Subject: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF controller bindings
Date:   Tue, 21 May 2019 15:19:34 +0800
Message-Id: <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x4L6vvQf093632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/mfd/renesas-rpc-if.txt     | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt

diff --git a/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
new file mode 100644
index 0000000..20ec85b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
@@ -0,0 +1,65 @@
+Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
+---------------------------------------------------------
+
+RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+		"renesas,rcar-gen3-rpc" as a fallback.
+		supported SoC-specific values are:
+		"renesas,r8a77995-rpc"	(R-Car D3)
+- reg: should contain three register areas:
+	first for RPC-IF registers,
+	second for the direct mapping read mode and
+	third for the write buffer area.
+- reg-names: should contain "regs", "dirmap" and "wbuf"
+- clocks: should contain 1 entries for the module's clock
+- clock-names: should contain "rpc"
+- power-domains: should contain system-controller(sysc) for power-domain-cell
+- resets: should contain clock pulse generator(cpg) for reset-cell,
+	  power-domain-cell and clock-cell
+- #address-cells: should be 1
+- #size-cells: should be 0
+
+Example:
+- SPI mode:
+
+	rpc: spi@ee200000 {
+		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
+		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
+		      <0 0xee208000 0 0x100>;
+		reg-names = "regs", "dirmap", "wbuf";
+		clocks = <&cpg CPG_MOD 917>;
+		clock-names = "rpc";
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <1>;
+		};
+	};
+
+- HF mode:
+	rpc: spi@ee200000 {
+		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
+		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
+		      <0 0xee208000 0 0x100>;
+		reg-names = "regs", "dirmap", "wbuf";
+		clocks = <&cpg CPG_MOD 917>;
+		clock-names = "rpc";
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "cypress,hyperflash", "cfi-flash";
+			reg = <0>;
+		};
+	};
-- 
1.9.1

