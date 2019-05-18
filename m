Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC9AC072A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E837A206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfERPkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 11:40:22 -0400
Received: from mailoutvs56.siol.net ([185.57.226.247]:48283 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727594AbfERPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:40:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 102F7520B82;
        Sat, 18 May 2019 17:40:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PuM_LcnyTvqU; Sat, 18 May 2019 17:40:19 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id BB40A520BDC;
        Sat, 18 May 2019 17:40:19 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 65006520B82;
        Sat, 18 May 2019 17:40:19 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: sun8i-h3: Fix wifi in Beelink X2 DT
Date:   Sat, 18 May 2019 17:40:14 +0200
Message-Id: <20190518154014.28998-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc1 node where wifi module is connected doesn't have properly defined
power supplies so wifi module is never powered up. Fix that by
specifying additional power supplies.

Additionally, this STB may have either Realtek or Broadcom based wifi
module. One based on Broadcom module also needs external clock to work
properly. Fix that by adding clock property to wifi_pwrseq node.

Fixes: e582b47a9252 ("ARM: dts: sun8i-h3: Add dts for the Beelink X2 STB"=
)
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
Changes from v1:
- removed unneeded pinctrl-names node

 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dt=
s/sun8i-h3-beelink-x2.dts
index 6277f13f3eb3..ac9e26b1d906 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -90,6 +90,8 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible =3D "mmc-pwrseq-simple";
 		reset-gpios =3D <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		clocks =3D <&rtc 1>;
+		clock-names =3D "ext_clock";
 	};
=20
 	sound_spdif {
@@ -155,6 +157,8 @@
=20
 &mmc1 {
 	vmmc-supply =3D <&reg_vcc3v3>;
+	vqmmc-supply =3D <&reg_vcc3v3>;
+	mmc-pwrseq =3D <&wifi_pwrseq>;
 	bus-width =3D <4>;
 	non-removable;
 	status =3D "okay";
--=20
2.21.0

