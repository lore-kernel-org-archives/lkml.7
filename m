Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901C9C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73366213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfGAJrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:47:46 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59730 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfGAJrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:47:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA50520090D;
        Mon,  1 Jul 2019 11:47:41 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D51EA200925;
        Mon,  1 Jul 2019 11:47:30 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C76FC402B1;
        Mon,  1 Jul 2019 17:47:17 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, daniel.baluta@nxp.com, ping.bai@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, angus@akkea.ca,
        agx@sigxcpu.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 2/5] clocksource/drivers/sysctr: Add clock-frequency property
Date:   Mon,  1 Jul 2019 17:38:23 +0800
Message-Id: <20190701093826.5472-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190701093826.5472-1-Anson.Huang@nxp.com>
References: <20190701093826.5472-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Systems which use platform driver model for clock driver require the
clock frequency to be supplied via device tree when system counter
driver is enabled.

This is necessary as in the platform driver model the of_clk operations
do not work correctly because system counter driver is initialized in
early phase of system boot up, and clock driver using platform driver
model is NOT ready at that time, it will cause system counter driver
initialization failed.

Add clock-frequency property to the device tree bindings of the NXP
system counter, so the driver can tell timer-of driver to get clock
frequency from DT directly instead of doing of_clk operations via
clk APIs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 .../devicetree/bindings/timer/nxp,sysctr-timer.txt        | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
index d576599..7088a0e 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
@@ -11,15 +11,18 @@ Required properties:
 - reg :             Specifies the base physical address and size of the comapre
                     frame and the counter control, read & compare.
 - interrupts :      should be the first compare frames' interrupt
-- clocks : 	    Specifies the counter clock.
-- clock-names: 	    Specifies the clock's name of this module
+- clocks :          Specifies the counter clock, mutually exclusive with clock-frequency.
+- clock-names :     Specifies the clock's name of this module, mutually exclusive with
+		    clock-frequency.
+- clock-frequency : Specifies system counter clock frequency, mutually exclusive with
+		    clocks/clock-names.
 
 Example:
 
 	system_counter: timer@306a0000 {
 		compatible = "nxp,sysctr-timer";
-		reg = <0x306a0000 0x20000>;/* system-counter-rd & compare */
-		clocks = <&clk_8m>;
-		clock-names = "per";
-		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x306a0000 0x30000>;
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <8333333>;
 	};
-- 
2.7.4

