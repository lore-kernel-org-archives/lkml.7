Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B0C751EE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9315524796
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuwpFKwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfLMQGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:06:09 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43203 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfLMQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:06:07 -0500
Received: by mail-yw1-f66.google.com with SMTP id s187so22597ywe.10;
        Fri, 13 Dec 2019 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O86HMihHsLWT55NFgoxc5smTvSP4VUSjDe/evqkgoXg=;
        b=IuwpFKwMsYw66Cu048loiY0A80ILWUhf+l5CKYtcRZSL1WJaoJ/gVTn5FYw1Jg0VY/
         2esnX/D+NdQpReISaBCkAA9uIcPRpEHROalrEJzFLfRZmGZB0zu01+S2GoCMrfw6qWAz
         UTUK6Bmwq0ZCkJTq1EsmL4SDwDwofriMAYQuXwyPdg6ZY2mLNJg/dA46/5zfEQnNvbAC
         4hg85rLqXHWu27GssxirUhUrFR9fQSpPzYIcF3lcBVzIrv/CL63aQP0bmVw1k83zPFBj
         p1Zr6Z5ysOrRwsblXEklxnsc27EKSJLgUqyPfmaxxPg+W6Egs4G6Zpz7qgdMTXu3ruRv
         zobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O86HMihHsLWT55NFgoxc5smTvSP4VUSjDe/evqkgoXg=;
        b=MVUc1JtKtJRQ6bCfWxvn0nH81+ZdXd4/QzpHpFYnoDY8zGOQ4NlyyfteXvwEf1pxlb
         foze91jwv8ipsQNUO2TFX+sC4EPDt/3ccTRmEeUyHEkPN57vd8VRNaXpkOUAXkaLInpH
         Fb5BO7TBMGUZsq4ND3w4ZbXL1cZwuRH+/EYKDaKYW4L3ykWI7HZTSFLqLaq3bYuTTFx6
         waVY18snUbml3L6r2ezn9vxAkzCwpG9H5zIJXXqVK9xQAtunry7ys5Z9ammGTeIabum4
         KrOis8mcvqvUhBLB71NdG7686TIt5WU5yo7vWcl4/MP5B0l+r77j3SEDQHToeiaOzQjg
         5Kqw==
X-Gm-Message-State: APjAAAXbKPnyyBqpi81U/N1Fd8u+r56vNTpuwW0cXQkDQKyWxrJhyX1o
        C40JJte8lt0XdrjHVPHar7Q=
X-Google-Smtp-Source: APXvYqxbyg1OTSypua4WtIwv/+XQh3KgfGv8Xaawz3j12rcsjIrEvpA2kEwv3Wx7GzdIA++YJW54TA==
X-Received: by 2002:a81:c841:: with SMTP id k1mr1081859ywl.45.1576253165810;
        Fri, 13 Dec 2019 08:06:05 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v38sm3984694ywh.63.2019.12.13.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:06:05 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     peng.fan@nxp.com, ping.bai@nxp.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 7/7] arm64: dts: imx8mm: Add PCIe support
Date:   Fri, 13 Dec 2019 10:05:42 -0600
Message-Id: <20191213160542.15757-8-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160542.15757-1-aford173@gmail.com>
References: <20191213160542.15757-1-aford173@gmail.com>
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
V2:  No Change

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index dbeee4059c55..33fa760a3f2e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/imx8mm-clock.h>
 #include <dt-bindings/power/imx8m-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -934,6 +935,40 @@
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

