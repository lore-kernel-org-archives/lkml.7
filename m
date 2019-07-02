Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D5C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0AF2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+3dGzZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGBNMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:12:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37395 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGBNMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:12:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so976734wme.2;
        Tue, 02 Jul 2019 06:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xY8o03GKg7yE0EDv+JzNdYmGsRVySZFoyWELDtBrxsQ=;
        b=L+3dGzZqpQ2QrZyjS0R0EMbctTzpWn30VI9Gk0ULoS0BK1YNpPvtNid+iqGcxesqyS
         l+OmcE+IikAlMXWGoXhzozhJ4mfxUAVRr6SGz6J5LwK+4rV48vIJDv4UvhaF/fU4y91N
         vV2juYYeDO2hecTi/Ibtpsf7tl43LAHeIKYjczOSbVny40/yBznTMon/2cpej///nlK7
         0kgvQLsfAVG2onOknvNSu1Z+JklA9HHTWyjtWqAciQxCAaThKC2E0k/zZGKh90s5Tc+E
         /LA2sPJJOg4e9XdEd2aXYOrBOgsmxJRIhNF8ZtvugT3UnYvQ2QWWnCuqGnEAkId4+iyK
         nauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xY8o03GKg7yE0EDv+JzNdYmGsRVySZFoyWELDtBrxsQ=;
        b=KbOs+lYRgXhRqqdAE4u5WzQVwuaOvkkRFrIx585WNR6kiGO1XaUgd3qdf0xAaLsaMN
         hnlUWWQE0735WLLHZVkt6RDEPlZMRAQwIXhW2+VHPh9qBrZ6BjNhqEnNA8M7BCtvlVHw
         4KD8K9KQKkR0G+0wM6GWB4wRwM/r55x17Bij6SUz3LV2YLnwXHImM42VCA25yczN1IWJ
         ezBnw+3XSXLk8TlErPagyUhh3IK7u9UquD3xs2Z4EvbjnUtnlc/hYg1kY0QDcFMV4DV5
         AC+ngtmS7a+pT9VRa2m7OdWQEYYCSOd63EEQGn5P+aw1BopTnhvp8QxetZyaaDLnPUu6
         VTlg==
X-Gm-Message-State: APjAAAWYMShH1qFk1Yf/peMOE8WGkdXein0DetWy5PSIIJDq/BWhwOy+
        UjiRcxNANryIezOn2m8EE/Q=
X-Google-Smtp-Source: APXvYqwN2JTq7fEYVbdkNym5m6nNOaDhPP5LMVErx0F9CCrxHaY3Laf/tTPkWgVzxni8MfZZNBFocw==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr3529000wmg.7.1562073123716;
        Tue, 02 Jul 2019 06:12:03 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id h8sm2526416wmf.12.2019.07.02.06.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 06:12:03 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com, Anson.Huang@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mq: Add sai3 and sai6 nodes
Date:   Tue,  2 Jul 2019 16:11:55 +0300
Message-Id: <20190702131155.18170-1-andradanciu1997@gmail.com>
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
Changes since v1:
	- Added sai3 node because we need it to enable audio on pico-pi-8m
	- Added commit description

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d09b808eff87..2d489c5cdc26 100644
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
@@ -728,6 +742,22 @@
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
+
 			i2c1: i2c@30a20000 {
 				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
 				reg = <0x30a20000 0x10000>;
-- 
2.11.0

