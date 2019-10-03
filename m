Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498E3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C11A215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfJCWVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 18:21:42 -0400
Received: from mailoutvs37.siol.net ([185.57.226.228]:33009 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728692AbfJCWVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 18:21:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 95C28524629;
        Fri,  4 Oct 2019 00:21:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UmRQVluGO7pv; Fri,  4 Oct 2019 00:21:38 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 4992852462A;
        Fri,  4 Oct 2019 00:21:38 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id D4D13524629;
        Fri,  4 Oct 2019 00:21:37 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: a64: orangepi-win: Enable audio codec
Date:   Fri,  4 Oct 2019 00:21:30 +0200
Message-Id: <20191003222130.2015617-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables internal audio codec on OrangePi Win board by
enabling all relevant nodes and adding appropriate routing. Board has
on-board microphone (MIC1) and 3.5 mm jack with stereo audio and
microphone (MIC2).

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../dts/allwinner/sun50i-a64-orangepi-win.dts | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 04446e4716c4..f54a415f2e3b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -114,6 +114,19 @@
 	};
 };
=20
+&codec {
+	status =3D "okay";
+};
+
+&codec_analog {
+	cpvdd-supply =3D <&reg_eldo1>;
+	status =3D "okay";
+};
+
+&dai {
+	status =3D "okay";
+};
+
 &de {
 	status =3D "okay";
 };
@@ -333,6 +346,22 @@
 	vcc-hdmi-supply =3D <&reg_dldo1>;
 };
=20
+&sound {
+	status =3D "okay";
+	simple-audio-card,widgets =3D "Headphone", "Headphone Jack",
+				    "Microphone", "Microphone Jack",
+				    "Microphone", "Onboard Microphone";
+	simple-audio-card,routing =3D
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Headphone Jack", "HP",
+			"MIC2", "Microphone Jack",
+			"Onboard Microphone", "MBIAS",
+			"MIC1", "Onboard Microphone";
+};
+
 &spi0 {
 	status =3D "okay";
=20
--=20
2.23.0

