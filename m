Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA83C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B02220856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfILUJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:09:34 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:49202 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfILUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:09:33 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: k55UhUVvseHoxsxZLGCkDYEmleLTHCcJbs1dE81Px8bX3JjzxF6xYlGZLivaGo2mRDvt7kBbr/
 a3ihEToS4W7XYroGY5TDJFiexNqi71KTVtgF+o7k7gnG1PPmB9Y//OINJ/DpNkbf36euVED8y8
 h0ltWzOyPwVHm3MuVni3DeS1TNIu1GH8xkRLEY2pgmSJoWotekNwerdhKal5UqEn+d9NKiZGH4
 bVuxuMHJjeCUP1TZswcIWYfYRq+/dngYIcQ+GtnWxg9n8lf3gN/z9DtCa6QM4pX0VBMHmiM/GS
 vLI=
X-IronPort-AV: E=Sophos;i="5.64,498,1559545200"; 
   d="scan'208";a="48745929"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Sep 2019 13:09:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Sep 2019 13:09:31 -0700
Received: from sekiro.microchip.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 12 Sep 2019 13:09:29 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>, <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] ARM: dts: at91: sama5d2: set the sdmmc gclk frequency
Date:   Thu, 12 Sep 2019 22:09:08 +0200
Message-ID: <20190912200908.31318-3-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912200908.31318-1-ludovic.desroches@microchip.com>
References: <20190912200908.31318-1-ludovic.desroches@microchip.com>
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
 arch/arm/boot/dts/sama5d2.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2e2c1a7b1d1d..8d79ff75e3cd 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -300,6 +300,8 @@
 			interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 31>, <&pmc PMC_TYPE_GCK 31>, <&pmc PMC_TYPE_CORE PMC_MAIN>;
 			clock-names = "hclock", "multclk", "baseclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 31>;
+			assigned-clock-rates = <480000000>;
 			status = "disabled";
 		};
 
@@ -309,6 +311,8 @@
 			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&pmc PMC_TYPE_PERIPHERAL 32>, <&pmc PMC_TYPE_GCK 32>, <&pmc PMC_TYPE_CORE PMC_MAIN>;
 			clock-names = "hclock", "multclk", "baseclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 32>;
+			assigned-clock-rates = <480000000>;
 			status = "disabled";
 		};
 
-- 
2.23.0

