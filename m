Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F83C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB7920665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 12:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFWMCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:02:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54140 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFWMCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 08:02:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B1FA2003C4;
        Sun, 23 Jun 2019 14:02:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B8E8200133;
        Sun, 23 Jun 2019 14:02:41 +0200 (CEST)
Received: from mega.ap.freescale.net (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3C2FD402CF;
        Sun, 23 Jun 2019 20:02:30 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, ccaione@baylibre.com, angus@akkea.ca,
        andrew.smirnov@gmail.com, agx@sigxcpu.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/3] clocksource/drivers/sysctr: Add optional clock-frequency property
Date:   Sun, 23 Jun 2019 20:04:32 +0800
Message-Id: <20190623120434.19556-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
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

Add the optinal clock-frequency to the device tree bindings of the NXP
system counter, so the frequency can be handed in and the of_clk
operations can be skipped.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- improve commit log, no content change.
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

