Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446C1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2891B2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfGSKq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:46:27 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:41880 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:46:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 08D8F9C01AF;
        Fri, 19 Jul 2019 06:46:25 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pDmCSr7ERjkb; Fri, 19 Jul 2019 06:46:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 4E0E09C0279;
        Fri, 19 Jul 2019 06:46:24 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Yj8MoRMJPG9k; Fri, 19 Jul 2019 06:46:24 -0400 (EDT)
Received: from localhost.localdomain (unknown [37.165.9.228])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0194D9C01AF;
        Fri, 19 Jul 2019 06:46:21 -0400 (EDT)
From:   Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     jerome.oufella@savoirfairelinux.com, rennes@savoirfairelinux.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Subject: [PATCH v2] arm: dts: imx6qdl: add gpio expander pca9535
Date:   Fri, 19 Jul 2019 12:46:15 +0200
Message-Id: <20190719104615.5329-1-gilles.doffe@savoirfairelinux.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pca9535 gpio expander is present on the Rex baseboard, but missing
from the dtsi.

Add the new gpio controller and the associated interrupt line
MX6QDL_PAD_NANDF_CS3__GPIO6_IO16.

Signed-off-by: Gilles DOFFE <gilles.doffe@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx6qdl-rex.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6q=
dl-rex.dtsi
index 97f1659144ea..b517efb22fcb 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -136,6 +136,19 @@
 		compatible =3D "atmel,24c02";
 		reg =3D <0x57>;
 	};
+
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
 };
=20
 &i2c3 {
@@ -237,6 +250,12 @@
 			>;
 		};
=20
+		pinctrl_pca9535: pca9535 {
+			fsl,pins =3D <
+				MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x00017059
+		   >;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins =3D <
 				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
--=20
2.19.1

