Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D10C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A017120857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfCSPzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:55:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:57627 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726579AbfCSPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:55:00 -0400
X-IronPort-AV: E=Sophos;i="5.58,498,1544454000"; 
   d="scan'208";a="10591178"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Mar 2019 00:54:58 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BCD86400F023;
        Wed, 20 Mar 2019 00:54:56 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: snps,dw-apb-ssi: Add optional clock bindings documentation
Date:   Tue, 19 Mar 2019 15:52:06 +0000
Message-Id: <1553010727-23157-3-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553010727-23157-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1553010727-23157-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to the Synopsys SPI dt-bindings to support an
optional interface clock that may be used for register access.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
v2: Created this separate patch to detail the optional interface clock
    property. This includes the clocks section on working with the two
    clocks and the clock-names line for pclk.
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index bcd8f96..f54c8c3 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,15 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
-- clocks : phandle for the core clock used to generate the external SPI clock.
+- clocks : phandles for the clocks, see the description of clock-names below.
+   The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
+   is optional. If a single clock is specified but no clock-name, it is the
+   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
 
 Optional properties:
+- clock-names : Contains the names of the clocks:
+    "ssi_clk", for the core clock used to generate the external SPI clock.
+    "pclk", the interface clock, required for register access.
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
-- 
2.7.4

