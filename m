Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCFAC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB7621721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391994AbfFMQ14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:27:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54928 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfFMQ1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:27:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2E34F27D7A1
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     devicetree@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vicente Bergas <vicencb@gmail.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Update DWC3 modules on RK3399 SoCs
Date:   Thu, 13 Jun 2019 18:27:45 +0200
Message-Id: <20190613162745.12195-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per binding documentation [1], the DWC3 core should have the "ref",
"bus_early" and "suspend" clocks. As explained in the binding, those
clocks are required for new platforms but not for existing platforms
before commit fe8abf332b8f ("usb: dwc3: support clocks and resets for
DWC3 core").

However, as those clocks are really treated as required, this ends with
having some annoying messages when the "rockchip,rk3399-dwc3" is used:

[    1.724107] dwc3 fe800000.dwc3: Failed to get clk 'ref': -2
[    1.731893] dwc3 fe900000.dwc3: Failed to get clk 'ref': -2
[    2.495937] dwc3 fe800000.dwc3: Failed to get clk 'ref': -2
[    2.647239] dwc3 fe900000.dwc3: Failed to get clk 'ref': -2

In order to remove those annoying messages, update the DWC3 hardware
module node and add all the required clocks. With this change, both, the
glue node and the DWC3 core node, have the clocks defined, but that's
not really a problem and there isn't a side effect on do this. So, we
can get rid of the annoying get clk error messages.

[1] Documentation/devicetree/bindings/usb/dwc3.txt

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 196ac9b78076..a15348d185ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -414,6 +414,9 @@
 			compatible = "snps,dwc3";
 			reg = <0x0 0xfe800000 0x0 0x100000>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&cru SCLK_USB3OTG0_REF>, <&cru ACLK_USB3OTG0>,
+				 <&cru SCLK_USB3OTG0_SUSPEND>;
+			clock-names = "ref", "bus_early", "suspend";
 			dr_mode = "otg";
 			phys = <&u2phy0_otg>, <&tcphy0_usb3>;
 			phy-names = "usb2-phy", "usb3-phy";
@@ -447,6 +450,9 @@
 			compatible = "snps,dwc3";
 			reg = <0x0 0xfe900000 0x0 0x100000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&cru SCLK_USB3OTG1_REF>, <&cru ACLK_USB3OTG1>,
+				 <&cru SCLK_USB3OTG1_SUSPEND>;
+			clock-names = "ref", "bus_early", "suspend";
 			dr_mode = "otg";
 			phys = <&u2phy1_otg>, <&tcphy1_usb3>;
 			phy-names = "usb2-phy", "usb3-phy";
-- 
2.20.1

