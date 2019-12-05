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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79881C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E29321744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZqvPktc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfLECUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:20:06 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36148 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfLECTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:19:54 -0500
Received: by mail-yb1-f196.google.com with SMTP id v2so882435ybo.3;
        Wed, 04 Dec 2019 18:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBUCQ3HXWtjqS7u+DV8bVMI4GRsmhHpuG+2/DBZke2U=;
        b=gZqvPktcf6I8/hfOocl3lqK6ZkGdntiy5ippuyOtLR1PsAvNFTzHaCL0peOfCUrZFN
         hZBA2YM5Zqiqf+TjBICsmwrRVJTbjb6UCIRkl3PM2kOboSJ+NqrO4svjirQ8QORXJdeg
         qv5mNTpM+DPfWLq7RjcJ8+JWYXqPvqqGzwh1uGn9P+tiLP8f96Dm4PNROjUBA83XIxcm
         VzmmovvA+bxcThlIUHj5FBlFqpB5HkSrnVphnsgF32EtIVTh+GecSxdiVbLBF+LP+fDs
         D1NwShFZ5ueZxyFaeac2pntK9BO4aLlmJDZ4d4CkUanv6sO2BcaDF5DwmuaVZY7SjIyG
         LTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBUCQ3HXWtjqS7u+DV8bVMI4GRsmhHpuG+2/DBZke2U=;
        b=pWCh53rmv9NCM+4i99YaKZpjYXoTdWkUWrgybmKnTFlTEwpYLHryDBQ08KHdWXh7s1
         6ia7aecBpuQUpANmT1BTre4QAEGLATE+kOn1RXQ77i1ddAaobhpWOq3Dtek4whLqow4j
         6DIr32z+xmI4duwj7kC2xg8ZuIoz/b15gGKQt0xx6VNsfFTs7eUXs7uBajxH9YttajLS
         TIPCGhEJCNVMlMTM1O6nh/jitXWg1zu0GKWm6V+xgC6V8LTjYcWUg+CEHEmKTHfpoOuY
         MavexBkDrN7TxKFJ7AYBr0ULayDA3w4uVUvcqgrPVeVxKd8vVTHuVG+8EQsdjV0Kd8kA
         h3oA==
X-Gm-Message-State: APjAAAUXWxpeFxp7Hq4/yOkhwEzRgsZrxbrJP3h32v1LnYeEYKXdAwRe
        JqaNkoObFBDjBe5lwGUpEO0=
X-Google-Smtp-Source: APXvYqwpnSW0TEm1sDRCzLBvTQE4cuFAOFTuoVVDJT3nfkg/Z0yJYgcHWfa00gQ6AC1z7piMSl0Ffg==
X-Received: by 2002:a25:860b:: with SMTP id y11mr4655565ybk.485.1575512392989;
        Wed, 04 Dec 2019 18:19:52 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l6sm4188449ywa.39.2019.12.04.18.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 18:19:52 -0800 (PST)
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
Subject: [PATCH 6/7] ARM64: dts: imx8mm: Fix clocks and power domain for USB OTG
Date:   Wed,  4 Dec 2019 20:19:22 -0600
Message-Id: <20191205021924.25188-7-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205021924.25188-1-aford173@gmail.com>
References: <20191205021924.25188-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two USB OTG controllers on the i.MX8M Mini, but currently
neither are functional.

According to the device tree entries published on the NXP kernel
for the imx8m mini, these both need to be assigned to the proper
clocks and power domain in order to function.

This patch configures both USB OTG controllers to enable a missing
clock and define the power domain so boards wishing to enable
the USB OTG can do so.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index d05c5b617a4d..5036d713558f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -14,7 +14,7 @@
 
 / {
 	compatible = "fsl,imx8mm";
-	interrupt-parent = <&gpc>;
+	interrupt-parent = <&gic>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -867,8 +867,11 @@
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
 				clock-names = "usb1_ctrl_root_clk";
-				assigned-clocks = <&clk IMX8MM_CLK_USB_BUS>;
-				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
+				assigned-clocks = <&clk IMX8MM_CLK_USB_BUS>,
+						  <&clk IMX8MM_CLK_USB_CORE_REF>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>,
+							 <&clk IMX8MM_SYS_PLL1_100M>;
+				power-domains = <&pgc_otg1>;
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
 				status = "disabled";
@@ -886,8 +889,11 @@
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
 				clock-names = "usb1_ctrl_root_clk";
-				assigned-clocks = <&clk IMX8MM_CLK_USB_BUS>;
-				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
+				assigned-clocks = <&clk IMX8MM_CLK_USB_BUS>,
+						  <&clk IMX8MM_CLK_USB_CORE_REF>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>,
+							 <&clk IMX8MM_SYS_PLL1_100M>;
+				power-domains = <&pgc_otg2>;
 				fsl,usbphy = <&usbphynop2>;
 				fsl,usbmisc = <&usbmisc2 0>;
 				status = "disabled";
-- 
2.20.1

