Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C101ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003E52053B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436757AbfJPT23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:28:29 -0400
Received: from mailoutvs51.siol.net ([185.57.226.242]:46337 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2436616AbfJPT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:28:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 8DC465244B4;
        Wed, 16 Oct 2019 21:28:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dK_l9uSgvmns; Wed, 16 Oct 2019 21:28:24 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4190A524462;
        Wed, 16 Oct 2019 21:28:24 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id E755F524452;
        Wed, 16 Oct 2019 21:28:21 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        hverkuil@xs4all.nl, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v3 3/6] ARM: dts: sunxi: h3/h5: Add MBUS controller node
Date:   Wed, 16 Oct 2019 21:28:04 +0200
Message-Id: <20191016192807.1278987-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016192807.1278987-1-jernej.skrabec@siol.net>
References: <20191016192807.1278987-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both, H3 and H5, contain MBUS, which is the bus used by DMA devices to
access system memory.

MBUS controller is responsible for arbitration between channels based
on set priority and can do some other things as well, like report
bandwidth used. It also maps RAM region to different address than CPU.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi=
-h3-h5.dtsi
index 107eeafad20a..66bee3bea633 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -109,6 +109,7 @@
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;
+		dma-ranges;
 		ranges;
=20
 		display_clocks: clock@1000000 {
@@ -544,6 +545,14 @@
 			};
 		};
=20
+		mbus: dram-controller@1c62000 {
+			compatible =3D "allwinner,sun8i-h3-mbus";
+			reg =3D <0x01c62000 0x1000>;
+			clocks =3D <&ccu 113>;
+			dma-ranges =3D <0x00000000 0x40000000 0xc0000000>;
+			#interconnect-cells =3D <1>;
+		};
+
 		spi0: spi@1c68000 {
 			compatible =3D "allwinner,sun8i-h3-spi";
 			reg =3D <0x01c68000 0x1000>;
--=20
2.23.0

