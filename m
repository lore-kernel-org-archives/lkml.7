Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B08CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568002064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436843AbfJWWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:41:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57438 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436833AbfJWWlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:41:22 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iNPJg-0004Ia-RW; Thu, 24 Oct 2019 00:41:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] arm64: dts: rockchip: add px30 otp controller
Date:   Thu, 24 Oct 2019 00:41:13 +0200
Message-Id: <20191023224113.3268-1-heiko@sntech.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The px30 soc contains a controller for one-time-programmable memory,
so add the necessary node for it and the fields defined in it by default.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index dd58b1bc5981..767f3ce6e9f7 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -664,6 +664,30 @@
 		status = "disabled";
 	};
 
+	otp: nvmem@ff290000 {
+		compatible = "rockchip,px30-otp";
+		reg = <0x0 0xff290000 0x0 0x4000>;
+		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
+			 <&cru PCLK_OTP_PHY>;
+		clock-names = "otp", "apb_pclk", "phy";
+		resets = <&cru SRST_OTP_PHY>;
+		reset-names = "phy";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* Data cells */
+		cpu_id: id@7 {
+			reg = <0x07 0x10>;
+		};
+		cpu_leakage: cpu-leakage@17 {
+			reg = <0x17 0x1>;
+		};
+		performance: performance@1e {
+			reg = <0x1e 0x1>;
+			bits = <4 3>;
+		};
+	};
+
 	cru: clock-controller@ff2b0000 {
 		compatible = "rockchip,px30-cru";
 		reg = <0x0 0xff2b0000 0x0 0x1000>;
-- 
2.23.0

