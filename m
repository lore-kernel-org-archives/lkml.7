Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4DFC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D4B2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLJMpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:45:07 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:33208 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbfLJMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:45:06 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ieesx-00054G-9u; Tue, 10 Dec 2019 13:45:03 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id xBACj2Fp005769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 10 Dec 2019 13:45:02 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH 2/3] arm64: dts: rockchip: Enable PD for USB-C-Port on
 rk3399-roc-pc.
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Organization: five technologies GmbH
Message-ID: <678df227-38be-47af-7ee3-741a391a196c@fivetechno.de>
Date:   Tue, 10 Dec 2019 13:45:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1575981906;7d90b998;
X-HE-SMSGID: 1ieesx-00054G-9u
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB-C-Port 0 on rk3399-roc-pc is designed to supply the board.
To meet the power requirements of up to 45W a power delivery (PD)
compatible supply is needed. To configure the PD the node of the
fusb302 needs a connector property with desired PD description.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
Presently the board in mainline has to be powered from a 12V supply,
connected to two pins on the expansion header as the standard 5V
delivered by the unconfigured USB-C plug is not enough for higher
loads or peripherals on USB or M.2.

With this patch the board requests 15V from the PD and runs fine
on high loads with NVME SSD, Ethernet, SDIO WLAN and USB peripherals.
During boot the 12V supply is still needed for some seconds,
as the fusb302 shuts down or resets the PD shortly when initializing (BUG?).

The board's 12V line is running presently on 5V, the default output
voltage of the MP8859 on I2C-7, for wich no mainline kernel driver exists yet.
---
  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 16 ++++++++++++++--
  1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 8e01b04144b7..90783b2b1d1f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -6,6 +6,7 @@
  /dts-v1/;
  #include <dt-bindings/input/linux-event-codes.h>
  #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/usb/pd.h>
  #include "rk3399.dtsi"
  #include "rk3399-opp.dtsi"
  
@@ -540,11 +541,22 @@ fusb0: usb-typec@22 {
  		compatible = "fcs,fusb302";
  		reg = <0x22>;
  		interrupt-parent = <&gpio1>;
-		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
  		pinctrl-names = "default";
  		pinctrl-0 = <&fusb0_int>;
  		vbus-supply = <&vcc_vbus_typec0>;
-		status = "okay";
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C-0";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 15000, 3000)
+				     PDO_PPS_APDO(5000, 15000, 3000)>;
+			op-sink-microwatt = <45000000>;
+		};
  	};
  };
  
-- 
2.24.0

