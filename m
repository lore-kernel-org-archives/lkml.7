Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F83C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6221841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CLRlNpcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfDKInu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:43:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41372 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDKInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:43:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so3182271pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7iT3ZB4whlJ7SaEMLeDA/+Cc985ijuEksdJYrKjTpo=;
        b=CLRlNpcJJbab4Iw8f/mERFQkjxdFOzFwrtqG1jfj0qkFSLLPNduyh/67TxTfm3E4rM
         xlBm7uMwRkmPu0oidetWo0OtkZ6Qg/Zrfk7N6JW8m+Y56R0EUYMaUwdVJ9nYdKg14R+j
         cHFKt7cgIR9FFCWsxUcVm6Lp4EAml7pUsocuqfU5/W9bTtz5F+keGJ1OX4/8zOKnSeg7
         knh0d0iVWdvIjgSsfeD9fZ7DVWqFNGPEzkAKTZLSTh57POI+kDBC5eyF+ArohmqEzlJ1
         JUaHGPrKgLFQdvhPBX7NZxC1H2iBupCjedpOPdIyF5QB+rum00bxu6bLNihYWDkyCHuq
         fsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7iT3ZB4whlJ7SaEMLeDA/+Cc985ijuEksdJYrKjTpo=;
        b=eEUQqOkTg6ogU4chvpz+xdsiywdDWiPt9nNb9PTD57O+qHml14Mwh0iDb3vdvlj5aI
         F0S0vZpPoGqLFgSuHzFLZlwPMBU46Xm99AFOb5XTobbFCecYH1qpWs7RT8ThDJLOx1ta
         K1T9ENdwwRMnZdIklwjg4Rbf9n8sAIM6xIwwZRoK+YESYZmS6sCrLPuP7BZTmyxQ2udb
         CpY5Ns9o0vDTuEoODdGyAUJ/S+SkZw9zvbZ8IVzM2dREca1cGUcWfVXT//wAb3CJrD/H
         +WOZ0pwDWdnNhAs0CER7j48Vi3JqsFje29wC3QENIAoohljhJkNU3HQaUI7Y3HQZBtsa
         8Xcw==
X-Gm-Message-State: APjAAAU6bFYTDwOSNm3PWbYaqiX0bBLO8qrgd1pP+gzGMNRn+qEfwQWX
        AvEeXvTlhmA7WjW/KrewJTmzWJoOQBE=
X-Google-Smtp-Source: APXvYqye6k8PBckeC3MlXT5CqlZpgGSMhiXHEShG1oez7V70W9vgoDKcQYLFbBEM/CVb4g2nbAqN/w==
X-Received: by 2002:aa7:9193:: with SMTP id x19mr49302325pfa.108.1554972228269;
        Thu, 11 Apr 2019 01:43:48 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a3sm61699456pfn.182.2019.04.11.01.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:43:47 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 5/6] riscv: dts: add initial board data for the SiFive HiFive Unleashed
Date:   Thu, 11 Apr 2019 01:43:03 -0700
Message-Id: <20190411084304.5072-6-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411084304.5072-2-paul.walmsley@sifive.com>
References: <20190411084304.5072-2-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial board data for the SiFive HiFive Unleashed A00.

Currently the data populated in this DT file describes the board
DRAM configuration and the external clock sources that supply the
PRCI.

This second version adds onboard SPI device data, fixes the board's
memory size, and adds changes based on comments from Rob Herring
<robh+dt@kernel.org>.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/sifive/Makefile           |  2 +
 .../dts/sifive/hifive-unleashed-a00-fu540.dts | 69 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sifive/Makefile
 create mode 100644 arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts

diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
new file mode 100644
index 000000000000..fb825db888df
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SIFIVE) += hifive-unleashed-a00-fu540.dtb
diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
new file mode 100644
index 000000000000..9d35e811a3aa
--- /dev/null
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: (Apache-2.0 OR GPL-2.0+)
+/* Copyright (c) 2018-2019 SiFive, Inc */
+
+/dts-v1/;
+
+#include "fu540-c000.dtsi"
+
+/* Clock frequency (in Hz) of the PCB crystal for rtcclk */
+#define RTCCLK_FREQ		1000000
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "SiFive HiFive Unleashed A00 (FU540-C000)";
+	compatible = "sifive,hifive-unleashed-a00-fu540",
+		"sifive,hifive-unleashed-fu540",
+		"sifive,fu540-c000", "sifive-fu540";
+
+	chosen {
+	};
+
+	cpus {
+		timebase-frequency = <RTCCLK_FREQ>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x00000000>;
+	};
+
+	soc {
+	};
+
+	hfclk: hfclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <33333333>;
+		clock-output-names = "hfclk";
+	};
+
+	rtcclk: rtcclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <RTCCLK_FREQ>;
+		clock-output-names = "rtcclk";
+	};
+};
+
+&qspi0 {
+	flash@0 {
+		compatible = "issi,is25wp256d", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&qspi2 {
+	status = "okay";
+	mmc@0 {
+		compatible = "mmc-spi-slot";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		voltage-ranges = <3300 3300>;
+		disable-wp;
+	};
+};
-- 
2.20.1

