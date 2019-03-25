Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D454C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD452087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b0Q4yp19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfCYO7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:59:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33871 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbfCYO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:59:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so10571504wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O1nsOWFPG6K9bGK6UYys+/cEUbualMnKnuKmrKMXNZ0=;
        b=b0Q4yp19uYsNtycqKcgc6HYVdkmFwenHMO6o9QfqUaE11SN/7syw3bFbBxdnq0glvt
         G/aCN6KeUKGgDoEs+foL42p3twNe8WnapUEmyhKzWSi1+ZamzhsgFxYJSBxUd8blKlpc
         DwlMzyNshnv0EX6wreZiDhTJ1XW6krdicRQP+Sv03N2AG+0LQxWKubK/FiT2LBHCfkXH
         7KMP9Gp7MYsBITjrp81nYE4ybVr7CFYbmzvA/g3vPlFZE88M4BUTT1rLmFkvAJPF5Ygw
         fO81KvgQnjFBw7lPDy3B6XlH85MzPsri+JIdnQgze30YptDPpvz8lh9rWCl7I92IImSl
         3GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1nsOWFPG6K9bGK6UYys+/cEUbualMnKnuKmrKMXNZ0=;
        b=os+Mza3pu0k6wko2j+oxga3mnriEkFWn1Mat5KYyiRiguJzpKyhhIJmvcBMVSQa09p
         hA+2/ZnFe8JD6TNZ7WhRSUa68+XK5rM5iwDjkOqFclY8k3vYwuEhWhTTv9PW5K0JthxI
         EMltYc9k6Sx78FV3IeRh4byH7ZIoByZH1lQvc0Yb2QZ/722TjzkPeOVTZJfHp2o1yAEY
         IJBTAZbO5jhc7zKrrKChWkgWC1GR1d6Ba9xYFrAu4OB+nDsQZu8ujzQycP/Pp+B5Lmwc
         Z3G+VfzPvueHDnirelo1JZIWMvybRHoxkogg7IWbcXimJdSWaequDoNq39nRRH136szU
         gefA==
X-Gm-Message-State: APjAAAWYJKSCHCYSy479GVjjX1RK1Tdj9IaB68txI7KhKntRRMm+Pt3C
        egdPvow0hwR5CIuqmA4Ut7sgLA==
X-Google-Smtp-Source: APXvYqxn3AZzRk5fzm57yi+eh1d1s7G5yiWV3bZNjUt1v+8mTPVc9pfhFOpqFgQrsa0X7XUm3rRzGQ==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr15703740wru.30.1553525963296;
        Mon, 25 Mar 2019 07:59:23 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d11sm12836156wmb.19.2019.03.25.07.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:59:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: meson-g12a-u200: Add support for Video Display
Date:   Mon, 25 Mar 2019 15:59:14 +0100
Message-Id: <20190325145914.32391-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325145914.32391-1-narmstrong@baylibre.com>
References: <20190325145914.32391-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the HDMI, CVBS and CEC attributes and nodes to support
full display on the U200 Reference Design.

AO-CEC-A is used for now until AO-CEC-B is supported.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 2240e365af27..a9f217b9e86c 100644
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
@@ -102,6 +123,32 @@
 
 };
 
+&cec_AO {
+	pinctrl-0 = <&cec_ao_a_h_pins>;
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

