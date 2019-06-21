Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C1D208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFUI0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:26:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58112 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfFUI0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:26:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97DE420092B;
        Fri, 21 Jun 2019 10:26:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7EE2200037;
        Fri, 21 Jun 2019 10:26:44 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CF83A402CF;
        Fri, 21 Jun 2019 16:26:33 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, ccaione@baylibre.com, angus@akkea.ca,
        andrew.smirnov@gmail.com, agx@sigxcpu.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] clocksource/drivers/sysctr: Add an optional property
Date:   Fri, 21 Jun 2019 16:28:36 +0800
Message-Id: <20190621082838.12630-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

This patch adds an optional property "clock-frequency" to pass
the system counter frequency value to kernel system counter
driver and indicate the driver to skip of_clk operations, this
is to support those platforms using platform driver model for
clock driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
index d576599..c9907a0 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
@@ -14,6 +14,11 @@ Required properties:
 - clocks : 	    Specifies the counter clock.
 - clock-names: 	    Specifies the clock's name of this module
 
+Optional properties:
+
+- clock-frequency : Specifies system counter clock frequency and indicates system
+		    counter driver to skip clock operations.
+
 Example:
 
 	system_counter: timer@306a0000 {
@@ -22,4 +27,5 @@ Example:
 		clocks = <&clk_8m>;
 		clock-names = "per";
 		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <8333333>;
 	};
-- 
2.7.4

