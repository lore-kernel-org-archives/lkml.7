Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B6C206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfG3PGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:06:12 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43644 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfG3PGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:06:12 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45yfyT33DCz1rKXF;
        Tue, 30 Jul 2019 17:06:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45yfyT1mT5z1qqkK;
        Tue, 30 Jul 2019 17:06:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id TtrviBwiBTSX; Tue, 30 Jul 2019 17:06:08 +0200 (CEST)
X-Auth-Info: aTGk0kR+4QgAU9zcVWxZMYtuGzMpdVmeVoztrzZPGhc=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 30 Jul 2019 17:06:07 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ARM: DTS: vybrid: Update qspi node description for VF610 BK4 board
Date:   Tue, 30 Jul 2019 17:05:52 +0200
Message-Id: <20190730150552.24927-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change the device tree description of qspi node for
second memory on BK4 board was wrong (applicable to old, in-house
tunned fsl-quadspi.c driver).

As a result this memory was not recognized correctly when used
with the new spi-fsl-qspi.c driver.

From the dt-bindings:

"Required SPI slave node properties:
  - reg: There are two buses (A and B) with two chip selects each.
This encodes to which bus and CS the flash is connected:
<0>: Bus A, CS 0
<1>: Bus A, CS 1
<2>: Bus B, CS 0
<3>: Bus B, CS 1"

According to above with new driver the second SPI-NOR memory shall
have reg=<2> as it is connected to Bus B, CS 0.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/vf610-bk4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index 3fa0cbe456db..0f3870d3b099 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -246,13 +246,13 @@
 		reg = <0>;
 	};
 
-	n25q128a13_2: flash@1 {
+	n25q128a13_2: flash@2 {
 		compatible = "n25q128a13", "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		spi-max-frequency = <66000000>;
 		spi-rx-bus-width = <2>;
-		reg = <1>;
+		reg = <2>;
 	};
 };
 
-- 
2.11.0

