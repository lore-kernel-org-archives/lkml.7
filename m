Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB767C468BD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DD020840
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfFJCvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 22:51:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53068 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfFJCvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 22:51:39 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 191492006CC;
        Mon, 10 Jun 2019 04:51:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B551200186;
        Mon, 10 Jun 2019 04:51:21 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C3EAA402C0;
        Mon, 10 Jun 2019 10:51:07 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
        rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, peng.fan@nxp.com,
        mchehab+samsung@kernel.org, linux@roeck-us.net,
        daniel.baluta@nxp.com, maxime.ripard@bootlin.com, olof@lixom.net,
        jagan@amarulasolutions.com, horms+renesas@verge.net.au,
        leonard.crestez@nxp.com, bjorn.andersson@linaro.org,
        dinguyen@kernel.org, enric.balletbo@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V14 1/5] dt-bindings: fsl: scu: add thermal binding
Date:   Mon, 10 Jun 2019 10:52:50 +0800
Message-Id: <20190610025254.23940-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and thermal sensors etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to get temperature from thermal sensors, this patch adds
binding doc for i.MX system controller thermal driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No change.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index a575e42..fc3844e 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -155,6 +155,17 @@ Required properties:
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
 
+Thermal bindings based on SCU Message Protocol
+------------------------------------------------------------
+
+Required properties:
+- compatible:			Should be :
+				  "fsl,imx8qxp-sc-thermal"
+				followed by "fsl,imx-sc-thermal";
+
+- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
+				for a description.
+
 Example (imx8qxp):
 -------------
 aliases {
@@ -222,6 +233,11 @@ firmware {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
 		};
+
+		tsens: thermal-sensor {
+			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+			#thermal-sensor-cells = <1>;
+		};
 	};
 };
 
-- 
2.7.4

