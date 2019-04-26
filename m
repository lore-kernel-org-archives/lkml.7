Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C5DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6D9206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DbFctEFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfDZC4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:56:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12638 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfDZC4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:56:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc2735a0000>; Thu, 25 Apr 2019 19:56:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Apr 2019 19:56:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Apr 2019 19:56:29 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 02:56:29 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Apr
 2019 02:56:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Apr 2019 02:56:29 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cc273590003>; Thu, 25 Apr 2019 19:56:28 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <linus.walleij@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <pdeschrijver@nvidia.com>, <josephl@nvidia.com>,
        <smangipudi@nvidia.com>, <ldewangan@nvidia.com>,
        <vidyas@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 1/2] dt-binding: Tegra194 pinctrl support
Date:   Fri, 26 Apr 2019 08:26:17 +0530
Message-ID: <1556247378-3335-1-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556247386; bh=gttAJcs6P3kaq53FjEVB4CsAbUUe3aO+wz7HAYhiBKA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=DbFctEFqfwNsTYvKpdtBZlV/8EMymGVR0Rj8+XlA0rUlujU3fsiVbxcsCwKO1GV0W
         eusrZG/5bRC8fjSRokGsQUFfCTuvaB6Wt/RKabFAeYWesL2ggFWVSt6oV7EJzOXcNc
         Q68Frah8AzYYGGeetDWsQ82k+lBhshPBdM8aI0H18En0Yj8ht9EsyvGuXQTMkM8DUU
         r4xbqr3hShEcIUJ6es2m+1SwPdVcLJ9diPNH1xWT8llHPbmyLYsr2R2Cf/VCTJbD3n
         BRt7yt9azt+2Tz7ZsELHSZ5CYXOqlLq+W3faEHT/y5CEIAI3JG07jGkCQ0anQ2ioZB
         ObVpSXYasn+cA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string and other fields used in pinctrl
driver for Tegra194 in nvidia,tegra210-pinmux.txt

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 .../bindings/pinctrl/nvidia,tegra210-pinmux.txt    | 43 +++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
index 85f2114..c4e802d 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra210-pinmux.txt
@@ -1,7 +1,7 @@
-NVIDIA Tegra210 pinmux controller
+NVIDIA Tegra210/194 pinmux controller
 
 Required properties:
-- compatible: "nvidia,tegra210-pinmux"
+- compatible: "nvidia,tegra210-pinmux" or "nvidia,tegra194-pinmux"
 - reg: Should contain a list of base address and size pairs for:
   - first entry: The APB_MISC_GP_*_PADCTRL registers (pad control)
   - second entry: The PINMUX_AUX_* registers (pinmux)
@@ -83,6 +83,10 @@ Valid values for pin and group names (nvidia,pin) are:
     These correspond to Tegra PINMUX_AUX_* (pinmux) registers. Any property
     that exists in those registers may be set for the following pin names.
 
+  Tegra194:
+    pex_l5_clkreq_n_pgg0, pex_l5_rst_n_pgg1
+
+  Tegra210:
     In Tegra210, many pins also have a dedicated APB_MISC_GP_*_PADCTRL
     register. Where that is true, and property that exists in that register
     may also be set on the following pin names.
@@ -127,12 +131,15 @@ Valid values for pin and group names (nvidia,pin) are:
     registers. Note that where one of these registers controls a single pin
     for which a PINMUX_AUX_* exists, see the list above for the pin name to
     use when configuring the pinmux.
-
+  Tegra210:
     pa6, pcc7, pe6, pe7, ph6, pk0, pk1, pk2, pk3, pk4, pk5, pk6, pk7, pl0, pl1,
     pz0, pz1, pz2, pz3, pz4, pz5, sdmmc1, sdmmc2, sdmmc3, sdmmc4
+  Tegra194:
+    pex_l5_clkreq_n_pgg0, pex_l5_rst_n_pgg1
 
 Valid values for nvidia,functions are:
 
+  Tegra210:
     aud, bcl, blink, ccla, cec, cldvfs, clk, core, cpu, displaya, displayb,
     dmic1, dmic2, dmic3, dp, dtv, extperiph3, i2c1, i2c2, i2c3, i2cpmu, i2cvi,
     i2s1, i2s2, i2s3, i2s4a, i2s4b, i2s5a, i2s5b, iqc0, iqc1, jtag, pe, pe0,
@@ -140,9 +147,12 @@ Valid values for nvidia,functions are:
     sdmmc1, sdmmc3, shutdown, soc, sor0, sor1, spdif, spi1, spi2, spi3, spi4,
     sys, touch, uart, uarta, uartb, uartc, uartd, usb, vgp1, vgp2, vgp3, vgp4,
     vgp5, vgp6, vimclk, vimclk2
+  Tegra194:
+    pe5
 
-Example:
+Examples:
 
+  Tegra210:
 	pinmux: pinmux@70000800 {
 		compatible = "nvidia,tegra210-pinmux";
 		reg = <0x0 0x700008d4 0x0 0x2a8>, /* Pad control registers */
@@ -163,4 +173,27 @@ Example:
 			};
 		};
 	};
-};
+
+  Tegra194:
+		tegra_pinctrl: pinmux: pinmux@2430000 {
+			compatible = "nvidia,tegra194-pinmux";
+			reg = <0x2430000 0x17000
+			       0xc300000 0x4000>;
+			#gpio-range-cells = <2>;
+			pex_rst_c5_out_state: pex_rst_c5_out {
+				pex_rst {
+					nvidia,pins = "pex_l5_rst_n_pgg1";
+					nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+					nvidia,lpdr = <TEGRA_PIN_ENABLE>;
+					nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+					nvidia,io-high-voltage = <TEGRA_PIN_ENABLE>;
+					nvidia,tristate = <TEGRA_PIN_DISABLE>;
+					nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				};
+			};
+		};
+		pinmuxtest@0 {
+			compatible = "nvidia,tegra194-pinmux-test";
+			pinctrl-names = "pex_rst";
+			pinctrl-0 = <&pex_rst_c5_out_state>;
+		};
-- 
2.7.4

