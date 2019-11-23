Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E99C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1212420719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfKWUiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:38:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:34386 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfKWUiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 15:38:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AB49B14F;
        Sat, 23 Nov 2019 20:38:12 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 7/8] ARM: dts: rtd1195: Add Realtek Horseradish EVB
Date:   Sat, 23 Nov 2019 21:37:58 +0100
Message-Id: <20191123203759.20708-8-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191123203759.20708-1-afaerber@suse.de>
References: <20191123203759.20708-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Device Tree for Realtek's RTD1195 EVB "Horseradish".

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4: New
 
 arch/arm/boot/dts/Makefile                |  1 +
 arch/arm/boot/dts/rtd1195-horseradish.dts | 32 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 arch/arm/boot/dts/rtd1195-horseradish.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4853a13c8cf2..7f1410ea7dff 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -866,6 +866,7 @@ dtb-$(CONFIG_ARCH_RDA) += \
 	rda8810pl-orangepi-2g-iot.dtb \
 	rda8810pl-orangepi-i96.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += \
+	rtd1195-horseradish.dtb \
 	rtd1195-mele-x1000.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
diff --git a/arch/arm/boot/dts/rtd1195-horseradish.dts b/arch/arm/boot/dts/rtd1195-horseradish.dts
new file mode 100644
index 000000000000..9d06d3d34c74
--- /dev/null
+++ b/arch/arm/boot/dts/rtd1195-horseradish.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+/dts-v1/;
+
+#include "rtd1195.dtsi"
+
+/ {
+	compatible = "realtek,horseradish", "realtek,rtd1195";
+	model = "Realtek Horseradish EVB";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@a800 {
+		device_type = "memory";
+		reg = <0x0000a800 0x17ff5800>, /* boot ROM to r-bus */
+		      <0x18070000 0x00090000>, /* r-bus to NOR flash */
+		      <0x19100000 0x26f00000>; /* NOR flash to 1 GiB */
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.16.4

