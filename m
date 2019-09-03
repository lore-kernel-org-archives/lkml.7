Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC184C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD02208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfICMIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:08:12 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:33524 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfICMIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:08:09 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 08:08:02 EDT
Received: from finley.xiao?rock-chips.com (unknown [192.168.167.224])
        by regular1.263xmail.com (Postfix) with ESMTP id 500B122C;
        Tue,  3 Sep 2019 20:00:57 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13045T140284270724864S1567511992953411_;
        Tue, 03 Sep 2019 20:00:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <29b5b6971d3a2ee134c0ffe9bdde52f1>
X-RL-SENDER: finley.xiao@rock-chips.com
X-SENDER: xf@rock-chips.com
X-LOGIN-NAME: finley.xiao@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Finley Xiao <finley.xiao@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        tony.xie@rock-chips.com, andy.yan@rock-chips.com,
        Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v1 1/3] dt-bindings: Add bindings for rk3308 clock controller
Date:   Tue,  3 Sep 2019 19:59:45 +0800
Message-Id: <20190903115947.26618-2-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190903115947.26618-1-finley.xiao@rock-chips.com>
References: <20190903115947.26618-1-finley.xiao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for Rockchip cru which found on
Rockchip SoCs.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 .../devicetree/bindings/clock/rockchip,rk3308.txt  | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308.txt

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3308.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3308.txt
new file mode 100644
index 000000000000..5d46c9b7f937
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3308.txt
@@ -0,0 +1,58 @@
+* Rockchip RK3308 Clock and Reset Unit
+
+The RK3308 clock controller generates and supplies clock to various
+controllers within the SoC and also implements a reset controller for SoC
+peripherals.
+
+Required Properties:
+
+- compatible: CRU should be "rockchip,rk3308-cru"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- #clock-cells: should be 1.
+- #reset-cells: should be 1.
+
+Optional Properties:
+
+- rockchip,grf: phandle to the syscon managing the "general register files"
+  If missing, pll rates are not changeable, due to the missing pll lock status.
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume. All available clocks are defined as
+preprocessor macros in the dt-bindings/clock/rk3308-cru.h headers and can be
+used in device tree sources. Similar macros exist for the reset sources in
+these files.
+
+External clocks:
+
+There are several clocks that are generated outside the SoC. It is expected
+that they are defined using standard clock bindings with following
+clock-output-names:
+ - "xin24m" - crystal input - required,
+ - "xin32k" - rtc clock - optional,
+ - "mclk_i2sx_xch_in" - external I2S or SPDIF clock - optional,
+ - "mac_clkin" - external MAC clock - optional
+
+Example: Clock controller node:
+
+	cru: clock-controller@ff500000 {
+		compatible = "rockchip,rk3308-cru";
+		reg = <0x0 0xff500000 0x0 0x1000>;
+		rockchip,grf = <&grf>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+Example: UART controller node that consumes the clock generated by the clock
+  controller:
+
+	uart0: serial@ff0a0000 {
+		compatible = "rockchip,rk3308-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff0a0000 0x0 0x100>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
+		clock-names = "baudclk", "apb_pclk";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
-- 
2.11.0



