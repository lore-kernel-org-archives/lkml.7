Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125CFC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D742320879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yfJMTXxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfCYO7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:59:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35632 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfCYO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:59:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so10575087wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apV9C5vnP7hnEusl0/IGwUCXCWFQYz3Mv2aqqCWrzLU=;
        b=yfJMTXxVFPlFyyU+42XRfCkkBpWD+/LOPBHR0tPtu4LZ9AoHhwT5tr4c2oZmITtWLk
         u3E58CoGEDnBteD7ZDxBIKvMKG2EKvKzHRo1KSTarhzBVmAhLSkshkvI9o4UAuuB9jf6
         bWdC70hHjT0ZoBoc/2ojDkDWfW26Y/sXvVE6Qc4xmazFSCWmg5Q2NC6yCozsmwBRPehr
         LV0Wghr+vGUL6hMyQVLbD+SVfBWxpaPUSRvTXyz8169RUtaSHRUhDGhKwWP8CSNpi/xM
         nXQRYlbnysHV92tZ4T8hfobTL5KQcO0zbK+y0+eRm7skrNNgIbzb1uJRXK79mrbGiUUX
         ylQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apV9C5vnP7hnEusl0/IGwUCXCWFQYz3Mv2aqqCWrzLU=;
        b=unocMJP2bcdImzeU+zYMLbLI5saB2k+AN0J1xtETXA6MvrYN1fOwDRJnY4mul+u9vk
         8Tp/eBsDyoClZ6dIVP+erYFQ6n2A++8mfepXmmf01pyeIwgafsBYlU8KV0RbYnlfjTPi
         RndCbU3uES3qGi+H+7U2Zyn8olptdYCzfy65NBnASQfGYhKGpHeGu4AwUOifMvYsPFbP
         izYmEUv0hesr5ypCjNXOwbxgfXiSTU+tBcPksxbChV+XDPdPBmDCzk7Jq7GrAWC1JZIM
         HrGstpACEfo1zGBvJjJBg30Jm6l/MoOhEsDfoTXVcKCTGpVdo+7i3HAuNEkrnHquSJW3
         vrvw==
X-Gm-Message-State: APjAAAUZxXru64outQs8M8wuYO2nx4twQdBGFuNDWeWYZwnp1hQTqR9P
        CP0IFcnSeXZB5lkkHH3JgBepE7TM/PUkqA==
X-Google-Smtp-Source: APXvYqwN4zaEmF5iuFKZFyAjXGO9tPJ1DFzwz/S+O80NbMMGeaQKO1pzPObYHUrK3BCPp28MDFhG9Q==
X-Received: by 2002:adf:e949:: with SMTP id m9mr6399327wrn.237.1553525962254;
        Mon, 25 Mar 2019 07:59:22 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d11sm12836156wmb.19.2019.03.25.07.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:59:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: meson-g12a-sei510: Add support for Video Display
Date:   Mon, 25 Mar 2019 15:59:13 +0100
Message-Id: <20190325145914.32391-5-narmstrong@baylibre.com>
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
full display on the SEI510 STB.

AO-CEC-A is used for now until AO-CEC-B is supported.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index c350a0165d44..3e7a8a4093f2 100644
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
@@ -103,6 +124,19 @@
 	};
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
 &saradc {
 	status = "okay";
 	vref-supply = <&vddio_ao1v8>;
@@ -120,6 +154,18 @@
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

