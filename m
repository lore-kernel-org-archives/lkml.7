Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F5BC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 23:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B157B2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 23:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDfSvRU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfK2XlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 18:41:22 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35929 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfK2XlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 18:41:22 -0500
Received: by mail-yb1-f194.google.com with SMTP id v2so12141077ybo.3;
        Fri, 29 Nov 2019 15:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rKiQHSwuUCF9AELRHNdLMuxf8z6xR1bB61s0tnxzNE=;
        b=kDfSvRU3IToCKYqz4BXDquOBvvC9Zy46H4g+899B8ZSEpHA3hMqRXTse+L/RAMQdHs
         bmQFjBLR0y596ZukQgj2Wc5ogj5Hv6DJuLb9qmfvbPuQIuwMnATeIHww7BXS1IB23d7u
         7l82E71a+GM7IqRawG8KJdCvXVDAU9AyMiEZ0lM7Pjtq25E+6DTwxVtqo1mGhR7RACyn
         cgmzki2m8XR8GgiOIPPIbWdlqzAUy/p10XuivFsfN5iwaEhI8JmA/tH7D0+H6Z+K8RTi
         HsweW5NOqWWyoX56cZj3t2Ehllx3nqCipJDa0FeM1db6K5h53KNMytsNJy+G0VtEGJAC
         nFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rKiQHSwuUCF9AELRHNdLMuxf8z6xR1bB61s0tnxzNE=;
        b=HQa5FgjwcaJ2c7EARyiJbPeVyTPGX4voaRoUPx6pEhl51mWu8GZ0lK4HiTV11IoLip
         PoBjU+lrPRiNMc1BpphBmOuJjGgiteFoOiXuubgy+Q+7jJs3+IbDsj9NycEZkJAZw1ZP
         lV78Rq8o6zDS4c29aAQmemEPfg5EZbWWoSWlh23RnLw1wZHHwqGNEZFtOrQRbgbGzt1A
         lyUyNijiOKbmFN4LmRvzjY599OTznvzzuzff/rLnFuhFGZDYVVZ/Er8xiGE7ELJYuoeL
         uQL3am6LKMRUcap4xV3lEHp0qMwbF4twKiMf5j+YPPtrEp4rB8YgGr/RruAEOUfs795/
         LPvw==
X-Gm-Message-State: APjAAAVpzfRjBnsrTDD0NsukPR33EV5kMprhpkjlu780NlRjxg51LzyX
        A/HEDgiG8rAKszmeu4HZL+Q=
X-Google-Smtp-Source: APXvYqwr/LIgU0jfzryCJVUcaDeplSmBTLSebhAPSCfhBOYQ8LJZyb6eDQWVMKL5MWICobsnwFY5rA==
X-Received: by 2002:a25:245:: with SMTP id 66mr8022427ybc.104.1575070880925;
        Fri, 29 Nov 2019 15:41:20 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id q131sm10636436ywh.22.2019.11.29.15.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 15:41:20 -0800 (PST)
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
Subject: [PATCH 2/2] arm64: dts: Add GPC Support
Date:   Fri, 29 Nov 2019 17:41:08 -0600
Message-Id: <20191129234108.12732-2-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129234108.12732-1-aford173@gmail.com>
References: <20191129234108.12732-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The General Power Controller (GPC) used on the i.MX8MQ is the
same as what is used on the i.MX8M Mini.

This patch adds the GPC support to the device tree for the SoC.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 6edbdfe2d0d7..860cddec9632 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mm-clock.h>
+#include <dt-bindings/power/imx8mq-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -498,6 +499,90 @@
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mm-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_mipi: power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI>;
+					};
+
+					/*
+					 * As per comment in ATF source code:
+					 *
+					 * PCIE1 and PCIE2 share the
+					 * same reset signal, if we
+					 * power down PCIE2, PCIE1
+					 * will be held in reset too.
+					 *
+					 * So instead of creating two
+					 * separate power domains for
+					 * PCIE1 and PCIE2 we create a
+					 * link between both and use
+					 * it as a shared PCIE power
+					 * domain.
+					 */
+					pgc_pcie: power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
+						power-domains = <&pgc_pcie2>;
+					};
+
+					pgc_otg1: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_USB_OTG1>;
+					};
+
+					pgc_otg2: power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_USB_OTG2>;
+					};
+
+					pgc_ddr1: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_DDR1>;
+					};
+
+					pgc_gpu: power-domain@5 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_GPU>;
+					};
+
+					pgc_vpu: power-domain@6 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_VPU>;
+					};
+
+					pgc_disp: power-domain@7 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_DISP>;
+					};
+
+					pgc_mipi_csi1: power-domain@8 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI_CSI1>;
+					};
+
+					pgc_mipi_csi2: power-domain@9 {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_MIPI_CSI2>;
+					};
+
+					pgc_pcie2: power-domain@a {
+						#power-domain-cells = <0>;
+						reg = <IMX8M_POWER_DOMAIN_PCIE2>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
-- 
2.20.1

