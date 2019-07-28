Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D68C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634682077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564325996;
	bh=DpUGmLY8RrR8zxdN3nN3Mo7lThZhDLYKhs1tZUEsSXs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DcV5/Tq8224eB9kv6qyScobCCUY+kLqqYD+akkiwhaiA/GItZxtwL01hJxdfbFDK+
	 4Lw+mW5pVrDVUOvXYow3wQg0FdYXhbuwjbTtP1eryg9z/S/1dhqE9rx98eObab7jjq
	 jrC0PrlvdU2/3Pz48HF0Fw97S9YzmO7j55Cb3ciA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfG1O7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 10:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfG1O7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:59:52 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2180F2077C;
        Sun, 28 Jul 2019 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564325991;
        bh=DpUGmLY8RrR8zxdN3nN3Mo7lThZhDLYKhs1tZUEsSXs=;
        h=From:To:Cc:Subject:Date:From;
        b=nlRAI/BIC/ZmVdyBmc95Sd/sRgE9StTHGWhfwdhiG+VYsug161KgDP4MrN7w3/+JP
         0aJcA9O47R1VRCgDDz0pqPDbRSQBLYNPJx0HcaG5/CQbtGAWpMwJxTrmP3brgpTLgr
         4PXkhdR7ZfZgzd20cI1G0Py29WJC23hcnMQy7psM=
Received: by wens.tw (Postfix, from userid 1000)
        id 2E25B5FD59; Sun, 28 Jul 2019 22:59:48 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i: a83t: Enable HDMI output on Cubietruck Plus
Date:   Sun, 28 Jul 2019 22:59:44 +0800
Message-Id: <20190728145944.4091-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Cubietruck Plus has an HDMI connector tied to the HDMI output of the
SoC.

Enables display output via HDMI on the Cubietruck Plus. The connector
device node is named "hdmi-connector" as there is also a display port
connector, which is tied to the MIPI DSI output of the SoC through a
MIPI-DSI-to-DP bridge. This part is not supported yet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index ea299d3d84d0..fb928503ad45 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -60,6 +60,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -153,6 +164,10 @@
 	cpu-supply = <&reg_dcdc3>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	/* GL830 USB-to-SATA bridge here */
 	status = "okay";
@@ -172,6 +187,16 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mdio {
 	rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.20.1

