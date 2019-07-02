Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394CBC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F36921473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZinVKjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGBLlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:41:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfGBLlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:41:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so17450059wrs.3;
        Tue, 02 Jul 2019 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3ayARXXXxV3IZqjBDFXfm/F9xA0F1MyP5bO9yUsg2Ew=;
        b=AZinVKjD5pKpkyAmHH7XFm1MJdG7VCz5MHEl6HNuf1p4y1EUXDtsY+8mVWGCZqLRje
         D+nMxa/7TuZ3+NykLjkgcBza1N1XSzmFnykOEo5G8RXwP9BK2WY5Rs+yASWm+LuB6n3c
         r0/9su+hOOvStO6ZoBA6V9b3+reXk17DZeOpTMWyhJ0qTipfFrTTIE2X8850LvYgIqQo
         vKAcVq1E/QTU8ivbSQsa2Jj98jIGtlwUPUuLLQTgbpa0UQ+dqat7DyaaSrumZGojLGuH
         YJ+4SPklWMHFTjU8PnGYcT7kbp/l5lLXZmIDUaTKyt6KOWitvfqey7f17442kMuoJrKB
         x22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ayARXXXxV3IZqjBDFXfm/F9xA0F1MyP5bO9yUsg2Ew=;
        b=CqQuCRDyzXCKsoEsY+/Y1AM+I+kzSmvyV8ZUgydK85GT1Hu1zXM/MyPQWHtMIrcrKM
         KUbdbz1K0SgoAL4uFYu6Q9RbhLi0vJzsffAiEUMySXX5Wr+8cE3H5yc71scdCzEH12XD
         rud1VOmxLKeT7OZdqZdOpfm11YaNnwOfnpnPUZtClFZaJJpjVL+F7gEmyGxqm0K1OFTd
         AzXNxB7AAUT9YCijacmnfJvj6z/sodZ89/jjhiA9iLWmeTbJVPj9Ik9Jtg1KkRnNN30k
         7u74o3BeF/myaNvXwDD4So9JVb0LttK8sL1Aa7MTL1+g/6RX1fgZ4fMfhbP48eNTVSzY
         Wb1Q==
X-Gm-Message-State: APjAAAW5pgwgvueo1GZkm+EpXfu/1IeOGDn5T7bCKCJ/Cq/Q2Sr80hBF
        yusM3LOBnFOg+3yEzNrJ+5z02Q9dzzxFpQ==
X-Google-Smtp-Source: APXvYqzVnJhzYVmt/0FHCQg264+pplDP2RS6ArTB3HMHwEw52k6crvLwZk7yPFAFf8XHcactQ4JYCw==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr18970181wrq.333.1562067676248;
        Tue, 02 Jul 2019 04:41:16 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id 5sm2202039wmg.42.2019.07.02.04.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 04:41:15 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com, Anson.Huang@nxp.com,
        ccaione@baylibre.com, angus@akkea.ca, andrew.smirnov@gmail.com,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq: Add sai6 node
Date:   Tue,  2 Jul 2019 14:41:02 +0300
Message-Id: <20190702114102.1254-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d09b808eff87..1ff664523f56 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -278,6 +278,20 @@
 			#size-cells = <1>;
 			ranges = <0x30000000 0x30000000 0x400000>;
 
+			sai6: sai@30030000 {
+				compatible = "fsl,imx8mq-sai",
+					"fsl,imx6sx-sai";
+				reg = <0x30030000 0x10000>;
+				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SAI6_IPG>,
+					<&clk IMX8MQ_CLK_SAI6_ROOT>,
+					<&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+				clock-names = "bus", "mclk1", "mclk2", "mclk3";
+				dmas = <&sdma2 4 24 0>, <&sdma2 5 24 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			gpio1: gpio@30200000 {
 				compatible = "fsl,imx8mq-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
2.11.0

