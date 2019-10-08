Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C108AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A460321871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfJHMes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:34:48 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10186 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfJHMer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:34:47 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: WhkBNvq3jsOp2cyfmV0+lPJQ1VKmrmpaIiaKSptI7W1Ff6RnMsBmfbNQpUBAPc+ovIn+vQnxBS
 41+4SHKSC6OZwlXR+uw3XZsEMODm3QfSQLtApT7ReFe290q99kHpMn0NhuIFtEI8bBNYVTA9J1
 HEXvSo6HnQinu8CGN5E1jZ006EdJmtpdfoxIk4bPoBhW1Ce+wVZ9UtX6QjHcRPJUH7eyMPRe0l
 1nPJgLo72x6qtYQMDV+D/CAYpHOJYwlo82+ziBVupWT+hFBW5J1KzoN4XaFSjoivSuYlB3zAEh
 4uc=
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="49212609"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Oct 2019 05:34:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Oct 2019 05:34:46 -0700
Received: from tenerife.corp.atmel.com (10.10.85.251) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 8 Oct 2019 05:34:44 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/2] dt-bindings: sdhci-of-at91: add the microchip,sdcal-inverted property
Date:   Tue, 8 Oct 2019 14:34:31 +0200
Message-ID: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the specific microchip,sdcal-inverted property to at91 sdhci
device binding.
This optional property describes how the SoC SDCAL pin is connected.
It could be handled at SiP, SoM or board level.

This property read by at91 sdhci driver will allow to put in place a
software workaround that would reduce power consumption.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
index 1b662d7171a0..503c6dbac1b2 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
@@ -9,6 +9,11 @@ Required properties:
 - clocks:		Phandlers to the clocks.
 - clock-names:		Must be "hclock", "multclk", "baseclk";
 
+Optional properties:
+- microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
+  inverted. The default polarity for this signal is described in the datasheet.
+  For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
+  and a capacitor (see "SDMMC I/O Calibration" chapter).
 
 Example:
 
-- 
2.17.1

