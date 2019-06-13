Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E584C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEBB21743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392901AbfFMQvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:51:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57836 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730148AbfFMDdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:33:47 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 143C31A030B;
        Thu, 13 Jun 2019 05:33:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 87F401A02F9;
        Thu, 13 Jun 2019 05:33:41 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 795A3402E6;
        Thu, 13 Jun 2019 11:33:35 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 5/6] ARM: dts: imx7s: Enable SNVS power key according to board design
Date:   Thu, 13 Jun 2019 11:35:26 +0800
Message-Id: <20190613033527.40555-5-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613033527.40555-1-Anson.Huang@nxp.com>
References: <20190613033527.40555-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

The SNVS power key depends on board design, by default it should
be disabled in SoC DT and ONLY be enabled on board DT if it is
wired up.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 4 ++++
 arch/arm/boot/dts/imx7s.dtsi    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index a5365b8..869efbc 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -387,6 +387,10 @@
 	vin-supply = <&sw2_reg>;
 };
 
+&snvs_pwrkey {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index d8b4eb6..479be1f 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -609,6 +609,7 @@
 					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 					linux,keycode = <KEY_POWER>;
 					wakeup-source;
+					status = "disabled";
 				};
 			};
 
-- 
2.7.4

