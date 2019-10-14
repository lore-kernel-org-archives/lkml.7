Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53747C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C1D20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="fMeNYw08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfJNGVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:21:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45631 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729899AbfJNGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:21:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so8270309pgj.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 23:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dt9aSfmBZ6LIV0i55cEdXYechi1vICbK96yocgmvqwk=;
        b=fMeNYw08oac+yqfjGz66wpSYP6I5s4d03WYFUwW7jPVKzEYacgso3WXR/vnIWvLWEP
         DfchWo8zVwmHxi6GKS1k/fpHOwmvAny5wvuYNGu2594W00s3xQOp7LVPcnrQiCSnfWU3
         NOELA+GK3dKPVeok9z7/hXLUxdDOYroqqMZb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dt9aSfmBZ6LIV0i55cEdXYechi1vICbK96yocgmvqwk=;
        b=hu7MoBaT6WZNi0quWZCnEPpmL61i/y9hRub+p26uwBV59E/dnNrsix2CKf0boIAIkH
         XPs5mlgMS22sWn0P1KUHcjLWutaxcNDzLHOBjO4qSU43q/16dvL5LkJ4tlmu7Gx3ONXw
         L/U1/e+CkSKGcCMTcZfgcZuz5EQc60n+4RBmz7D06Y86N2w0BvHwXlHv8vlfkHOVNNti
         UtJUZ2vjQgU5q1WoIuT4/uI8YExBSbPKPz9Bepbvo1jsyjKGygZgiBPaZ75/drS0iGj7
         +CgWjoZffb8G++GgKXsRfhKtnU+fTOzdq322lE/JJc8QAlQUm5sRNZjzIt74p+s/Phc+
         eSjQ==
X-Gm-Message-State: APjAAAWOib0uNfMI6KnXh/1+ql9K63jLwVlKiStoNoUhhPwAfX0rssba
        uUmQtNDFWpZQCP98lXfe19LMrA==
X-Google-Smtp-Source: APXvYqyg5mD4dW8rMIaeqg1wy4Th5FUhx0sXYlfMLKeDe3PUH+hGw/J1/3zoyaDIccQRSqG/n/Fvew==
X-Received: by 2002:a63:1417:: with SMTP id u23mr30319138pgl.279.1571034112068;
        Sun, 13 Oct 2019 23:21:52 -0700 (PDT)
Received: from shiro.work (p1092222-ipngn200709sizuokaden.shizuoka.ocn.ne.jp. [220.106.235.222])
        by smtp.googlemail.com with ESMTPSA id g24sm16874074pfi.81.2019.10.13.23.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 23:21:51 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
Cc:     daniel@0x0f.com, Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: mstar: Add infinity series dtsi
Date:   Mon, 14 Oct 2019 15:15:58 +0900
Message-Id: <20191014061617.10296-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014061617.10296-1-daniel@0x0f.com>
References: <20191014061617.10296-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds initial dtsis for the infinity SoC family and a dtsi for
the infinity3 based msc313e part.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                              |  1 +
 arch/arm/boot/dts/Makefile               |  3 +
 arch/arm/boot/dts/infinity.dtsi          | 71 ++++++++++++++++++++++++
 arch/arm/boot/dts/infinity3-msc313e.dtsi | 14 +++++
 arch/arm/boot/dts/infinity3.dtsi         | 11 ++++
 5 files changed, 100 insertions(+)
 create mode 100644 arch/arm/boot/dts/infinity.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index e35c3eb2b680..8045563ac76f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1986,6 +1986,7 @@ M:	Daniel Palmer <daniel@thingy.jp>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 F:	Documentation/devicetree/bindings/arm/mstar.yaml
 F:	arch/arm/mach-mstar/
+F:	arch/arm/boot/dts/infinity*.dtsi
 S:	Maintained
 
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b21b3a64641a..bf0aa53d3a13 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1303,3 +1303,6 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-zaius.dtb \
 	aspeed-bmc-portwell-neptune.dtb \
 	aspeed-bmc-quanta-q71l.dtb
+dtb-$(CONFIG_ARCH_MSTAR) += \
+	infinity3-msc313e-breadbee.dtb
+
diff --git a/arch/arm/boot/dts/infinity.dtsi b/arch/arm/boot/dts/infinity.dtsi
new file mode 100644
index 000000000000..101582f277ff
--- /dev/null
+++ b/arch/arm/boot/dts/infinity.dtsi
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+		};
+	};
+
+	arch_timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2)
+				| IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2)
+				| IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2)
+				| IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2)
+				| IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <6000000>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gic: interrupt-controller@0x16001000 {
+			compatible = "arm,cortex-a7-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupt-controller;
+			reg = <0x16001000 0x1000>,
+			      <0x16002000 0x1000>;
+		};
+
+		pm_uart: uart@1f221000 {
+			compatible = "ns16550a";
+			reg = <0x1f221000 0x100>;
+			reg-shift = <3>;
+			clock-frequency = <172000000>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/infinity3-msc313e.dtsi b/arch/arm/boot/dts/infinity3-msc313e.dtsi
new file mode 100644
index 000000000000..d0c53153faad
--- /dev/null
+++ b/arch/arm/boot/dts/infinity3-msc313e.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "infinity3.dtsi"
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0x20000000 0x4000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/infinity3.dtsi b/arch/arm/boot/dts/infinity3.dtsi
new file mode 100644
index 000000000000..bea22cf62373
--- /dev/null
+++ b/arch/arm/boot/dts/infinity3.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "infinity.dtsi"
+
+/ {
+};
+
-- 
2.23.0

