Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6225CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A071821929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407554AbfJYIDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:03:00 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:50108 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405453AbfJYIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:02:59 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Wk5VDaxaa04ZpXepyN7l+LRq4sXtuTcFje32+veLdWTvipsU7orBg/qzpAw5tsHiYqYKnknM47
 7l628LyAVaxgt7OMBt0qLjo4vAeR1r6cyBsTyiw0Ibfcxuk5gSqoMlLvaPXYX8vqsFB9rMurJ8
 nigqOiPfbg0pUv3a2cjVxsGrl2n0mtaCDVb8JbWAmde4/QomptLuqogolaiZLxj/hkRGEqZ5Ks
 Qn7D2KSC4iL6xT1CFLYSoskg2GXbbuNMaXZYwttycp8iHAolMc5RWF4lAxG3fdW+zXOAfAOwpt
 k0A=
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="52935735"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2019 01:02:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Oct 2019 01:02:49 -0700
Received: from M43218.corp.atmel.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 25 Oct 2019 01:02:47 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <claudiu.beznea@microchip.com>, <Eugen.Hristev@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH v3 3/3] ARM: dts: at91: sama5d2: set the sdmmc gclk frequency
Date:   Fri, 25 Oct 2019 10:03:44 +0200
Message-ID: <20191025080344.15492-3-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191025080344.15492-1-ludovic.desroches@microchip.com>
References: <20191025080344.15492-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the frequency of the generated clock used by sdmmc devices in order
to not rely on the configuration done by previous components.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---

Changes:
- v3: none
- v2: none

 arch/arm/boot/dts/sama5d2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index fa3b9c30a63a..f013c3562724 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -300,6 +300,8 @@ sdmmc0: sdio-host@a0000000 {
 			interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 31>, <&pmc PMC_TYPE_GCK 31>, <&pmc PMC_TYPE_CORE PMC_MAIN>;
 			clock-names = "hclock", "multclk", "baseclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 31>;
+			assigned-clock-rates = <480000000>;
 			status = "disabled";
 		};
 
@@ -309,6 +311,8 @@ sdmmc1: sdio-host@b0000000 {
 			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 32>, <&pmc PMC_TYPE_GCK 32>, <&pmc PMC_TYPE_CORE PMC_MAIN>;
 			clock-names = "hclock", "multclk", "baseclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 32>;
+			assigned-clock-rates = <480000000>;
 			status = "disabled";
 		};
 
-- 
2.24.0.rc0

