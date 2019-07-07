Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E25C48BDC
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05217206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ3XsY8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfGGNX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:23:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGGNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:23:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so5633391wrm.2;
        Sun, 07 Jul 2019 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PozgmYpk6e3239kZizZzBtKP9r6DhYvVMkCeoENwK5I=;
        b=AJ3XsY8NEjeBatMG4PqOVhNRVdbJjoDylIKGyllCrFJwaakcBJ+0DAoC8EARR1/AUQ
         YmNlLjGQBELKF4TR/02qTu3RnelvSXLpMpOFJEEjNXVbAB3J279FIG9RI3m0itfLeTbb
         s3Amqemg5YinR39IY90gQ3GrjfZ3Ro6VcfSoi7b/RLaP3gPIzVrfgG9YxnLiuifgSghJ
         Eq+SdXOg390GlE9r4bjasRkUN9RR7CFMukhOMGXCpiJptfdVgTrsxXVBBSd5LC/CKV6y
         ji7aDwnNNAbOScjXSI9fpT+mOdNLnXxASRmPNsn4yOQk0EmXRTeHuXo7sTlS21S5Weo5
         qr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PozgmYpk6e3239kZizZzBtKP9r6DhYvVMkCeoENwK5I=;
        b=OtLTKfI5HIDf7dAmEk3dFuY4s6NRoNUwyZBMWjC4pxu5gnukFTIuqg+5TyN8m1F05I
         1YUBvi9SQdItbH8OoXjljO+kAdxehLwUtOO3VH8iA8GscWDfH+I7gELVye3nmdJtkpIB
         5szBZQp+ALpsa1ykGjjeJ6YwmHkSezZAXE+bdxTI0xe0iJm3P2rJES0B602VwwEau8xX
         BKcPXgNDEiIS5JHobL/NaH5VzhfV4Yuxkfnel4yLp71qI4vPdFvgLQhK2+6jXoqxqOzI
         6JcqNbg9OGZ4aqF28z+v2tZ1fF0UKJiIrBoeFvSCTIlj8tf1BaAZ49YbCsKnO2pZKki5
         srTA==
X-Gm-Message-State: APjAAAVhU4bitjCFLDufC5P09wso0UdkapM6yKj7TgDx+dV+8m4mhhpt
        Qjlf4GTclLugadIFaHkOImo=
X-Google-Smtp-Source: APXvYqyLTMPgQmEK2+zOPxs1c/zJny/YSIhqAGndbB9+JqNn+j/q9cwwNQGN6pU1g2R1MipoXZd3JA==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr11325854wrp.145.1562505834319;
        Sun, 07 Jul 2019 06:23:54 -0700 (PDT)
Received: from arks.localdomain (179.red-83-58-138.dynamicip.rima-tde.net. [83.58.138.179])
        by smtp.gmail.com with ESMTPSA id z5sm9876282wmf.48.2019.07.07.06.23.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 06:23:53 -0700 (PDT)
Date:   Sun, 7 Jul 2019 15:23:51 +0200
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: realtek: Add bpi-w2 board support and its
 RTD1296 SoC
Message-ID: <20190707132351.GG13340@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic device tree description for the Bannana Pi W2 (bpi-w2) and its
SoC. The board should be able to boot up to a ram based rootfs.

The only information available on the memreserve areas are the macro
names holing the addresses in the original source code:

 - 0x00000000 0x00100000 - apparently used to fix an undefined bug
 - 0x02600000 0x00c00000 - ION_AUDIO_HEAP
 - 0x03200000 0x0b800000 - ION_MEDIA_HEAP 1
 - 0x10000000 0x00014000 - ACPU_IDMEM
 - 0x14200000 0x09200000 - ION_MEDIA_HEAP 2

The CPUs still lack the enable-method property "rtk-spin-table" as
previously noted in [1].

[1] - commit 72a7786c0a0d65 ("ARM64: dts: Add Realtek RTD1295 and Zidoo X9S")

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---
 arch/arm64/boot/dts/realtek/Makefile          |  1 +
 .../dts/realtek/rtd1296-bananapi-bpi-w2.dts   | 27 +++++++
 arch/arm64/boot/dts/realtek/rtd1296.dtsi      | 77 +++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296-bananapi-bpi-w2.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index 90c897ac3f7a..c1a6654e7d5b 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -2,3 +2,4 @@
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-mele-v9.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-bananapi-bpi-w2.dtb
diff --git a/arch/arm64/boot/dts/realtek/rtd1296-bananapi-bpi-w2.dts b/arch/arm64/boot/dts/realtek/rtd1296-bananapi-bpi-w2.dts
new file mode 100644
index 000000000000..1a81b9f2c3c3
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1296-bananapi-bpi-w2.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include "rtd1296.dtsi"
+
+/ {
+	model = "Banana Pi BPI-W2";
+	compatible = "bananapi,bpi-w2", "realtek,rtd1296";
+
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0x98007800";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0x80000000>; /* 2048 MB */
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1296.dtsi b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
new file mode 100644
index 000000000000..f7a5f3b9698c
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+// extension because of bug reported in realtek's source code
+/memreserve/ 0x00000000 0x00100000;
+
+/memreserve/ 0x02600000 0x00c00000;
+/memreserve/ 0x03200000 0x0b800000;
+/memreserve/ 0x10000000 0x00014000;
+/memreserve/ 0x14200000 0x09200000;
+
+#include "rtd129x.dtsi"
+
+/ {
+	compatible = "realtek,rtd1296";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		A53_0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0>;
+			cpu-release-addr = <0x0 0x9801AA44>;
+			next-level-cache = <&a53_l2>;
+		};
+
+		A53_1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x1>;
+			cpu-release-addr = <0x0 0x9801AA44>;
+			next-level-cache = <&a53_l2>;
+		};
+
+		A53_2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x02>;
+			cpu-release-addr = <0x0 0x9801AA44>;
+			next-level-cache = <&a53_l2>;
+		};
+
+		A53_3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x03>;
+			cpu-release-addr = <0x0 0x9801AA44>;
+			next-level-cache = <&a53_l2>;
+		};
+
+		a53_l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	soc@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x98000000 0x70000>;
+		compatible = "simple-bus";
+		device_type = "soc";
+		ranges;
+	};
+
+	arch_timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0xf08>,
+			<1 14 0xf08>,
+			<1 11 0xf08>,
+			<1 10 0xf08>;
+		clock-frequency = <27000000>;
+	};
+};
-- 
2.21.0

