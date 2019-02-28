Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27198C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E043A205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfB1N1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:27:08 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:20317 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727869AbfB1N1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:27:06 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544454000"; 
   d="scan'208";a="9122308"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2019 22:27:04 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7A2B844683AE;
        Thu, 28 Feb 2019 22:27:02 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 1/2] dt: snps,dw-apb-ssi: Add clock bindings documentation
Date:   Thu, 28 Feb 2019 13:25:41 +0000
Message-Id: <1551360342-23981-2-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The driver requires a clock property, so detail it in the docs.
Fix a typo, 'pis' to 'pins'.
Add documentation for a separate, optional, interface clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 2864bc6..7971193 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,16 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
+- clocks : phandles for the clocks, see the description of clock-names below.
+   The phandle for the "ssi_clk" clock is required. The phandle for the "pclk"
+   clock is optional. If a single clock is specified but no clock-name, it is
+   the "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
 
 Optional properties:
-- cs-gpios : Specifies the gpio pis to be used for chipselects.
+- clock-names : Contains the names of the clocks:
+    "ssi_clk", for the core clock used to generate the external SPI clock.
+    "pclk", the interface clock, required for register access.
+- cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
   device.  Supported values are 2 or 4 (the default).
@@ -25,6 +32,7 @@ Example:
 		interrupts = <0 154 4>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&spi_m_clk>;
 		num-cs = <2>;
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
-- 
2.7.4

