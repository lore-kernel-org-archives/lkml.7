Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E110C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D56624679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLTHOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:14:49 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59546 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbfLTHOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:14:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8597FDFCAF;
        Fri, 20 Dec 2019 07:14:50 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vIzVzB36xj78; Fri, 20 Dec 2019 07:14:50 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DE67CDFCB0;
        Fri, 20 Dec 2019 07:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EFegCLmctJug; Fri, 20 Dec 2019 07:14:49 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 78E15DFCAF;
        Fri, 20 Dec 2019 07:14:49 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, soc@kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ARM: dts: mmp3: Fix the TWSI ranges
Date:   Fri, 20 Dec 2019 08:14:43 +0100
Message-Id: <20191220071443.247183-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register blocks don't occupy 4K. In fact, some blocks are packed
close to others and assuming they're 4K causes overlaps:

  pxa2xx-i2c d4033800.i2c: can't request region for resource
    [mem 0xd4033800-0xd40347ff]

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 7e38b7f662be4..991b07253090f 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -415,7 +415,7 @@ gcb5: gpio@d4019108 {
=20
 			twsi1: i2c@d4011000 {
 				compatible =3D "mrvl,mmp-twsi";
-				reg =3D <0xd4011000 0x1000>;
+				reg =3D <0xd4011000 0x70>;
 				interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 				clocks =3D <&soc_clocks MMP2_CLK_TWSI0>;
 				resets =3D <&soc_clocks MMP2_CLK_TWSI0>;
@@ -427,7 +427,7 @@ twsi1: i2c@d4011000 {
=20
 			twsi2: i2c@d4031000 {
 				compatible =3D "mrvl,mmp-twsi";
-				reg =3D <0xd4031000 0x1000>;
+				reg =3D <0xd4031000 0x70>;
 				interrupt-parent =3D <&twsi_mux>;
 				interrupts =3D <0>;
 				clocks =3D <&soc_clocks MMP2_CLK_TWSI1>;
@@ -439,7 +439,7 @@ twsi2: i2c@d4031000 {
=20
 			twsi3: i2c@d4032000 {
 				compatible =3D "mrvl,mmp-twsi";
-				reg =3D <0xd4032000 0x1000>;
+				reg =3D <0xd4032000 0x70>;
 				interrupt-parent =3D <&twsi_mux>;
 				interrupts =3D <1>;
 				clocks =3D <&soc_clocks MMP2_CLK_TWSI2>;
@@ -451,7 +451,7 @@ twsi3: i2c@d4032000 {
=20
 			twsi4: i2c@d4033000 {
 				compatible =3D "mrvl,mmp-twsi";
-				reg =3D <0xd4033000 0x1000>;
+				reg =3D <0xd4033000 0x70>;
 				interrupt-parent =3D <&twsi_mux>;
 				interrupts =3D <2>;
 				clocks =3D <&soc_clocks MMP2_CLK_TWSI3>;
@@ -464,7 +464,7 @@ twsi4: i2c@d4033000 {
=20
 			twsi5: i2c@d4033800 {
 				compatible =3D "mrvl,mmp-twsi";
-				reg =3D <0xd4033800 0x1000>;
+				reg =3D <0xd4033800 0x70>;
 				interrupt-parent =3D <&twsi_mux>;
 				interrupts =3D <3>;
 				clocks =3D <&soc_clocks MMP2_CLK_TWSI4>;
@@ -476,7 +476,7 @@ twsi5: i2c@d4033800 {
=20
 			twsi6: i2c@d4034000 {
 				compatible =3D "mrvl,mmp-twsi";
-				reg =3D <0xd4034000 0x1000>;
+				reg =3D <0xd4034000 0x70>;
 				interrupt-parent =3D <&twsi_mux>;
 				interrupts =3D <4>;
 				clocks =3D <&soc_clocks MMP2_CLK_TWSI5>;
--=20
2.24.1

