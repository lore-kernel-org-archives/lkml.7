Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B92C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E1D20867
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121321;
	bh=/J2pAeecO5+wy94vLp5m0dXczIyTOj8lr+GmEvWqm2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lu3ii3CTMZou/mT/gibEw1QBrc93/SYnXJ5+HdT3XGz1CNHr21laAF68HOrmJmGQI
	 PpLIf/xVJgQOeu8k+ZjZRKxz2UcAGXjkDMPzgho3AInzeqIbX5pyI8CBGKrEMD9v8n
	 Y0FLvHXvqqdr3s7PpmQJdtA2Sxp5S7j4iB6O0XDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405716AbfJCQsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405695AbfJCQsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:48:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D2F20867;
        Thu,  3 Oct 2019 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121316;
        bh=/J2pAeecO5+wy94vLp5m0dXczIyTOj8lr+GmEvWqm2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wF+z7eQdog1Sx0kYzgbRcMua2LJKU+5bpgkFDvzewshO2heGEgVzwOpySWnLjYUip
         JqHXRaycnjZsbXrKB9KNlCY0C3Y5tNpwDiRHOYfN/9uryd8Tx3kdyzxNSCBpWBqkux
         BiilTseumZxv64UE8Cz1urGvQyOJy/3ACDRIB/XI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.3 235/344] ARM: dts: logicpd-torpedo-baseboard: Fix missing video
Date:   Thu,  3 Oct 2019 17:53:20 +0200
Message-Id: <20191003154603.566037614@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

commit f9f5518a38684e031d913f40482721ff553f5ba2 upstream.

A previous commit removed the panel-dpi driver, which made the
Torpedo video stop working because it relied on the dpi driver
for setting video timings.  Now that the simple-panel driver is
available in omap2plus, this patch migrates the Torpedo dev kits
to use a similar panel and remove the manual timing requirements.

Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi |   37 +++--------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

--- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
@@ -108,7 +108,6 @@
 &dss {
 	status = "ok";
 	vdds_dsi-supply = <&vpll2>;
-	vdda_video-supply = <&video_reg>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&dss_dpi_pins1>;
 	port {
@@ -124,44 +123,20 @@
 		display0 = &lcd0;
 	};
 
-	video_reg: video_reg {
-		pinctrl-names = "default";
-		pinctrl-0 = <&panel_pwr_pins>;
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-supply";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd INI */
-	};
-
 	lcd0: display {
-		compatible = "panel-dpi";
+		/* This isn't the exact LCD, but the timings meet spec */
+		/* To make it work, set CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4 */
+		compatible = "newhaven,nhd-4.3-480272ef-atxl";
 		label = "15";
-		status = "okay";
-		/* default-on; */
 		pinctrl-names = "default";
-
+		pinctrl-0 = <&panel_pwr_pins>;
+		backlight = <&bl>;
+		enable-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
 		port {
 			lcd_in: endpoint {
 				remote-endpoint = <&dpi_out>;
 			};
 		};
-
-		panel-timing {
-			clock-frequency = <9000000>;
-			hactive = <480>;
-			vactive = <272>;
-			hfront-porch = <3>;
-			hback-porch = <2>;
-			hsync-len = <42>;
-			vback-porch = <3>;
-			vfront-porch = <4>;
-			vsync-len = <11>;
-			hsync-active = <0>;
-			vsync-active = <0>;
-			de-active = <1>;
-			pixelclk-active = <1>;
-		};
 	};
 
 	bl: backlight {


