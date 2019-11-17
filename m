Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A143C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 10:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3490220740
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 10:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfKQKQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 05:16:56 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:44716 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfKQKQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 05:16:56 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id xAHAFqoA011611;
        Sun, 17 Nov 2019 13:15:57 +0300
Received: from oak.local (unknown [92.243.181.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 335C137923;
        Sun, 17 Nov 2019 13:15:53 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Akash Gajjar <akash@openedev.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
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
Subject: [PATCH v2] arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 board
Date:   Sun, 17 Nov 2019 13:15:37 +0300
Message-Id: <20191117101545.6406-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radxa Rock Pi 4 is equipped with M.2 PCIe slot,
so enable PCIe for the board.

The changes has been tested with Intel SSD 660p series device.

    01:00.0 Class 0108: Device 8086:f1a8 (rev 03)

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---

Changes since v1:
 - add vpcie3v3-supply

 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
index 1ae1ebd4efdd..01f8effd8206 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
@@ -463,6 +463,21 @@
 	pmu1830-supply = <&vcc_3v0>;
 };
 
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+
+	ep-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;
+	max-link-speed = <2>;
+	num-lanes = <4>;
+	pinctrl-0 = <&pcie_clkreqnb_cpm>;
+	pinctrl-names = "default";
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
-- 
2.16.4

