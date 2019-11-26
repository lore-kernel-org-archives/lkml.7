Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D16C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE832075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfKZQ4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:56:07 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:34757 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfKZQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:56:07 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xAQGtfEc076814;
        Wed, 27 Nov 2019 01:55:41 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Wed, 27 Nov 2019 01:55:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from localhost.localdomain (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xAQGtahH076800
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 27 Nov 2019 01:55:41 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: split rk3399-rockpro64 for v2 and v2.1 boards
Date:   Wed, 27 Nov 2019 01:55:29 +0900
Message-Id: <20191126165529.30703-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch splits rk3399-rockpro64 dts file to 2 files for v2 and
v2.1 boards.

Both v2 and v2.1 boards can use almost same settings but we find a
difference in I2C address of audio CODEC ES8136.

Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  3 +-
 .../dts/rockchip/rk3399-rockpro64-v2.1.dts    | 30 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-rockpro64-v2.dts | 30 +++++++++++++++++++
 ...99-rockpro64.dts => rk3399-rockpro64.dtsi} | 18 -----------
 4 files changed, 62 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.1.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
 rename arch/arm64/boot/dts/rockchip/{rk3399-rockpro64.dts => rk3399-rockpro64.dtsi} (97%)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 48fb631d5451..3debaeb517fd 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -33,6 +33,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
-dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.1.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.1.dts
new file mode 100644
index 000000000000..9450207bedad
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.1.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Katsuhiro Suzuki <katsuhiro@katsuster.net>
+ */
+
+/dts-v1/;
+#include "rk3399-rockpro64.dtsi"
+
+/ {
+	model = "Pine64 RockPro64 v2.1";
+	compatible = "pine64,rockpro64", "rockchip,rk3399";
+};
+
+&i2c1 {
+	es8316: codec@11 {
+		compatible = "everest,es8316";
+		reg = <0x11>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s1_p0_0>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
new file mode 100644
index 000000000000..7bd37eaa1d57
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
+ * Copyright (c) 2019 Katsuhiro Suzuki <katsuhiro@katsuster.net>
+ */
+
+/dts-v1/;
+#include "rk3399-rockpro64.dtsi"
+
+/ {
+	model = "Pine64 RockPro64 v2";
+	compatible = "pine64,rockpro64", "rockchip,rk3399";
+};
+
+&i2c1 {
+	es8316: codec@10 {
+		compatible = "everest,es8316";
+		reg = <0x10>;
+		clocks = <&cru SCLK_I2S_8CH_OUT>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+
+		port {
+			es8316_p0_0: endpoint {
+				remote-endpoint = <&i2s1_p0_0>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
similarity index 97%
rename from arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
rename to arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 7f4b2eba31d4..183eda4ffb9c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -4,16 +4,12 @@
  * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
  */
 
-/dts-v1/;
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3399.dtsi"
 #include "rk3399-opp.dtsi"
 
 / {
-	model = "Pine64 RockPro64";
-	compatible = "pine64,rockpro64", "rockchip,rk3399";
-
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
@@ -476,20 +472,6 @@ &i2c1 {
 	i2c-scl-rising-time-ns = <300>;
 	i2c-scl-falling-time-ns = <15>;
 	status = "okay";
-
-	es8316: codec@11 {
-		compatible = "everest,es8316";
-		reg = <0x11>;
-		clocks = <&cru SCLK_I2S_8CH_OUT>;
-		clock-names = "mclk";
-		#sound-dai-cells = <0>;
-
-		port {
-			es8316_p0_0: endpoint {
-				remote-endpoint = <&i2s1_p0_0>;
-			};
-		};
-	};
 };
 
 &i2c3 {
-- 
2.24.0

