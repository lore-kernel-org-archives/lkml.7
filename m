Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A0C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32CE205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfEHOiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:38:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45300 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfEHOhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:37:51 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hONha-0006TE-SP; Wed, 08 May 2019 16:37:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     broonie@kernel.org, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tony.xie@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 3/5] dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
Date:   Wed,  8 May 2019 16:37:11 +0200
Message-Id: <20190508143713.27954-4-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508143713.27954-1-heiko@sntech.de>
References: <20190508143713.27954-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Xie <tony.xie@rock-chips.com>

Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/mfd/rk808.txt         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 1683ec3245bc..04df07f6f793 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -3,11 +3,15 @@ RK8XX Power Management Integrated Circuit
 The rk8xx family current members:
 rk805
 rk808
+rk809
+rk817
 rk818
 
 Required properties:
 - compatible: "rockchip,rk805"
 - compatible: "rockchip,rk808"
+- compatible: "rockchip,rk809"
+- compatible: "rockchip,rk817"
 - compatible: "rockchip,rk818"
 - reg: I2C slave address
 - interrupts: the interrupt outputs of the controller.
@@ -45,6 +49,23 @@ Optional RK808 properties:
   the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
   very quickly with no slow ramp time.
 
+Optional shared RK809 and RK817 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
+- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
+- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
+
+Optional RK809 properties:
+- vcc8-supply:  The input supply for SWITCH_REG1
+- vcc9-supply:  The input supply for DCDC_REG5, SWITCH_REG2
+
+Optional RK817 properties:
+- vcc8-supply:  The input supply for BOOST
+- vcc9-supply:  The input supply for OTG_SWITCH
+
 Optional RK818 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -86,6 +107,21 @@ number as described in RK808 datasheet.
 	- SWITCH_REGn
 		- valid values for n are 1 to 2
 
+Following regulators of the RK809 and RK817 PMIC blocks are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK809 and RK817 datasheets.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 5 for RK809.
+		- valid values for n are 1 to 4 for RK817.
+	- LDO_REGn
+		- valid values for n are 1 to 9 for RK809.
+		- valid values for n are 1 to 9 for RK817.
+	- SWITCH_REGn
+		- valid values for n are 1 to 2 for RK809.
+	- BOOST for RK817
+	- OTG_SWITCH for RK817
+
 Following regulators of the RK818 PMIC block are supported. Note that
 the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
 number as described in RK818 datasheet.
@@ -98,6 +134,14 @@ number as described in RK818 datasheet.
 	- HDMI_SWITCH
 	- OTG_SWITCH
 
+It is necessary to configure three pins for both the RK809 and RK817, the three
+pins are "gpio_ts" "gpio_gt" "gpio_slp".
+	The gpio_gt and gpio_ts pins support the gpio function.
+	The gpio_slp pin is for controlling the pmic states, as below:
+		- reset
+		- power down
+		- sleep
+
 Standard regulator bindings are used inside regulator subnodes. Check
   Documentation/devicetree/bindings/regulator/regulator.txt
 for more details
-- 
2.20.1

