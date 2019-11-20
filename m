Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB38CC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C300D20715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbfKTQOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:14:31 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:47874 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfKTQOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:14:30 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id xAKGDCJ3002142;
        Wed, 20 Nov 2019 19:13:17 +0300
Received: from oak.local (unknown [92.243.181.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 293C67A53;
        Wed, 20 Nov 2019 19:13:13 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     tom@radxa.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Akash Gajjar <akash@openedev.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     matwey.kornilov@gmail.com,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: rockchip: Add regulators for PCIe for Radxa Rock Pi 4 board
Date:   Wed, 20 Nov 2019 19:12:54 +0300
Message-Id: <20191120161302.5157-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <CAFjve-AT6c-yweF0mOPea-caG3n43nZzVPcwef-qp+n35JN9ig@mail.gmail.com>
References: <CAFjve-AT6c-yweF0mOPea-caG3n43nZzVPcwef-qp+n35JN9ig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 0.9V and 1.8V voltage regulators for Radxa Rock Pi 4 board PCIe.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
index 01f8effd8206..215fb02b6bd0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
@@ -53,6 +53,16 @@
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	vcc_0v9: vcc-0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -475,6 +485,8 @@
 	num-lanes = <4>;
 	pinctrl-0 = <&pcie_clkreqnb_cpm>;
 	pinctrl-names = "default";
+	vpcie0v9-supply = <&vcc_0v9>;
+	vpcie1v8-supply = <&vcc_1v8>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 };
 
-- 
2.16.4

