Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823AFC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5265D222BF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439873AbfIYSuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:50:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40464 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfIYSuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:50:15 -0400
Received: from muedsl-82-207-238-254.citykom.de ([82.207.238.254] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iDCMb-0005K2-1f; Wed, 25 Sep 2019 20:50:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     srinivas.kandagatla@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/2] dt-bindings: nvmem: add binding for Rockchip OTP controller
Date:   Wed, 25 Sep 2019 20:49:56 +0200
Message-Id: <20190925184957.14338-1-heiko@sntech.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Rockchip SoCs use a different IP for accessing special one-
time-programmable memory, so add a binding for these controllers.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/nvmem/rockchip-otp.txt           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt b/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
new file mode 100644
index 000000000000..40f649f7c2e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
@@ -0,0 +1,25 @@
+Rockchip internal OTP (One Time Programmable) memory device tree bindings
+
+Required properties:
+- compatible: Should be one of the following.
+  - "rockchip,px30-otp" - for PX30 SoCs.
+  - "rockchip,rk3308-otp" - for RK3308 SoCs.
+- reg: Should contain the registers location and size
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should be "otp", "apb_pclk" and "phy".
+- resets: Must contain an entry for each entry in reset-names.
+  See ../../reset/reset.txt for details.
+- reset-names: Should be "phy".
+
+See nvmem.txt for more information.
+
+Example:
+	otp: otp@ff290000 {
+		compatible = "rockchip,px30-otp";
+		reg = <0x0 0xff290000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
+			 <&cru PCLK_OTP_PHY>;
+		clock-names = "otp", "apb_pclk", "phy";
+	};
-- 
2.23.0

