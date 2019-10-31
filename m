Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A77CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292F02080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfJaXQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:16:35 -0400
Received: from palmtree.beeroclock.net ([178.79.160.154]:43066 "EHLO
        palmtree.beeroclock.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:16:34 -0400
Received: from beros.lan (89-160-129-47.du.xdsl.is [89.160.129.47])
        by palmtree.beeroclock.net (Postfix) with ESMTPSA id 66ACF1FAF3;
        Thu, 31 Oct 2019 23:12:33 +0000 (UTC)
From:   Karl Palsson <karlp@tweak.net.au>
To:     mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Karl Palsson <karlp@tweak.net.au>
Subject: [PATCH 3/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2-IoT Box
Date:   Thu, 31 Oct 2019 23:12:16 +0000
Message-Id: <20191031231216.30903-3-karlp@tweak.net.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031231216.30903-2-karlp@tweak.net.au>
References: <20191031231216.30903-2-karlp@tweak.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IoT-Box is a dock for the NanoPi Duo2, adding two USB host ports, a
10/100 ethernet port, a variety of pin headers for i2c and uarts, and a
quad band 2G GSM module, a SIM800C.

Full documentation and schematics available from vendor:
http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2_IoT-Box

Signed-off-by: Karl Palsson <karlp@tweak.net.au>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts  | 45 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d8bf02abcda1..d605766441dd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1097,6 +1097,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-libretech-all-h3-cc.dtb \
 	sun8i-h3-mapleboard-mp130.dtb \
 	sun8i-h3-nanopi-duo2.dtb \
+	sun8i-h3-nanopi-duo2-iotbox.dtb \
 	sun8i-h3-nanopi-m1.dtb	\
 	sun8i-h3-nanopi-m1-plus.dtb \
 	sun8i-h3-nanopi-neo.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts
new file mode 100644
index 000000000000..d4f347192199
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2019 Karl Palsson <karlp@tweak.net.au>
+ */
+
+#include "sun8i-h3-nanopi-duo2.dts"
+
+/ {
+	model = "FriendlyARM NanoPi Duo2 IoT Box";
+	compatible = "friendlyarm,nanopi-duo2-iotbox",
+		"friendlyarm,nanopi-duo2",
+		"allwinner,sun8i-h3";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+/* Not addressed, SIM800C module on uart3 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>, <&uart3_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
-- 
2.20.1

