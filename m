Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B8C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA532087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHSGyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:54:35 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:59675 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:54:34 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x7J6sIRK002951;
        Mon, 19 Aug 2019 14:54:21 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com, robh+dt@kernel.org,
        stefan@agner.ch, mark.rutland@arm.com
Cc:     lee.jones@linaro.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, paul.burton@mips.com,
        liang.yang@amlogic.com, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw, anders.roxell@linaro.org,
        christophe.kerello@st.com, paul@crapouillou.net,
        devicetree@vger.kernel.org
Subject: [PATCH v7 2/2] dt-bindings: mtd: Document Macronix raw NAND controller bindings
Date:   Mon, 19 Aug 2019 15:19:09 +0800
Message-Id: <1566199149-5669-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566199149-5669-1-git-send-email-masonccyang@mxic.com.tw>
References: <1566199149-5669-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x7J6sIRK002951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Macronix raw NAND controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/mtd/mxic-nand.txt          | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
new file mode 100644
index 0000000..46c5529
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
@@ -0,0 +1,36 @@
+Macronix Raw NAND Controller Device Tree Bindings
+-------------------------------------------------
+
+Required properties:
+- compatible: should be "mxic,multi-itfc-v009-nand-controller"
+- reg: should contain 1 entry for the registers
+- #address-cells: should be set to 1
+- #size-cells: should be set to 0
+- interrupts: interrupt line connected to this raw NAND controller
+- clock-names: should contain "ps", "send" and "send_dly"
+- clocks: should contain 3 phandles for the "ps", "send" and
+	 "send_dly" clocks
+
+Children nodes:
+- children nodes represent the available NAND chips.
+
+See Documentation/devicetree/bindings/mtd/nand-controller.yaml
+for more details on generic bindings.
+
+Example:
+
+	nand: nand-controller@43c30000 {
+		compatible = "mxic,multi-itfc-v009-nand-controller";
+		reg = <0x43c30000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 0x1d IRQ_TYPE_EDGE_RISING>;
+		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+		clock-names = "send", "send_dly", "ps";
+
+		nand@0 {
+			reg = <0>;
+			nand-ecc-mode = "soft";
+			nand-ecc-algo = "bch";
+		};
+	};
-- 
1.9.1

