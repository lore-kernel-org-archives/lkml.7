Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CFDC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314662075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfE1LzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:55:25 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:10896 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726580AbfE1LzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:55:25 -0400
X-IronPort-AV: E=Sophos;i="5.60,521,1549897200"; 
   d="scan'208";a="16978920"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 May 2019 20:55:22 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C26734007541;
        Tue, 28 May 2019 20:55:20 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl: Document power Domains
Date:   Tue, 28 May 2019 12:54:26 +0100
Message-Id: <1559044467-2639-2-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559044467-2639-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1559044467-2639-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is gaining power domain support, so add the new property
to the DT binding and update the examples.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
 - Added missing HCLK to UART0 example to show the clock added
   to the driver.
 - Added Geert's Reviewed-by line.
v3:
 - Added new #power-domain-cells property to the required properties.
 - Added "#power-domain-cells" and "power-domains" lines to examples.
v2:
 - No changes.
---
 .../devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
index d60b997..30adb4c 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- external (optional) RGMII_REFCLK
   - clock-names: Must be:
         clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+  - #power-domain-cells : Must be 0
 
 Examples
 --------
@@ -27,6 +28,7 @@ Examples
 		clocks = <&ext_mclk>, <&ext_rtc_clk>,
 				<&ext_jtag_clk>, <&ext_rgmii_ref>;
 		clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+		#power-domain-cells = <0>;
 	};
 
   - Other nodes can use the clocks provided by SYSCTRL as in:
@@ -38,6 +40,7 @@ Examples
 		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
-		clocks = <&sysctrl R9A06G032_CLK_UART0>;
-		clock-names = "baudclk";
+		clocks = <&sysctrl R9A06G032_CLK_UART0>, <&sysctrl R9A06G032_HCLK_UART0>;
+		clock-names = "baudclk", "apb_pclk";
+		power-domains = <&sysctrl>;
 	};
-- 
2.7.4

