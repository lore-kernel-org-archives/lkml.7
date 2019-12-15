Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB8FC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827172465E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 17:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576429212;
	bh=54k6tl/u+QN8VRT7KToMNhJCWuLH8xcLwdQidKHpf5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S6tIKePI9iLPwjbqDYOjXu1RT+BNRQLW7JNXg+yVverxyGS689SA3LD7FVyIlLdPq
	 Stb7f4mng1azPfxsaFLI0tN5UV5NuOelwwL5JIomNPXtipGqhZUyzDWPB8CNqwGS8/
	 F3YUg7aEU1DC80Iyw7ukvJx0K1CZCAH6TBLxrW18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLORAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfLOQ7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:59:32 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE86424698;
        Sun, 15 Dec 2019 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576429172;
        bh=54k6tl/u+QN8VRT7KToMNhJCWuLH8xcLwdQidKHpf5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJz3Qqq0Q0L+/eAbbBSro1dsvZOsx30HJMSOdbCZgixRkCAA1aW+GvmImMQAkNME6
         v7HDFCqqnW1x1tBZ2mIzzClD/ylIks9DAcDijQO+qJjLJfCv2ibQ0+JH2L/PwdBz/x
         Hcobms1QGKlvXiZ1HZgf24G0yPx9umflyAGW5WsI=
Received: by wens.tw (Postfix, from userid 1000)
        id 918F95FFE9; Mon, 16 Dec 2019 00:59:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 13/14] [DO NOT MERGE] ARM: dts: sun7i: cubieboard2: Enable OV7670 camera on CSI1
Date:   Mon, 16 Dec 2019 00:59:23 +0800
Message-Id: <20191215165924.28314-14-wens@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191215165924.28314-1-wens@kernel.org>
References: <20191215165924.28314-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Cubieboard2 has CSI1 pins exposed on one of its GPIO headers.
Combined with I2C1 on the same header, a connected OV7670 based
camera module can be used. Power is provided via the 5V rail on
the same header. The module has onboard LDOs for the sensor's
various power rails.

Add a device node for the sensor, enable CSI1 and I2C1, and hook
everything up.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 42 +++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index b8203e4ef21c..0ff1593041eb 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -100,6 +100,25 @@ &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
 
+&csi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&csi1_8bits_pg_pins>;
+	status = "okay";
+
+	port {
+		/* Parallel bus endpoint */
+		csi_from_ov7670: endpoint {
+			remote-endpoint = <&ov7670_to_csi>;
+			bus-width = <8>;
+			/* driver is broken */
+			hsync-active = <0>; /* Active high */
+			vsync-active = <1>; /* Active high */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
 &de {
 	status = "okay";
 };
@@ -142,6 +161,29 @@ axp209: pmic@34 {
 
 &i2c1 {
 	status = "okay";
+
+	ov7670: camera@21 {
+		compatible = "ovti,ov7670";
+		reg = <0x21>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&csi1_clk_pg_pin>;
+		clocks = <&ccu CLK_CSI1>;
+		clock-names = "xclk";
+
+		reset-gpios = <&pio 7 14 GPIO_ACTIVE_LOW>; /* PH14 */
+		powerdown-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
+
+		port {
+			ov7670_to_csi: endpoint {
+				remote-endpoint = <&csi_from_ov7670>;
+				bus-width = <8>;
+				hsync-active = <1>; /* Active high */
+				vsync-active = <1>; /* Active high */
+				data-active = <1>;  /* Active high */
+				pclk-sample = <1>;  /* Rising */
+			};
+		};
+	};
 };
 
 &ir0 {
-- 
2.24.0

