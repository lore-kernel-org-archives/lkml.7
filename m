Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB142186A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368243;
	bh=19H22YuuAwxZ+4Yp6EALBTtAWQvsttkHu86iqqTV1cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2pVxUGLvKrX9MVOXwhVcNwi2VTity3h+pPAuf8eGfK6O/z7tZKdjjq0KDWlsQEPA9
	 aWoi+c3doK9kja2NWu2Nj6IAiN7ltaxzBuwsgDfW7bZuDPp25hzGtyGv0+yl5lFvO0
	 BqIfcCrdZMlotLTtwwoMvUc3vgZakXP/G9KpO31o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfDDI5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbfDDI5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:57:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0309E20882;
        Thu,  4 Apr 2019 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368237;
        bh=19H22YuuAwxZ+4Yp6EALBTtAWQvsttkHu86iqqTV1cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RomRS+qVszzjQxvZlIFZCUOB8VFPDpNRO4kBWK1IK956FxlIgP+JRBP4pDfXQWDbG
         1kX1slZ4BZEkz9kf/RuGRjqPGRpVAcQtp4IoWZHH1/Cbc/Rbo6hJ33A6+23Bc7MrrM
         6rpjIWZI0dWvp1qTEryj4RioSLTYQIB/JPFZSFd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>,
        Rob Herring <robh@kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 088/121] ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation
Date:   Thu,  4 Apr 2019 10:47:56 +0200
Message-Id: <20190404084550.079152662@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3e3380d0675d5e20b0af067d60cb947a4348bf9b ]

Improve the DTS files by removing all the leading "0x" and zeros to fix
the following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +

For simplicity, two sed expressions were used to solve each warnings
separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
[vzapolskiy: fixed commit message to pass checkpatch.pl test]
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index d81fe433e3c8..f22a33a01819 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -230,7 +230,7 @@
 				status = "disabled";
 			};
 
-			i2s1: i2s@2009C000 {
+			i2s1: i2s@2009c000 {
 				compatible = "nxp,lpc3220-i2s";
 				reg = <0x2009C000 0x1000>;
 			};
@@ -273,7 +273,7 @@
 				status = "disabled";
 			};
 
-			i2c1: i2c@400A0000 {
+			i2c1: i2c@400a0000 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x400A0000 0x100>;
 				interrupt-parent = <&sic1>;
@@ -284,7 +284,7 @@
 				clocks = <&clk LPC32XX_CLK_I2C1>;
 			};
 
-			i2c2: i2c@400A8000 {
+			i2c2: i2c@400a8000 {
 				compatible = "nxp,pnx-i2c";
 				reg = <0x400A8000 0x100>;
 				interrupt-parent = <&sic1>;
@@ -295,7 +295,7 @@
 				clocks = <&clk LPC32XX_CLK_I2C2>;
 			};
 
-			mpwm: mpwm@400E8000 {
+			mpwm: mpwm@400e8000 {
 				compatible = "nxp,lpc3220-motor-pwm";
 				reg = <0x400E8000 0x78>;
 				status = "disabled";
@@ -394,7 +394,7 @@
 				#gpio-cells = <3>; /* bank, pin, flags */
 			};
 
-			timer4: timer@4002C000 {
+			timer4: timer@4002c000 {
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x4002C000 0x1000>;
 				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
@@ -412,7 +412,7 @@
 				status = "disabled";
 			};
 
-			watchdog: watchdog@4003C000 {
+			watchdog: watchdog@4003c000 {
 				compatible = "nxp,pnx4008-wdt";
 				reg = <0x4003C000 0x1000>;
 				clocks = <&clk LPC32XX_CLK_WDOG>;
@@ -451,7 +451,7 @@
 				status = "disabled";
 			};
 
-			timer1: timer@4004C000 {
+			timer1: timer@4004c000 {
 				compatible = "nxp,lpc3220-timer";
 				reg = <0x4004C000 0x1000>;
 				interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
@@ -475,7 +475,7 @@
 				status = "disabled";
 			};
 
-			pwm1: pwm@4005C000 {
+			pwm1: pwm@4005c000 {
 				compatible = "nxp,lpc3220-pwm";
 				reg = <0x4005C000 0x4>;
 				clocks = <&clk LPC32XX_CLK_PWM1>;
@@ -484,7 +484,7 @@
 				status = "disabled";
 			};
 
-			pwm2: pwm@4005C004 {
+			pwm2: pwm@4005c004 {
 				compatible = "nxp,lpc3220-pwm";
 				reg = <0x4005C004 0x4>;
 				clocks = <&clk LPC32XX_CLK_PWM2>;
-- 
2.19.1



