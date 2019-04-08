Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D9CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069C8208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JRc9RRhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDHJbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:31:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37309 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:31:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so13895288wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C90Y7HygE0mkNukG/zDtJRz6NFRvz69KyUip09FFMs0=;
        b=JRc9RRhXAFeK6/yMJOEoo+ScnEDx9ifHzUyRxv7dljS2OoA1xHrAqOPWoAGty9tKhg
         bch9NbCy7zjwWdfZLjXLx7QGzGXkJs2yGI+3qezzVFCNcH//DdzRZ16nIwZYQl/U9Ia5
         te1IHjdP3Sq1WqYVTQFBWJ0LvMHyT319tx4XAcb5ON/rmcdOQiMFPno+5fcadbnX2bz6
         BBHVoBr+EVHsmojhrgTktOVXGk85A4RRS7xLOPfVDDMX3SQX5xtHn66vwYOfH3tDMowC
         ochqLgtlYecoWpI2QbHWYsBYvHUxnt4hcgBa0R6lZkfvJHuWK1VuefNRlR3Rq3G3U3Z5
         7tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C90Y7HygE0mkNukG/zDtJRz6NFRvz69KyUip09FFMs0=;
        b=Vxm/P/AmH/eBgZj3W5joskY6eSbvRA0zMxE+hzXzkDFNpJOfm+8djH/svzYrQgsALb
         nV1cSG6VgfysOhymDcKoE+OpWNcxkYJFLpXzJAEVpGf8EXJlwplpX1VJECJ4x7UTHRlw
         av2GSpz/VjDxp+HINihBz7pK46wjuhUz5jPAxtoiUOv4Lb9HsKNfMKIsraZz94hV5Rs9
         iXTfzaKHN3kr1Spl+o0oDZcSh8xmf6PIZUBzJjtFjrhfIlFjsRrLAIzfbO5Ry5lkwsk2
         DIKaXKfRynFVQWbu/r+CTSjpJTkt9On6LmQIkwk0hIrKdPiFuLwN7+33DosljK4vzs04
         7I1g==
X-Gm-Message-State: APjAAAXMrIcgbFZSn57jdaN/3UBXel3fh7pc7ZHSGC5yFZptswfQVPww
        TTYeRIWJ8DTOS21FCp0SbVxi+d52Ek0c7Q==
X-Google-Smtp-Source: APXvYqzGJm0dfH6FBRfvfvtnlLB9Y1VEibjdkqVJe52rHJ1ryuwPncpH1hHkmVUKV7XvyZS5S5fpXw==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr16514545wma.57.1554715903558;
        Mon, 08 Apr 2019 02:31:43 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c10sm36777427wru.83.2019.04.08.02.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:31:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: dts: meson-g12a-x96-max: Add support for Video Display
Date:   Mon,  8 Apr 2019 11:31:37 +0200
Message-Id: <20190408093139.27161-4-narmstrong@baylibre.com>
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
full display on the X96 Max STB.

AO-CEC-B is used by default and AO-CEC-A is disabled.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index b5b88262c06a..b3d913f28f12 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -24,6 +24,27 @@
 		reg = <0x0 0x0 0x0 0x40000000>;
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
 	flash_1v8: regulator-flash_1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "FLASH_1V8";
@@ -90,6 +111,39 @@
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
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
+	pinctrl-names = "default";
+	hdmi-supply = <&vcc_5v>;
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
 &uart_A {
 	status = "okay";
 	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-- 
2.21.0

