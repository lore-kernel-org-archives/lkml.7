Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC87C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB20247B6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0WjSdiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEaUTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:19:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43837 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfEaUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:19:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id gn7so4418753plb.10;
        Fri, 31 May 2019 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHXPz3bmXRLX7mBl1qQo7PINranTFtOG3PdQWBgTOjU=;
        b=a0WjSdiLPggj9E3E7xXCRM/5laD1Sw++NUkYtQzHWZdn9aw3TdUfdHoMtk3plE52kE
         zMRGyvNLZS3CcPo5HD9vJcXnxp89GfGTotKaG9tISjVp8r1DTl2umuT96gRiMzpFEEU+
         8P3fj2xp47B3N8GQxzFuxcD2nd1XrGvsuRI85nX1lzcLi6AzWzzZRKryCQHfglMToY40
         HGTN3P7vh6LeQEvsB4lUCgipJqjL16o4H1YMkF4QUD00pC6+GnnXz8Ce17Qtt+5iKJ7L
         WxYe5SwXejZnhtSGfBMKIoKlNOyL7K/bf1gK9WSXgUXpcmw6xHG/4hUmXFJ4WP75ajWo
         8JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHXPz3bmXRLX7mBl1qQo7PINranTFtOG3PdQWBgTOjU=;
        b=YylUs0v4q0WYDimqmAtYCBl58fbxgB9o6tzujAEyzE8ij2N3ssI4roTXwhtC57kNMQ
         oTgJ6zD8YTrkgk4DzZlODcEsVNLKCVvX+TDOKnZoZdTnCUtt4qNYX8lr19rRtpyTbYUt
         9yE7Ot34iK4u0T+iVJYaIkECYlB1Y+FKkpRqMllgbOSHJ/9ZnA962G8Wb3jKDJ09MDPU
         g6KhCp5XwCGPiaVnTpqoe6Y6O5JHxoYGbQlVvf9PXSdtErufLaLNoy5n0BWUYkaCMJBa
         UmXGDtdfDz3Ip1i87w6srxUa1XhSJ8Sr1FA+wFwHT3/mC0lcvFq7acpVPpMjCoHqnydV
         fc9w==
X-Gm-Message-State: APjAAAVHP9FWBuS3ouqgn418Ese+qBsQ4aPPBV+/1JJfJL3OP2/CX7j8
        eJtwZCXCLi5i1QHkk96YFHU=
X-Google-Smtp-Source: APXvYqx5vljHHiOIRFhCMYdS3kAzR4Rv1/1+nmNLeBVQtZibd3Bh1eOQllGPzSyNezBbnOOE4+G+Yw==
X-Received: by 2002:a17:902:a405:: with SMTP id p5mr11115959plq.51.1559333961553;
        Fri, 31 May 2019 13:19:21 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.35])
        by smtp.gmail.com with ESMTPSA id j20sm4408050pff.183.2019.05.31.13.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 13:19:21 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Add missing configuration pwr amd rst for PCIe
Date:   Fri, 31 May 2019 20:19:13 +0000
Message-Id: <20190531201913.1122-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add missing PCIe gpio pin (#PCIE_PWR) for vcc3v3_pcie power
regulator node also add missing reset pinctrl (#PCIE_PERST_L) for PCIe node.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
using schematics: thanks for suggested by Manivannan
[1] https://dl.vamrs.com/products/rock960/docs/hw/rock960_sch_v12_20180314.pdf

Changes from prevoius patch:
[2] https://patchwork.kernel.org/patch/10968695/

Fix the suject and commit message and corrected the PWR and PERST configuration
as per shematics and dts nodes.
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts    | 7 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts  | 7 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 3 +--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index 6b059bd7a04f..94e2a59bc1c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -89,6 +89,8 @@
 
 &pcie0 {
 	ep-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
 };
 
 &pinctrl {
@@ -104,6 +106,11 @@
 			rockchip,pins =
 				<1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
+
+		pcie_perst_l: pcie-perst-l {
+			rockchip,pins =
+				<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	usb2 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 12285c51cceb..665fe09c7c74 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -64,6 +64,8 @@
 
 &pcie0 {
 	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
 };
 
 &pinctrl {
@@ -104,6 +106,11 @@
 			rockchip,pins =
 				<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 			};
+
+		pcie_perst_l: pcie-perst-l {
+			rockchip,pins =
+				<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	usb2 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index c7d48d41e184..3df0cd67b4b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -55,6 +55,7 @@
 
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
+		gpio = <&gpio2 RK_PA5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie_drv>;
@@ -382,8 +383,6 @@
 
 &pcie0 {
 	num-lanes = <4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreqn_cpm>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 	status = "okay";
 };
-- 
2.21.0

