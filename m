Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7EDC2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EA821744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGgUmBF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfLECT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:19:59 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45542 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfLECT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:19:56 -0500
Received: by mail-yw1-f66.google.com with SMTP id d12so598803ywl.12;
        Wed, 04 Dec 2019 18:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrsetGriwFN7O5PokupRSAWoGTBVUJcT37C7y0ZMNmw=;
        b=NGgUmBF79hKaA6rfHlyxqgOEoGaktYvly2OXQKwO26azgRrBz+Kg6wWarzxKrBq0ra
         t12HAvhbHelpoN/lvn8Kd9NAnRtEIxa0c+Xl7+zyQy/O/De1xKlMO81J/jWbGA0GLcjv
         82KvKhAIVYtzQIhF64Bicyj7UdpV+YFwVl+lz4QG/tVLjRfth1yjB5YZUEZSjVH4D3Gt
         KfxHyXbBGdSWfmg/87FrbBb2nmEFWV2G6O9cSfQPXu7p8pNyLq0cBfgphV8iNhqf3hbH
         o/hv6dlaZtnqx/isgXXPCZu5IGLWlYMsRrE8ZC3tAaN5WUio/rykeziwLK16Fd1ur1NI
         C6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrsetGriwFN7O5PokupRSAWoGTBVUJcT37C7y0ZMNmw=;
        b=COF8UWfNsoF63V55DvjemMq9iqge8qd6tRi4q4L2x/d9ALkLJ6xMd9rF49mn4g24BH
         No9RZ2ifBaQJlEuBDVfzRLPzDUElylKQXUwPBjWMVj+kF8shkyVOMaLK9AONy0i7FfLA
         lBM71wHronKcXvDcmweFwRQ4amJLuUZXMmlksKqFb4d69ApRFG9btHawK8ZJMX+fSsPv
         KSfe2LCdqmjhu1GI5xq5HhT8oFLPIQP4hgO5+iUxIwxBbIrNepfQypqLTrHPZQDKgMag
         jdlUhLnfrNaSaxnBvjufP/1cQSLkBYQdhHQ1kdUavO6vXn4oqMBth09Kpd7OBT95OKZl
         BXew==
X-Gm-Message-State: APjAAAU2pk7nnc7yPHCyZxl8HYWm8s1vuOgNNsd4gF2zIWvFc+8q+8U1
        BNu4odLO+vU3bpSR+stIkKs=
X-Google-Smtp-Source: APXvYqzCCriI9i8RMQSO8C5ehwieJ+buobW2fxeTKupTKau3EoE8HIWwRb+cK78pEhE54ySr7gqOEw==
X-Received: by 2002:a81:7a0d:: with SMTP id v13mr4506519ywc.175.1575512395086;
        Wed, 04 Dec 2019 18:19:55 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l6sm4188449ywa.39.2019.12.04.18.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:19:54 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: imx8mm: Add PCIe support
Date:   Wed,  4 Dec 2019 20:19:23 -0600
Message-Id: <20191205021924.25188-8-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205021924.25188-1-aford173@gmail.com>
References: <20191205021924.25188-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIE controller on the i.MX8M Mini appears to be the same
as the i.MX8MQ but it is absent.

This patch uses the bindings from the i.MX8MQ and the clock
information from the NXP Linux release and marks it as disabled
so it can be configured and enabled on boards where needed.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 5036d713558f..f384934ddbb4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/imx8mm-clock.h>
 #include <dt-bindings/power/imx8m-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -936,6 +937,40 @@
 			status = "disabled";
 		};
 
+		pcie0: pcie@33800000 {
+			compatible = "fsl,imx8mq-pcie";
+			reg = <0x33800000 0x400000>,
+			      <0x1ff00000 0x80000>;
+			reg-names = "dbi", "config";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			bus-range = <0x00 0xff>;
+			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
+				  0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
+			num-lanes = <1>;
+			num-viewport = <4>;
+			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie>;
+			resets = <&src IMX8MQ_RESET_PCIEPHY>,
+				 <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
+				 <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>,
+				 <&clk IMX8MM_CLK_PCIE1_AUX>,
+				 <&clk IMX8MM_CLK_PCIE1_PHY>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy";
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>, /* GIC Dist */
-- 
2.20.1

