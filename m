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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D27DC751ED
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B215247BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0zVNR1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfLMQGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:06:08 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37661 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfLMQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:06:05 -0500
Received: by mail-yw1-f66.google.com with SMTP id z7so39946ywd.4;
        Fri, 13 Dec 2019 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diIP0k4eLIclWt3c/P5DOQ3zYxKekMVmETftkqEOchs=;
        b=U0zVNR1JYZrod79QD+eDZAcUrQLpJCzs1xbJF04ZdGD7FFvmgU+XZweRDwBFjV3VGc
         +1R7hzyluTLSRVoGCDYDrGROkXjBeQgBOPxARbQo7f+T0a5/5PX60jT1sxXV7D9iTAZO
         xbJyGbMXSWmC9Rbm8ywt9ZBLMKVLq8ty7Sy/M4pA1qWaRaaq/eu4JnBK6CSb90BZfpTU
         AZg/ySD0AYBh1c0vlCkURnEr/F6AzxrJcCr+yjFVum8cFKwDaaOLJmeH1ESJ6+Wob06l
         ubM8c2KvDJSJNZxJXDDNVxzxFgods0cj++bfgxYA7AJc8iKlvYacbNLmD/9GcY+VN7He
         YcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diIP0k4eLIclWt3c/P5DOQ3zYxKekMVmETftkqEOchs=;
        b=q3fTwoRterXdC17id7RpGeKqKucASKAX7k22pCf+y3GzPnP2AAKnHXG1iTiJzKY2io
         9f/ga6ujjqhDXoYvrl62pqA9wUWT5U2ekSJTvs3lgFsR/afIa4INzGE4cWP4xeuAgA0q
         AlEwmP+UZgq/5fK3/Znjya7TdpDTgytgNfeq2m7FlT/8bqSrix03SkbADsjSyqgy9BDH
         agECZb15/cdGo0+KeuN61CRJLogzVEDprBs4bUp9scjqnWt8fc37y/THjHKbKBaCsvgp
         wMVK41904JkqG0RynweYnoTOLPRwl12wbr/PzRHFHe2J/zbKcB5q90cLPLZnik9pkM0C
         XVoA==
X-Gm-Message-State: APjAAAXNofmpj2bIwD1Z+2kWqDx6HjyxFr879dIef8u5kUA6Vd2UMGDW
        JxC/Yxd8XrlhbryntIs6SDY=
X-Google-Smtp-Source: APXvYqyBJY9tyGyZZfmfIE+qd5Bdaurz+H3WDg5noJq3FlC0IeODXBcxvHA//Hh2Do1CdrtahGJS3g==
X-Received: by 2002:a0d:f443:: with SMTP id d64mr8872022ywf.125.1576253163588;
        Fri, 13 Dec 2019 08:06:03 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id v38sm3984694ywh.63.2019.12.13.08.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:06:03 -0800 (PST)
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
Subject: [PATCH V2 6/7] ARM64: dts: imx8mm: Fix clocks and power domain for USB OTG
Date:   Fri, 13 Dec 2019 10:05:41 -0600
Message-Id: <20191213160542.15757-7-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160542.15757-1-aford173@gmail.com>
References: <20191213160542.15757-1-aford173@gmail.com>
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
V2:  No Change
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index f38bed94bce2..dbeee4059c55 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -865,8 +865,11 @@
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
@@ -884,8 +887,11 @@
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

