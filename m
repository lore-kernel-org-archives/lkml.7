Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF5C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C854A20659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfFYFsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:48:41 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:34810 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfFYFsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:48:35 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x5P5mKt2093478;
        Tue, 25 Jun 2019 13:48:23 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        bbrezillon@kernel.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com, paul.burton@mips.com,
        liang.yang@amlogic.com, richard@nod.at, anders.roxell@linaro.org,
        christophe.kerello@st.com, paul@crapouillou.net,
        jianxin.pan@amlogic.com, stefan@agner.ch,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, lee.jones@linaro.org,
        masonccyang@mxic.com.tw, broonie@kernel.org
Subject: [PATCH v4 2/2] dt-bindings: mtd: Document Macronix raw NAND controller bindings
Date:   Tue, 25 Jun 2019 14:10:56 +0800
Message-Id: <1561443056-13766-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x5P5mKt2093478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings used by the Macronix raw NAND controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/mtd/mxic-nand.txt          | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
new file mode 100644
index 0000000..3d198e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
@@ -0,0 +1,26 @@
+Macronix Raw NAND Controller Device Tree Bindings
+-------------------------------------------------
+
+Required properties:
+- compatible: should be "mxic,raw-nand-ctlr"
+- reg: should contain 1 entrie for the registers
+- reg-names: should contain "regs"
+- interrupts: interrupt line connected to this NAND controller
+- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
+- clocks: should contain 3 entries for the "ps_clk", "send_clk" and
+	 "send_dly_clk" clocks
+
+Example:
+
+	nand: mxic-nfc@43c30000 {
+		compatible = "mxic,raw-nand-ctlr";
+		reg = <0x43c30000 0x10000>;
+		reg-names = "regs";
+		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+		clock-names = "send_clk", "send_dly_clk", "ps_clk";
+
+		nand-ecc-mode = "soft";
+		nand-ecc-algo = "bch";
+		nand-ecc-step-size = <512>;
+		nand-ecc-strength = <8>;
+	};
-- 
1.9.1

