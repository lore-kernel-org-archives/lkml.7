Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD04C606D7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DA621743
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="O2r2OFQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGIHfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:35:05 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61848 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfGIHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656769; x=1565248769;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aDw5hzswtjO4S2Z52rF4tVaiyeGPvfY6gqilXLeQpJA=;
        b=O2r2OFQhSQAavReuIhL9NwrA07VvlouMsps+J6512YpcobsDTjAXntJ7WiZYpgdd
        2FntbANeXdx0m3aU+o1DF+K+t4CAQFRp7l+lERub/u+V7VPMFHNqun2pKpiKBFuo
        v0nlCy841IMxZooB2iedh84wGEHEcwFtcyXXgKY/KAM=;
X-AuditID: c39127d2-193ff70000001aee-08-5d2440018592
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1D.B0.06894.100442D5; Tue,  9 Jul 2019 09:19:29 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192926-309711 ;
          Tue, 9 Jul 2019 09:19:29 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 08/10] ARM: dts: imx6ul: segin: Move ECSPI interface to board include file
Date:   Tue, 9 Jul 2019 09:19:25 +0200
Message-Id: <1562656767-273566-9-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:29,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:29,
        Serialize complete at 09.07.2019 09:19:29
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWyRoCBS5fRQSXW4NUBHYv5R86xWjy86m+x
        aupOFotNj6+xWnT9WslscXnXHDaLpdcvMlk8uNjFYtG69wi7xd/tm1gsXmwRd+D2WDNvDaPH
        jrtLGD12zrrL7rFpVSebx+Yl9R4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqRvl0CV8bEZ0dZ
        Cr4KVGz9cp61gbGHr4uRk0NCwETi0PRm1i5GLg4hgR2MEt2nL7BAOBcYJY4ubWUGqWITMJJY
        MK2RCcQWEYiUeLf9NztIEbPAHkaJadevM4IkhAWiJH4e/8YCYrMIqEi8mHQQyObg4BXwkLi2
        jwdim5zEzXOdYDM5BTwljl78BWYLAZVcXjANbLGEQCOTxLXXWxghGoQkTi8+yzyBkW8BI8Mq
        RqHczOTs1KLMbL2CjMqS1GS9lNRNjMBAPTxR/dIOxr45HocYmTgYDzFKcDArifDuc1eOFeJN
        SaysSi3Kjy8qzUktPsQozcGiJM67gbckTEggPbEkNTs1tSC1CCbLxMEp1cBYdHyvxSH2s/+j
        tdX8drN6Byy5/0939ZYp5444zX4kJjjx6sMV1UzM/Aa1D1Q2TAmfo7f14t4/xwSTWBmLrpxJ
        nyT062jrim/BTyrPliU1lh67tb/Zy+bYoTfKaZE/JnckvZm/XsGw9Q7f10fCUw2m9sV83/9z
        dtu2/Kchftb6LJ+Kbjitfc9yR4mlOCPRUIu5qDgRAK9K5zVCAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ECSPI interface is available on the expansion connector of every
PHYTEC phyBOARD-Segin. Move its definition to the board include file
for better reuse.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts | 14 --------------
 arch/arm/boot/dts/imx6ul-phytec-segin.dtsi            | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
index c6ef13685a7c..32d90c67a6f2 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
@@ -28,9 +28,6 @@
 };
 
 &ecspi3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi3>;
-	cs-gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
@@ -93,14 +90,3 @@
 &usdhc1 {
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_ecspi3: ecspi3grp {
-		fsl,pins = <
-			MX6UL_PAD_UART2_RTS_B__ECSPI3_MISO	0x10b0
-			MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
-			MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
-			MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20	0x10b0
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
index 7cd24ec40c36..8d5f8dc6ad58 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
@@ -103,6 +103,13 @@
 	assigned-clock-rates = <786432000>;
 };
 
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
+	status = "disabled";
+};
+
 &fec2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2>;
@@ -225,6 +232,15 @@
 		>;
 	};
 
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_RTS_B__ECSPI3_MISO	0x10b0
+			MX6UL_PAD_UART2_CTS_B__ECSPI3_MOSI	0x10b0
+			MX6UL_PAD_UART2_RX_DATA__ECSPI3_SCLK	0x10b0
+			MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20	0x10b0
+		>;
+	};
+
 	pinctrl_enet2: enet2grp {
 		fsl,pins = <
 			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
-- 
2.7.4

