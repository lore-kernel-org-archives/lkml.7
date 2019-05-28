Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326BEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EDB208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KX06IYOz";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KX06IYOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfE1QLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:11:17 -0400
Received: from node.akkea.ca ([192.155.83.177]:49692 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfE1QLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:11:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id CF3004E204E;
        Tue, 28 May 2019 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559059874; bh=OT6Dn+VZn9tZ3DTf3tjazgTtPicDCyht9awlqDytBXs=;
        h=From:To:Cc:Subject:Date;
        b=KX06IYOzL6lGh15W/wG/F0dmzpZQMPv/jl7zW19y7lMeRctceEgRuEEVQf7CpBmYQ
         hnWdoZp56UJ5vSmpdvK89wbE061fgJ5KBZwHnzn9XWkcaTDEv6hkoIt+0tvChfYE/5
         frTNKqQl/5sIWCSc2NiYOGDNGkiFfLTI09WOQ8Cc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BZwGAX36mlMG; Tue, 28 May 2019 16:11:14 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id C9D244E204B;
        Tue, 28 May 2019 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559059874; bh=OT6Dn+VZn9tZ3DTf3tjazgTtPicDCyht9awlqDytBXs=;
        h=From:To:Cc:Subject:Date;
        b=KX06IYOzL6lGh15W/wG/F0dmzpZQMPv/jl7zW19y7lMeRctceEgRuEEVQf7CpBmYQ
         hnWdoZp56UJ5vSmpdvK89wbE061fgJ5KBZwHnzn9XWkcaTDEv6hkoIt+0tvChfYE/5
         frTNKqQl/5sIWCSc2NiYOGDNGkiFfLTI09WOQ8Cc=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: fsl: imx8mq: add the snvs power key node
Date:   Tue, 28 May 2019 09:11:01 -0700
Message-Id: <20190528161101.28919-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the snvs power key, "disabled" by default.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 45d10d8efd14..85008dc6e663 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/power/imx8mq-power.h>
 #include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
+#include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 #include "imx8mq-pinfunc.h"
@@ -463,6 +464,15 @@
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
 						<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
+
+				snvs_pwrkey: snvs-powerkey {
+					compatible = "fsl,sec-v4.0-pwrkey";
+					regmap = <&snvs>;
+					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+					linux,keycode = <KEY_POWER>;
+					wakeup-source;
+					status = "disabled";
+				};
 			};
 
 			clk: clock-controller@30380000 {
-- 
2.17.1

