Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDC6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3928213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDICLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:11:40 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:26739 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfDICLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:11:39 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x3929vUm032141;
        Tue, 9 Apr 2019 10:10:00 +0800 (GMT-8)
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
Subject: [PATCH v2 4/4] dt-bindings: mfd: Document Macronix MX25F0A controller bindings
Date:   Tue,  9 Apr 2019 10:30:00 +0800
Message-Id: <1554777000-10542-5-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554777000-10542-1-git-send-email-masonccyang@mxic.com.tw>
References: <1554777000-10542-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x3929vUm032141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Macronix MX25F0A MFD controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/mfd/mxic-mx25f0a.txt       | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt

diff --git a/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
new file mode 100644
index 0000000..7f3e0f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
@@ -0,0 +1,51 @@
+Macronix MX25F0A MultiFunction Device Tree Bindings
+----------------------------------------------------
+
+MX25F0A is a MultiFunction Device with SPI and raw NAND, which
+supports either spi host controller or raw nand controller.
+
+Required properties:
+- compatible: should be "mxic,mx25f0a"
+- #address-cells: should be 1
+- #size-cells: should be 0
+- reg: should contain 2 entries, one for the registers and one for the direct
+       mapping area in SPI mode.
+- reg-names: should contain "regs" and "dirmap"
+- interrupts: interrupt line connected to this MFD controller
+- SPI controller driver:
+		- clock-names: should contain "ps_clk", "send_clk" and
+			       "send_dly_clk"
+		- clocks: should contain 3 entries for the "ps_clk", "send_clk"
+			  and "send_dly_clk" clocks
+
+- Raw nand controller driver.
+		- nand-ecc-mode = "soft";
+		- nand-ecc-algo = "bch";
+
+Example:
+
+	mxic: mx25f0a@43c30000 {
+		compatible = "mxic,mx25f0a";
+		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
+		reg-names = "regs", "dirmap";
+
+		/* spi */
+		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+		clock-names = "send_clk", "send_dly_clk", "ps_clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <25000000>;
+			spi-tx-bus-width = <4>;
+			spi-rx-bus-width = <4>;
+		};
+
+		/* nand */
+		nand-ecc-mode = "soft";
+		nand-ecc-algo = "bch";
+		nand-ecc-step-size = <512>;
+		nand-ecc-strength = <8>;
+	};
-- 
1.9.1

