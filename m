Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D28BC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4403920656
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578300190;
	bh=eVqvnMTAH9P1OLuUyEiot4QmZkLk+LF/E69QJEZ/PAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m6JFhWPna0TKmCGPTnISLY73TaB5jsf3TJFOGuEA47gk2VZSS7AQqMxFG1++rbSzW
	 OiRzZ2RAUB2YXKuJhrqkgd8pOJLjCpyWTxws5iXgE5Ti741eghlVgBoq5prfBPXSNG
	 tBC2GTsyFmsVaMQAwFDrp4dL+CQZbE2vUEQJo2X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAFInJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgAFImo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:42:44 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EDE21775;
        Mon,  6 Jan 2020 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300163;
        bh=eVqvnMTAH9P1OLuUyEiot4QmZkLk+LF/E69QJEZ/PAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyGL9dEOfWJ1ZMV5t/c4+E0O/mQoXPWyshR1ZzH70DS1HxKy2PKcvmoVmSD9dhedZ
         y/YpPkrj91Sd1UlO9I6XaVUjOxm+DgKNi31oW9xml8bJ5jKRXzfEsuq7S59MxE4qv+
         h6MiVGAvf+gbqj5D1cgSJZASimQylhxufVLvYmkA=
Received: by wens.tw (Postfix, from userid 1000)
        id 4E7645FA6A; Mon,  6 Jan 2020 16:42:41 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] ARM: dts: sun4i: Add CSI1 controller and pinmux options
Date:   Mon,  6 Jan 2020 16:42:34 +0800
Message-Id: <20200106084240.1076-2-wens@kernel.org>
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
 arch/arm/boot/dts/sun4i-a10.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 4c268b70b735..bf531efc0610 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -624,6 +624,16 @@ ohci1: usb@1c1c400 {
 			status = "disabled";
 		};
 
+		csi1: csi@1c1d000 {
+			compatible = "allwinner,sun4i-a10-csi1";
+			reg = <0x01c1d000 0x1000>;
+			interrupts = <43>;
+			clocks = <&ccu CLK_AHB_CSI1>, <&ccu CLK_DRAM_CSI1>;
+			clock-names = "bus", "ram";
+			resets = <&ccu RST_CSI1>;
+			status = "disabled";
+		};
+
 		spi3: spi@1c1f000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
@@ -670,6 +680,31 @@ can0_ph_pins: can0-ph-pins {
 				function = "can";
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
 			emac_pins: emac0-pins {
 				pins = "PA0", "PA1", "PA2",
 				       "PA3", "PA4", "PA5", "PA6",
-- 
2.24.1

