Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A1C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4FD208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfK2LkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:40:07 -0500
Received: from olimex.com ([184.105.72.32]:44946 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfK2LkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:40:06 -0500
Received: from localhost.localdomain ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 03:39:57 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com, Stefan Mavrodiev <stefan@olimex.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: allwinner: a64: olinuxino: Fix eMMC supply regulator
Date:   Fri, 29 Nov 2019 13:39:39 +0200
Message-Id: <20191129113941.20170-2-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191129113941.20170-1-stefan@olimex.com>
References: <20191129113941.20170-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A64-OLinuXino-eMMC uses 1.8V for eMMC supply. This is done via a triple
jumper, which sets VCC-PL to either 1.8V or 3.3V. This setting is different
for boards with and without eMMC.

This is not a big issue for DDR52 mode, however the eMMC will not work in
HS200/HS400, since these modes explicitly requires 1.8V.

Fixes: 94f68f3a4b2a ("arm64: dts: allwinner: a64: Add A64 OlinuXino board (with eMMC)")
Cc: stable@vger.kernel.org # v5.4
Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
Changes for v2:
 - Restore the original eMMC vmmc-supply property

 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
index 96ab0227e82d..121e6cc4849b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino-emmc.dts
@@ -15,7 +15,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&reg_dcdc1>;
-	vqmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_eldo1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
-- 
2.17.1
