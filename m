Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF973C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8812521738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfDWR0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:26:38 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:39736 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbfDWR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:26:33 -0400
Received: from pgsop.sopnet.com.ar (unknown [179.40.38.12])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id CF7BD7B3083;
        Tue, 23 Apr 2019 14:26:17 -0300 (-03)
From:   Pablo Greco <pgreco@centosproject.org>
To:     linux-sunxi@googlegroups.com
Cc:     Pablo Greco <pgreco@centosproject.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/7] ARM: dts: sun8i: v40: bananapi-m2-berry: Enable HDMI output
Date:   Tue, 23 Apr 2019 14:26:01 -0300
Message-Id: <1556040365-10913-5-git-send-email-pgreco@centosproject.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
References: <1556040365-10913-1-git-send-email-pgreco@centosproject.org>
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: CF7BD7B3083.A396B
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the hdmi nodes to the Bananapi M2 Berry, the same way it
was done to the Bananapi M2 Ultra

Signed-off-by: Pablo Greco <pgreco@centosproject.org>
---
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 561319b..e5ea901 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -58,6 +58,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
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
 
@@ -88,6 +99,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	/* Terminus Tech FE 1.1s 4-port USB 2.0 hub here */
 	status = "okay";
@@ -109,6 +124,16 @@
 	};
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
 &i2c0 {
 	status = "okay";
 
@@ -209,6 +234,10 @@
 	regulator-name = "vcc-wifi";
 };
 
+&tcon_tv0 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
1.8.3.1

