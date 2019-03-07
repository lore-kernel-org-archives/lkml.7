Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707B82064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfCGQ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:58:57 -0500
Received: from mailoutvs44.siol.net ([185.57.226.235]:46033 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726606AbfCGQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:58:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 389A05237EB;
        Thu,  7 Mar 2019 17:58:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kHFN88ElkmTh; Thu,  7 Mar 2019 17:58:51 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id E33E65237FA;
        Thu,  7 Mar 2019 17:58:51 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 91A9852380A;
        Thu,  7 Mar 2019 17:58:49 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 6/6] arm64: dts: allwinner: h6: Add DMA node
Date:   Thu,  7 Mar 2019 17:58:29 +0100
Message-Id: <20190307165829.9086-7-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307165829.9086-1-jernej.skrabec@siol.net>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 has DMA controller which supports 16 channels.

Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
index c9e861a50a63..ff8cf6e3b6ec 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -192,6 +192,18 @@
 			#reset-cells =3D <1>;
 		};
=20
+		dma: dma-controller@3002000 {
+			compatible =3D "allwinner,sun50i-h6-dma";
+			reg =3D <0x03002000 0x1000>;
+			interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names =3D "bus", "mbus";
+			dma-channels =3D <16>;
+			dma-requests =3D <46>;
+			resets =3D <&ccu RST_BUS_DMA>;
+			#dma-cells =3D <1>;
+		};
+
 		pio: pinctrl@300b000 {
 			compatible =3D "allwinner,sun50i-h6-pinctrl";
 			reg =3D <0x0300b000 0x400>;
--=20
2.21.0

