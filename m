Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB072087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0PXFX9I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfCYO7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:59:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43251 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:59:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so2587221wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0+TIG6VNjrqUujR6aG+tFwwFoGuZYT2WNxyTgEQcO8=;
        b=0PXFX9I7jb9iP16DZa4aEdcF7/XDIIQs4p8Vr45jAfJoxVHaeG1I/WVPwRwlK3WzWq
         h/rCwxiwgpu82NIGy8gJPr65mmxCSX0FLrQ3XteuI8ApgJo6MtqKziw0L2+hzxA82uTr
         qvFOhLxXR1JtgGGjQAwAicpfynbkrpQ5b8mRMojH3Iz8AsMSTRmz0wXLFhFtRkabEcCj
         ddYZ+84cQh47kdakz8TZ/s0vVBRFTylxqy8+Aj8pUfK8/tnSVj5YHvb+2yhkaJEChWJT
         A4u0GxRZdgaQTIoW/sftrpm0slWvl9CAqlPl7An8WtyPrehAvro0CkLxx71JTwsX8WJM
         6PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0+TIG6VNjrqUujR6aG+tFwwFoGuZYT2WNxyTgEQcO8=;
        b=cTJEVq1N5vNdMDb11nxfgM6n76udQx4WJ1qlWPRvPC+F8u6dFODj0/YjC/vu91A2ra
         /tFUuy7ZH4Fhq/zxLdG+/N0Ulg/plfBqFwukCawUl2YqGWVTZXl3EoWeBI3HE7uyieih
         4AyzvW6/wV/wCzZ5TjXiLLfky3AKOrUkCZGN7npkAtjeu594eDvHKLyuwJ7vGZjj1zcy
         1WrzBRErUEz36qtWdaiGBZ3PUy2tdzaHoGzslTJBS75+KTzj7Li4P99tmI6NZE5qtBN0
         oxYZX4S/f79t5yDQJ+9BLK/REGeA7hqo0+Itj95pSmiSFSI36Lzm8aHxwY2N7OW2iVUY
         fXdA==
X-Gm-Message-State: APjAAAVnbc+YCKRVIbKFBCA4JLR5ity3FD67vO19vVRe7w0lMmA0RAbf
        fOtICGio2xo4SJJ/dPJIK9+Y2R96Mx+BkA==
X-Google-Smtp-Source: APXvYqwMam1A4aufyBg2Z8cGjwAt+XemUqKzVmBCCtbnhW19uT4Uh4kASSjbEU/TLZOQVi4qp0Oisg==
X-Received: by 2002:a5d:66c2:: with SMTP id k2mr15403349wrw.312.1553525961075;
        Mon, 25 Mar 2019 07:59:21 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d11sm12836156wmb.19.2019.03.25.07.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:59:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: meson-g12a-x96-max: Add support for Video Display
Date:   Mon, 25 Mar 2019 15:59:12 +0100
Message-Id: <20190325145914.32391-4-narmstrong@baylibre.com>
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
full display on the X96 Max STB.

AO-CEC-A is used for now until AO-CEC-B is supported.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index b5b88262c06a..eac4f5523e78 100644
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
@@ -90,6 +111,32 @@
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

