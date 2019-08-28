Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6557C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C462D22CBB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfH1BgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:36:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32970 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfH1BgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:36:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 47AE71A064D;
        Wed, 28 Aug 2019 03:36:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 163DD1A064B;
        Wed, 28 Aug 2019 03:36:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C36D2402E7;
        Wed, 28 Aug 2019 09:35:48 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux@armlinux.org.uk,
        otavio@ossystems.com.br, leonard.crestez@nxp.com,
        u.kleine-koenig@pengutronix.de, schnitzeltony@gmail.com,
        jan.tuerk@emtrion.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V5 1/4] dt-bindings: watchdog: Add i.MX7ULP bindings
Date:   Wed, 28 Aug 2019 09:35:00 -0400
Message-Id: <1566999303-18795-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the watchdog bindings for Freescale i.MX7ULP.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <rohb@kernel.org>
---
Changes since V4:
	- improve watchdog node name.
---
 .../bindings/watchdog/fsl-imx7ulp-wdt.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.txt
new file mode 100644
index 0000000..f902508
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.txt
@@ -0,0 +1,22 @@
+* Freescale i.MX7ULP Watchdog Timer (WDT) Controller
+
+Required properties:
+- compatible : Should be "fsl,imx7ulp-wdt"
+- reg : Should contain WDT registers location and length
+- interrupts : Should contain WDT interrupt
+- clocks: Should contain a phandle pointing to the gated peripheral clock.
+
+Optional properties:
+- timeout-sec : Contains the watchdog timeout in seconds
+
+Examples:
+
+wdog1: watchdog@403d0000 {
+	compatible = "fsl,imx7ulp-wdt";
+	reg = <0x403d0000 0x10000>;
+	interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
+	assigned-clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
+	assigned-clocks-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
+	timeout-sec = <40>;
+};
-- 
2.7.4

