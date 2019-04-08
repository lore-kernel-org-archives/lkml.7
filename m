Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BBFC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C19208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Aw66rmbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDHJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:31:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35454 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfDHJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:31:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so13937425wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0OhW0PixCcZE3GgEvOYBQ3vXGDFPSSPy6kTggO+4Z8=;
        b=Aw66rmbDlY21uk3y7OpuNy9TIevo2FXV++FK0kZ+TLdEpfHoO9BREktAkplxeHy5WT
         IRXIPfYzylhya6Zp/89Uqxy/MHp0m8kSGxIZfbB2LGMr61/DMbG84LX8bslaqzVjeppi
         Wn1+/pEEucV2NW8+jsHWYK5AYL0IU7yfOy8qUckBSyLVG7/HhIQNO19e8JUfE56acZlO
         RaDPzrcnrVrhniIEJvRGNU+xNF1VBde5GRIVcZJHArLxPV3gcvpDrA/FdFbbPIdxJ/jb
         n8iGa1U//p7KuhMYceq9TLEK4WEht7NKSaMRiEO7Bsh/N0VUSi0EVDu82rBy3PaWeKdm
         X4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0OhW0PixCcZE3GgEvOYBQ3vXGDFPSSPy6kTggO+4Z8=;
        b=F4hTqbaFjKmTfGMqlUP1OiKFeXZqRYO59zQy/FrMiCa3kbcC6BJraXb4XLTRJYGSeJ
         RFu8LJuyFY6Mh7e9hChY49q+1hJiyVLqDg6LanJT3GWrFLCtCOX2a56D5+/jrfPixOf5
         eJH5R7oLeDNm/5nTiA4kZadJHbwHCLrISZz3QYfP4tPiBHx9JD288Op/iVJhvWyqcN29
         2iTqVaqQ9UDj1GdcoCAyMkjZI2QOQHCATWUTJhBS8GvHbqoweVTKNyNb+qrX+F0Kyu1B
         AcZlB4dRXfOpn9L1GlTsQWc8B6q+0NR/GnFURszNV7H8CjTqHdMDhWfM0yK/UYMTu1zq
         zdKg==
X-Gm-Message-State: APjAAAXhRkUXcVavd9L3bzwKot8n4CMahDjKDFRA/Xg8Fxka9MXXovyb
        FAgdWt2WbMS9sMqFAb9yyq/daw==
X-Google-Smtp-Source: APXvYqy5TFymeRw5ntPQxMe3cCfJSmX0KwOqNbF0Mqfo24DAhGH3N0rMSXJ59QYDjE/mIqKbjs779g==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr16687549wmd.124.1554715904264;
        Mon, 08 Apr 2019 02:31:44 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c10sm36777427wru.83.2019.04.08.02.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:31:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: meson-g12a-sei510: Add support for Video Display
Date:   Mon,  8 Apr 2019 11:31:38 +0200
Message-Id: <20190408093139.27161-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408093139.27161-1-narmstrong@baylibre.com>
References: <20190408093139.27161-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the HDMI, CVBS and CEC attributes and nodes to support
full display on the SEI510 STB.

AO-CEC-B is used by default and AO-CEC-A is disabled.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index c350a0165d44..34b40587e5ef 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -44,6 +44,16 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
 	dc_in: regulator-dc_in {
 		compatible = "regulator-fixed";
 		regulator-name = "DC_IN";
@@ -61,6 +71,17 @@
 		regulator-always-on;
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
@@ -103,6 +124,26 @@
 	};
 };
 
+&cec_AO {
+	pinctrl-0 = <&cec_ao_a_h_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cecb_AO {
+	pinctrl-0 = <&cec_ao_b_h_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+	hdmi-phandle = <&hdmi_tx>;
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vddio_ao1v8>;
@@ -120,6 +161,18 @@
 	};
 };
 
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.21.0

