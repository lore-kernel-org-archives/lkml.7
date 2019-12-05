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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F41C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9239D21744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1C+dYyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfLECT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:19:56 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37023 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbfLECTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:19:52 -0500
Received: by mail-yb1-f196.google.com with SMTP id x139so881203ybe.4;
        Wed, 04 Dec 2019 18:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8rdL81CA1/QSUatk5QZuPPaOIlwBprO0GQX2EhaRjM=;
        b=W1C+dYywW8EEg+KrCR9sD3uflofMaz0LkxIaYVdl/6TGvx8BVp2HSq7vgphATgN2BI
         6XVVI9gBWLX8BXhgqJpIOEOnWlbOzToicgYJaS/tBb+dIxQ1BjfPhhjR5gxnTz7Uat/o
         olvMTEB5EwL45/extiYTkrbyuMactGPuACcJrxIWL4klqMk8XGZCnS192UxkZBdXT3Y0
         H7PaFjvvmjAs3+JJEbpefhzNYgO7SI7WRWgJa/jFqa9t7praVOIsTiPhgAQzyQGxX/im
         3p2rBbJFcte9jSQblW7252rhLust313ljInBl79Yz6S+TBhx6Z6itNRymzOs0EbLzHvI
         OXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8rdL81CA1/QSUatk5QZuPPaOIlwBprO0GQX2EhaRjM=;
        b=JFipOzyFQelxvW3Nks6wpp6Zc0LR+ePibSiDPSwXXUFqsr8QJiMBIU5otRk4I3Z3xN
         nJcvpjsRbXdORFJpF7xaBDDNnx8jOlGumRPNO7OmVakV9M7lYqxArvNz/JWGg7l76VXH
         ye1Pte0hssgdMsgCsAbkgFxNuLu+u+q0M76jAhWdZ/GVqUkCp7mKh6QqfCXl0bczvzV1
         Pw0r6FNQf5IeJHO28iCnJMZ2aotjQaCOfdlCjbK/eFsHb4/SKVqzWw0QD7JqDv3PPkEt
         GQs6vUwe7dSuPU4qoL1IhZcCiECg3QbQ9n1npcmc2azNaW4KZA7IxOkDx8VdRUZ+qzfk
         cUBA==
X-Gm-Message-State: APjAAAXnxOr5EQczaLTXQak9Yapdln8UozytScX8owjnZECL1cOvEOO7
        N5QAxT/XJ39TFsYpzQhoBYc=
X-Google-Smtp-Source: APXvYqwAD9YGInc+qgp3awEl6WpVlrReB1uKRLWOTxVKUwY1TL0YVhztXM3OkuWK1013hQExDq0WRQ==
X-Received: by 2002:a25:d5:: with SMTP id 204mr4502582yba.165.1575512390970;
        Wed, 04 Dec 2019 18:19:50 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l6sm4188449ywa.39.2019.12.04.18.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:19:50 -0800 (PST)
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
Subject: [PATCH 5/7] arm64: dts: imx8mm: add GPC power domains
Date:   Wed,  4 Dec 2019 20:19:21 -0600
Message-Id: <20191205021924.25188-6-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205021924.25188-1-aford173@gmail.com>
References: <20191205021924.25188-1-aford173@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 82 ++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 23c8fad7932b..d05c5b617a4d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mm-clock.h>
+#include <dt-bindings/power/imx8m-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -13,7 +14,7 @@
 
 / {
 	compatible = "fsl,imx8mm";
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&gpc>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -495,6 +496,85 @@
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mm-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
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

