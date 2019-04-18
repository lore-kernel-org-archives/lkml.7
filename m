Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8620C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9144A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555604299;
	bh=Xi24po2KN4j+1dHugTua8MzPs3SRhNUDTVu86FSi3ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CAn0xKRW66Fwsx/ECdVaX1GwgC8xlQSNAVvbPNMxZspzU36+p4zVjjZMhzCwSh/KC
	 Ch9pqytn4gzEonoJrHvf4jYvrC1Kl+Z5U1n4Hw9xYJRJxCOLfmcYHUNEE8ZDK9fW4r
	 CVL6iKDS1/P+djXI5Wiwk8MAGddZWbNF2XZ3h0dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389710AbfDRQSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:18:17 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34390 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388401AbfDRQSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:18:07 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 5F11D602D3; Fri, 19 Apr 2019 00:18:05 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: allwinner: a64: bananapi-m64: Enable PMIC USB power supply
Date:   Fri, 19 Apr 2019 00:18:04 +0800
Message-Id: <20190418161804.17723-4-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418161804.17723-1-wens@kernel.org>
References: <20190418161804.17723-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Bananapi M64 has a micro-USB connector with USB OTG support (that
is already enabled). VBUS from this connector is wired to the PMIC's
VBUS input.

Enable the PMIC's USB power supply on this board, and also hook it up
to the USB PHY.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 0a56c0c23ba1..855d1044b9a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -394,8 +394,13 @@
 	status = "okay";
 };
 
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
 	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
 	usb0_vbus-supply = <&reg_drivevbus>;
 	status = "okay";
 };
-- 
2.20.1

