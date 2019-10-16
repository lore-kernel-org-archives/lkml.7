Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F299CECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C9420854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390353AbfJPCRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:17:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39850 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732007AbfJPCRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:17:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EF0E200923;
        Wed, 16 Oct 2019 04:17:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 30C8D20093E;
        Wed, 16 Oct 2019 04:17:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7911F40342;
        Wed, 16 Oct 2019 10:17:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        jun.li@nxp.com, ping.bai@nxp.com, daniel.baluta@nxp.com,
        leonard.crestez@nxp.com, daniel.lezcano@linaro.org,
        l.stach@pengutronix.de, ccaione@baylibre.com, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, jon@solid-run.com, baruch@tkos.co.il,
        angus@akkea.ca, pavel@ucw.cz, agx@sigxcpu.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        dafna.hirschfeld@collabora.com, richard.hu@technexion.com,
        andradanciu1997@gmail.com, manivannan.sadhasivam@linaro.org,
        aisheng.dong@nxp.com, peng.fan@nxp.com, fugang.duan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 5/5] ARM: dts: imx7ulp: Move usdhc clocks assignment to board DT
Date:   Wed, 16 Oct 2019 10:14:27 +0800
Message-Id: <1571192067-19600-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
References: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usdhc's clock rate is different according to different devices
connected, so clock rate assignment should be placed in board
DT according to different devices connected on each usdhc port.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 2 ++
 arch/arm/boot/dts/imx7ulp.dtsi    | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-evk.dts
index 4245b33..f1093d2 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -77,6 +77,8 @@
 };
 
 &usdhc0 {
+	assigned-clocks = <&pcc2 IMX7ULP_CLK_USDHC0>;
+	assigned-clock-parents = <&scg1 IMX7ULP_CLK_NIC1_DIV>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc0>;
 	cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index 25e6f09..d37a192 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -223,8 +223,6 @@
 				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
 				 <&pcc2 IMX7ULP_CLK_USDHC0>;
 			clock-names = "ipg", "ahb", "per";
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_USDHC0>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_NIC1_DIV>;
 			bus-width = <4>;
 			fsl,tuning-start-tap = <20>;
 			fsl,tuning-step = <2>;
@@ -239,8 +237,6 @@
 				 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
 				 <&pcc2 IMX7ULP_CLK_USDHC1>;
 			clock-names = "ipg", "ahb", "per";
-			assigned-clocks = <&pcc2 IMX7ULP_CLK_USDHC1>;
-			assigned-clock-parents = <&scg1 IMX7ULP_CLK_NIC1_DIV>;
 			bus-width = <4>;
 			fsl,tuning-start-tap = <20>;
 			fsl,tuning-step = <2>;
-- 
2.7.4

