Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE063C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC34420883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Oy9FRep8";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Oy9FRep8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfE1MoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:44:15 -0400
Received: from node.akkea.ca ([192.155.83.177]:43058 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfE1MoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:44:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id E243F4E204D;
        Tue, 28 May 2019 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559047454; bh=QN+qfKJcn+iv1NFE027lzE+60Gd7OUBp8PBwf368hi8=;
        h=From:To:Cc:Subject:Date;
        b=Oy9FRep8jiYbF4jTd69IGkP9IGgMBqpY3UZZJFMP+XDZ3fyJxL955yZWPDnGcdu2M
         Rg8y7rcdRF/t540YZGn5wCWnQf0T/Gs7dfsrbFmi4QkaIhGAdqGb9AUEdfDr4ctaLT
         m5vxS/3uQUUiAfvV8+QLEocdB0vHGP4RJpGnGec4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lTtIYmYKCoKZ; Tue, 28 May 2019 12:44:14 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id EE1D04E204B;
        Tue, 28 May 2019 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1559047454; bh=QN+qfKJcn+iv1NFE027lzE+60Gd7OUBp8PBwf368hi8=;
        h=From:To:Cc:Subject:Date;
        b=Oy9FRep8jiYbF4jTd69IGkP9IGgMBqpY3UZZJFMP+XDZ3fyJxL955yZWPDnGcdu2M
         Rg8y7rcdRF/t540YZGn5wCWnQf0T/Gs7dfsrbFmi4QkaIhGAdqGb9AUEdfDr4ctaLT
         m5vxS/3uQUUiAfvV8+QLEocdB0vHGP4RJpGnGec4=
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
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: fsl: imx8mq: enable the svns power key
Date:   Tue, 28 May 2019 05:44:06 -0700
Message-Id: <20190528124406.29730-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the snvs power key.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 45d10d8efd14..5f93fd9662ae 100644
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
@@ -463,6 +464,14 @@
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
+				};
 			};
 
 			clk: clock-controller@30380000 {
-- 
2.17.1

