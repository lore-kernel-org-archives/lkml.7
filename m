Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C17C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8F821773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfC1KBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:01:11 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50857 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfC1KAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:00:48 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x2S9wlJN052359;
        Thu, 28 Mar 2019 17:58:52 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmal.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, miquel.raynal@bootlin.com
Cc:     juliensu@mxic.com.tw, zhengxunli@mxic.com.tw,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 4/7] dt-bindings: mfd: Document Macronix MX25F0A controller bindings
Date:   Thu, 28 Mar 2019 18:18:35 +0800
Message-Id: <1553768318-23149-5-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x2S9wlJN052359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Macronix MX25F0A MFD controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/mfd/mxic-mx25f0a.txt       | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt

diff --git a/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
new file mode 100644
index 0000000..53b4839
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
@@ -0,0 +1,66 @@
+Macronix MX25F0A Multi-Function Device Tree Bindings
+----------------------------------------------------
+
+MX25F0A is a MultiFunction Device with SPI and raw NAND, which
+supports either spi host controller or raw nand controller.
+
+Required properties:
+- compatible: should be "mxic,mx25f0a-mfd"
+- #address-cells: should be 1
+- #size-cells: should be 0
+- reg: should contain 2 entries, one for the registers and one for the direct
+       mapping area in SPI mode.
+- reg-names: should contain "regs" and "dirmap"
+- interrupts: interrupt line connected to this MFD controller
+
+Required nodes:
+ - spi :
+	Node for configuring the SPI controller driver.
+	Required properties:
+		- compatible = "mxicy,mx25f0a-spi";
+		- clock-names: should contain "ps_clk", "send_clk" and
+			       "send_dly_clk"
+		- clocks: should contain 3 entries for the "ps_clk", "send_clk"
+			  and "send_dly_clk" clocks
+
+- nand :
+	Node for configuring the raw nand controller driver.
+	Required properties:
+		- compatible = "mxicy,mx25f0a-nand-ctlr";
+		- nand-ecc-mode = "soft";
+		- nand-ecc-algo = "bch";
+
+Example:
+
+	mxic: mx25f0a-mfd@43c30000 {
+		compatible = "mxic,mx25f0a-mfd";
+		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
+		reg-names = "regs", "dirmap";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* either spi or nand */
+		spi {
+			compatible = "mxicy,mx25f0a-spi";
+			clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+			clock-names = "send_clk", "send_dly_clk", "ps_clk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			flash@0 {
+				compatible = "jedec,spi-nor";
+				reg = <0>;
+				spi-max-frequency = <25000000>;
+				spi-tx-bus-width = <4>;
+				spi-rx-bus-width = <4>;
+			};
+		};
+
+		nand {
+			compatible = "mxicy,mx25f0a-nand-ctlr";
+			nand-ecc-mode = "soft";
+			nand-ecc-algo = "bch";
+			nand-ecc-step-size = <512>;
+			nand-ecc-strength = <8>;
+		};
+	};
-- 
1.9.1

