Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29673C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37A82064B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbfFTPHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:07:47 -0400
Received: from shell.v3.sk ([90.176.6.54]:51671 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731991AbfFTPHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:07:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 48FD2CC54A;
        Thu, 20 Jun 2019 17:07:39 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id T8NdU3UxI22t; Thu, 20 Jun 2019 17:07:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DB6B1CC415;
        Thu, 20 Jun 2019 17:07:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AcQmaE4KGXvF; Thu, 20 Jun 2019 17:07:27 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2EE29CC526;
        Thu, 20 Jun 2019 17:07:27 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/5] ARM: dts: mmp2: fix the SPI nodes
Date:   Thu, 20 Jun 2019 17:07:21 +0200
Message-Id: <20190620150724.1406757-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150724.1406757-1-lkundrak@v3.sk>
References: <20190620150724.1406757-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI bus has a single address cell and not size cells.

Also, dtc thinks the SPI nodes are preferrably called "spi" and it is
right to think so.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 50b6c38b39cc..e64639ce57a9 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -346,35 +346,43 @@
 				status =3D "disabled";
 			};
=20
-			ssp1: ssp@d4035000 {
+			ssp1: spi@d4035000 {
 				compatible =3D "marvell,mmp2-ssp";
 				reg =3D <0xd4035000 0x1000>;
 				clocks =3D <&soc_clocks MMP2_CLK_SSP0>;
 				interrupts =3D <0>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
 				status =3D "disabled";
 			};
=20
-			ssp2: ssp@d4036000 {
+			ssp2: spi@d4036000 {
 				compatible =3D "marvell,mmp2-ssp";
 				reg =3D <0xd4036000 0x1000>;
 				clocks =3D <&soc_clocks MMP2_CLK_SSP1>;
 				interrupts =3D <1>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
 				status =3D "disabled";
 			};
=20
-			ssp3: ssp@d4037000 {
+			ssp3: spi@d4037000 {
 				compatible =3D "marvell,mmp2-ssp";
 				reg =3D <0xd4037000 0x1000>;
 				clocks =3D <&soc_clocks MMP2_CLK_SSP2>;
 				interrupts =3D <20>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
 				status =3D "disabled";
 			};
=20
-			ssp4: ssp@d4039000 {
+			ssp4: spi@d4039000 {
 				compatible =3D "marvell,mmp2-ssp";
 				reg =3D <0xd4039000 0x1000>;
 				clocks =3D <&soc_clocks MMP2_CLK_SSP3>;
 				interrupts =3D <21>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
 				status =3D "disabled";
 			};
 		};
--=20
2.21.0

