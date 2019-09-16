Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C4BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A695206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfIPKoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:44:14 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:38376 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfIPKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:44:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 1A7B69C017D;
        Mon, 16 Sep 2019 06:44:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kFmGDLlrphLV; Mon, 16 Sep 2019 06:44:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id DB5AE9C028F;
        Mon, 16 Sep 2019 06:44:10 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KKf5wO2X-a9a; Mon, 16 Sep 2019 06:44:10 -0400 (EDT)
Received: from gdo-sfl-laptop.home (lfbn-1-1474-163.w86-253.abo.wanadoo.fr [86.253.99.163])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 493AA9C017D;
        Mon, 16 Sep 2019 06:44:09 -0400 (EDT)
From:   Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
To:     devicetree@vger.kernel.org
Cc:     rennes@savoirfairelinux.com, jerome.oufella@savoirfairelinux.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ARM: dts: imx6qdl-rex: add gpio expander pca9535
Date:   Mon, 16 Sep 2019 12:43:53 +0200
Message-Id: <20190916104353.7278-1-gilles.doffe@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pca9535 gpio expander is present on the Rex baseboard, but missing
from the dtsi.
The pca9535 is on i2c2 bus which is common to the three SOM
variants (Basic/Pro/Ultra), thus it is activated by default.

Add also the new gpio controller and the associated interrupt line
MX6QDL_PAD_NANDF_CS3__GPIO6_IO16.

Signed-off-by: Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx6qdl-rex.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6q=
dl-rex.dtsi
index 97f1659144ea..8a748ca1b108 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -132,6 +132,19 @@
 	pinctrl-0 =3D <&pinctrl_i2c2>;
 	status =3D "okay";
=20
+	pca9535: gpio8@27 {
+		compatible =3D "nxp,pca9535";
+		reg =3D <0x27>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_pca9535>;
+		interrupt-parent =3D <&gpio6>;
+		interrupts =3D <16 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells =3D <2>;
+	};
+
 	eeprom@57 {
 		compatible =3D "atmel,24c02";
 		reg =3D <0x57>;
@@ -237,6 +250,12 @@
 			>;
 		};
=20
+		pinctrl_pca9535: pca9535 {
+			fsl,pins =3D <
+				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x17059
+		   >;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
--=20
2.20.1

