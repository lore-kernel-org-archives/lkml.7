Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA57FC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEC9218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVqoF0hH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfLREVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:21:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43533 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLREVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:21:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id k197so514742pga.10;
        Tue, 17 Dec 2019 20:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNX03JAOppaU3e3PkzJ7AHYN2jOBOqdXzk0VsYgjatg=;
        b=jVqoF0hHjloQCi5UH4qQ9ART3reXrk4ao/eieXiXlKTbZbR0O3D1JQTW42ym6leW3N
         lO+0DHoBNw1ZxOBfWD1jEYDPL9jIbBChkvneuNd04gDEwLdCEI76a5znDNA7ApKlaKgp
         6xMo1RTDCkTfz3qB7OiNs+0JLT1Q6Uuw3CWJX3e6xvG8JUdq9Ls0X+5hZG9wmPMrbp6i
         KIn+wP3aC5+GmWBl1wNb4cbIgfNKHUYRz3q15ypI0HnzGS0EwYHSJB2tZZc7caAHPdm6
         0pO6/LeQ4NYXLJimevLa3OGR8RuignIHeJNAEzeIBbP3/ZDnlNIbS3YpxaoJFtMzFHMY
         f+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNX03JAOppaU3e3PkzJ7AHYN2jOBOqdXzk0VsYgjatg=;
        b=aSHyWEI/TbWlulgKF0VbQlX6GhMbmEbeYmpUK67Tx6vjPLO6To/0Tdt/pWKuyuFfn7
         dQSpxcV1YOUTubQM1/nQnLDbUJNen/PfJ7TCqWqDaVAnzdW3jrwZ7ysPZiMr5/iqZ+b0
         jCDrdK6O+dY2SI/+d+rhsydQFuhGcfNQyJc0cFPmeMhrJXDSGrTlk1c246wqu5rFD+Lc
         um4WRMtamwkcid9E1n4lgMCdP7Ms0ctiYULOD2o1ocrlQW8T4dC/U8IOUK2GzfiXDsCd
         Tz2xm+iUSv2UGTfacOG2iDDmwwkiGVihDBQFdpsK/i/3P7VLUo13454Gfn/iVxGuZEBc
         4fWQ==
X-Gm-Message-State: APjAAAUWoUeMP8VskMbkeaA8JZDypfiUAB4l3gld40UCRFlWBssnr+nd
        uGYXAxgxMtUrNg7kXKWhG2I=
X-Google-Smtp-Source: APXvYqy4TSEggqwbg/BFa9ETiaGNQrz9Vejq1CKVDpkMenvRmSXBpmZp8SS0b5R+mUmZ/0fqmxVYqg==
X-Received: by 2002:a62:b519:: with SMTP id y25mr760491pfe.194.1576642893785;
        Tue, 17 Dec 2019 20:21:33 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id g17sm775380pfb.180.2019.12.17.20.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 20:21:33 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megous@megous.com>,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v7 6/7] arm64: dts: allwinner: h6: Add thermal sensor and thermal zones
Date:   Tue, 17 Dec 2019 20:21:20 -0800
Message-Id: <20191218042121.1471954-7-anarsoul@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218042121.1471954-1-anarsoul@gmail.com>
References: <20191218042121.1471954-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

There are two sensors, one for CPU, one for GPU.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 29824081b43b..cdcb1a36301a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/reset/sun50i-h6-ccu.h>
 #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
 #include <dt-bindings/reset/sun8i-de2.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -233,6 +234,12 @@ dma: dma-controller@3002000 {
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-h6-sid";
 			reg = <0x03006000 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@14 {
+				reg = <0x14 0x6>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {
@@ -856,5 +863,31 @@ r_i2c: i2c@7081400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		ths: thermal-sensor@5070400 {
+			compatible = "allwinner,sun50i-h6-ths";
+			reg = <0x05070400 0x100>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+		};
 	};
 };
-- 
2.24.1

