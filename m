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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7ACC06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB19206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHUiT+FQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGBNYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:24:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52127 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfGBNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:24:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so860643wma.1;
        Tue, 02 Jul 2019 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cC1gx2tGeUkm0jddtz1+JKDjr/jThd+nsoub/6VA7i8=;
        b=sHUiT+FQAH9m6cP8gSfh1KbMHY16yW9IZ4GimxwQMpNch9RqCRBXufuyNXe3uqH+Ph
         rRjgsu3OruUslUAxE5kIZfo/sT5T1nbIjyzxlgLU5BnMNDT40UErxB/zVk69Kr8XZ8of
         cjo12l0SM/ULDgSRyGCc7ec3Pkw+6k7hKC/rHDoOjoIr6BQJLjqTbHdJP3gHAm1NZw2H
         mLCJcY7nYFiUCA3ClguI6xyXRJB8/CFfCdBMz5WSvvJwjQKrXXt1irdj7ii+0h/v2RSa
         AfwJI2k4WR5r8Tkbg8uSRZ3c+uxI9FPvaFolIxG28Sjnv37w09bx/Uj1aiCqrNHfhBMn
         QAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cC1gx2tGeUkm0jddtz1+JKDjr/jThd+nsoub/6VA7i8=;
        b=qJvJ6aiswLjErlspGLgJrqP4fVc0WKAkdeyQNWYuWNaVAhnyU6YdQ3QVqP4+H7kxNg
         0x4TZYR3GQHNCOXpnsu0kp5C1f6NqAFBsr7evxg1bJfTswQWr6QyMspV2vCIg5ncD2lL
         wOo6Ab8DIB+UYLhwhI2uVFYSWzZ0trPH2nApiJq+IcsQ/KvJ3TQ7eKVwPfKefphuuZDJ
         qK9QlJo1VZAd4kykhLMKt5yqHEhCHpotL8nNZ46pmG3PPJAe7r9ZF1CA2jqd9L4BpeGr
         Aol0qyI22bGtPCos2oFz1l0zsB74l/UZgrS4GvfRrIkqUIJYwaoOptkFeMUHVptbFxsu
         1cww==
X-Gm-Message-State: APjAAAWj9mQECQA6UXOLehxz2KPs3d3JfyLUqDTOSDWZXd1mIi27rTE+
        6V2Ua+iXwlEyl/55HNd8iDw=
X-Google-Smtp-Source: APXvYqwmc1vBbsQXhJM0UrDmXVFAZ7NBp8WbbjJE8tJhJBuzNxeFxyG3ILAlShVphxpcBPLS5w1y/Q==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr3391735wmb.66.1562073842154;
        Tue, 02 Jul 2019 06:24:02 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id g5sm14545741wrp.29.2019.07.02.06.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 06:24:01 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com, Anson.Huang@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: imx8mq: Add sai3 and sai6 nodes
Date:   Tue,  2 Jul 2019 16:23:53 +0300
Message-Id: <20190702132353.18632-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI3 and SAI6 nodes are used to connect to an external codec.
They have 1 Tx and 1 Rx dataline.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
Changes since v2:
	- removed multiple new lines

Changes since v1:
	- Added sai3 node because we need it to enable audio on pico-pi-8m
	- Added commit description

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d09b808eff87..736cf81b695e 100644
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
@@ -728,6 +742,21 @@
 				status = "disabled";
 			};
 
+			sai3: sai@308c0000 {
+				compatible = "fsl,imx8mq-sai",
+					     "fsl,imx6sx-sai";
+				reg = <0x308c0000 0x10000>;
+				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MQ_CLK_SAI3_IPG>,
+					<&clk IMX8MQ_CLK_DUMMY>,
+					<&clk IMX8MQ_CLK_SAI3_ROOT>,
+					<&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+				clock-names = "bus", "mclk1", "mclk2", "mclk3";
+				dmas = <&sdma1 12 24 0>, <&sdma1 13 24 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			i2c1: i2c@30a20000 {
 				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
 				reg = <0x30a20000 0x10000>;
-- 
2.11.0

