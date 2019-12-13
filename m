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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE1C751E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9319A247CF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jplSiqf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfLMQGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:06:06 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45186 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfLMQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:06:03 -0500
Received: by mail-yw1-f67.google.com with SMTP id d12so15800ywl.12;
        Fri, 13 Dec 2019 08:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUBn4hPQtTP6/1UnracKB+PKuO3QMFkkquLizrjA/XM=;
        b=jplSiqf47y6ZYGeFyNC9sZb3biXn2gVEJv+PNanVJiJfXKyGzSYXXYRfL7jBHBCM4n
         2Aqo6V6mUEzEMOcUjxb0pk24ulPgKMf5pdFFfE33y2TtBqr0kM4nGeY4zTvSUSoDfmMD
         J70Deq811qD/hht1L21MoaE5Q8SLoPsULIueKFkEh3jOpz1mPB+ezRVkdNymmWeI4bif
         5wCpDZO0aFl0eVcGNVignY7201cs3i3SsddVZNdZNugBdC9+b/5pJoVjKTbWwPszg0oe
         sT2qDSAfMwE9kGXBLhDfwSHGj+ZtMk3QT4BSpakH0JQUlZmPdH3tJWAhk1oo5Ab6zMaj
         Qujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUBn4hPQtTP6/1UnracKB+PKuO3QMFkkquLizrjA/XM=;
        b=SN8MIE9yfFlazw4WFJVQfexdiA0xkGEAh9wQKH64up5rla93Hzhg6k/pL16XSsh70N
         KsFOwXVMBqinPq4aTySe5Jt0kW7N4hvYMSOXobFUp/PB/Y18ZZSOWLVHIaxE3dIY29Nh
         WyYhTUE7tYHNqAVbJbxGuhFXmeKTWawBG5M4+VJMmgJTCVdX8/o80x50pgCuZCxAdzHA
         +Gz+bXtlpfaYwy4q+HVJqe35Q+5gBWNejn8iRDtG7XaQJchcLKYwkN4aoQmFk4lJGzJY
         Q8D/aAtA6z0k19okfL9xEUvvmmV0bMjciwDwdYFyt435c//Jha90DTuyd4C/TyP9lzzE
         MLeQ==
X-Gm-Message-State: APjAAAUMLZyXsasYMzuE+1cacl0exeA+6o3n7hkZa+FlW85lF/Lg6b0F
        7hM9nuCveH+zrEi97QiyW84=
X-Google-Smtp-Source: APXvYqzObFt2i3P9CQgT7UV8LybxmIu+0nBxBacvga9qhhrksInhZa+8qHAwAJAlCO1naM/6MDEqMQ==
X-Received: by 2002:a81:b548:: with SMTP id c8mr8655777ywk.465.1576253161238;
        Fri, 13 Dec 2019 08:06:01 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v38sm3984694ywh.63.2019.12.13.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:06:00 -0800 (PST)
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
Subject: [PATCH V2 5/7] arm64: dts: imx8mm: add GPC power domains
Date:   Fri, 13 Dec 2019 10:05:40 -0600
Message-Id: <20191213160542.15757-6-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160542.15757-1-aford173@gmail.com>
References: <20191213160542.15757-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a power domain controller on the i.XM8M Mini used for
handling interrupts and controlling certain peripherals like
USB OTG and PCIe, which are currently unavailable.

This patch enables support the controller itself to the help
facilitate enabling additional peripherals.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Removed references making GPC an interrupt controller.

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 78 +++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 23c8fad7932b..f38bed94bce2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mm-clock.h>
+#include <dt-bindings/power/imx8m-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -495,6 +496,83 @@
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mm-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_mipi: power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_MIPI>;
+					};
+
+					pgc_pcie: power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_PCIE>;
+					};
+
+					pgc_otg1: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_USB_OTG1>;
+					};
+
+					pgc_otg2: power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_USB_OTG2>;
+					};
+
+					pgc_ddr1: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_DDR1>;
+					};
+
+					pgc_gpu2d: power-domain@5 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_GPU2D>;
+					};
+
+					pgc_gpu: power-domain@6 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_GPU>;
+					};
+
+					pgc_vpu: power-domain@7 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_VPU>;
+					};
+
+					pgc_gpu3d: power-domain@8 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_GPU3D>;
+					};
+
+					pgc_disp: power-domain@9 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_DISP>;
+					};
+
+					pgc_vpu_g1: power-domain@a {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_VPU_G1>;
+					};
+
+					pgc_vpu_g2: power-domain@b {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_VPU_G2>;
+					};
+
+					pgc_vpu_h1: power-domain@c {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_VPU_H1>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
-- 
2.20.1

