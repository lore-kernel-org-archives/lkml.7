Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D74AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AFD216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 07:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfK1Hpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:45:46 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7644 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfK1Hpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 02:45:43 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 1BIEeTe/xvsmF8vn9hfa3SajDb9AMZepfhaR5sJ5afACDvhZx8yk0wd9EG4Y4ohqz4j+zUPNuc
 8rWl4jbODMHJF4mNW6X8aHpiOnOzMrmmHAN+QBRyXvZbwAqoro9AKiWNZK1rqGNJNTdZz300Fd
 l4TKYp185RBa+7dffRoDLgUsfJLrN2G2dkb5cqCxFDKMsS2ZiHUvaZTFr4gn0+DgEOMOmysEWv
 g2MVDGJWGxNaOZCTjsJwIF/ssIPrfMxUCVcdrlzn7WV7KQdD9tknVfA1Ny3YtBybPCzhETeAGK
 Ojw=
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; 
   d="scan'208";a="55970602"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2019 00:45:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Nov 2019 00:45:34 -0700
Received: from M43218.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 28 Nov 2019 00:45:31 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <claudiu.beznea@microchip.com>, <Eugen.Hristev@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: sdhci-of-at91: new compatible string and update properties
Date:   Thu, 28 Nov 2019 08:45:20 +0100
Message-ID: <20191128074522.69706-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new compatible string for the SAM9X60 sdhci device. It involves
an update of the properties about the clocks stuff.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes:
- v3: rebase due to conflict with Nicolas' patch
- v2: remove the extra example and fix node label

 .../devicetree/bindings/mmc/sdhci-atmel.txt         | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
index 503c6dbac1b2..69edfd4d3922 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
@@ -5,11 +5,16 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
 sdhci-of-at91 driver.
 
 Required properties:
-- compatible:		Must be "atmel,sama5d2-sdhci".
+- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
 - clocks:		Phandlers to the clocks.
-- clock-names:		Must be "hclock", "multclk", "baseclk";
+- clock-names:		Must be "hclock", "multclk", "baseclk" for
+			"atmel,sama5d2-sdhci".
+			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
 
 Optional properties:
+- assigned-clocks:	The same with "multclk".
+- assigned-clock-rates	The rate of "multclk" in order to not rely on the
+			gck configuration set by previous components.
 - microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
   inverted. The default polarity for this signal is described in the datasheet.
   For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
@@ -17,10 +22,12 @@ Optional properties:
 
 Example:
 
-sdmmc0: sdio-host@a0000000 {
+mmc0: sdio-host@a0000000 {
 	compatible = "atmel,sama5d2-sdhci";
 	reg = <0xa0000000 0x300>;
 	interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
 	clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
 	clock-names = "hclock", "multclk", "baseclk";
+	assigned-clocks = <&sdmmc0_gclk>;
+	assigned-clock-rates = <480000000>;
 };
-- 
2.24.0

