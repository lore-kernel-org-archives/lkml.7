Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E759AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52BD24683
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfLTGxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:53:38 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59184 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfLTGxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:53:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6B417DFC76;
        Fri, 20 Dec 2019 06:53:24 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BUYhCElFSDFC; Fri, 20 Dec 2019 06:53:22 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B51E1DFC5E;
        Fri, 20 Dec 2019 06:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rSDtHG59z_Kv; Fri, 20 Dec 2019 06:53:22 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C846ADFCA3;
        Fri, 20 Dec 2019 06:53:21 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 4/5] ARM: dts: mmp3: Add HSIC controllers
Date:   Fri, 20 Dec 2019 07:53:13 +0100
Message-Id: <20191220065314.237624-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220065314.237624-1-lkundrak@v3.sk>
References: <20191220065314.237624-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two on MMP3, along with the PHYs. The PHYs are made compatible
with the NOP transceiver, since there's no driver for the time being and
they're likely configured by the firmware.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3.dtsi | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index d9762de0ed34b..36c50706e60e0 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -201,6 +201,50 @@ usb_otg0: usb-otg@d4208000 {
 				status =3D "disabled";
 			};
=20
+			hsic_phy0: hsic-phy@f0001800 {
+				compatible =3D "marvell,mmp3-hsic-phy",
+					     "usb-nop-xceiv",
+				reg =3D <0xf0001800 0x40>;
+				#phy-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			hsic0: hsic@f0001000 {
+				compatible =3D "marvell,pxau2o-ehci";
+				reg =3D <0xf0001000 0x200>;
+				interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_USBHSIC0>;
+				clock-names =3D "USBCLK";
+				phys =3D <&hsic_phy0>;
+				phy-names =3D "usb";
+				phy_type =3D "hsic";
+				#address-cells =3D <0x01>;
+				#size-cells =3D <0x00>;
+				status =3D "disabled";
+			};
+
+			hsic_phy1: hsic-phy@f0002800 {
+				compatible =3D "marvell,mmp3-hsic-phy",
+					     "usb-nop-xceiv",
+				reg =3D <0xf0002800 0x40>;
+				#phy-cells =3D <0>;
+				status =3D "disabled";
+			};
+
+			hsic1: hsic@f0002000 {
+				compatible =3D "marvell,pxau2o-ehci";
+				reg =3D <0xf0002000 0x200>;
+				interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&soc_clocks MMP2_CLK_USBHSIC1>;
+				clock-names =3D "USBCLK";
+				phys =3D <&hsic_phy1>;
+				phy-names =3D "usb";
+				phy_type =3D "hsic";
+				#address-cells =3D <0x01>;
+				#size-cells =3D <0x00>;
+				status =3D "disabled";
+			};
+
 			mmc1: mmc@d4280000 {
 				compatible =3D "mrvl,pxav3-mmc";
 				reg =3D <0xd4280000 0x120>;
--=20
2.24.1

