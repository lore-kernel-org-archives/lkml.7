Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7251AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40832208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="glJp3/n0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDHJcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:32:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55010 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDHJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:31:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so13473681wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaU7NIMcW3tdSdPQAkkny9SZP4+9jAbAzKLhaKmgEX0=;
        b=glJp3/n0ZKJJSx+E6CpcZmnF1wEOmEF/AfSiaJJX/UJL3jDuCqbasudOEZ/kwMD5xh
         5n5wGNQ5UYmBrDrigDXiiRPba4S/mFfZMy5spi+B1gcamB/o/VPHeQ9ha0jVJbjyNPdR
         VA8XpiQBoO0UWZiuWoM3SxUm5l25sB3gg5U+q0ZaVJ94eg5+p1Hue3iHuIlGw4yHHUyL
         06Ln/7xW6n46cst2CyV/aiGSNAdHOyGQGNPUAgPi6j0E7qwWFoAuBt3dxTFQBoF4lmP5
         Wn6LlSuR32lawNNEv63XJOkShQLLmrpPRIOLYCytV6QjSxhggUKEKpZmfYFBBLu4K7lT
         DTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaU7NIMcW3tdSdPQAkkny9SZP4+9jAbAzKLhaKmgEX0=;
        b=AsVO+Vylc2wTHZa+s7WMefcdw78Pg3WvYzPdxjq71mZnabh2v+4W8oyw13KCQiWvag
         Om+jSNgvht1oQbBkvEDj+CqmEqHdqsq0mT6nG6//jDVA90lWcdz/KjUBvcoXlarY8xZr
         B7JJ9pJQBaregSXc21b7dQ2ehhvYVzXJMCOCGXN7D+BYYmxcicomoIS43ktiiajU9HUK
         5Dj0w9EKj70m67HAgSAdOjGfc0qp14YvU06bPbI7KpqlAVI3FQfELFZ3pkkOaE9JeDPq
         1pEv6eFW9DkgDi88JgKx3IRoAxrfGc4U4ExjOJjN+GJOkGgp2BNo+5ZPbX94rJeXbWRi
         dxww==
X-Gm-Message-State: APjAAAUZzhdropmtpwxsFVLAIvI2EYnE7GNfqYU3yv/zBJqyIq8aKyaV
        ryK8CKawXxOTjr4/CO8Au3ikfw==
X-Google-Smtp-Source: APXvYqwfSOl9DE6nbVm0MkaxAsI771gH+QmlwapHjt0w1hAxbt8Pvd6trrP6zooM95Hdrymq+oy0PA==
X-Received: by 2002:a7b:c5ce:: with SMTP id n14mr17542154wmk.18.1554715905695;
        Mon, 08 Apr 2019 02:31:45 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c10sm36777427wru.83.2019.04.08.02.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:31:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] arm64: dts: meson-g12a-u200: Add support for Video Display
Date:   Mon,  8 Apr 2019 11:31:39 +0200
Message-Id: <20190408093139.27161-6-narmstrong@baylibre.com>
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
full display on the U200 Reference Design.

AO-CEC-B is used by default and AO-CEC-A is disabled.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 2240e365af27..0e8045b8a915 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -24,6 +24,16 @@
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
 	flash_1v8: regulator-flash_1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "FLASH_1V8";
@@ -33,6 +43,17 @@
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
 	main_12v: regulator-main_12v {
 		compatible = "regulator-fixed";
 		regulator-name = "12V";
@@ -102,6 +123,39 @@
 
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
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.21.0

