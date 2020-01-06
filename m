Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3258C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9919121775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578300167;
	bh=T1Oa7zbOHffWDB1OltdRU6wsYmtDX4x74FL/eNDFpAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wsg/qHjR04Fdoq9uyptbDF6JiivrTFrDXPWkIsLbFye0Hxhp4VYuPU2BvDB40VFGv
	 lzA6cmu4o5ftrEsbUHIy3lvc8iX2IGwTSGExsIyJ3OlQiceojVLyziiljDvI31p8G8
	 4Lk08AMFutqzdgVCBcfPa0pGKtTmdecU7SR8sI4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgAFImr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgAFImo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:42:44 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2102072A;
        Mon,  6 Jan 2020 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300163;
        bh=T1Oa7zbOHffWDB1OltdRU6wsYmtDX4x74FL/eNDFpAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3/2k6zYZvsVRCcVfwz/uGfgdpdoSbDHBsGtA9RAY2VU6wTulkqel+LpymxGNJiPB
         u89IP4Z+XyD4Y7r1xvKZDdCPrGnKal48LSd/P3FjXGE8b6LW5KGhYBoSH8qVCYZn2D
         SblmZUGTESwtIYGeYdUc4PzZ0kHLq4TzUsCILOBw=
Received: by wens.tw (Postfix, from userid 1000)
        id 566A15FD2A; Mon,  6 Jan 2020 16:42:41 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] ARM: dts: sun7i: Add CSI1 controller and pinmux options
Date:   Mon,  6 Jan 2020 16:42:35 +0800
Message-Id: <20200106084240.1076-3-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106084240.1076-1-wens@kernel.org>
References: <20200106084240.1076-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The CSI controller driver now supports the second CSI controller, CSI1.

Add a device node for it. Pinmuxing options for the MCLK output, the
standard 8-bit interface, and a secondary 24-bit interface are included.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 8aebefd6accf..92b5be97085d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -729,6 +729,17 @@ ohci1: usb@1c1c400 {
 			status = "disabled";
 		};
 
+		csi1: csi@1c1d000 {
+			compatible = "allwinner,sun7i-a20-csi1",
+				     "allwinner,sun4i-a10-csi1";
+			reg = <0x01c1d000 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_AHB_CSI1>, <&ccu CLK_DRAM_CSI1>;
+			clock-names = "bus", "ram";
+			resets = <&ccu RST_CSI1>;
+			status = "disabled";
+		};
+
 		spi3: spi@1c1f000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
@@ -802,6 +813,31 @@ csi0_clk_pin: csi-clk-pin {
 				function = "csi0";
 			};
 
+			/omit-if-no-ref/
+			csi1_8bits_pg_pins: csi1-8bits-pg-pins {
+				pins = "PG0", "PG2", "PG3", "PG4", "PG5",
+				       "PG6", "PG7", "PG8", "PG9", "PG10",
+				       "PG11";
+				function = "csi1";
+			};
+
+			/omit-if-no-ref/
+			csi1_24bits_ph_pins: csi1-24bits-ph-pins {
+				pins = "PH0", "PH1", "PH2", "PH3", "PH4",
+				       "PH5", "PH6", "PH7", "PH8", "PH9",
+				       "PH10", "PH11", "PH12", "PH13", "PH14",
+				       "PH15", "PH16", "PH17", "PH18", "PH19",
+				       "PH20", "PH21", "PH22", "PH23", "PH24",
+				       "PH25", "PH26", "PH27";
+				function = "csi1";
+			};
+
+			/omit-if-no-ref/
+			csi1_clk_pg_pin: csi1-clk-pg-pin {
+				pins = "PG1";
+				function = "csi1";
+			};
+
 			/omit-if-no-ref/
 			emac_pa_pins: emac-pa-pins {
 				pins = "PA0", "PA1", "PA2",
-- 
2.24.1

